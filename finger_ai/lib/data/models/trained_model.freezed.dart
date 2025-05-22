// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'trained_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

TrainedModel _$TrainedModelFromJson(Map<String, dynamic> json) {
  return _TrainedModel.fromJson(json);
}

/// @nodoc
mixin _$TrainedModel {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'model_path')
  String? get modelPath => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'training_job_id')
  int? get trainingJobId => throw _privateConstructorUsedError;
  @JsonKey(name: 'model_accuracy')
  double? get modelAccuracy => throw _privateConstructorUsedError;
  @JsonKey(name: 'model_loss')
  double? get modelLoss => throw _privateConstructorUsedError;

  /// Serializes this TrainedModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TrainedModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TrainedModelCopyWith<TrainedModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TrainedModelCopyWith<$Res> {
  factory $TrainedModelCopyWith(
    TrainedModel value,
    $Res Function(TrainedModel) then,
  ) = _$TrainedModelCopyWithImpl<$Res, TrainedModel>;
  @useResult
  $Res call({
    int id,
    String name,
    String type,
    @JsonKey(name: 'created_at') DateTime createdAt,
    @JsonKey(name: 'model_path') String? modelPath,
    String status,
    @JsonKey(name: 'training_job_id') int? trainingJobId,
    @JsonKey(name: 'model_accuracy') double? modelAccuracy,
    @JsonKey(name: 'model_loss') double? modelLoss,
  });
}

