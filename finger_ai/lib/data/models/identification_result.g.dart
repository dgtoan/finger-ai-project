// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'identification_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$IdentificationResultImpl _$$IdentificationResultImplFromJson(
  Map<String, dynamic> json,
) => _$IdentificationResultImpl(
  employeeId: json['employee_id'] as String?,
  status: json['status'] as String,
  identifiedImageBase64: json['identified_image_base64'] as String?,
);

Map<String, dynamic> _$$IdentificationResultImplToJson(
  _$IdentificationResultImpl instance,
) => <String, dynamic>{
  'employee_id': instance.employeeId,
  'status': instance.status,
  'identified_image_base64': instance.identifiedImageBase64,
};
