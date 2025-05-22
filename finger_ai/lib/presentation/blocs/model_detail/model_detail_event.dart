import 'package:equatable/equatable.dart';
import 'package:finger_ai/data/models/model_update_data.dart';

abstract class ModelDetailEvent extends Equatable {
  const ModelDetailEvent();

  @override
  List<Object?> get props => [];
}

class LoadModelDetail extends ModelDetailEvent {
  final int id;

  const LoadModelDetail(this.id);

  @override
  List<Object?> get props => [id];
}

class UpdateModel extends ModelDetailEvent {
  final int id;
  final ModelUpdateData data;

  const UpdateModel({required this.id, required this.data});

  @override
  List<Object?> get props => [id, data];
}

class DeleteModel extends ModelDetailEvent {
  final int id;

  const DeleteModel(this.id);

  @override
  List<Object?> get props => [id];
}
