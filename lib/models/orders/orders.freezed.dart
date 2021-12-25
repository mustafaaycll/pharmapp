// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'orders.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

pharmappOrder _$pharmappOrderFromJson(Map<String, dynamic> json) {
  return _pharmappOrder.fromJson(json);
}

/// @nodoc
class _$pharmappOrderTearOff {
  const _$pharmappOrderTearOff();

  _pharmappOrder call(
      {required int id,
      required int pharmid,
      List<pharmappProduct> products = const [],
      required DateTime date,
      required double cost}) {
    return _pharmappOrder(
      id: id,
      pharmid: pharmid,
      products: products,
      date: date,
      cost: cost,
    );
  }

  pharmappOrder fromJson(Map<String, Object?> json) {
    return pharmappOrder.fromJson(json);
  }
}

/// @nodoc
const $pharmappOrder = _$pharmappOrderTearOff();

/// @nodoc
mixin _$pharmappOrder {
  int get id => throw _privateConstructorUsedError;
  int get pharmid => throw _privateConstructorUsedError;
  List<pharmappProduct> get products => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError;
  double get cost => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $pharmappOrderCopyWith<pharmappOrder> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $pharmappOrderCopyWith<$Res> {
  factory $pharmappOrderCopyWith(
          pharmappOrder value, $Res Function(pharmappOrder) then) =
      _$pharmappOrderCopyWithImpl<$Res>;
  $Res call(
      {int id,
      int pharmid,
      List<pharmappProduct> products,
      DateTime date,
      double cost});
}

/// @nodoc
class _$pharmappOrderCopyWithImpl<$Res>
    implements $pharmappOrderCopyWith<$Res> {
  _$pharmappOrderCopyWithImpl(this._value, this._then);

  final pharmappOrder _value;
  // ignore: unused_field
  final $Res Function(pharmappOrder) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? pharmid = freezed,
    Object? products = freezed,
    Object? date = freezed,
    Object? cost = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      pharmid: pharmid == freezed
          ? _value.pharmid
          : pharmid // ignore: cast_nullable_to_non_nullable
              as int,
      products: products == freezed
          ? _value.products
          : products // ignore: cast_nullable_to_non_nullable
              as List<pharmappProduct>,
      date: date == freezed
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      cost: cost == freezed
          ? _value.cost
          : cost // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
abstract class _$pharmappOrderCopyWith<$Res>
    implements $pharmappOrderCopyWith<$Res> {
  factory _$pharmappOrderCopyWith(
          _pharmappOrder value, $Res Function(_pharmappOrder) then) =
      __$pharmappOrderCopyWithImpl<$Res>;
  @override
  $Res call(
      {int id,
      int pharmid,
      List<pharmappProduct> products,
      DateTime date,
      double cost});
}

/// @nodoc
class __$pharmappOrderCopyWithImpl<$Res>
    extends _$pharmappOrderCopyWithImpl<$Res>
    implements _$pharmappOrderCopyWith<$Res> {
  __$pharmappOrderCopyWithImpl(
      _pharmappOrder _value, $Res Function(_pharmappOrder) _then)
      : super(_value, (v) => _then(v as _pharmappOrder));

  @override
  _pharmappOrder get _value => super._value as _pharmappOrder;

  @override
  $Res call({
    Object? id = freezed,
    Object? pharmid = freezed,
    Object? products = freezed,
    Object? date = freezed,
    Object? cost = freezed,
  }) {
    return _then(_pharmappOrder(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      pharmid: pharmid == freezed
          ? _value.pharmid
          : pharmid // ignore: cast_nullable_to_non_nullable
              as int,
      products: products == freezed
          ? _value.products
          : products // ignore: cast_nullable_to_non_nullable
              as List<pharmappProduct>,
      date: date == freezed
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      cost: cost == freezed
          ? _value.cost
          : cost // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_pharmappOrder implements _pharmappOrder {
  _$_pharmappOrder(
      {required this.id,
      required this.pharmid,
      this.products = const [],
      required this.date,
      required this.cost});

  factory _$_pharmappOrder.fromJson(Map<String, dynamic> json) =>
      _$$_pharmappOrderFromJson(json);

  @override
  final int id;
  @override
  final int pharmid;
  @JsonKey()
  @override
  final List<pharmappProduct> products;
  @override
  final DateTime date;
  @override
  final double cost;

  @override
  String toString() {
    return 'pharmappOrder(id: $id, pharmid: $pharmid, products: $products, date: $date, cost: $cost)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _pharmappOrder &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.pharmid, pharmid) &&
            const DeepCollectionEquality().equals(other.products, products) &&
            const DeepCollectionEquality().equals(other.date, date) &&
            const DeepCollectionEquality().equals(other.cost, cost));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(pharmid),
      const DeepCollectionEquality().hash(products),
      const DeepCollectionEquality().hash(date),
      const DeepCollectionEquality().hash(cost));

  @JsonKey(ignore: true)
  @override
  _$pharmappOrderCopyWith<_pharmappOrder> get copyWith =>
      __$pharmappOrderCopyWithImpl<_pharmappOrder>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_pharmappOrderToJson(this);
  }
}

abstract class _pharmappOrder implements pharmappOrder {
  factory _pharmappOrder(
      {required int id,
      required int pharmid,
      List<pharmappProduct> products,
      required DateTime date,
      required double cost}) = _$_pharmappOrder;

  factory _pharmappOrder.fromJson(Map<String, dynamic> json) =
      _$_pharmappOrder.fromJson;

  @override
  int get id;
  @override
  int get pharmid;
  @override
  List<pharmappProduct> get products;
  @override
  DateTime get date;
  @override
  double get cost;
  @override
  @JsonKey(ignore: true)
  _$pharmappOrderCopyWith<_pharmappOrder> get copyWith =>
      throw _privateConstructorUsedError;
}
