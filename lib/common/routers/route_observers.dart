/*
 * @Author: 杨武硕
 * @Date: 2023-08-09 01:29:28
 * @LastEditors: 杨武硕
 * @LastEditTime: 2023-08-10 23:11:05
 * @Descripttion: 路由监听配置
 */

import 'package:flutter/material.dart';

/// 页面路由监听
class NavObserver extends NavigatorObserver {
  void log(value) => debugPrint('MyNavObserver:$value');

  @override
  void didPush(
    Route<dynamic> route,
    Route<dynamic>? previousRoute,
  ) {
    log('didPush: ${route.toString()}, previousRoute= ${previousRoute?.toString()}');
  }

  @override
  void didPop(
    Route<dynamic> route,
    Route<dynamic>? previousRoute,
  ) {
    log('didPop: ${route.toString()}, previousRoute= ${previousRoute?.toString()}');
  }

  @override
  void didRemove(
    Route<dynamic> route,
    Route<dynamic>? previousRoute,
  ) {
    log('didRemove: ${route.toString()}, previousRoute= ${previousRoute?.toString()}');
  }

  @override
  void didReplace({
    Route<dynamic>? newRoute,
    Route<dynamic>? oldRoute,
  }) {
    log('didReplace: new= ${newRoute?.toString()}, old= ${oldRoute?.toString()}');
  }

  @override
  void didStartUserGesture(
    Route<dynamic> route,
    Route<dynamic>? previousRoute,
  ) {
    log('didStartUserGesture: ${route.toString()}, '
        'previousRoute= ${previousRoute?.toString()}');
  }

  @override
  void didStopUserGesture() {
    log('didStopUserGesture');
  }
}
