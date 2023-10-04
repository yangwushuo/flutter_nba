/*
 * @Author: 杨武硕
 * @Date: 2023-08-10 23:23:20
 * @LastEditors: 杨武硕
 * @LastEditTime: 2023-10-01 02:57:03
 * @Descripttion: 创建自定义AppBar组建
 */

import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nba/common/index.dart';

/// 自定义tabbar
class MyAppBar extends StatefulWidget implements PreferredSizeWidget {
  /// 背景颜色
  final Color backgroundColor;

  /// 左侧组件
  final Widget? leftChild;

  /// 左侧点击事件
  final GestureTapCallback? leftChildOnTap;

  /// 中间组件
  final Widget? centerChild;

  /// 中间点击事件
  final GestureTapCallback? centerChildOnTap;

  /// 右侧组件
  final Widget? rightChild;

  /// 右击点击事件
  final GestureTapCallback? rightChildOnTap;

  /// bottom
  final PreferredSizeWidget? bottom;

  const MyAppBar({
    super.key,
    this.backgroundColor = Colors.white,
    this.leftChild,
    this.centerChild,
    this.rightChild,
    this.leftChildOnTap,
    this.centerChildOnTap,
    this.rightChildOnTap,
    this.bottom,
  });

  @override
  State<StatefulWidget> createState() => _AppBarWidgetState();

  @override
  Size get preferredSize => Size.fromHeight(100.h);
}

class _AppBarWidgetState extends State<MyAppBar> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // 安全距离
    var topSafeArea = MediaQuery.of(context).padding.top;

    return Container(
      padding: EdgeInsets.only(
          top: topSafeArea.sp, left: 16.sp, right: 16.sp, bottom: 0),
      width: MediaQuery.of(context).size.width,
      height: topSafeArea.sp +
          AppSpace.topAppBarHeight.sp +
          (widget.bottom?.preferredSize.height.toDouble().sp ?? 0),
      decoration: BoxDecoration(
        color: widget.backgroundColor,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                    onTap: widget.leftChildOnTap,
                    child: widget.leftChild ?? const SizedBox(),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Align(
                  alignment: Alignment.center,
                  child: GestureDetector(
                    onTap: widget.centerChildOnTap,
                    child: widget.centerChild ?? const SizedBox(),
                  ),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: widget.rightChildOnTap,
                    child: widget.rightChild ?? const SizedBox(),
                  ),
                ),
              ),
            ],
          ),
          widget.bottom ?? const SizedBox()
        ],
      ),
    );
  }
}
