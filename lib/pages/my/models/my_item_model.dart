import 'package:flutter/material.dart';

class MyItemModel {
  @required
  final String title;
  @required
  final Icon icon;

  final GestureTapCallback? onTap;

  MyItemModel({
    required this.title,
    required this.icon,
    this.onTap,
  });
}
