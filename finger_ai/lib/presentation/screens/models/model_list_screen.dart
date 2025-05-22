import 'package:finger_ai/injection.dart';
import 'package:finger_ai/presentation/blocs/model_list/model_list_bloc.dart';
import 'package:finger_ai/presentation/blocs/model_list/model_list_event.dart';
import 'package:finger_ai/presentation/blocs/model_list/model_list_state.dart';
import 'package:finger_ai/presentation/widgets/error_display_widget.dart';
import 'package:finger_ai/presentation/widgets/loading_widget.dart';
import 'package:finger_ai/presentation/widgets/model_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ModelListScreen extends StatefulWidget {
  const ModelListScreen({super.key});

  @override
  State<ModelListScreen> createState() => _ModelListScreenState();
}

class _ModelListScreenState extends State<ModelListScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ModelListBloc>()..add(const LoadModels()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Models'),
          actions: [
            BlocBuilder<ModelListBloc, ModelListState>(
              builder: (context, state) {
                return IconButton(
                  icon: const Icon(Icons.refresh),
                  onPressed: () {
                    context.read<ModelListBloc>().add(const RefreshModels());
                  },
                );
              },
            ),
          ],
        ),
        body: BlocBuilder<ModelListBloc, ModelListState>(
          builder: (context, state) {
            if (state is ModelListInitial || state is ModelListLoading) {
              return const LoadingWidget();
            } else if (state is ModelListLoaded) {
              if (state.models.isEmpty) {
                return const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.model_training, size: 64, color: Colors.grey),
                      SizedBox(height: 16),
                      Text(
                        'No trained models found',
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Create training jobs to generate models',
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ],
                  ),
                );
              }

              return RefreshIndicator(
                onRefresh: () async {
                  context.read<ModelListBloc>().add(const RefreshModels());
                },
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  itemCount: state.models.length,
                  itemBuilder: (context, index) {
                    final model = state.models[index];
                    return ModelListTile(
                      model: model,
                      onBackFromDetail: () {
                        context.read<ModelListBloc>().add(const LoadModels());
                      },
                    );
                  },
                ),
              );
            } else if (state is ModelListError) {
              return ErrorDisplayWidget(
                message: state.message,
                onRetry: () {
                  context.read<ModelListBloc>().add(const LoadModels());
                },
              );
            }
            return const Center(child: Text('Unknown state'));
          },
        ),
      ),
    );
  }
}
