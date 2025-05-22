// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'model_update_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ModelUpdateData _$ModelUpdateDataFromJson(Map<String, dynamic> json) {
  return _ModelUpdateData.fromJson(json);
}

/// @nodoc
mixin _$ModelUpdateData {
  String? get name => throw _privateConstructorUsedError;
  String? get status => throw _privateConstructorUsedError;

  /// Serializes this ModelUpdateData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ModelUpdateData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ModelUpdateDataCopyWith<ModelUpdateData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ModelUpdateDataCopyWith<$Res> {
  factory $ModelUpdateDataCopyWith(
    ModelUpdateData value,
    $Res Function(ModelUpdateData) then,
  ) = _$ModelUpdateDataCopyWithImpl<$Res, ModelUpdateData>;
  @useResult
  $Res call({String? name, String? status});
}

/// @nodoc
class _$ModelUpdateDataCopyWithImpl<$Res, $Val extends ModelUpdateData>
    implements $ModelUpdateDataCopyWith<$Res> {
  _$ModelUpdateDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ModelUpdateData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? name = freezed, Object? status = freezed}) {
    return _then(
      _value.copyWith(
            name:
                freezed == name
                    ? _value.name
                    : name // ignore: cast_nullable_to_non_nullable
                        as String?,
            status:
                freezed == status
                    ? _value.status
                    : status // ignore: cast_nullable_to_non_nullable
                        as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ModelUpdateDataImplCopyWith<$Res>
    implements $ModelUpdateDataCopyWith<$Res> {
  factory _$$ModelUpdateDataImplCopyWith(
    _$ModelUpdateDataImpl value,
    $Res Function(_$ModelUpdateDataImpl) then,
  ) = __$$ModelUpdateDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? name, String? status});
}

/// @nodoc
class __$$ModelUpdateDataImplCopyWithImpl<$Res>
    extends _$ModelUpdateDataCopyWithImpl<$Res, _$ModelUpdateDataImpl>
    implements _$$ModelUpdateDataImplCopyWith<$Res> {
  __$$ModelUpdateDataImplCopyWithImpl(
    _$ModelUpdateDataImpl _value,
    $Res Function(_$ModelUpdateDataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ModelUpdateData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? name = freezed, Object? status = freezed}) {
    return _then(
      _$ModelUpdateDataImpl(
        name:
            freezed == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                    as String?,
        status:
            freezed == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                    as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ModelUpdateDataImpl implements _ModelUpdateData {
  const _$ModelUpdateDataImpl({this.name, this.status});

  factory _$ModelUpdateDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$ModelUpdateDataImplFromJson(json);

  @override
  final String? name;
  @override
  final String? status;

  @override
  String toString() {
    return 'ModelUpdateData(name: $name, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ModelUpdateDataImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, status);

  /// Create a copy of ModelUpdateData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ModelUpdateDataImplCopyWith<_$ModelUpdateDataImpl> get copyWith =>
      __$$ModelUpdateDataImplCopyWithImpl<_$ModelUpdateDataImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ModelUpdateDataImplToJson(this);
  }
}

abstract class _ModelUpdateData implements ModelUpdateData {
  const factory _ModelUpdateData({final String? name, final String? status}) =
      _$ModelUpdateDataImpl;

  factory _ModelUpdateData.fromJson(Map<String, dynamic> json) =
      _$ModelUpdateDataImpl.fromJson;

  @override
  String? get name;
  @override
  String? get status;

  /// Create a copy of ModelUpdateData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ModelUpdateDataImplCopyWith<_$ModelUpdateDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
