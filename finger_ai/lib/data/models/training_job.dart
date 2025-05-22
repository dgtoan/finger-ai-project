// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'training_job.freezed.dart';
part 'training_job.g.dart';

@freezed
class TrainingJob with _$TrainingJob {
  const factory TrainingJob({
    required int id,
    @JsonKey(name: 'model_type') required String modelType,
    required String status,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'started_at') DateTime? startedAt,
    @JsonKey(name: 'completed_at') DateTime? completedAt,
    @JsonKey(name: 'uploaded_data_path') String? uploadedDataPath,
    @JsonKey(name: 'original_filename') String? originalFilename,
    @JsonKey(name: 'config_params') required Map<String, dynamic> configParams,
    @JsonKey(name: 'error_message') String? errorMessage,
  }) = _TrainingJob;

  factory TrainingJob.fromJson(Map<String, dynamic> json) =>
      _$TrainingJobFromJson(json);
}
