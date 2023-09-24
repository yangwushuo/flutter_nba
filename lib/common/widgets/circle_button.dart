import 'package:flutter/material.dart';

class CircleButton extends StatelessWidget {
  @required
  final Icon icon;
  final double? size;
  final Color? backgroundColor;
  final EdgeInsets? edge;
  final GestureTapCallback? onTap;

  const CircleButton(
      {super.key,
      required this.icon,
      this.size,
      this.backgroundColor,
      this.edge,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: backgroundColor,
          shape: BoxShape.circle,
        ),
        margin: edge,
        child: icon,
      ),
    );
  }
}
