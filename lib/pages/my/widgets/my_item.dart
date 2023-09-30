import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyItem extends StatelessWidget {
  @required
  final String title;
  @required
  final Icon icon;

  const MyItem({super.key, required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).colorScheme.inversePrimary;
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(8.0.sp),
          child: icon,
        ),
        Text(
          title,
          style: Theme.of(context)
              .textTheme
              .titleSmall
              ?.copyWith(color: color, fontSize: 10.sp),
        )
      ],
    );
  }
}
