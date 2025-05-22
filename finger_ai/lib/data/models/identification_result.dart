// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'identification_result.freezed.dart';
part 'identification_result.g.dart';

@freezed
class IdentificationResult with _$IdentificationResult {
  const factory IdentificationResult({
    @JsonKey(name: 'employee_id') String? employeeId,
    required String status,
  }) = _IdentificationResult;

  factory IdentificationResult.fromJson(Map<String, dynamic> json) =>
      _$IdentificationResultFromJson(json);
}
