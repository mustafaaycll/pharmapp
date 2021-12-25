// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orders.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_pharmappOrder _$$_pharmappOrderFromJson(Map<String, dynamic> json) =>
    _$_pharmappOrder(
      id: json['id'] as int,
      pharmid: json['pharmid'] as int,
      products: (json['products'] as List<dynamic>?)
              ?.map((e) => pharmappProduct.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      date: DateTime.parse(json['date'] as String),
      cost: (json['cost'] as num).toDouble(),
    );

Map<String, dynamic> _$$_pharmappOrderToJson(_$_pharmappOrder instance) =>
    <String, dynamic>{
      'id': instance.id,
      'pharmid': instance.pharmid,
      'products': instance.products,
      'date': instance.date.toIso8601String(),
      'cost': instance.cost,
    };
