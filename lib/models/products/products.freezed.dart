// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'products.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

pharmappProduct _$pharmappProductFromJson(Map<String, dynamic> json) {
  return _pharmappProduct.fromJson(json);
}

/// @nodoc
class _$pharmappProductTearOff {
  const _$pharmappProductTearOff();

  _pharmappProduct call(
      {required int id,
      required String name,
      required String category,
      required double price}) {
    return _pharmappProduct(
      id: id,
      name: name,
      category: category,
      price: price,
    );
  }

  pharmappProduct fromJson(Map<String, Object?> json) {
    return pharmappProduct.fromJson(json);
  }
}

/// @nodoc
const $pharmappProduct = _$pharmappProductTearOff();

/// @nodoc
mixin _$pharmappProduct {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get category => throw _privateConstructorUsedError;
  double get price => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $pharmappProductCopyWith<pharmappProduct> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $pharmappProductCopyWith<$Res> {
  factory $pharmappProductCopyWith(
          pharmappProduct value, $Res Function(pharmappProduct) then) =
      _$pharmappProductCopyWithImpl<$Res>;
  $Res call({int id, String name, String category, double price});
}

/// @nodoc
class _$pharmappProductCopyWithImpl<$Res>
    implements $pharmappProductCopyWith<$Res> {
  _$pharmappProductCopyWithImpl(this._value, this._then);

  final pharmappProduct _value;
  // ignore: unused_field
  final $Res Function(pharmappProduct) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? category = freezed,
    Object? price = freezed,
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
      category: category == freezed
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      price: price == freezed
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
abstract class _$pharmappProductCopyWith<$Res>
    implements $pharmappProductCopyWith<$Res> {
  factory _$pharmappProductCopyWith(
          _pharmappProduct value, $Res Function(_pharmappProduct) then) =
      __$pharmappProductCopyWithImpl<$Res>;
  @override
  $Res call({int id, String name, String category, double price});
}

/// @nodoc
class __$pharmappProductCopyWithImpl<$Res>
    extends _$pharmappProductCopyWithImpl<$Res>
    implements _$pharmappProductCopyWith<$Res> {
  __$pharmappProductCopyWithImpl(
      _pharmappProduct _value, $Res Function(_pharmappProduct) _then)
      : super(_value, (v) => _then(v as _pharmappProduct));

  @override
  _pharmappProduct get _value => super._value as _pharmappProduct;

  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? category = freezed,
    Object? price = freezed,
  }) {
    return _then(_pharmappProduct(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      category: category == freezed
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      price: price == freezed
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_pharmappProduct implements _pharmappProduct {
  _$_pharmappProduct(
      {required this.id,
      required this.name,
      required this.category,
      required this.price});

  factory _$_pharmappProduct.fromJson(Map<String, dynamic> json) =>
      _$$_pharmappProductFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  final String category;
  @override
  final double price;

  @override
  String toString() {
    return 'pharmappProduct(id: $id, name: $name, category: $category, price: $price)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _pharmappProduct &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality().equals(other.category, category) &&
            const DeepCollectionEquality().equals(other.price, price));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(category),
      const DeepCollectionEquality().hash(price));

  @JsonKey(ignore: true)
  @override
  _$pharmappProductCopyWith<_pharmappProduct> get copyWith =>
      __$pharmappProductCopyWithImpl<_pharmappProduct>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_pharmappProductToJson(this);
  }
}

abstract class _pharmappProduct implements pharmappProduct {
  factory _pharmappProduct(
      {required int id,
      required String name,
      required String category,
      required double price}) = _$_pharmappProduct;

  factory _pharmappProduct.fromJson(Map<String, dynamic> json) =
      _$_pharmappProduct.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  String get category;
  @override
  double get price;
  @override
  @JsonKey(ignore: true)
  _$pharmappProductCopyWith<_pharmappProduct> get copyWith =>
      throw _privateConstructorUsedError;
}
