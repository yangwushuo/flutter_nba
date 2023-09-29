/*
 * @Author: 杨武硕
 * @Date: 2023-09-24 00:39:03
 * @LastEditors: 杨武硕
 * @LastEditTime: 2023-09-30 02:10:18
 * @Descripttion: 
 */
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nba/common/index.dart';

class Recommend extends StatelessWidget {
  @required
  final RecommendType recommendType;

  @required
  final String coverUrl;

  @required
  final String title;

  final int? time;

  const Recommend({
    super.key,
    required this.recommendType,
    required this.coverUrl,
    required this.title,
    this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 2,
      height: 200.sp,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      clipBehavior: Clip.hardEdge,
      child: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image.network(
                    coverUrl,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  left: 5,
                  bottom: 10,
                  child: Row(
                    children: [
                      recommendType == RecommendType.VIDEO
                          ? Container(
                              width: 20.sp,
                              height: 20.sp,
                              decoration: const BoxDecoration(
                                color: Colors.yellow,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.play_arrow,
                                color: Theme.of(context).colorScheme.background,
                                size: 12.sp,
                              ),
                            )
                          : Container(
                              width: 20.sp,
                              height: 20.sp,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.article,
                                color: Theme.of(context).colorScheme.background,
                                size: 12.sp,
                              ),
                            ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        TimeUtil.format2Split(time ?? 0),
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.w400,
                            ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 70.sp,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onBackground,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            alignment: Alignment.center,
            child: Text(
              title,
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    height: 1.5,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
