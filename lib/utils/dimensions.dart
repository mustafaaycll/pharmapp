import 'package:flutter/material.dart';

class Dimen {
  static const double parentMargin = 20;
  static const double regularMargin = 8.0;
  static const double largeMargin = 20.0;
  static const double borderRadius = 8.0;
  static const double borderRadiusRounded = 20.0;
  static const double textFieldHeight = 32.0;

  static get regularPadding => EdgeInsets.all(parentMargin);
  static get boxBorderRadius => BorderRadius.all(Radius.circular(borderRadius));
}