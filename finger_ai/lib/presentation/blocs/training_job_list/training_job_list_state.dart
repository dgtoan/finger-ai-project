import 'package:equatable/equatable.dart';
import 'package:finger_ai/data/models/training_job.dart';

abstract class TrainingJobListState extends Equatable {
  const TrainingJobListState();

  @override
  List<Object?> get props => [];
}

class TrainingJobListInitial extends TrainingJobListState {
  const TrainingJobListInitial();
}

class TrainingJobListLoading extends TrainingJobListState {
  const TrainingJobListLoading();
}

class TrainingJobListLoaded extends TrainingJobListState {
  final List<TrainingJob> jobs;

  const TrainingJobListLoaded(this.jobs);

  @override
  List<Object?> get props => [jobs];
}

class TrainingJobListError extends TrainingJobListState {
  final String message;

  const TrainingJobListError(this.message);

  @override
  List<Object?> get props => [message];
}
