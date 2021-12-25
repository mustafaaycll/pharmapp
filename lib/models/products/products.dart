import 'package:flutter/services.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'products.freezed.dart';
part 'products.g.dart';


@freezed
class pharmappProduct with _$pharmappProduct {
  
  factory pharmappProduct({
    required int id,
    required String name,
    required String category,
    required double price,
  }) = _pharmappProduct;

  factory pharmappProduct.fromJson(Map<String, dynamic> json) => _$pharmappProductFromJson(json);
}