import 'package:finger_ai/data/models/identification_result.dart';
import 'package:finger_ai/data/models/trained_model.dart';
import 'package:finger_ai/injection.dart';
import 'package:finger_ai/presentation/blocs/identification/identification_bloc.dart';
import 'package:finger_ai/presentation/blocs/identification/identification_event.dart';
import 'package:finger_ai/presentation/blocs/identification/identification_state.dart';
import 'package:finger_ai/presentation/widgets/error_display_widget.dart';
import 'package:finger_ai/presentation/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IdentificationScreen extends StatefulWidget {
  const IdentificationScreen({super.key});

  @override
  State<IdentificationScreen> createState() => _IdentificationScreenState();
}

class _IdentificationScreenState extends State<IdentificationScreen> {
  late IdentificationBloc _identificationBloc;

  @override
  void initState() {
    super.initState();
    _identificationBloc = getIt<IdentificationBloc>();

    // Load active models when screen initializes
    _identificationBloc.add(const LoadActiveModels());
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _identificationBloc,
      child: Scaffold(
        appBar: AppBar(title: const Text('Fingerprint Identification')),
        body: BlocBuilder<IdentificationBloc, IdentificationState>(
          builder: (context, state) {
            if (state is LoadingModels) {
              return const LoadingWidget();
            } else if (state is ModelsLoadingFailure) {
              return ErrorDisplayWidget(
                message: state.message,
                onRetry: () {
                  context.read<IdentificationBloc>().add(
                    const LoadActiveModels(),
                  );
                },
              );
            } else if (state is ModelsLoaded) {
              return _buildIdentificationScreen(context, state);
            } else {
              // Initial state, load active models
              return const LoadingWidget();
            }
          },
        ),
      ),
    );
  }

  Widget _buildIdentificationScreen(BuildContext context, ModelsLoaded state) {
    if (state.activeModels.isEmpty) {
      return _buildNoModelsMessage();
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Select Models Section
          _buildModelSelectionSection(context, state),
          const SizedBox(height: 20),

          // Image Selection Section - Tappable area
          _buildImageSection(context, state),
          const SizedBox(height: 20),

          // Action Button
          _buildActionButton(context, state),
          const SizedBox(height: 24),

          // Error message if any
          if (state.errorMessage != null) ...[
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.red.shade300),
              ),
              child: Row(
                children: [
                  const Icon(Icons.error_outline, color: Colors.red),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      state.errorMessage!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
          ],

          // Result Section if available
          if (state.identificationResult != null) ...[
            const Divider(thickness: 1),
            const SizedBox(height: 16),
            const Text(
              'Identification Result',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: _buildResultSection(context, state.identificationResult!),
            ),
          ],

          // Processing indicator
          if (state.isIdentifying) ...[
            const SizedBox(height: 20),
            const Center(
              child: Column(
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 12),
                  Text('Processing...'),
                ],
              ),
            ),
          ],

          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _buildNoModelsMessage() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.model_training, size: 64, color: Colors.grey),
          const SizedBox(height: 16),
          const Text(
            'No active models found',
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
          const SizedBox(height: 8),
          const Text(
            'You need active models to perform identification',
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              context.read<IdentificationBloc>().add(const LoadActiveModels());
            },
            child: const Text('Refresh'),
          ),
        ],
      ),
    );
  }

  Widget _buildModelSelectionSection(BuildContext context, ModelsLoaded state) {
    // Filter models by type
    final regionModels =
        state.activeModels
            .where((model) => model.type.toLowerCase() == 'region')
            .toList();
    final identityModels =
        state.activeModels
            .where((model) => model.type.toLowerCase() == 'identity')
            .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Select Models',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        // Region Model Selection
        const Text('Region Model:', style: TextStyle(fontSize: 16)),
        const SizedBox(height: 8),
        _buildModelDropdown(context, regionModels, state.selectedRegionModel, (
          model,
        ) {
          context.read<IdentificationBloc>().add(SetRegionModel(model));
        }, 'Select a region model'),
        const SizedBox(height: 16),
        // Identity Model Selection
        const Text('Identity Model:', style: TextStyle(fontSize: 16)),
        const SizedBox(height: 8),
        _buildModelDropdown(
          context,
          identityModels,
          state.selectedIdentityModel,
          (model) {
            context.read<IdentificationBloc>().add(SetIdentityModel(model));
          },
          'Select an identity model',
        ),
      ],
    );
  }

  Widget _buildModelDropdown(
    BuildContext context,
    List<TrainedModel> models,
    TrainedModel? selectedModel,
    Function(TrainedModel) onChanged,
    String hintText,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(4),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<int>(
          isExpanded: true,
          hint: Text(hintText),
          value: selectedModel?.id,
          onChanged: (value) {
            if (value != null) {
              final model = models.firstWhere((m) => m.id == value);
              onChanged(model);
            }
          },
          items:
              models.map<DropdownMenuItem<int>>((model) {
                return DropdownMenuItem<int>(
                  value: model.id,
                  child: Text(
                    '${model.name} (${model.id})',
                    overflow: TextOverflow.ellipsis,
                  ),
                );
              }).toList(),
        ),
      ),
    );
  }

  Widget _buildImageSection(BuildContext context, ModelsLoaded state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Fingerprint Image',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        const Text(
          'Tap on the area below to select an image',
          style: TextStyle(fontSize: 14, color: Colors.grey),
        ),
        const SizedBox(height: 12),
        // Tappable area to select image
        InkWell(
          onTap: () {
            context.read<IdentificationBloc>().add(const PickImage());
          },
          child: Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(
                color:
                    state.imageFile != null
                        ? Colors.grey.shade400
                        : Theme.of(context).primaryColor,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child:
                state.imageFile != null
                    ? ClipRRect(
                      borderRadius: BorderRadius.circular(7),
                      child: Image.file(state.imageFile!, fit: BoxFit.contain),
                    )
                    : Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add_photo_alternate_outlined,
                            size: 64,
                            color: Theme.of(
                              context,
                            ).primaryColor.withOpacity(0.5),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'Tap to select image',
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton(BuildContext context, ModelsLoaded state) {
    return Center(
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed:
              state.canProcess
                  ? () {
                    context.read<IdentificationBloc>().add(
                      ProcessImage(
                        imageFile: state.imageFile!,
                        regionModelId: state.selectedRegionModel!.id,
                        identityModelId: state.selectedIdentityModel!.id,
                      ),
                    );
                  }
                  : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).primaryColor,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Text('Identify', style: TextStyle(fontSize: 16)),
        ),
      ),
    );
  }

  Widget _buildResultSection(
    BuildContext context,
    IdentificationResult result,
  ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildStatusIcon(result.status),
        const SizedBox(height: 20),
        Text('Status: ${result.status}', style: const TextStyle(fontSize: 18)),
        if (result.employeeId != null) ...[
          const SizedBox(height: 10),
          Text(
            'Employee ID: ${result.employeeId}',
            style: const TextStyle(fontSize: 18),
          ),
        ],
      ],
    );
  }

  Widget _buildStatusIcon(String status) {
    switch (status.toLowerCase()) {
      case 'allowed':
        return const Icon(Icons.check_circle, color: Colors.green, size: 80);
      case 'denied':
        return const Icon(Icons.cancel, color: Colors.red, size: 80);
      case 'unknown':
      default:
        return const Icon(Icons.help_center, color: Colors.amber, size: 80);
    }
  }
}
