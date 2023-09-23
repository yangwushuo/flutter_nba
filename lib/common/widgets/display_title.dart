import 'package:flutter/material.dart';

class DisplayTitile extends StatelessWidget {
  @required
  final String title;

  @required
  final EdgeInsets edge;

  const DisplayTitile({super.key, required this.title, required this.edge});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: edge,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Text(
          title,
          textAlign: TextAlign.start,
          style: Theme.of(context).textTheme.displayLarge,
        ),
      ),
    );
  }
}
