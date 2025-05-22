import 'package:finger_ai/data/models/model_update_data.dart';
import 'package:finger_ai/injection.dart';
import 'package:finger_ai/presentation/blocs/model_detail/model_detail_bloc.dart';
import 'package:finger_ai/presentation/blocs/model_detail/model_detail_event.dart';
import 'package:finger_ai/presentation/blocs/model_detail/model_detail_state.dart';
import 'package:finger_ai/presentation/widgets/error_display_widget.dart';
import 'package:finger_ai/presentation/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class ModelDetailScreen extends StatefulWidget {
  final String modelId;

  const ModelDetailScreen({super.key, required this.modelId});

  @override
  State<ModelDetailScreen> createState() => _ModelDetailScreenState();
}

class _ModelDetailScreenState extends State<ModelDetailScreen> {
  final _nameController = TextEditingController();
  String _currentStatus = '';
  bool _hasChanges = false;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _showDeleteConfirmDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (ctx) => AlertDialog(
            title: const Text('Delete Model'),
            content: const Text(
              'Are you sure you want to delete this model? This action cannot be undone.',
            ),
            actions: [
              TextButton(
                onPressed: () => ctx.pop(),
                child: const Text('CANCEL'),
              ),
              TextButton(
                style: TextButton.styleFrom(foregroundColor: Colors.red),
                onPressed: () {
                  ctx.pop();
                  final modelId = int.parse(widget.modelId);
                  context.read<ModelDetailBloc>().add(DeleteModel(modelId));
                },
                child: const Text('DELETE'),
              ),
            ],
          ),
    );
  }

  void _showDiscardChangesDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (ctx) => AlertDialog(
            title: const Text('Discard Changes?'),
            content: const Text(
              'You have unsaved changes. Are you sure you want to discard them?',
            ),
            actions: [
              TextButton(onPressed: () => ctx.pop(), child: const Text('STAY')),
              TextButton(
                onPressed: () {
                  context.pop();
                  context.pop();
                },
                child: const Text('DISCARD'),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              getIt<ModelDetailBloc>()
                ..add(LoadModelDetail(int.parse(widget.modelId))),
      child: BlocListener<ModelDetailBloc, ModelDetailState>(
        listener: (context, state) {
          if (state is ModelDetailLoaded) {
            _nameController.text = state.model.name;
            _currentStatus = state.model.status;
            setState(() {
              _hasChanges = false;
            });
          } else if (state is ModelDetailUpdateSuccess) {
            _nameController.text = state.model.name;
            _currentStatus = state.model.status;
            setState(() {
              _hasChanges = false;
            });
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Model updated successfully'),
                backgroundColor: Colors.green,
              ),
            );
          } else if (state is ModelDetailDeleteSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Model deleted successfully'),
                backgroundColor: Colors.green,
              ),
            );
            context.pop();
          } else if (state is ModelDetailError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Error: ${state.message}'),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: BlocBuilder<ModelDetailBloc, ModelDetailState>(
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                title: const Text('Model Details'),
                actions: [
                  if (state is ModelDetailLoaded ||
                      state is ModelDetailUpdateSuccess)
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => _showDeleteConfirmDialog(context),
                    ),
                ],
              ),
              body: _buildBody(context, state),
              bottomNavigationBar:
                  (state is ModelDetailLoaded ||
                              state is ModelDetailUpdateSuccess) &&
                          _hasChanges
                      ? BottomAppBar(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 8.0,
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: OutlinedButton(
                                  onPressed: () {
                                    final model =
                                        state is ModelDetailLoaded
                                            ? state.model
                                            : (state
                                                    as ModelDetailUpdateSuccess)
                                                .model;

                                    _nameController.text = model.name;
                                    _currentStatus = model.status;
                                    setState(() {
                                      _hasChanges = false;
                                    });
                                  },
                                  child: const Text('RESET'),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    final modelId = int.parse(widget.modelId);
                                    final updateData = ModelUpdateData(
                                      name: _nameController.text,
                                      status: _currentStatus,
                                    );

                                    context.read<ModelDetailBloc>().add(
                                      UpdateModel(
                                        id: modelId,
                                        data: updateData,
                                      ),
                                    );
                                  },
                                  child: const Text('SAVE'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                      : null,
            );
          },
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context, ModelDetailState state) {
    if (state is ModelDetailInitial || state is ModelDetailLoading) {
      return const LoadingWidget();
    } else if (state is ModelDetailLoaded ||
        state is ModelDetailUpdateSuccess) {
      final model =
          state is ModelDetailLoaded
              ? state.model
              : (state as ModelDetailUpdateSuccess).model;
      return WillPopScope(
        onWillPop: () async {
          if (_hasChanges) {
            _showDiscardChangesDialog(context);
            return false;
          }
          return true;
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Name Field
              const Text(
                'Model Name',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  hintText: 'Enter model name',
                ),
                onChanged: (value) {
                  setState(() {
                    _hasChanges =
                        value != model.name || _currentStatus != model.status;
                  });
                },
              ),
              const SizedBox(height: 20),

              // Status Field
              const Text(
                'Status',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              SegmentedButton<String>(
                segments: const [
                  ButtonSegment<String>(
                    value: 'active',
                    label: Text('Active'),
                    icon: Icon(Icons.check_circle),
                  ),
                  ButtonSegment<String>(
                    value: 'inactive',
                    label: Text('Inactive'),
                    icon: Icon(Icons.cancel),
                  ),
                ],
                selected: {_currentStatus},
                onSelectionChanged: (Set<String> selection) {
                  setState(() {
                    _currentStatus = selection.first;
                    _hasChanges =
                        _nameController.text != model.name ||
                        _currentStatus != model.status;
                  });
                },
              ),
              const SizedBox(height: 24),

              // Model Info (non-editable)
              const Divider(),
              const SizedBox(height: 16),
              const Text(
                'Model Information',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              // Model Type
              _buildInfoRow(
                'Type',
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color:
                            model.type.toLowerCase() == 'region'
                                ? Colors.purple[100]
                                : Colors.blue[100],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        model.type,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color:
                              model.type.toLowerCase() == 'region'
                                  ? Colors.purple[800]
                                  : Colors.blue[800],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Model ID
              _buildInfoRow('Model ID', Text('#${model.id}')),

              // Created Date
              _buildInfoRow(
                'Created At',
                Text(DateFormat('MMM dd, yyyy HH:mm').format(model.createdAt)),
              ),

              // Storage Path
              _buildInfoRow('Storage Path', Text(model.modelPath ?? 'N/A')),

              // Training Job ID
              if (model.trainingJobId != null)
                _buildInfoRow(
                  'Training Job',
                  GestureDetector(
                    onTap: () => context.push('/jobs/${model.trainingJobId}'),
                    child: Row(
                      children: [
                        Text('#${model.trainingJobId}'),
                        const SizedBox(width: 4),
                        const Icon(Icons.open_in_new, size: 16),
                      ],
                    ),
                  ),
                ),

              // Metrics
              if (model.modelAccuracy != null || model.modelLoss != null) ...[
                const SizedBox(height: 16),
                const Text(
                  'Performance Metrics',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),

                // Accuracy
                if (model.modelAccuracy != null)
                  _buildInfoRow(
                    'Accuracy',
                    Text(
                      '${(model.modelAccuracy! * 100).toStringAsFixed(1)}%',
                      style: TextStyle(
                        color: Colors.green[700],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                // Loss
                if (model.modelLoss != null)
                  _buildInfoRow(
                    'Loss',
                    Text(
                      model.modelLoss!.toStringAsFixed(4),
                      style: TextStyle(
                        color: Colors.orange[700],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ],
          ),
        ),
      );
    } else if (state is ModelDetailUpdating) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Updating model...'),
          ],
        ),
      );
    } else if (state is ModelDetailDeleting) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Deleting model...'),
          ],
        ),
      );
    } else if (state is ModelDetailError) {
      return ErrorDisplayWidget(
        message: state.message,
        onRetry: () {
          context.read<ModelDetailBloc>().add(
            LoadModelDetail(int.parse(widget.modelId)),
          );
        },
      );
    }

    return const Center(child: Text('Unknown state'));
  }

  Widget _buildInfoRow(String label, Widget value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: TextStyle(
                color: Colors.grey[700],
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(child: value),
        ],
      ),
    );
  }
}
