import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:finger_ai/data/models/trained_model.dart';

abstract class IdentificationEvent extends Equatable {
  const IdentificationEvent();

  @override
  List<Object?> get props => [];
}

class PickImage extends IdentificationEvent {
  const PickImage();
}

class LoadActiveModels extends IdentificationEvent {
  const LoadActiveModels();
}

class SetRegionModel extends IdentificationEvent {
  final TrainedModel model;

  const SetRegionModel(this.model);

  @override
  List<Object?> get props => [model];
}

class SetIdentityModel extends IdentificationEvent {
  final TrainedModel model;

  const SetIdentityModel(this.model);

  @override
  List<Object?> get props => [model];
}

class ProcessImage extends IdentificationEvent {
  final File imageFile;
  final int regionModelId;
  final int identityModelId;

  const ProcessImage({
    required this.imageFile,
    required this.regionModelId,
    required this.identityModelId,
  });

  @override
  List<Object?> get props => [imageFile, regionModelId, identityModelId];
}

class ResetIdentification extends IdentificationEvent {
  const ResetIdentification();
}
