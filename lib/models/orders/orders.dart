import 'package:flutter/services.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pharm_app/models/products/products.dart';

part 'orders.freezed.dart';
part 'orders.g.dart';


@freezed
class pharmappOrder with _$pharmappOrder {
  
  factory pharmappOrder({
    required int id,
    required int pharmid,
    @Default([]) List<pharmappProduct> products,
    required DateTime date,
    required double cost,
  }) = _pharmappOrder;

  factory pharmappOrder.fromJson(Map<String, dynamic> json) => _$pharmappOrderFromJson(json);
}