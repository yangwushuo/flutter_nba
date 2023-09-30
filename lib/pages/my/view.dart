/*
 * @Author: 杨武硕
 * @Date: 2023-08-10 23:11:55
 * @LastEditors: 杨武硕
 * @LastEditTime: 2023-09-30 17:49:53
 * @Descripttion: 用户个人页面
 */

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:nba/common/index.dart';
import 'package:nba/pages/my/models/my_item_model.dart';
import 'package:nba/pages/my/widgets/order_space.dart';
import 'package:nba/pages/my/widgets/other_space.dart';
import 'package:nba/pages/my/widgets/user_space.dart';

class MyPage extends StatelessWidget {
  const MyPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                // 头部图片
                Positioned(
                  top: 0,
                  left: 0,
                  child: Image.asset(
                    AssetsImages.my_background,
                    width: MediaQuery.of(context).size.width,
                    height: 360.sp,
                    fit: BoxFit.cover,
                  ),
                ),
                // 过渡
                Positioned(
                  top: 260.sp,
                  left: 0,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 200.sp,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Theme.of(context).colorScheme.background,
                          Theme.of(context).colorScheme.background,
                          Theme.of(context).colorScheme.background,
                          Theme.of(context).colorScheme.background,
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).padding.top,
                  right: 20.sp,
                  child: GestureDetector(
                    onTap: () => context.push(RoutePathMap.more, extra: "我的"),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 3.sp, vertical: 1.sp),
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          borderRadius: BorderRadius.circular(4.sp)),
                      child: Image.asset(
                        AssetsImages.more,
                        width: 25.sp,
                        height: 14.sp,
                        fit: BoxFit.cover,
                        color: Theme.of(context).colorScheme.background,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).padding.top + 26.sp,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Column(
                      children: [
                        SizedBox(
                          width: 200,
                          height: 260.h,
                        ),
                        UserSpace(),
                        OrderSpace(),
                        OtherSpace(),
                        SizedBox(
                          height: 1.h,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
