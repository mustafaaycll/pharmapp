// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'users.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

pharmappUser _$pharmappUserFromJson(Map<String, dynamic> json) {
  return _pharmappUser.fromJson(json);
}

/// @nodoc
class _$pharmappUserTearOff {
  const _$pharmappUserTearOff();

  _pharmappUser call(
      {required int id,
      required String name,
      required String surname,
      required String email,
      required String password,
      String profile_pic_url = '',
      List<pharmappAddress> addresses = const [],
      List<pharmappPharmacy> fav_pharms = const [],
      List<pharmappOrder> pre_orders = const []}) {
    return _pharmappUser(
      id: id,
      name: name,
      surname: surname,
      email: email,
      password: password,
      profile_pic_url: profile_pic_url,
      addresses: addresses,
      fav_pharms: fav_pharms,
      pre_orders: pre_orders,
    );
  }

  pharmappUser fromJson(Map<String, Object?> json) {
    return pharmappUser.fromJson(json);
  }
}

/// @nodoc
const $pharmappUser = _$pharmappUserTearOff();

/// @nodoc
mixin _$pharmappUser {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get surname => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String get password => throw _privateConstructorUsedError;
  String get profile_pic_url => throw _privateConstructorUsedError;
  List<pharmappAddress> get addresses => throw _privateConstructorUsedError;
  List<pharmappPharmacy> get fav_pharms => throw _privateConstructorUsedError;
  List<pharmappOrder> get pre_orders => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $pharmappUserCopyWith<pharmappUser> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $pharmappUserCopyWith<$Res> {
  factory $pharmappUserCopyWith(
          pharmappUser value, $Res Function(pharmappUser) then) =
      _$pharmappUserCopyWithImpl<$Res>;
  $Res call(
      {int id,
      String name,
      String surname,
      String email,
      String password,
      String profile_pic_url,
      List<pharmappAddress> addresses,
      List<pharmappPharmacy> fav_pharms,
      List<pharmappOrder> pre_orders});
}

/// @nodoc
class _$pharmappUserCopyWithImpl<$Res> implements $pharmappUserCopyWith<$Res> {
  _$pharmappUserCopyWithImpl(this._value, this._then);

  final pharmappUser _value;
  // ignore: unused_field
  final $Res Function(pharmappUser) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? surname = freezed,
    Object? email = freezed,
    Object? password = freezed,
    Object? profile_pic_url = freezed,
    Object? addresses = freezed,
    Object? fav_pharms = freezed,
    Object? pre_orders = freezed,
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
      surname: surname == freezed
          ? _value.surname
          : surname // ignore: cast_nullable_to_non_nullable
              as String,
      email: email == freezed
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      password: password == freezed
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      profile_pic_url: profile_pic_url == freezed
          ? _value.profile_pic_url
          : profile_pic_url // ignore: cast_nullable_to_non_nullable
              as String,
      addresses: addresses == freezed
          ? _value.addresses
          : addresses // ignore: cast_nullable_to_non_nullable
              as List<pharmappAddress>,
      fav_pharms: fav_pharms == freezed
          ? _value.fav_pharms
          : fav_pharms // ignore: cast_nullable_to_non_nullable
              as List<pharmappPharmacy>,
      pre_orders: pre_orders == freezed
          ? _value.pre_orders
          : pre_orders // ignore: cast_nullable_to_non_nullable
              as List<pharmappOrder>,
    ));
  }
}

/// @nodoc
abstract class _$pharmappUserCopyWith<$Res>
    implements $pharmappUserCopyWith<$Res> {
  factory _$pharmappUserCopyWith(
          _pharmappUser value, $Res Function(_pharmappUser) then) =
      __$pharmappUserCopyWithImpl<$Res>;
  @override
  $Res call(
      {int id,
      String name,
      String surname,
      String email,
      String password,
      String profile_pic_url,
      List<pharmappAddress> addresses,
      List<pharmappPharmacy> fav_pharms,
      List<pharmappOrder> pre_orders});
}

