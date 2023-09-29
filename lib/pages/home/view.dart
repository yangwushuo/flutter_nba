/*
 * @Author: 杨武硕
 * @Date: 2023-09-23 15:18:45
 * @LastEditors: 杨武硕
 * @LastEditTime: 2023-09-30 02:44:11
 * @Descripttion: 
 */
import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:nba/common/index.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  /// 主视图垂直滚动控制器
  late ScrollController _bodyScrollController;

  /// 头部新闻滚动控制器
  late ScrollController _topNewScrollController;

  /// 轮播图控制器
  late CarouselController _carouselController;

  /// 刷新控制器
  late EasyRefreshController _easyRefreshController;

  /// 旋转控制器
  late AnimationController _rotationController;

  /// 刷新旋转角度
  int _count = 0;

  /// topbar显示头部标题
  bool _showBarTitle = false;

  /// 显示头部标题内容
  String _barTitle = "";

  @override
  void initState() {
    super.initState();
    _bodyScrollController = ScrollController();
    _topNewScrollController = ScrollController();
    _carouselController = CarouselController();
    _easyRefreshController = EasyRefreshController(
      controlFinishLoad: true,
      controlFinishRefresh: true,
    );
    _rotationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 100), // 持续时间为100秒
    );
    _rotationController.repeat(); // 循环旋转
    listenBodyScroll();
  }

  @override
  void dispose() {
    _bodyScrollController.dispose();
    _topNewScrollController.dispose();
    _easyRefreshController.dispose();
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        backgroundColor: Colors.transparent,
        leftChild: Padding(
          padding: EdgeInsets.all(10.sp),
          child: Image.asset(
            AssetsImages.logo_nba,
          ),
        ),
        leftChildOnTap: context.pop,
        centerChild: AnimatedSlide(
          offset: _showBarTitle ? const Offset(0, 0) : const Offset(0, -2),
          duration: const Duration(milliseconds: 300),
          curve: Curves.linear,
          child: DisplayTitile(
            title: _barTitle,
            textAlign: TextAlign.center,
            textStyle:
                Theme.of(context).textTheme.displayLarge?.copyWith(height: 1),
            edge: EdgeInsets.only(bottom: 0.sp, left: 0.sp),
          ),
        ),
        centerChildOnTap: () => _bodyScrollController.animateTo(0,
            duration: const Duration(milliseconds: 400),
            curve: Curves.linear), // 跳回顶部
        rightChild: Padding(
          padding: EdgeInsets.all(10.sp),
          child: Icon(
            Icons.more_horiz,
            color: Theme.of(context).colorScheme.primary,
            size: 20.sp,
          ),
        ),
        rightChildOnTap: _toMore,
      ),
      body: Column(
        children: [
          Expanded(
            child: EasyRefresh.builder(
              controller: _easyRefreshController,
              onRefresh: _onRefresh,
              onLoad: _onLoading,
              callLoadOverOffset: 100.sp,
              callRefreshOverOffset: 100.sp,
              header: BuilderHeader(
                triggerOffset: 100.sp,
                clamping: false,
                position: IndicatorPosition.above,
                processedDuration: Duration.zero,
                springRebound: true,
                hapticFeedback: true,
                builder: createLoadingWidget,
              ),
              footer: BuilderFooter(
                triggerOffset: 100.sp,
                clamping: false,
                position: IndicatorPosition.behind,
                processedDuration: Duration.zero,
                springRebound: true,
                hapticFeedback: true,
                builder: createLoadingWidget,
                infiniteOffset: null,
              ),
              childBuilder: (context, physics) => SingleChildScrollView(
                controller: _bodyScrollController,
                physics: physics,
                child: Column(
                  children: [
                    // 头部新闻
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 115.sp,
                      child: ListView.builder(
                        controller: _topNewScrollController,
                        scrollDirection: Axis.horizontal,
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return TopNew(
                            imageUrl: 'https://api.dujin.org/bing/1366.php',
                            title: "212adfasdfasdfasdfasdfadsfadsfas",
                            onTap: _toVideoPlay,
                          );
                        },
                      ),
                    ),
                    // 轮播图ss
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 20.sp,
                        horizontal: 0.sp,
                      ),
                      child: CarouselSlider(
                        carouselController: _carouselController,
                        options: CarouselOptions(
                          height: 200.sp,
                          autoPlay: true,
                          enlargeCenterPage: false,
                          viewportFraction: 1,
                          aspectRatio: 2.0,
                          clipBehavior: Clip.antiAlias,
                          disableCenter: true,
                          initialPage: 0,
                          scrollPhysics: const BouncingScrollPhysics(),
                        ),
                        disableGesture: true,
                        items: [1, 2, 3, 4].map((i) {
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            clipBehavior: Clip.hardEdge,
                            child: Stack(
                              children: [
                                Positioned.fill(
                                  child: Image.network(
                                    'https://api.dujin.org/bing/1366.php',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Positioned(
                                  left: 15.sp,
                                  right: 15.sp,
                                  bottom: 20.sp,
                                  child: Text(
                                    "球场放大镜: 这是一个标题什么也没有这是一个标题什么也没有这是一个标题什么也没有这是一个标题什么也没有",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge
                                        ?.copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.sp),
                      child: DisplayTitile(
                        title: "今日必看",
                        edge: EdgeInsets.only(bottom: 20.sp, left: 5.sp),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 200.sp,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 10,
                        itemBuilder: (context, index) => VideoCover(
                          coverUrl: 'https://api.dujin.org/bing/1366.php',
                          title: "212adfasdfasdfasdfasdfadsfadsfas",
                          onTap: _toVideoPlay,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.sp),
                      child: DisplayTitile(
                        title: "热门内容",
                        edge: EdgeInsets.only(
                            top: 20.sp, bottom: 20.sp, left: 5.sp),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.sp),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 200.sp,
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        clipBehavior: Clip.hardEdge,
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: 8,
                          itemBuilder: (context, index) => NewItem(
                            index: index + 1,
                            title: "212adfasdfasdfasdfasdfadsfadsfas",
                            timestamp: DateTime.now().millisecondsSinceEpoch -
                                index * 1000000,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.sp),
                      child: DisplayTitile(
                        title: "推荐",
                        edge: EdgeInsets.only(
                            top: 20.sp, bottom: 20.sp, left: 5.sp),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.sp),
                      child: GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent:
                              MediaQuery.of(context).size.width /
                                  2, // 设置最大交叉轴扩展
                          mainAxisExtent: 270.sp,
                          mainAxisSpacing: 10.0, // 设置主轴间距
                          crossAxisSpacing: 10.0, // 设置交叉轴间距
                        ),
                        itemBuilder: (context, index) {
                          return const Recommend(
                            recommendType: RecommendType.VIDEO,
                            coverUrl: 'https://api.dujin.org/bing/1366.php',
                            title: "手感来了挡不住？乔丹耸肩摆手庆祝",
                            time: 100,
                          );
                        },
                        itemCount: _count,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

/// 逻辑分离
extension _HomePageStateExtension on _HomePageState {
  /// 主体滚动监听
  void listenBodyScroll() {
    _bodyScrollController.addListener(() {
      double offsetValue = _bodyScrollController.offset;
      _setTopBarTitle(offsetValue);
    });
  }

  /// topbar标题设置
  void _setTopBarTitle(double offsetValue) {
    offsetValue > 380.sp ? _showBarTitle = true : _showBarTitle = false;
    setState(() {
      if (offsetValue > 380.sp && offsetValue < 640.sp) {
        _barTitle = "今日必看";
      } else if (offsetValue > 640.sp && offsetValue < 900.sp) {
        _barTitle = "热门内容";
      } else if (offsetValue > 900.sp) {
        _barTitle = "推荐";
      } else {
        _barTitle = "";
      }
    });
  }

  /// 视频播放
  void _toVideoPlay() {
    context.push(RoutePathMap.videoPlay);
  }

  /// 更多
  void _toMore() {
    context.push(RoutePathMap.more);
  }

  /// 上拉刷新
  Future<void> _onRefresh() async {
    print("刷新");
    await Future.delayed(Duration(milliseconds: 3000));
    if (mounted) {
      _easyRefreshController.finishRefresh(IndicatorResult.success);
      _easyRefreshController.resetHeader();
    }
  }

  /// 加载
  Future<void> _onLoading() async {
    print("加载");
    await Future.delayed(Duration(milliseconds: 3000));
    if (mounted) {
      setState(() {
        _count = 8;
      });
      _easyRefreshController.finishLoad(IndicatorResult.success);
      _easyRefreshController.resetFooter();
    }
  }

  /// 加载图标
  Widget createLoadingWidget(BuildContext contenxt, IndicatorState state) {
    switch (state.mode) {
      case IndicatorMode.inactive:
        return const SizedBox();
      case IndicatorMode.ready:
      case IndicatorMode.armed:
      case IndicatorMode.drag:
        return SizedBox(
          height: state.offset.sp,
          child: UnconstrainedBox(
            child: RotationTransition(
              turns: AlwaysStoppedAnimation(state.offset.sp / 60),
              child: Image.asset(
                AssetsImages.basketball_icon,
                width: state.offset.sp * 0.3 >= 30.sp
                    ? 30.sp
                    : state.offset.sp * 0.3,
                height: state.offset.sp * 0.3 >= 30.sp
                    ? 30.sp
                    : state.offset.sp * 0.3,
                color: Colors.white54,
                fit: BoxFit.contain,
              ),
            ),
          ),
        );
      case IndicatorMode.processing:
        return SizedBox(
          height: state.offset.sp,
          child: UnconstrainedBox(
            child: RotationTransition(
              turns: _rotationController
                  .drive(Tween(begin: state.offset.sp / 360, end: 60)),
              child: Image.asset(
                AssetsImages.basketball_icon,
                width: state.offset.sp * 0.3 >= 30.sp
                    ? 30.sp
                    : state.offset.sp * 0.3,
                height: state.offset.sp * 0.3 >= 30.sp
                    ? 30.sp
                    : state.offset.sp * 0.3,
                color: Colors.white54,
                fit: BoxFit.contain,
              ),
            ),
          ),
        );
      case IndicatorMode.processed:
        return SizedBox(
          height: state.offset.sp,
          child: UnconstrainedBox(
            child: RotationTransition(
              turns: AlwaysStoppedAnimation(state.offset.sp / -60),
              child: Image.asset(
                AssetsImages.basketball_icon,
                width: state.offset.sp * 0.3 >= 30.sp
                    ? 30.sp
                    : state.offset.sp * 0.3,
                height: state.offset.sp * 0.3 >= 30.sp
                    ? 30.sp
                    : state.offset.sp * 0.3,
                color: Colors.white54,
                fit: BoxFit.contain,
              ),
            ),
          ),
        );
      case IndicatorMode.done:
        return SizedBox(
          height: state.offset.sp,
          child: UnconstrainedBox(
            child: RotationTransition(
              turns: AlwaysStoppedAnimation(state.offset.sp / 60),
              child: Image.asset(
                AssetsImages.basketball_icon,
                width: state.offset.sp * 0.3 >= 30.sp
                    ? 30.sp
                    : state.offset.sp * 0.3,
                height: state.offset.sp * 0.3 >= 30.sp
                    ? 30.sp
                    : state.offset.sp * 0.3,
                color: Colors.white54,
                fit: BoxFit.contain,
              ),
            ),
          ),
        );
      default:
        return const SizedBox();
    }
  }
}
