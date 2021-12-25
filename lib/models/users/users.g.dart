// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'users.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_pharmappUser _$$_pharmappUserFromJson(Map<String, dynamic> json) =>
    _$_pharmappUser(
      id: json['id'] as int,
      name: json['name'] as String,
      surname: json['surname'] as String,
      email: json['email'] as String,
      profile_pic_url: json['profile_pic_url'] as String? ?? '',
      addresses: (json['addresses'] as List<dynamic>?)
              ?.map((e) => pharmappAddress.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      fav_pharms: (json['fav_pharms'] as List<dynamic>?)
              ?.map((e) => pharmappPharmacy.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      pre_orders: (json['pre_orders'] as List<dynamic>?)
              ?.map((e) => pharmappOrder.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$_pharmappUserToJson(_$_pharmappUser instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'surname': instance.surname,
      'email': instance.email,
      'profile_pic_url': instance.profile_pic_url,
      'addresses': instance.addresses,
      'fav_pharms': instance.fav_pharms,
      'pre_orders': instance.pre_orders,
    };