/// @nodoc
class _$TrainedModelCopyWithImpl<$Res, $Val extends TrainedModel>
    implements $TrainedModelCopyWith<$Res> {
  _$TrainedModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TrainedModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? type = null,
    Object? createdAt = null,
    Object? modelPath = freezed,
    Object? status = null,
    Object? trainingJobId = freezed,
    Object? modelAccuracy = freezed,
    Object? modelLoss = freezed,
  }) {
    return _then(
      _value.copyWith(
            id:
                null == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as int,
            name:
                null == name
                    ? _value.name
                    : name // ignore: cast_nullable_to_non_nullable
                        as String,
            type:
                null == type
                    ? _value.type
                    : type // ignore: cast_nullable_to_non_nullable
                        as String,
            createdAt:
                null == createdAt
                    ? _value.createdAt
                    : createdAt // ignore: cast_nullable_to_non_nullable
                        as DateTime,
            modelPath:
                freezed == modelPath
                    ? _value.modelPath
                    : modelPath // ignore: cast_nullable_to_non_nullable
                        as String?,
            status:
                null == status
                    ? _value.status
                    : status // ignore: cast_nullable_to_non_nullable
                        as String,
            trainingJobId:
                freezed == trainingJobId
                    ? _value.trainingJobId
                    : trainingJobId // ignore: cast_nullable_to_non_nullable
                        as int?,
            modelAccuracy:
                freezed == modelAccuracy
                    ? _value.modelAccuracy
                    : modelAccuracy // ignore: cast_nullable_to_non_nullable
                        as double?,
            modelLoss:
                freezed == modelLoss
                    ? _value.modelLoss
                    : modelLoss // ignore: cast_nullable_to_non_nullable
                        as double?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TrainedModelImplCopyWith<$Res>
    implements $TrainedModelCopyWith<$Res> {
  factory _$$TrainedModelImplCopyWith(
    _$TrainedModelImpl value,
    $Res Function(_$TrainedModelImpl) then,
  ) = __$$TrainedModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    String name,
    String type,
    @JsonKey(name: 'created_at') DateTime createdAt,
    @JsonKey(name: 'model_path') String? modelPath,
    String status,
    @JsonKey(name: 'training_job_id') int? trainingJobId,
    @JsonKey(name: 'model_accuracy') double? modelAccuracy,
    @JsonKey(name: 'model_loss') double? modelLoss,
  });
}

/// @nodoc
class __$$TrainedModelImplCopyWithImpl<$Res>
    extends _$TrainedModelCopyWithImpl<$Res, _$TrainedModelImpl>
    implements _$$TrainedModelImplCopyWith<$Res> {
  __$$TrainedModelImplCopyWithImpl(
    _$TrainedModelImpl _value,
    $Res Function(_$TrainedModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TrainedModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? type = null,
    Object? createdAt = null,
    Object? modelPath = freezed,
    Object? status = null,
    Object? trainingJobId = freezed,
    Object? modelAccuracy = freezed,
    Object? modelLoss = freezed,
  }) {
    return _then(
      _$TrainedModelImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as int,
        name:
            null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                    as String,
        type:
            null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                    as String,
        createdAt:
            null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                    as DateTime,
        modelPath:
            freezed == modelPath
                ? _value.modelPath
                : modelPath // ignore: cast_nullable_to_non_nullable
                    as String?,
        status:
            null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                    as String,
        trainingJobId:
            freezed == trainingJobId
                ? _value.trainingJobId
                : trainingJobId // ignore: cast_nullable_to_non_nullable
                    as int?,
        modelAccuracy:
            freezed == modelAccuracy
                ? _value.modelAccuracy
                : modelAccuracy // ignore: cast_nullable_to_non_nullable
                    as double?,
        modelLoss:
            freezed == modelLoss
                ? _value.modelLoss
                : modelLoss // ignore: cast_nullable_to_non_nullable
                    as double?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TrainedModelImpl implements _TrainedModel {
  const _$TrainedModelImpl({
    required this.id,
    required this.name,
    required this.type,
    @JsonKey(name: 'created_at') required this.createdAt,
    @JsonKey(name: 'model_path') this.modelPath,
    required this.status,
    @JsonKey(name: 'training_job_id') this.trainingJobId,
    @JsonKey(name: 'model_accuracy') this.modelAccuracy,
    @JsonKey(name: 'model_loss') this.modelLoss,
  });

  factory _$TrainedModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$TrainedModelImplFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  final String type;
  @override
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @override
  @JsonKey(name: 'model_path')
  final String? modelPath;
  @override
  final String status;
  @override
  @JsonKey(name: 'training_job_id')
  final int? trainingJobId;
  @override
  @JsonKey(name: 'model_accuracy')
  final double? modelAccuracy;
  @override
  @JsonKey(name: 'model_loss')
  final double? modelLoss;

  @override
  String toString() {
    return 'TrainedModel(id: $id, name: $name, type: $type, createdAt: $createdAt, modelPath: $modelPath, status: $status, trainingJobId: $trainingJobId, modelAccuracy: $modelAccuracy, modelLoss: $modelLoss)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TrainedModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.modelPath, modelPath) ||
                other.modelPath == modelPath) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.trainingJobId, trainingJobId) ||
                other.trainingJobId == trainingJobId) &&
            (identical(other.modelAccuracy, modelAccuracy) ||
                other.modelAccuracy == modelAccuracy) &&
            (identical(other.modelLoss, modelLoss) ||
                other.modelLoss == modelLoss));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    type,
    createdAt,
    modelPath,
    status,
    trainingJobId,
    modelAccuracy,
    modelLoss,
  );

  /// Create a copy of TrainedModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TrainedModelImplCopyWith<_$TrainedModelImpl> get copyWith =>
      __$$TrainedModelImplCopyWithImpl<_$TrainedModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TrainedModelImplToJson(this);
  }
}

abstract class _TrainedModel implements TrainedModel {
  const factory _TrainedModel({
    required final int id,
    required final String name,
    required final String type,
    @JsonKey(name: 'created_at') required final DateTime createdAt,
    @JsonKey(name: 'model_path') final String? modelPath,
    required final String status,
    @JsonKey(name: 'training_job_id') final int? trainingJobId,
    @JsonKey(name: 'model_accuracy') final double? modelAccuracy,
    @JsonKey(name: 'model_loss') final double? modelLoss,
  }) = _$TrainedModelImpl;

  factory _TrainedModel.fromJson(Map<String, dynamic> json) =
      _$TrainedModelImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  String get type;
  @override
  @JsonKey(name: 'created_at')
  DateTime get createdAt;
  @override
  @JsonKey(name: 'model_path')
  String? get modelPath;
  @override
  String get status;
  @override
  @JsonKey(name: 'training_job_id')
  int? get trainingJobId;
  @override
  @JsonKey(name: 'model_accuracy')
  double? get modelAccuracy;
  @override
  @JsonKey(name: 'model_loss')
  double? get modelLoss;

  /// Create a copy of TrainedModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TrainedModelImplCopyWith<_$TrainedModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