/// @nodoc
class __$pharmappUserCopyWithImpl<$Res> extends _$pharmappUserCopyWithImpl<$Res>
    implements _$pharmappUserCopyWith<$Res> {
  __$pharmappUserCopyWithImpl(
      _pharmappUser _value, $Res Function(_pharmappUser) _then)
      : super(_value, (v) => _then(v as _pharmappUser));

  @override
  _pharmappUser get _value => super._value as _pharmappUser;

  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? surname = freezed,
    Object? email = freezed,
    Object? password = freezed,
    Object? profile_pic_url = freezed,
    Object? addresses = freezed,
    Object? fav_pharms = freezed,
    Object? pre_orders = freezed,
  }) {
    return _then(_pharmappUser(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      surname: surname == freezed
          ? _value.surname
          : surname // ignore: cast_nullable_to_non_nullable
              as String,
      email: email == freezed
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      password: password == freezed
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      profile_pic_url: profile_pic_url == freezed
          ? _value.profile_pic_url
          : profile_pic_url // ignore: cast_nullable_to_non_nullable
              as String,
      addresses: addresses == freezed
          ? _value.addresses
          : addresses // ignore: cast_nullable_to_non_nullable
              as List<pharmappAddress>,
      fav_pharms: fav_pharms == freezed
          ? _value.fav_pharms
          : fav_pharms // ignore: cast_nullable_to_non_nullable
              as List<pharmappPharmacy>,
      pre_orders: pre_orders == freezed
          ? _value.pre_orders
          : pre_orders // ignore: cast_nullable_to_non_nullable
              as List<pharmappOrder>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_pharmappUser implements _pharmappUser {
  _$_pharmappUser(
      {required this.id,
      required this.name,
      required this.surname,
      required this.email,
      required this.password,
      this.profile_pic_url = '',
      this.addresses = const [],
      this.fav_pharms = const [],
      this.pre_orders = const []});

  factory _$_pharmappUser.fromJson(Map<String, dynamic> json) =>
      _$$_pharmappUserFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  final String surname;
  @override
  final String email;
  @override
  final String password;
  @JsonKey()
  @override
  final String profile_pic_url;
  @JsonKey()
  @override
  final List<pharmappAddress> addresses;
  @JsonKey()
  @override
  final List<pharmappPharmacy> fav_pharms;
  @JsonKey()
  @override
  final List<pharmappOrder> pre_orders;

  @override
  String toString() {
    return 'pharmappUser(id: $id, name: $name, surname: $surname, email: $email, password: $password, profile_pic_url: $profile_pic_url, addresses: $addresses, fav_pharms: $fav_pharms, pre_orders: $pre_orders)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _pharmappUser &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality().equals(other.surname, surname) &&
            const DeepCollectionEquality().equals(other.email, email) &&
            const DeepCollectionEquality().equals(other.password, password) &&
            const DeepCollectionEquality()
                .equals(other.profile_pic_url, profile_pic_url) &&
            const DeepCollectionEquality().equals(other.addresses, addresses) &&
            const DeepCollectionEquality()
                .equals(other.fav_pharms, fav_pharms) &&
            const DeepCollectionEquality()
                .equals(other.pre_orders, pre_orders));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(surname),
      const DeepCollectionEquality().hash(email),
      const DeepCollectionEquality().hash(password),
      const DeepCollectionEquality().hash(profile_pic_url),
      const DeepCollectionEquality().hash(addresses),
      const DeepCollectionEquality().hash(fav_pharms),
      const DeepCollectionEquality().hash(pre_orders));

  @JsonKey(ignore: true)
  @override
  _$pharmappUserCopyWith<_pharmappUser> get copyWith =>
      __$pharmappUserCopyWithImpl<_pharmappUser>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_pharmappUserToJson(this);
  }
}

abstract class _pharmappUser implements pharmappUser {
  factory _pharmappUser(
      {required int id,
      required String name,
      required String surname,
      required String email,
      required String password,
      String profile_pic_url,
      List<pharmappAddress> addresses,
      List<pharmappPharmacy> fav_pharms,
      List<pharmappOrder> pre_orders}) = _$_pharmappUser;

  factory _pharmappUser.fromJson(Map<String, dynamic> json) =
      _$_pharmappUser.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  String get surname;
  @override
  String get email;
  @override
  String get password;
  @override
  String get profile_pic_url;
  @override
  List<pharmappAddress> get addresses;
  @override
  List<pharmappPharmacy> get fav_pharms;
  @override
  List<pharmappOrder> get pre_orders;
  @override
  @JsonKey(ignore: true)
  _$pharmappUserCopyWith<_pharmappUser> get copyWith =>
      throw _privateConstructorUsedError;
}
