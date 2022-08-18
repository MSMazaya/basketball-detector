// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'position_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PositionConfig _$PositionConfigFromJson(Map<String, dynamic> json) {
  return _PositionConfig.fromJson(json);
}

/// @nodoc
mixin _$PositionConfig {
  int get position => throw _privateConstructorUsedError;
  double get starting_angle => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PositionConfigCopyWith<PositionConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PositionConfigCopyWith<$Res> {
  factory $PositionConfigCopyWith(
          PositionConfig value, $Res Function(PositionConfig) then) =
      _$PositionConfigCopyWithImpl<$Res>;
  $Res call({int position, double starting_angle});
}

/// @nodoc
class _$PositionConfigCopyWithImpl<$Res>
    implements $PositionConfigCopyWith<$Res> {
  _$PositionConfigCopyWithImpl(this._value, this._then);

  final PositionConfig _value;
  // ignore: unused_field
  final $Res Function(PositionConfig) _then;

  @override
  $Res call({
    Object? position = freezed,
    Object? starting_angle = freezed,
  }) {
    return _then(_value.copyWith(
      position: position == freezed
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as int,
      starting_angle: starting_angle == freezed
          ? _value.starting_angle
          : starting_angle // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
abstract class _$$_PositionConfigCopyWith<$Res>
    implements $PositionConfigCopyWith<$Res> {
  factory _$$_PositionConfigCopyWith(
          _$_PositionConfig value, $Res Function(_$_PositionConfig) then) =
      __$$_PositionConfigCopyWithImpl<$Res>;
  @override
  $Res call({int position, double starting_angle});
}

/// @nodoc
class __$$_PositionConfigCopyWithImpl<$Res>
    extends _$PositionConfigCopyWithImpl<$Res>
    implements _$$_PositionConfigCopyWith<$Res> {
  __$$_PositionConfigCopyWithImpl(
      _$_PositionConfig _value, $Res Function(_$_PositionConfig) _then)
      : super(_value, (v) => _then(v as _$_PositionConfig));

  @override
  _$_PositionConfig get _value => super._value as _$_PositionConfig;

  @override
  $Res call({
    Object? position = freezed,
    Object? starting_angle = freezed,
  }) {
    return _then(_$_PositionConfig(
      position: position == freezed
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as int,
      starting_angle: starting_angle == freezed
          ? _value.starting_angle
          : starting_angle // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_PositionConfig implements _PositionConfig {
  const _$_PositionConfig(
      {required this.position, required this.starting_angle});

  factory _$_PositionConfig.fromJson(Map<String, dynamic> json) =>
      _$$_PositionConfigFromJson(json);

  @override
  final int position;
  @override
  final double starting_angle;

  @override
  String toString() {
    return 'PositionConfig(position: $position, starting_angle: $starting_angle)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PositionConfig &&
            const DeepCollectionEquality().equals(other.position, position) &&
            const DeepCollectionEquality()
                .equals(other.starting_angle, starting_angle));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(position),
      const DeepCollectionEquality().hash(starting_angle));

  @JsonKey(ignore: true)
  @override
  _$$_PositionConfigCopyWith<_$_PositionConfig> get copyWith =>
      __$$_PositionConfigCopyWithImpl<_$_PositionConfig>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PositionConfigToJson(
      this,
    );
  }
}

abstract class _PositionConfig implements PositionConfig {
  const factory _PositionConfig(
      {required final int position,
      required final double starting_angle}) = _$_PositionConfig;

  factory _PositionConfig.fromJson(Map<String, dynamic> json) =
      _$_PositionConfig.fromJson;

  @override
  int get position;
  @override
  double get starting_angle;
  @override
  @JsonKey(ignore: true)
  _$$_PositionConfigCopyWith<_$_PositionConfig> get copyWith =>
      throw _privateConstructorUsedError;
}
