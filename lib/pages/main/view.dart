/*
 * @Author: 杨武硕
 * @Date: 2023-08-06 23:54:33
 * @LastEditors: 杨武硕
 * @LastEditTime: 2023-09-30 01:30:16
 * @Descripttion: 
 */
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'package:nba/common/index.dart';
import 'package:nba/pages/index.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  /// 当前页面索引 TODO: 后期动态调配
  late int _currentPageIndex;

  /// tabbar控制器
  late PageController _pageController;

  /// 导航页面列表
  List<Widget> _bottomNavPages = [];

  @override
  void initState() {
    super.initState();
    _currentPageIndex = 0;
    _pageController = PageController(initialPage: _currentPageIndex);
    _bottomNavPages.addAll(
      [
        HomePage(),
        GamePage(),
        ShopPage(),
        MyPage(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: _pageController,
          children: _bottomNavPages, // 页面列表
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            _currentPageIndex = index;
            _pageController.jumpToPage(index);
          });
        },
        elevation: 0,
        currentIndex: _currentPageIndex,
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 16.sp,
        unselectedFontSize: 16.sp,
        iconSize: 24.sp,
        enableFeedback: false, // 取消反馈
        items: [
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(bottom: 2),
              child: Image.asset(
                AssetsImages.home_outline,
                width: 22.sp,
                height: 22.sp,
              ),
            ),
            activeIcon: Padding(
              padding: const EdgeInsets.only(bottom: 2),
              child: Image.asset(
                AssetsImages.home_fill,
                width: 22.sp,
                height: 22.sp,
              ),
            ),
            label: "首页",
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(bottom: 2),
              child: Image.asset(
                AssetsImages.basketball_outline,
                width: 24.sp,
                height: 24.sp,
              ),
            ),
            activeIcon: Padding(
              padding: const EdgeInsets.only(bottom: 2),
              child: Image.asset(
                AssetsImages.basketball_fill,
                width: 24.sp,
                height: 24.sp,
              ),
            ),
            label: "比赛",
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(bottom: 2),
              child: Image.asset(
                AssetsImages.shop_outline,
                width: 24.sp,
                height: 24.sp,
              ),
            ),
            activeIcon: Padding(
              padding: const EdgeInsets.only(bottom: 2),
              child: Image.asset(
                AssetsImages.shop_fill,
                width: 24.sp,
                height: 24.sp,
              ),
            ),
            label: "商城",
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(bottom: 2),
              child: Image.asset(
                AssetsImages.my_outline,
                width: 24.sp,
                height: 24.sp,
              ),
            ),
            activeIcon: Padding(
              padding: const EdgeInsets.only(bottom: 2),
              child: Image.asset(
                AssetsImages.my_fill,
                width: 24.sp,
                height: 24.sp,
              ),
            ),
            label: "我的",
          ),
        ],
      ),
    );
  }
}

/// 分离逻辑
extension _MainPageStateExtension on _MainPageState {
  /// 这是详细介绍
  ///
  /// 这是其他详细介绍
  /// ```
  /// 这是是代码介绍
  /// ```
  ///
  /// - Parameter text: void
  /// - Returns: void
  void testOnTip() {
    context.push(RoutePathMap.my);
  }

  /// 页面跳转
  void jumpPage(index) {
    setState() {
      _currentPageIndex = index;
      _pageController.jumpToPage(index);
    }
  }
}
