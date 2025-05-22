// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trained_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TrainedModelImpl _$$TrainedModelImplFromJson(Map<String, dynamic> json) =>
    _$TrainedModelImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      type: json['type'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      modelPath: json['model_path'] as String?,
      status: json['status'] as String,
      trainingJobId: (json['training_job_id'] as num?)?.toInt(),
      modelAccuracy: (json['model_accuracy'] as num?)?.toDouble(),
      modelLoss: (json['model_loss'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$TrainedModelImplToJson(_$TrainedModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': instance.type,
      'created_at': instance.createdAt.toIso8601String(),
      'model_path': instance.modelPath,
      'status': instance.status,
      'training_job_id': instance.trainingJobId,
      'model_accuracy': instance.modelAccuracy,
      'model_loss': instance.modelLoss,
    };
