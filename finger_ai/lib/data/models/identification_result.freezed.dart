// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'identification_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

IdentificationResult _$IdentificationResultFromJson(Map<String, dynamic> json) {
  return _IdentificationResult.fromJson(json);
}

/// @nodoc
mixin _$IdentificationResult {
  @JsonKey(name: 'employee_id')
  String? get employeeId => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;

  /// Serializes this IdentificationResult to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of IdentificationResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $IdentificationResultCopyWith<IdentificationResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IdentificationResultCopyWith<$Res> {
  factory $IdentificationResultCopyWith(
    IdentificationResult value,
    $Res Function(IdentificationResult) then,
  ) = _$IdentificationResultCopyWithImpl<$Res, IdentificationResult>;
  @useResult
  $Res call({@JsonKey(name: 'employee_id') String? employeeId, String status});
}

/// @nodoc
class _$IdentificationResultCopyWithImpl<
  $Res,
  $Val extends IdentificationResult
>
    implements $IdentificationResultCopyWith<$Res> {
  _$IdentificationResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of IdentificationResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? employeeId = freezed, Object? status = null}) {
    return _then(
      _value.copyWith(
            employeeId:
                freezed == employeeId
                    ? _value.employeeId
                    : employeeId // ignore: cast_nullable_to_non_nullable
                        as String?,
            status:
                null == status
                    ? _value.status
                    : status // ignore: cast_nullable_to_non_nullable
                        as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$IdentificationResultImplCopyWith<$Res>
    implements $IdentificationResultCopyWith<$Res> {
  factory _$$IdentificationResultImplCopyWith(
    _$IdentificationResultImpl value,
    $Res Function(_$IdentificationResultImpl) then,
  ) = __$$IdentificationResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@JsonKey(name: 'employee_id') String? employeeId, String status});
}

/// @nodoc
class __$$IdentificationResultImplCopyWithImpl<$Res>
    extends _$IdentificationResultCopyWithImpl<$Res, _$IdentificationResultImpl>
    implements _$$IdentificationResultImplCopyWith<$Res> {
  __$$IdentificationResultImplCopyWithImpl(
    _$IdentificationResultImpl _value,
    $Res Function(_$IdentificationResultImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of IdentificationResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? employeeId = freezed, Object? status = null}) {
    return _then(
      _$IdentificationResultImpl(
        employeeId:
            freezed == employeeId
                ? _value.employeeId
                : employeeId // ignore: cast_nullable_to_non_nullable
                    as String?,
        status:
            null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$IdentificationResultImpl implements _IdentificationResult {
  const _$IdentificationResultImpl({
    @JsonKey(name: 'employee_id') this.employeeId,
    required this.status,
  });

  factory _$IdentificationResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$IdentificationResultImplFromJson(json);

  @override
  @JsonKey(name: 'employee_id')
  final String? employeeId;
  @override
  final String status;

  @override
  String toString() {
    return 'IdentificationResult(employeeId: $employeeId, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IdentificationResultImpl &&
            (identical(other.employeeId, employeeId) ||
                other.employeeId == employeeId) &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, employeeId, status);

  /// Create a copy of IdentificationResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$IdentificationResultImplCopyWith<_$IdentificationResultImpl>
  get copyWith =>
      __$$IdentificationResultImplCopyWithImpl<_$IdentificationResultImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$IdentificationResultImplToJson(this);
  }
}

abstract class _IdentificationResult implements IdentificationResult {
  const factory _IdentificationResult({
    @JsonKey(name: 'employee_id') final String? employeeId,
    required final String status,
  }) = _$IdentificationResultImpl;

  factory _IdentificationResult.fromJson(Map<String, dynamic> json) =
      _$IdentificationResultImpl.fromJson;

  @override
  @JsonKey(name: 'employee_id')
  String? get employeeId;
  @override
  String get status;

  /// Create a copy of IdentificationResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$IdentificationResultImplCopyWith<_$IdentificationResultImpl>
  get copyWith => throw _privateConstructorUsedError;
}
