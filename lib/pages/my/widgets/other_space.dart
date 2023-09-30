/*
 * @Author: 杨武硕
 * @Date: 2023-09-30 16:58:50
 * @LastEditors: 杨武硕
 * @LastEditTime: 2023-09-30 18:15:09
 * @Descripttion: 
 */
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nba/pages/my/models/my_item_model.dart';
import 'package:nba/pages/my/widgets/my_item.dart';

class OtherSpace extends StatelessWidget {
  const OtherSpace({super.key});

  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).colorScheme.inversePrimary;
    List<MyItemModel> otherItem = [
      MyItemModel(
          title: "关注球队",
          icon: Icon(
            Icons.add_box_outlined,
            color: color,
            size: 30.sp,
            weight: 30,
          )),
      MyItemModel(
          title: "关注球员",
          icon: Icon(
            Icons.face_outlined,
            color: color,
            size: 30.sp,
          )),
      MyItemModel(
          title: "收藏",
          icon: Icon(Icons.star_border_outlined, color: color, size: 30.sp)),
      MyItemModel(
          title: "消息",
          icon: Icon(Icons.email_outlined, color: color, size: 30.sp)),
      MyItemModel(
          title: "奖励",
          icon: Icon(Icons.redeem_outlined, color: color, size: 30.sp)),
      MyItemModel(
          title: "喜欢",
          icon:
              Icon(Icons.favorite_border_outlined, color: color, size: 30.sp)),
      MyItemModel(
          title: "客服",
          icon: Icon(Icons.support_agent_outlined, color: color, size: 30.sp)),
      MyItemModel(
          title: "修改手机号",
          icon: Icon(Icons.phone_iphone_outlined, color: color, size: 30.sp)),
      MyItemModel(
          title: "意见反馈",
          icon: Icon(Icons.textsms_outlined, color: color, size: 30.sp)),
      MyItemModel(
          title: "设置",
          icon: Icon(Icons.settings_outlined, color: color, size: 30.sp)),
    ];
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(horizontal: 18.sp),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onBackground,
          borderRadius: BorderRadius.circular(15.sp),
        ),
        child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(vertical: 18.sp),
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent:
                MediaQuery.of(context).size.width / 4, // 设置最大交叉轴扩展
            mainAxisExtent: 66.sp,
            mainAxisSpacing: 10.0.sp, // 设置主轴间距
          ),
          itemBuilder: (context, index) => MyItem(
            title: otherItem[index].title,
            icon: otherItem[index].icon,
          ),
          itemCount: otherItem.length,
        ),
      ),
    );
  }
}
