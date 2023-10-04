/*
 * @Author: 杨武硕
 * @Date: 2023-09-23 15:08:02
 * @LastEditors: 杨武硕
 * @LastEditTime: 2023-10-01 23:44:15
 * @Descripttion: 
 */

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:nba/common/index.dart';
import 'package:nba/pages/game/widgets/schedule.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage>
    with SingleTickerProviderStateMixin {
  final List<Tab> _tabs = <Tab>[
    Tab(
      text: '赛程',
    ),
    Tab(
      text: '排名',
    ),
    Tab(
      text: '数据',
    ),
  ];

  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(vsync: this, length: _tabs.length);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        controller: _tabController,
        children: [Schedule(), Text("data"), Text("data")],
      ),
      appBar: MyAppBar(
        backgroundColor: Colors.transparent,
        leftChild: Image.asset(
          AssetsImages.logo_nba,
          height: AppSpace.topAppBarHeight.sp,
        ),
        leftChildOnTap: context.pop,
        rightChild: Padding(
          padding: EdgeInsets.all(10.sp),
          child: Image.asset(
            AssetsImages.more,
            width: 20.sp,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        rightChildOnTap: () => context.push(RoutePathMap.more),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(28.sp),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 28.sp,
            color: Colors.white10,
            child: TabBar(
              dividerHeight: 0, // 边框宽度
              isScrollable: false,
              tabAlignment: TabAlignment.fill,
              labelColor: Colors.white, // 选中的Widget颜色
              labelStyle: Theme.of(context).textTheme.titleSmall,
              unselectedLabelColor: Colors.white60,
              unselectedLabelStyle: Theme.of(context).textTheme.titleSmall,
              controller: _tabController,
              indicator: UnderlineTabIndicator(
                borderSide: BorderSide(color: Colors.yellow, width: 2.sp),
                insets: EdgeInsets.fromLTRB(10.sp, 0, 10.sp, 0),
              ),
              padding: EdgeInsets.zero,
              labelPadding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              // 有 tab 和 label 两种
              tabs: _tabs,
            ),
          ),
        ),
      ),
    );
  }
}
