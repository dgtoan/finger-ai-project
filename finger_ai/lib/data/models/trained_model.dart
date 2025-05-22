// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'trained_model.freezed.dart';
part 'trained_model.g.dart';

@freezed
class TrainedModel with _$TrainedModel {
  const factory TrainedModel({
    required int id,
    required String name,
    required String type,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'model_path') String? modelPath,
    required String status,
    @JsonKey(name: 'training_job_id') int? trainingJobId,
    @JsonKey(name: 'model_accuracy') double? modelAccuracy,
    @JsonKey(name: 'model_loss') double? modelLoss,
  }) = _TrainedModel;

  factory TrainedModel.fromJson(Map<String, dynamic> json) =>
      _$TrainedModelFromJson(json);
}
