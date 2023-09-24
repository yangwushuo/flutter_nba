/*
 * @Author: 杨武硕
 * @Date: 2023-09-23 22:47:35
 * @LastEditors: 杨武硕
 * @LastEditTime: 2023-09-24 15:46:55
 * @Descripttion: 
 */
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VideoCover extends StatelessWidget {
  @required
  final String coverUrl;

  final String? title;

  final GestureTapCallback? onTap;

  const VideoCover({super.key, required this.coverUrl, this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(10.sp),
          ),
          image:
              DecorationImage(image: NetworkImage(coverUrl), fit: BoxFit.cover),
        ),
        clipBehavior: Clip.hardEdge,
        margin: const EdgeInsets.symmetric(horizontal: 4.0),
        width: 140.sp,
        height: 200.sp,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              child: Container(
                width: 30.sp,
                height: 30.sp,
                decoration: const BoxDecoration(
                  color: Colors.black45,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.play_arrow,
                  size: 18.sp,
                ),
              ),
            ),
            Positioned(
              left: 2.sp,
              right: 2.sp,
              bottom: 10.sp,
              child: SizedBox(
                width: 150.sp,
                child: Text(
                  title ?? "",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
