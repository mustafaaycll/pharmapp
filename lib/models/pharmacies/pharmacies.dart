import 'package:flutter/services.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pharm_app/models/addresses/addresses.dart';
import 'package:pharm_app/models/products/products.dart';

part 'pharmacies.freezed.dart';
part 'pharmacies.g.dart';


@freezed
class pharmappPharmacy with _$pharmappPharmacy {
  
  factory pharmappPharmacy({
    required int id,
    required String name,
    @Default([]) List<pharmappAddress> service_addresses,
    @Default([]) List<pharmappProduct> products,
    @Default([]) List<int> ratings,
  }) = _pharmappPharmacy;

  factory pharmappPharmacy.fromJson(Map<String, dynamic> json) => _$pharmappPharmacyFromJson(json);
}