import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:finger_ai/data/models/identification_result.dart';
import 'package:finger_ai/data/models/trained_model.dart';

abstract class IdentificationState extends Equatable {
  const IdentificationState();

  @override
  List<Object?> get props => [];
}

class IdentificationInitial extends IdentificationState {
  const IdentificationInitial();
}

class LoadingModels extends IdentificationState {
  const LoadingModels();
}

class ModelsLoaded extends IdentificationState {
  final List<TrainedModel> activeModels;
  final TrainedModel? selectedRegionModel;
  final TrainedModel? selectedIdentityModel;
  final File? imageFile;
  final bool isIdentifying;
  final IdentificationResult? identificationResult;
  final String? errorMessage;

  const ModelsLoaded({
    required this.activeModels,
    this.selectedRegionModel,
    this.selectedIdentityModel,
    this.imageFile,
    this.isIdentifying = false,
    this.identificationResult,
    this.errorMessage,
  });

  bool get canProcess =>
      imageFile != null &&
      selectedRegionModel != null &&
      selectedIdentityModel != null &&
      !isIdentifying;

  ModelsLoaded copyWith({
    List<TrainedModel>? activeModels,
    TrainedModel? selectedRegionModel,
    TrainedModel? selectedIdentityModel,
    File? imageFile,
    bool? isIdentifying,
    IdentificationResult? identificationResult,
    String? errorMessage,
    bool clearResult = false,
    bool clearError = false,
  }) {
    return ModelsLoaded(
      activeModels: activeModels ?? this.activeModels,
      selectedRegionModel: selectedRegionModel ?? this.selectedRegionModel,
      selectedIdentityModel:
          selectedIdentityModel ?? this.selectedIdentityModel,
      imageFile: imageFile ?? this.imageFile,
      isIdentifying: isIdentifying ?? this.isIdentifying,
      identificationResult:
          clearResult
              ? null
              : (identificationResult ?? this.identificationResult),
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }

  @override
  List<Object?> get props => [
    activeModels,
    selectedRegionModel,
    selectedIdentityModel,
    imageFile,
    isIdentifying,
    identificationResult,
    errorMessage,
  ];
}

class ModelsLoadingFailure extends IdentificationState {
  final String message;

  const ModelsLoadingFailure(this.message);

  @override
  List<Object?> get props => [message];
}

class ImageSelected extends IdentificationState {
  final File imageFile;

  const ImageSelected(this.imageFile);

  @override
  List<Object?> get props => [imageFile];
}

class ImageSelectionFailed extends IdentificationState {
  final String message;

  const ImageSelectionFailed(this.message);

  @override
  List<Object?> get props => [message];
}

class Identifying extends IdentificationState {
  const Identifying();
}

class IdentificationSuccess extends IdentificationState {
  final IdentificationResult result;

  const IdentificationSuccess(this.result);

  @override
  List<Object?> get props => [result];
}

class IdentificationFailure extends IdentificationState {
  final String message;

  const IdentificationFailure(this.message);

  @override
  List<Object?> get props => [message];
}
