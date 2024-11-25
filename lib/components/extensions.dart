import 'package:flutter/material.dart';

extension Spacing on num {
  SizedBox get height => SizedBox(height: toDouble());
  SizedBox get width => SizedBox(width: toDouble());
}

extension ImagePath on String {
  String get toPng => 'assets/images/$this.png';
  String get toSvg => 'assets/images/$this.svg';
}
