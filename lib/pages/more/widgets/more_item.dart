/*
 * @Author: 杨武硕
 * @Date: 2023-09-25 01:10:46
 * @LastEditors: 杨武硕
 * @LastEditTime: 2023-09-25 01:42:13
 * @Descripttion: 
 */
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MoreItem extends StatelessWidget {
  @required
  final String title;

  @required
  final Icon icon;

  final Border? border;

  final GestureTapCallback? onTap;

  const MoreItem({
    super.key,
    required this.title,
    this.border,
    required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 45.sp,
        padding: EdgeInsets.symmetric(horizontal: 16.sp),
        decoration: BoxDecoration(border: border),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            icon,
            SizedBox(
              width: 15.sp,
            ),
            Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontSize: 16.sp),
            )
          ],
        ),
      ),
    );
  }
}
