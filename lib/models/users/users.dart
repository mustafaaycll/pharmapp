import 'package:flutter/services.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pharm_app/models/addresses/addresses.dart';
import 'package:pharm_app/models/orders/orders.dart';
import 'package:pharm_app/models/pharmacies/pharmacies.dart';

part 'users.freezed.dart';
part 'users.g.dart';

@freezed
class pharmappUser with _$pharmappUser {
  
  factory pharmappUser({
    required int id,
    required String name,
    required String surname,
    required String email,
    @Default('') String profile_pic_url,
    @Default([]) List<pharmappAddress> addresses,
    @Default([]) List<pharmappPharmacy> fav_pharms,
    @Default([]) List<pharmappOrder> pre_orders,
  }) = _pharmappUser;

  factory pharmappUser.fromJson(Map<String, dynamic> json) => _$pharmappUserFromJson(json);
}