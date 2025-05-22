// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'training_job.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TrainingJobImpl _$$TrainingJobImplFromJson(Map<String, dynamic> json) =>
    _$TrainingJobImpl(
      id: (json['id'] as num).toInt(),
      modelType: json['model_type'] as String,
      status: json['status'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      startedAt:
          json['started_at'] == null
              ? null
              : DateTime.parse(json['started_at'] as String),
      completedAt:
          json['completed_at'] == null
              ? null
              : DateTime.parse(json['completed_at'] as String),
      uploadedDataPath: json['uploaded_data_path'] as String?,
      originalFilename: json['original_filename'] as String?,
      configParams: json['config_params'] as Map<String, dynamic>,
      errorMessage: json['error_message'] as String?,
    );

Map<String, dynamic> _$$TrainingJobImplToJson(_$TrainingJobImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'model_type': instance.modelType,
      'status': instance.status,
      'created_at': instance.createdAt.toIso8601String(),
      'started_at': instance.startedAt?.toIso8601String(),
      'completed_at': instance.completedAt?.toIso8601String(),
      'uploaded_data_path': instance.uploadedDataPath,
      'original_filename': instance.originalFilename,
      'config_params': instance.configParams,
      'error_message': instance.errorMessage,
    };
