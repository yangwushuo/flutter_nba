/*
 * @Author: 杨武硕
 * @Date: 2023-09-23 15:18:45
 * @LastEditors: 杨武硕
 * @LastEditTime: 2023-09-25 00:53:50
 * @Descripttion: 
 */
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:nba/common/index.dart';
import 'package:nba/common/services/index.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  /// 主视图垂直滚动控制器
  late ScrollController _bodyScrollController;

  /// 头部新闻滚动控制器
  late ScrollController _topNewScrollController;

  /// 轮播图控制器
  late CarouselController _carouselController;

  /// topbar显示头部标题
  bool _showBarTitle = false;

  /// 显示头部标题内容
  String _barTitle = "";

  /// 主体滚动监听
  void listenBodyScroll() {
    _bodyScrollController.addListener(() {
      topTitle2TopBar();
    });
  }

  /// 头部新闻滚动监听
  void listenTopNewScroll() {
    _topNewScrollController.addListener(() {
      topNewScrollShock();
    });
  }

  void topTitle2TopBar() {
    setState(
      () {
        double offsetValue = _bodyScrollController.offset;
        offsetValue > 380.sp ? _showBarTitle = true : _showBarTitle = false;
        if (offsetValue > 380.sp && offsetValue < 640.sp) {
          _barTitle = "今日必看";
        } else if (offsetValue > 640.sp && offsetValue < 900.sp) {
          _barTitle = "热门内容";
        } else if (offsetValue > 900.sp) {
          _barTitle = "推荐";
        } else {
          _barTitle = "";
        }
      },
    );
  }

  void topNewScrollShock() {
    double offsetValue = _topNewScrollController.offset;
    if ([1, 2, 3, 4, 5, 6, 7, 8, 9, 10].contains(offsetValue / 75.sp)) {
      // 震动反馈
      SystemService().shock();
    }
  }

  @override
  void initState() {
    super.initState();
    _bodyScrollController = ScrollController();
    _topNewScrollController = ScrollController();
    _carouselController = CarouselController();
    listenBodyScroll();
    listenTopNewScroll();
  }

  @override
  void dispose() {
    _bodyScrollController.dispose();
    _topNewScrollController.dispose();
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
        centerChildOnTap: () => _bodyScrollController.jumpTo(0), // 跳回顶部
        rightChild: Padding(
          padding: EdgeInsets.all(10.sp),
          child: Icon(
            Icons.more_horiz,
            color: Theme.of(context).colorScheme.primary,
            size: 20.sp,
          ),
        ),
        rightChildOnTap: toMore,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.sp),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  controller: _bodyScrollController,
                  physics: const BouncingScrollPhysics(
                      decelerationRate: ScrollDecelerationRate.normal),
                  child: Column(
                    children: [
                      // 头部新闻
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 120.sp,
                        child: ListView.builder(
                          controller: _topNewScrollController,
                          scrollDirection: Axis.horizontal,
                          itemCount: 10,
                          itemBuilder: (context, index) {
                            return TopNew(
                              imageUrl: 'https://api.dujin.org/bing/1366.php',
                              title: "212adfasdfasdfasdfasdfadsfadsfas",
                              onTap: toVideoPlay,
                            );
                          },
                        ),
                      ),
                      // 轮播图ss
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 20.sp),
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
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 5.0),
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
                      DisplayTitile(
                        title: "今日必看",
                        edge: EdgeInsets.only(bottom: 20.sp, left: 5.sp),
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
                            onTap: toVideoPlay,
                          ),
                        ),
                      ),
                      DisplayTitile(
                        title: "热门内容",
                        edge: EdgeInsets.only(
                            top: 20.sp, bottom: 20.sp, left: 5.sp),
                      ),
                      Container(
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
                      DisplayTitile(
                        title: "推荐",
                        edge: EdgeInsets.only(
                            top: 20.sp, bottom: 20.sp, left: 5.sp),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 99 * 100,
                        child: GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent:
                                MediaQuery.of(context).size.width /
                                    2, // 设置最大交叉轴扩展
                            mainAxisExtent: 280.sp,
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
                          itemCount: 99,
                        ),
                      ),
                      Container(
                        height: 2000,
                        color: Colors.orange,
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

/// 逻辑分离
extension _HomePageStateExtension on _HomePageState {
  // 视频播放
  void toVideoPlay() {
    context.push(RoutePathMap.videoPlay);
  }

  // 更多
  void toMore() {
    context.push(RoutePathMap.more);
  }
}
