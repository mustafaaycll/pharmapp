// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'addresses.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

pharmappAddress _$pharmappAddressFromJson(Map<String, dynamic> json) {
  return _pharmappAddress.fromJson(json);
}

/// @nodoc
class _$pharmappAddressTearOff {
  const _$pharmappAddressTearOff();

  _pharmappAddress call(
      {required int id, required String city, required String neighborhood}) {
    return _pharmappAddress(
      id: id,
      city: city,
      neighborhood: neighborhood,
    );
  }

  pharmappAddress fromJson(Map<String, Object?> json) {
    return pharmappAddress.fromJson(json);
  }
}

/// @nodoc
const $pharmappAddress = _$pharmappAddressTearOff();

/// @nodoc
mixin _$pharmappAddress {
  int get id => throw _privateConstructorUsedError;
  String get city => throw _privateConstructorUsedError;
  String get neighborhood => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $pharmappAddressCopyWith<pharmappAddress> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $pharmappAddressCopyWith<$Res> {
  factory $pharmappAddressCopyWith(
          pharmappAddress value, $Res Function(pharmappAddress) then) =
      _$pharmappAddressCopyWithImpl<$Res>;
  $Res call({int id, String city, String neighborhood});
}

/// @nodoc
class _$pharmappAddressCopyWithImpl<$Res>
    implements $pharmappAddressCopyWith<$Res> {
  _$pharmappAddressCopyWithImpl(this._value, this._then);

  final pharmappAddress _value;
  // ignore: unused_field
  final $Res Function(pharmappAddress) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? city = freezed,
    Object? neighborhood = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      city: city == freezed
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String,
      neighborhood: neighborhood == freezed
          ? _value.neighborhood
          : neighborhood // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$pharmappAddressCopyWith<$Res>
    implements $pharmappAddressCopyWith<$Res> {
  factory _$pharmappAddressCopyWith(
          _pharmappAddress value, $Res Function(_pharmappAddress) then) =
      __$pharmappAddressCopyWithImpl<$Res>;
  @override
  $Res call({int id, String city, String neighborhood});
}

/// @nodoc
class __$pharmappAddressCopyWithImpl<$Res>
    extends _$pharmappAddressCopyWithImpl<$Res>
    implements _$pharmappAddressCopyWith<$Res> {
  __$pharmappAddressCopyWithImpl(
      _pharmappAddress _value, $Res Function(_pharmappAddress) _then)
      : super(_value, (v) => _then(v as _pharmappAddress));

  @override
  _pharmappAddress get _value => super._value as _pharmappAddress;

  @override
  $Res call({
    Object? id = freezed,
    Object? city = freezed,
    Object? neighborhood = freezed,
  }) {
    return _then(_pharmappAddress(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      city: city == freezed
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String,
      neighborhood: neighborhood == freezed
          ? _value.neighborhood
          : neighborhood // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_pharmappAddress implements _pharmappAddress {
  _$_pharmappAddress(
      {required this.id, required this.city, required this.neighborhood});

  factory _$_pharmappAddress.fromJson(Map<String, dynamic> json) =>
      _$$_pharmappAddressFromJson(json);

  @override
  final int id;
  @override
  final String city;
  @override
  final String neighborhood;

  @override
  String toString() {
    return 'pharmappAddress(id: $id, city: $city, neighborhood: $neighborhood)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _pharmappAddress &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.city, city) &&
            const DeepCollectionEquality()
                .equals(other.neighborhood, neighborhood));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(city),
      const DeepCollectionEquality().hash(neighborhood));

  @JsonKey(ignore: true)
  @override
  _$pharmappAddressCopyWith<_pharmappAddress> get copyWith =>
      __$pharmappAddressCopyWithImpl<_pharmappAddress>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_pharmappAddressToJson(this);
  }
}

abstract class _pharmappAddress implements pharmappAddress {
  factory _pharmappAddress(
      {required int id,
      required String city,
      required String neighborhood}) = _$_pharmappAddress;

  factory _pharmappAddress.fromJson(Map<String, dynamic> json) =
      _$_pharmappAddress.fromJson;

  @override
  int get id;
  @override
  String get city;
  @override
  String get neighborhood;
  @override
  @JsonKey(ignore: true)
  _$pharmappAddressCopyWith<_pharmappAddress> get copyWith =>
      throw _privateConstructorUsedError;
}
