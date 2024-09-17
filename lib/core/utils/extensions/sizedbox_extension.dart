import 'package:flutter/material.dart';

extension SizedboxExtension on int {
  SizedBox get height => SizedBox(height: toDouble());

  SizedBox get width => SizedBox(width: toDouble());
}
