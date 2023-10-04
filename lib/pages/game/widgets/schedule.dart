/*
 * @Author: 杨武硕
 * @Date: 2023-10-01 16:48:38
 * @LastEditors: 杨武硕
 * @LastEditTime: 2023-10-04 02:43:14
 * @Descripttion: 
 */
import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nba/common/index.dart';
import 'package:nba/common/services/index.dart';
import 'package:nba/pages/game/models/timeline_model.dart';
import 'package:nba/pages/game/widgets/date_line_item.dart';
import 'package:nba/pages/game/widgets/game_list.dart';

class Schedule extends StatefulWidget {
  const Schedule({
    super.key,
  });

  @override
  State<Schedule> createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
  /// 当日时间
  DateTime today = DateTime.parse(formatDate(
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day),
      [yyyy, '', mm, '', dd]));

  /// 今日时间索引
  int todayIndex = 0;

  /// 时间轴滚动控制器
  late ScrollController _scrollController;

  /// pageviewController
  late PageController _pageViewController;

  /// 起始时间
  late DateTime start;

  /// 结束时间
  late DateTime end;

  /// 存放每日时间信息
  List<TimelineModel> dateRange = [];

  @override
  void initState() {
    super.initState();
    start = DateTime.parse("${today.year - 2}0101");
    end = DateTime.parse("${today.year + 2}0101");
    DateTime tempTime = start;
    while (tempTime.millisecondsSinceEpoch < end.millisecondsSinceEpoch) {
      dateRange.add(
        TimelineModel(
          week: TimeUtil.numWeek2ZHWeek(tempTime.weekday),
          dayNum: tempTime.day.toString(),
          time: tempTime,
          timestamp: tempTime.millisecondsSinceEpoch,
        ),
      );
      if (tempTime.millisecondsSinceEpoch == today.millisecondsSinceEpoch) {
        todayIndex = dateRange.length - 1;
      }
      tempTime = tempTime.add(const Duration(days: 1));
    }
    _scrollController = ScrollController();
    _pageViewController =
        PageController(initialPage: todayIndex, keepPage: true);
    // 渲染结束调用，只执行1次
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _scrollController.animateTo(
        todayIndex * MediaQuery.of(context).size.width / 7,
        duration: const Duration(milliseconds: 700),
        curve: Curves.linear,
      );
      addListen2TimeLine();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant Schedule oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(horizontal: 18.sp, vertical: 10.sp),
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.white24, // 底部边框颜色
                width: 0.5, // 底部边框宽度
              ),
            ),
          ),
          child: Row(
            children: [
              Text(
                "${today.year}年${today.month}月",
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const Expanded(child: SizedBox()),
              GestureDetector(
                onTap: () => changeCurrentDate(DateTime.parse(formatDate(
                    DateTime(DateTime.now().year, DateTime.now().month,
                        DateTime.now().day),
                    [yyyy, '-', mm, '-', dd])).millisecondsSinceEpoch),
                child: Text(
                  "今天",
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
              SizedBox(
                width: 6.sp,
              ),
              Icon(
                Icons.account_tree_outlined,
                size: 22.sp,
                color: Theme.of(context).colorScheme.primaryContainer,
              ),
              SizedBox(
                width: 6.sp,
              ),
              GestureDetector(
                onTap: selectDate,
                child: Icon(
                  Icons.date_range_outlined,
                  size: 22.sp,
                  color: Theme.of(context).colorScheme.primaryContainer,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 100.sp,
          child: ListView.builder(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            itemCount: dateRange.length,
            itemBuilder: (context, index) => DateLineItem(
              dayName: dateRange[index].week,
              dayNumber: dateRange[index].dayNum,
              monthName: "2",
              fullDate: dateRange[index].time,
              isSelected: index == todayIndex,
              onTap: changeCurrentDate,
            ),
          ),
        ),
        Expanded(
          child: PageView.builder(
            controller: _pageViewController,
            itemCount: dateRange.length,
            onPageChanged: pageViewChange,
            itemBuilder: (context, index) =>
                GameList(time: dateRange[index].time),
          ),
        ),
      ],
    );
  }
}

extension _ScheduleExtension on _ScheduleState {
  /// 时间轴添加滚动监听事件
  void addListen2TimeLine() {
    _scrollController.addListener(
      () {
        /// 获取当前便宜量
        double offsetValue = _scrollController.offset;
        int index =
            (offsetValue / (MediaQuery.of(context).size.width / 7)).ceil();
        setState(() => today = dateRange[index].time);
      },
    );
  }

  /// 选择日期
  void selectDate() async {
    showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).colorScheme.onBackground,
      builder: (context) {
        return SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 300.sp,
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.date,
            backgroundColor: Colors.transparent, //背景颜色
            use24hFormat: true, //使用24小时制
            initialDateTime: today,
            //日期的限制
            maximumYear: end.year,
            minimumYear: start.year,
            onDateTimeChanged: (sd) =>
                changeCurrentDate(sd.millisecondsSinceEpoch, isShock: false),
          ),
        );
      },
    );
  }

  /// 修改当前日期
  void changeCurrentDate(int ts, {bool? isShock}) {
    // today = DateTime.fromMillisecondsSinceEpoch(ts);
    for (var i = 0; i < dateRange.length; i++) {
      if (dateRange[i].timestamp == ts) {
        todayIndex = i;
        _pageViewController.jumpToPage(i);
      }
    }
    _scrollController.animateTo(
      todayIndex * MediaQuery.of(context).size.width / 7,
      duration: const Duration(milliseconds: 200),
      curve: Curves.linear,
    );
    if (isShock == null) SystemService().shock();
    setState(() {});
  }

  /// pageview变动
  void pageViewChange(index) {
    double start = todayIndex * MediaQuery.of(context).size.width / 7;
    double end = start + MediaQuery.of(context).size.width;
    double value = index * MediaQuery.of(context).size.width / 7;
    setState(() {
      todayIndex = index;
      _scrollController.animateTo(
        todayIndex * MediaQuery.of(context).size.width / 7,
        duration: const Duration(milliseconds: 200),
        curve: Curves.linear,
      );
    });
  }
}
