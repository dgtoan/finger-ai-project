import 'package:equatable/equatable.dart';
import 'package:finger_ai/data/models/trained_model.dart';

abstract class ModelDetailState extends Equatable {
  const ModelDetailState();

  @override
  List<Object?> get props => [];
}

class ModelDetailInitial extends ModelDetailState {
  const ModelDetailInitial();
}

class ModelDetailLoading extends ModelDetailState {
  const ModelDetailLoading();
}

class ModelDetailLoaded extends ModelDetailState {
  final TrainedModel model;

  const ModelDetailLoaded(this.model);

  @override
  List<Object?> get props => [model];
}

class ModelDetailUpdating extends ModelDetailState {
  const ModelDetailUpdating();
}

class ModelDetailDeleting extends ModelDetailState {
  const ModelDetailDeleting();
}

class ModelDetailUpdateSuccess extends ModelDetailState {
  final TrainedModel model;

  const ModelDetailUpdateSuccess(this.model);

  @override
  List<Object?> get props => [model];
}

class ModelDetailDeleteSuccess extends ModelDetailState {
  const ModelDetailDeleteSuccess();
}

class ModelDetailError extends ModelDetailState {
  final String message;

  const ModelDetailError(this.message);

  @override
  List<Object?> get props => [message];
}
