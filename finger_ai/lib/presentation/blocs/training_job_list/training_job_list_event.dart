import 'package:equatable/equatable.dart';

abstract class TrainingJobListEvent extends Equatable {
  const TrainingJobListEvent();

  @override
  List<Object?> get props => [];
}

class LoadTrainingJobs extends TrainingJobListEvent {
  const LoadTrainingJobs();
}

class RefreshTrainingJobs extends TrainingJobListEvent {
  const RefreshTrainingJobs();
}
