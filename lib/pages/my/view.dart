/*
 * @Author: 杨武硕
 * @Date: 2023-08-10 23:11:55
 * @LastEditors: 杨武硕
 * @LastEditTime: 2023-09-23 15:03:13
 * @Descripttion: 用户个人页面
 */

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:nba/common/index.dart';

class MyPage extends StatelessWidget {
  const MyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        leftChild: Padding(
          padding: EdgeInsets.all(10.sp),
          child: Image.asset(
            AssetsImages.leftArrow3x,
            width: 18.sp,
            height: 18.sp,
          ),
        ),
        leftChildOnTap: context.pop,
        centerChild: Text(
          "测试",
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: SafeArea(
        child: Text(
          "111",
          style: Theme.of(context).textTheme.titleSmall,
        ),
      ),
    );
  }
}
