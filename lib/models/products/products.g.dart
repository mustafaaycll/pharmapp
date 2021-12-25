// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'products.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_pharmappProduct _$$_pharmappProductFromJson(Map<String, dynamic> json) =>
    _$_pharmappProduct(
      id: json['id'] as int,
      name: json['name'] as String,
      category: json['category'] as String,
      price: (json['price'] as num).toDouble(),
    );

Map<String, dynamic> _$$_pharmappProductToJson(_$_pharmappProduct instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'category': instance.category,
      'price': instance.price,
    };
