import 'package:equatable/equatable.dart';
import 'package:finger_ai/data/models/trained_model.dart';

abstract class ModelListState extends Equatable {
  const ModelListState();

  @override
  List<Object?> get props => [];
}

class ModelListInitial extends ModelListState {
  const ModelListInitial();
}

class ModelListLoading extends ModelListState {
  const ModelListLoading();
}

class ModelListLoaded extends ModelListState {
  final List<TrainedModel> models;

  const ModelListLoaded(this.models);

  @override
  List<Object?> get props => [models];
}

class ModelListError extends ModelListState {
  final String message;

  const ModelListError(this.message);

  @override
  List<Object?> get props => [message];
}
