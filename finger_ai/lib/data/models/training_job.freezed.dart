// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'training_job.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

TrainingJob _$TrainingJobFromJson(Map<String, dynamic> json) {
  return _TrainingJob.fromJson(json);
}

/// @nodoc
mixin _$TrainingJob {
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'model_type')
  String get modelType => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'started_at')
  DateTime? get startedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'completed_at')
  DateTime? get completedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'uploaded_data_path')
  String? get uploadedDataPath => throw _privateConstructorUsedError;
  @JsonKey(name: 'original_filename')
  String? get originalFilename => throw _privateConstructorUsedError;
  @JsonKey(name: 'config_params')
  Map<String, dynamic> get configParams => throw _privateConstructorUsedError;
  @JsonKey(name: 'error_message')
  String? get errorMessage => throw _privateConstructorUsedError;

  /// Serializes this TrainingJob to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TrainingJob
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TrainingJobCopyWith<TrainingJob> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TrainingJobCopyWith<$Res> {
  factory $TrainingJobCopyWith(
    TrainingJob value,
    $Res Function(TrainingJob) then,
  ) = _$TrainingJobCopyWithImpl<$Res, TrainingJob>;
  @useResult
  $Res call({
    int id,
    @JsonKey(name: 'model_type') String modelType,
    String status,
    @JsonKey(name: 'created_at') DateTime createdAt,
    @JsonKey(name: 'started_at') DateTime? startedAt,
    @JsonKey(name: 'completed_at') DateTime? completedAt,
    @JsonKey(name: 'uploaded_data_path') String? uploadedDataPath,
    @JsonKey(name: 'original_filename') String? originalFilename,
    @JsonKey(name: 'config_params') Map<String, dynamic> configParams,
    @JsonKey(name: 'error_message') String? errorMessage,
  });
}

