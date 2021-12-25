import 'package:flutter/services.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pharm_app/models/products/products.dart';

part 'addresses.freezed.dart';
part 'addresses.g.dart';


@freezed
class pharmappAddress with _$pharmappAddress {
  
  factory pharmappAddress({
    required int id,
    required String city,
    required String neighborhood,
  }) = _pharmappAddress;

  factory pharmappAddress.fromJson(Map<String, dynamic> json) => _$pharmappAddressFromJson(json);
}