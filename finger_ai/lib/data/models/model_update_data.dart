import 'package:freezed_annotation/freezed_annotation.dart';

part 'model_update_data.freezed.dart';
part 'model_update_data.g.dart';

@freezed
class ModelUpdateData with _$ModelUpdateData {
  const factory ModelUpdateData({String? name, String? status}) =
      _ModelUpdateData;

  factory ModelUpdateData.fromJson(Map<String, dynamic> json) =>
      _$ModelUpdateDataFromJson(json);
}
