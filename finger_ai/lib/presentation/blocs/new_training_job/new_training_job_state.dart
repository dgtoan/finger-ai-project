import 'package:equatable/equatable.dart';
import 'package:finger_ai/data/models/training_job.dart';

abstract class NewTrainingJobState extends Equatable {
  const NewTrainingJobState();

  @override
  List<Object?> get props => [];
}

class NewTrainingJobInitial extends NewTrainingJobState {
  const NewTrainingJobInitial();
}

class NewTrainingJobSubmitting extends NewTrainingJobState {
  const NewTrainingJobSubmitting();
}

class NewTrainingJobSuccess extends NewTrainingJobState {
  final TrainingJob job;

  const NewTrainingJobSuccess(this.job);

  @override
  List<Object?> get props => [job];
}

class NewTrainingJobFailure extends NewTrainingJobState {
  final String message;

  const NewTrainingJobFailure(this.message);

  @override
  List<Object?> get props => [message];
}