/// @nodoc
class _$TrainingJobCopyWithImpl<$Res, $Val extends TrainingJob>
    implements $TrainingJobCopyWith<$Res> {
  _$TrainingJobCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TrainingJob
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? modelType = null,
    Object? status = null,
    Object? createdAt = null,
    Object? startedAt = freezed,
    Object? completedAt = freezed,
    Object? uploadedDataPath = freezed,
    Object? originalFilename = freezed,
    Object? configParams = null,
    Object? errorMessage = freezed,
  }) {
    return _then(
      _value.copyWith(
            id:
                null == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as int,
            modelType:
                null == modelType
                    ? _value.modelType
                    : modelType // ignore: cast_nullable_to_non_nullable
                        as String,
            status:
                null == status
                    ? _value.status
                    : status // ignore: cast_nullable_to_non_nullable
                        as String,
            createdAt:
                null == createdAt
                    ? _value.createdAt
                    : createdAt // ignore: cast_nullable_to_non_nullable
                        as DateTime,
            startedAt:
                freezed == startedAt
                    ? _value.startedAt
                    : startedAt // ignore: cast_nullable_to_non_nullable
                        as DateTime?,
            completedAt:
                freezed == completedAt
                    ? _value.completedAt
                    : completedAt // ignore: cast_nullable_to_non_nullable
                        as DateTime?,
            uploadedDataPath:
                freezed == uploadedDataPath
                    ? _value.uploadedDataPath
                    : uploadedDataPath // ignore: cast_nullable_to_non_nullable
                        as String?,
            originalFilename:
                freezed == originalFilename
                    ? _value.originalFilename
                    : originalFilename // ignore: cast_nullable_to_non_nullable
                        as String?,
            configParams:
                null == configParams
                    ? _value.configParams
                    : configParams // ignore: cast_nullable_to_non_nullable
                        as Map<String, dynamic>,
            errorMessage:
                freezed == errorMessage
                    ? _value.errorMessage
                    : errorMessage // ignore: cast_nullable_to_non_nullable
                        as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TrainingJobImplCopyWith<$Res>
    implements $TrainingJobCopyWith<$Res> {
  factory _$$TrainingJobImplCopyWith(
    _$TrainingJobImpl value,
    $Res Function(_$TrainingJobImpl) then,
  ) = __$$TrainingJobImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    @JsonKey(name: 'model_type') String modelType,
    String status,
    @JsonKey(name: 'created_at') DateTime createdAt,
    @JsonKey(name: 'started_at') DateTime? startedAt,
    @JsonKey(name: 'completed_at') DateTime? completedAt,
    @JsonKey(name: 'uploaded_data_path') String? uploadedDataPath,
    @JsonKey(name: 'original_filename') String? originalFilename,
    @JsonKey(name: 'config_params') Map<String, dynamic> configParams,
    @JsonKey(name: 'error_message') String? errorMessage,
  });
}

/// @nodoc
class __$$TrainingJobImplCopyWithImpl<$Res>
    extends _$TrainingJobCopyWithImpl<$Res, _$TrainingJobImpl>
    implements _$$TrainingJobImplCopyWith<$Res> {
  __$$TrainingJobImplCopyWithImpl(
    _$TrainingJobImpl _value,
    $Res Function(_$TrainingJobImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TrainingJob
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? modelType = null,
    Object? status = null,
    Object? createdAt = null,
    Object? startedAt = freezed,
    Object? completedAt = freezed,
    Object? uploadedDataPath = freezed,
    Object? originalFilename = freezed,
    Object? configParams = null,
    Object? errorMessage = freezed,
  }) {
    return _then(
      _$TrainingJobImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as int,
        modelType:
            null == modelType
                ? _value.modelType
                : modelType // ignore: cast_nullable_to_non_nullable
                    as String,
        status:
            null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                    as String,
        createdAt:
            null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                    as DateTime,
        startedAt:
            freezed == startedAt
                ? _value.startedAt
                : startedAt // ignore: cast_nullable_to_non_nullable
                    as DateTime?,
        completedAt:
            freezed == completedAt
                ? _value.completedAt
                : completedAt // ignore: cast_nullable_to_non_nullable
                    as DateTime?,
        uploadedDataPath:
            freezed == uploadedDataPath
                ? _value.uploadedDataPath
                : uploadedDataPath // ignore: cast_nullable_to_non_nullable
                    as String?,
        originalFilename:
            freezed == originalFilename
                ? _value.originalFilename
                : originalFilename // ignore: cast_nullable_to_non_nullable
                    as String?,
        configParams:
            null == configParams
                ? _value._configParams
                : configParams // ignore: cast_nullable_to_non_nullable
                    as Map<String, dynamic>,
        errorMessage:
            freezed == errorMessage
                ? _value.errorMessage
                : errorMessage // ignore: cast_nullable_to_non_nullable
                    as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TrainingJobImpl implements _TrainingJob {
  const _$TrainingJobImpl({
    required this.id,
    @JsonKey(name: 'model_type') required this.modelType,
    required this.status,
    @JsonKey(name: 'created_at') required this.createdAt,
    @JsonKey(name: 'started_at') this.startedAt,
    @JsonKey(name: 'completed_at') this.completedAt,
    @JsonKey(name: 'uploaded_data_path') this.uploadedDataPath,
    @JsonKey(name: 'original_filename') this.originalFilename,
    @JsonKey(name: 'config_params')
    required final Map<String, dynamic> configParams,
    @JsonKey(name: 'error_message') this.errorMessage,
  }) : _configParams = configParams;

  factory _$TrainingJobImpl.fromJson(Map<String, dynamic> json) =>
      _$$TrainingJobImplFromJson(json);

  @override
  final int id;
  @override
  @JsonKey(name: 'model_type')
  final String modelType;
  @override
  final String status;
  @override
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @override
  @JsonKey(name: 'started_at')
  final DateTime? startedAt;
  @override
  @JsonKey(name: 'completed_at')
  final DateTime? completedAt;
  @override
  @JsonKey(name: 'uploaded_data_path')
  final String? uploadedDataPath;
  @override
  @JsonKey(name: 'original_filename')
  final String? originalFilename;
  final Map<String, dynamic> _configParams;
  @override
  @JsonKey(name: 'config_params')
  Map<String, dynamic> get configParams {
    if (_configParams is EqualUnmodifiableMapView) return _configParams;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_configParams);
  }

  @override
  @JsonKey(name: 'error_message')
  final String? errorMessage;

  @override
  String toString() {
    return 'TrainingJob(id: $id, modelType: $modelType, status: $status, createdAt: $createdAt, startedAt: $startedAt, completedAt: $completedAt, uploadedDataPath: $uploadedDataPath, originalFilename: $originalFilename, configParams: $configParams, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TrainingJobImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.modelType, modelType) ||
                other.modelType == modelType) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.startedAt, startedAt) ||
                other.startedAt == startedAt) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt) &&
            (identical(other.uploadedDataPath, uploadedDataPath) ||
                other.uploadedDataPath == uploadedDataPath) &&
            (identical(other.originalFilename, originalFilename) ||
                other.originalFilename == originalFilename) &&
            const DeepCollectionEquality().equals(
              other._configParams,
              _configParams,
            ) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    modelType,
    status,
    createdAt,
    startedAt,
    completedAt,
    uploadedDataPath,
    originalFilename,
    const DeepCollectionEquality().hash(_configParams),
    errorMessage,
  );

  /// Create a copy of TrainingJob
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TrainingJobImplCopyWith<_$TrainingJobImpl> get copyWith =>
      __$$TrainingJobImplCopyWithImpl<_$TrainingJobImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TrainingJobImplToJson(this);
  }
}

abstract class _TrainingJob implements TrainingJob {
  const factory _TrainingJob({
    required final int id,
    @JsonKey(name: 'model_type') required final String modelType,
    required final String status,
    @JsonKey(name: 'created_at') required final DateTime createdAt,
    @JsonKey(name: 'started_at') final DateTime? startedAt,
    @JsonKey(name: 'completed_at') final DateTime? completedAt,
    @JsonKey(name: 'uploaded_data_path') final String? uploadedDataPath,
    @JsonKey(name: 'original_filename') final String? originalFilename,
    @JsonKey(name: 'config_params')
    required final Map<String, dynamic> configParams,
    @JsonKey(name: 'error_message') final String? errorMessage,
  }) = _$TrainingJobImpl;

  factory _TrainingJob.fromJson(Map<String, dynamic> json) =
      _$TrainingJobImpl.fromJson;

  @override
  int get id;
  @override
  @JsonKey(name: 'model_type')
  String get modelType;
  @override
  String get status;
  @override
  @JsonKey(name: 'created_at')
  DateTime get createdAt;
  @override
  @JsonKey(name: 'started_at')
  DateTime? get startedAt;
  @override
  @JsonKey(name: 'completed_at')
  DateTime? get completedAt;
  @override
  @JsonKey(name: 'uploaded_data_path')
  String? get uploadedDataPath;
  @override
  @JsonKey(name: 'original_filename')
  String? get originalFilename;
  @override
  @JsonKey(name: 'config_params')
  Map<String, dynamic> get configParams;
  @override
  @JsonKey(name: 'error_message')
  String? get errorMessage;

  /// Create a copy of TrainingJob
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TrainingJobImplCopyWith<_$TrainingJobImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
