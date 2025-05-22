import 'package:finger_ai/injection.dart';
import 'package:finger_ai/presentation/blocs/training_job_list/training_job_list_bloc.dart';
import 'package:finger_ai/presentation/blocs/training_job_list/training_job_list_event.dart';
import 'package:finger_ai/presentation/blocs/training_job_list/training_job_list_state.dart';
import 'package:finger_ai/presentation/widgets/error_display_widget.dart';
import 'package:finger_ai/presentation/widgets/job_list_tile.dart';
import 'package:finger_ai/presentation/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class TrainingJobListScreen extends StatefulWidget {
  const TrainingJobListScreen({super.key});

  @override
  State<TrainingJobListScreen> createState() => _TrainingJobListScreenState();
}

class _TrainingJobListScreenState extends State<TrainingJobListScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (_) => getIt<TrainingJobListBloc>()..add(const LoadTrainingJobs()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Training Jobs'),
          actions: [
            BlocBuilder<TrainingJobListBloc, TrainingJobListState>(
              builder: (context, state) {
                return IconButton(
                  icon: const Icon(Icons.refresh),
                  onPressed: () {
                    context.read<TrainingJobListBloc>().add(
                      const RefreshTrainingJobs(),
                    );
                  },
                );
              },
            ),
          ],
        ),
        body: BlocBuilder<TrainingJobListBloc, TrainingJobListState>(
          builder: (context, state) {
            if (state is TrainingJobListInitial ||
                state is TrainingJobListLoading) {
              return const LoadingWidget();
            } else if (state is TrainingJobListLoaded) {
              if (state.jobs.isEmpty) {
                return const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.school_outlined, size: 64, color: Colors.grey),
                      SizedBox(height: 16),
                      Text(
                        'No training jobs found',
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Create a new job to get started',
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ],
                  ),
                );
              }

              return RefreshIndicator(
                onRefresh: () async {
                  context.read<TrainingJobListBloc>().add(
                    const RefreshTrainingJobs(),
                  );
                },
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  itemCount: state.jobs.length,
                  itemBuilder: (context, index) {
                    final job = state.jobs[index];
                    return JobListTile(
                      job: job,
                      onBackFromDetail: () {
                        context.read<TrainingJobListBloc>().add(
                          const LoadTrainingJobs(),
                        );
                      },
                    );
                  },
                ),
              );
            } else if (state is TrainingJobListError) {
              return ErrorDisplayWidget(
                message: state.message,
                onRetry: () {
                  context.read<TrainingJobListBloc>().add(
                    const LoadTrainingJobs(),
                  );
                },
              );
            }
            return const Center(child: Text('Unknown state'));
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => context.push('/jobs/new'),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
