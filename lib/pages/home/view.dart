/*
 * @Author: 杨武硕
 * @Date: 2023-09-23 15:18:45
 * @LastEditors: 杨武硕
 * @LastEditTime: 2023-09-24 01:20:32
 * @Descripttion: 
 */
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:nba/common/index.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  /// 主视图垂直滚动控制器
  late ScrollController _bodyScrollController;

  /// 轮播图控制器
  late CarouselController _carouselController;

  /// topbar显示头部新闻缩略图
  bool _showTopNewThumbnail = false;

  /// 主体滚动监听
  void listenBodyScroll() {
    _bodyScrollController.addListener(() {
      topNews2TopBar();
      print(_showTopNewThumbnail);
    });
  }

  // 头部新闻滚动出视图 -> 标题栏显示头部新闻缩略
  void topNews2TopBar() => setState(() => _bodyScrollController.offset > 120.sp
      ? _showTopNewThumbnail = true
      : _showTopNewThumbnail = false);

  @override
  void initState() {
    super.initState();
    _bodyScrollController = ScrollController();
    _carouselController = CarouselController();
    listenBodyScroll();
  }

  @override
  void dispose() {
    _bodyScrollController.dispose();
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
        centerChild: AnimatedSlide(
          offset: _showTopNewThumbnail ? Offset(0, 0) : Offset(0, -2),
          duration: const Duration(milliseconds: 200),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 10,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.all(10.sp),
                child: ClipOval(
                  child: Image.network(
                    'https://picsum.photos/200',
                    width: 28.sp,
                    height: 28.sp,
                    fit: BoxFit.contain,
                  ),
                ),
              );
            },
          ),
        ),
        centerChildOnTap: () => _bodyScrollController.jumpTo(0), // 跳回顶部
        leftChildOnTap: context.pop,
        rightChild: Padding(
          padding: EdgeInsets.all(10.sp),
          child: Icon(
            Icons.more_horiz,
            color: Theme.of(context).colorScheme.primary,
            size: 20.sp,
          ),
        ),
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
                          scrollDirection: Axis.horizontal,
                          itemCount: 10,
                          itemBuilder: (context, index) {
                            return const TopNew(
                              imageUrl: 'https://picsum.photos/200',
                              title: "212adfasdfasdfasdfasdfadsfadsfas",
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
                                      'https://picsum.photos/200',
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
                          itemBuilder: (context, index) => const VideoCover(
                            coverUrl: 'https://picsum.photos/200',
                            title: "212adfasdfasdfasdfasdfadsfadsfas",
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
                              coverUrl: 'https://picsum.photos/200',
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

extension _HomePageStateExtension on _HomePageState {}
