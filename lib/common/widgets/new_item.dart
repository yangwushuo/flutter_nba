/*
 * @Author: 杨武硕
 * @Date: 2023-09-23 23:59:20
 * @LastEditors: 杨武硕
 * @LastEditTime: 2023-09-30 02:12:22
 * @Descripttion: 
 */

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nba/common/index.dart';

class NewItem extends StatelessWidget {
  @required
  final int index;

  @required
  final String title;

  @required
  final int timestamp;

  const NewItem({
    super.key,
    required this.index,
    required this.title,
    required this.timestamp,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 40.sp,
      padding: EdgeInsets.symmetric(horizontal: 10.sp),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onBackground,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 14,
            height: 20,
            alignment: Alignment.center,
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: const BorderRadius.all(Radius.circular(4))),
            child: Text(
              index.toString(),
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: Theme.of(context).colorScheme.background,
                    fontWeight: FontWeight.w300,
                  ),
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          Expanded(
            child: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          Text(
            TimeUtil.format(timestamp),
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: Theme.of(context).colorScheme.inversePrimary,
                fontSize: 12.sp,
                fontWeight: FontWeight.w300),
          ),
        ],
      ),
    );
  }
}
