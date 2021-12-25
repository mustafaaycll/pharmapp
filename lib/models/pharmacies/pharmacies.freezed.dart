// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'pharmacies.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

pharmappPharmacy _$pharmappPharmacyFromJson(Map<String, dynamic> json) {
  return _pharmappPharmacy.fromJson(json);
}

/// @nodoc
class _$pharmappPharmacyTearOff {
  const _$pharmappPharmacyTearOff();

  _pharmappPharmacy call(
      {required int id,
      required String name,
      List<pharmappAddress> service_addresses = const [],
      List<pharmappProduct> products = const [],
      List<int> ratings = const []}) {
    return _pharmappPharmacy(
      id: id,
      name: name,
      service_addresses: service_addresses,
      products: products,
      ratings: ratings,
    );
  }

  pharmappPharmacy fromJson(Map<String, Object?> json) {
    return pharmappPharmacy.fromJson(json);
  }
}

/// @nodoc
const $pharmappPharmacy = _$pharmappPharmacyTearOff();

/// @nodoc
mixin _$pharmappPharmacy {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  List<pharmappAddress> get service_addresses =>
      throw _privateConstructorUsedError;
  List<pharmappProduct> get products => throw _privateConstructorUsedError;
  List<int> get ratings => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $pharmappPharmacyCopyWith<pharmappPharmacy> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $pharmappPharmacyCopyWith<$Res> {
  factory $pharmappPharmacyCopyWith(
          pharmappPharmacy value, $Res Function(pharmappPharmacy) then) =
      _$pharmappPharmacyCopyWithImpl<$Res>;
  $Res call(
      {int id,
      String name,
      List<pharmappAddress> service_addresses,
      List<pharmappProduct> products,
      List<int> ratings});
}

/// @nodoc
class _$pharmappPharmacyCopyWithImpl<$Res>
    implements $pharmappPharmacyCopyWith<$Res> {
  _$pharmappPharmacyCopyWithImpl(this._value, this._then);

  final pharmappPharmacy _value;
  // ignore: unused_field
  final $Res Function(pharmappPharmacy) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? service_addresses = freezed,
    Object? products = freezed,
    Object? ratings = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      service_addresses: service_addresses == freezed
          ? _value.service_addresses
          : service_addresses // ignore: cast_nullable_to_non_nullable
              as List<pharmappAddress>,
      products: products == freezed
          ? _value.products
          : products // ignore: cast_nullable_to_non_nullable
              as List<pharmappProduct>,
      ratings: ratings == freezed
          ? _value.ratings
          : ratings // ignore: cast_nullable_to_non_nullable
              as List<int>,
    ));
  }
}

/// @nodoc
abstract class _$pharmappPharmacyCopyWith<$Res>
    implements $pharmappPharmacyCopyWith<$Res> {
  factory _$pharmappPharmacyCopyWith(
          _pharmappPharmacy value, $Res Function(_pharmappPharmacy) then) =
      __$pharmappPharmacyCopyWithImpl<$Res>;
  @override
  $Res call(
      {int id,
      String name,
      List<pharmappAddress> service_addresses,
      List<pharmappProduct> products,
      List<int> ratings});
}

/// @nodoc
class __$pharmappPharmacyCopyWithImpl<$Res>
    extends _$pharmappPharmacyCopyWithImpl<$Res>
    implements _$pharmappPharmacyCopyWith<$Res> {
  __$pharmappPharmacyCopyWithImpl(
      _pharmappPharmacy _value, $Res Function(_pharmappPharmacy) _then)
      : super(_value, (v) => _then(v as _pharmappPharmacy));

  @override
  _pharmappPharmacy get _value => super._value as _pharmappPharmacy;

  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? service_addresses = freezed,
    Object? products = freezed,
    Object? ratings = freezed,
  }) {
    return _then(_pharmappPharmacy(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      service_addresses: service_addresses == freezed
          ? _value.service_addresses
          : service_addresses // ignore: cast_nullable_to_non_nullable
              as List<pharmappAddress>,
      products: products == freezed
          ? _value.products
          : products // ignore: cast_nullable_to_non_nullable
              as List<pharmappProduct>,
      ratings: ratings == freezed
          ? _value.ratings
          : ratings // ignore: cast_nullable_to_non_nullable
              as List<int>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_pharmappPharmacy implements _pharmappPharmacy {
  _$_pharmappPharmacy(
      {required this.id,
      required this.name,
      this.service_addresses = const [],
      this.products = const [],
      this.ratings = const []});

  factory _$_pharmappPharmacy.fromJson(Map<String, dynamic> json) =>
      _$$_pharmappPharmacyFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @JsonKey()
  @override
  final List<pharmappAddress> service_addresses;
  @JsonKey()
  @override
  final List<pharmappProduct> products;
  @JsonKey()
  @override
  final List<int> ratings;

  @override
  String toString() {
    return 'pharmappPharmacy(id: $id, name: $name, service_addresses: $service_addresses, products: $products, ratings: $ratings)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _pharmappPharmacy &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality()
                .equals(other.service_addresses, service_addresses) &&
            const DeepCollectionEquality().equals(other.products, products) &&
            const DeepCollectionEquality().equals(other.ratings, ratings));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(service_addresses),
      const DeepCollectionEquality().hash(products),
      const DeepCollectionEquality().hash(ratings));

  @JsonKey(ignore: true)
  @override
  _$pharmappPharmacyCopyWith<_pharmappPharmacy> get copyWith =>
      __$pharmappPharmacyCopyWithImpl<_pharmappPharmacy>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_pharmappPharmacyToJson(this);
  }
}

abstract class _pharmappPharmacy implements pharmappPharmacy {
  factory _pharmappPharmacy(
      {required int id,
      required String name,
      List<pharmappAddress> service_addresses,
      List<pharmappProduct> products,
      List<int> ratings}) = _$_pharmappPharmacy;

  factory _pharmappPharmacy.fromJson(Map<String, dynamic> json) =
      _$_pharmappPharmacy.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  List<pharmappAddress> get service_addresses;
  @override
  List<pharmappProduct> get products;
  @override
  List<int> get ratings;
  @override
  @JsonKey(ignore: true)
  _$pharmappPharmacyCopyWith<_pharmappPharmacy> get copyWith =>
      throw _privateConstructorUsedError;
}
