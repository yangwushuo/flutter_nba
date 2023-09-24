/*
 * @Author: 杨武硕
 * @Date: 2023-09-23 17:53:43
 * @LastEditors: 杨武硕
 * @LastEditTime: 2023-09-25 00:43:09
 * @Descripttion: 
 */
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TopNew extends StatelessWidget {
  @required
  final String imageUrl;
  @required
  final String title;

  final GestureTapCallback? onTap;

  const TopNew({
    super.key,
    required this.imageUrl,
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.all(5.sp),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  width: 2.sp,
                  color: Theme.of(context).colorScheme.outline,
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(2.sp),
                child: ClipOval(
                  child: Image.network(
                    imageUrl,
                    width: 65.sp,
                    height: 65.sp,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            SizedBox(
              width: 65.sp,
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleSmall,
                maxLines: 2,
                overflow: TextOverflow.visible,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
