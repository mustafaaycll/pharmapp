// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pharmacies.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_pharmappPharmacy _$$_pharmappPharmacyFromJson(Map<String, dynamic> json) =>
    _$_pharmappPharmacy(
      id: json['id'] as int,
      name: json['name'] as String,
      service_addresses: (json['service_addresses'] as List<dynamic>?)
              ?.map((e) => pharmappAddress.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      products: (json['products'] as List<dynamic>?)
              ?.map((e) => pharmappProduct.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      ratings:
          (json['ratings'] as List<dynamic>?)?.map((e) => e as int).toList() ??
              const [],
    );

Map<String, dynamic> _$$_pharmappPharmacyToJson(_$_pharmappPharmacy instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'service_addresses': instance.service_addresses,
      'products': instance.products,
      'ratings': instance.ratings,
    };
