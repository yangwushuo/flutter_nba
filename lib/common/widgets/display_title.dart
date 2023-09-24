import 'package:flutter/material.dart';

class DisplayTitile extends StatelessWidget {
  @required
  final String title;

  @required
  final EdgeInsets edge;

  final TextAlign? textAlign;

  final TextStyle? textStyle;

  const DisplayTitile(
      {super.key,
      required this.title,
      required this.edge,
      this.textAlign,
      this.textStyle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: edge,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Text(
          title,
          textAlign: textAlign ?? TextAlign.start,
          style: textStyle ?? Theme.of(context).textTheme.displayLarge,
        ),
      ),
    );
  }
}
