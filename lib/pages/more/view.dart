import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:nba/common/index.dart';
import 'package:nba/pages/more/widgets/more_item.dart';

class MorePage extends StatelessWidget {
  const MorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        backgroundColor: Colors.transparent,
        leftChild: Padding(
          padding: EdgeInsets.all(10.sp),
          child: Image.asset(
            AssetsImages.leftArrow3x,
            width: 18.sp,
            height: 18.sp,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        leftChildOnTap: context.pop,
        centerChild: Text(
          "更多",
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: SafeArea(
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(left: 16.sp, right: 16.sp, bottom: 5.sp),
              child: Text(
                "内容",
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: const Color(0xFF999999),
                      fontSize: 12.sp,
                    ),
              ),
            ),
            MoreItem(
              icon: Icon(
                Icons.sports_basketball_outlined,
                size: 22.sp,
              ),
              title: "球队",
              border: Border(
                top: BorderSide(
                  width: 1,
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
            ),
            MoreItem(
              icon: Icon(
                Icons.face_6_outlined,
                size: 22.sp,
              ),
              title: "球员",
              border: Border(
                top: BorderSide(
                  width: 1,
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
            ),
            MoreItem(
              icon: Icon(
                Icons.date_range_outlined,
                size: 22.sp,
              ),
              title: "重要日期",
              border: Border(
                top: BorderSide(
                  width: 1,
                  color: Theme.of(context).colorScheme.onBackground,
                ),
                bottom: BorderSide(
                  width: 1,
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
