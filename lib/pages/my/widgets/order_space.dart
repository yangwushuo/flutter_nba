/*
 * @Author: 杨武硕
 * @Date: 2023-09-30 15:40:59
 * @LastEditors: 杨武硕
 * @LastEditTime: 2023-09-30 18:14:56
 * @Descripttion: 订单
 */
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nba/pages/my/models/my_item_model.dart';
import 'package:nba/pages/my/widgets/my_item.dart';

class OrderSpace extends StatelessWidget {
  const OrderSpace({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).colorScheme.inversePrimary;
    List<MyItemModel> orderItem = [
      MyItemModel(
          title: "待付款",
          icon: Icon(
            Icons.credit_card,
            color: color,
            size: 30.sp,
          )),
      MyItemModel(
          title: "待发货",
          icon: Icon(
            Icons.schedule_outlined,
            color: color,
            size: 30.sp,
          )),
      MyItemModel(
          title: "待收货",
          icon: Icon(
            Icons.local_shipping_outlined,
            color: color,
            size: 30.sp,
          )),
      MyItemModel(
          title: "售后",
          icon: Icon(
            Icons.paid_outlined,
            color: color,
            size: 30.sp,
          )),
    ];
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(horizontal: 18.sp, vertical: 18.sp),
      child: DecoratedBox(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onBackground,
            borderRadius: BorderRadius.circular(15.sp),
          ),
          child: Column(
            children: [
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 15.sp, vertical: 10.sp),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.shopping_bag_outlined,
                      color: color,
                      size: 20.sp,
                    ),
                    SizedBox(
                      width: 8.sp,
                    ),
                    Expanded(
                      child: Text(
                        "我的订单",
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall
                            ?.copyWith(color: color),
                      ),
                    ),
                    Icon(
                      Icons.navigate_next_outlined,
                      color: color,
                      size: 20.sp,
                    ),
                  ],
                ),
              ),
              GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.only(bottom: 10.sp),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent:
                      MediaQuery.of(context).size.width / 4, // 设置最大交叉轴扩展
                  mainAxisExtent: 66.sp,
                  // mainAxisSpacing: 10.0, // 设置主轴间距
                  // crossAxisSpacing: 10.0, // 设置交叉轴间距
                ),
                itemBuilder: (context, index) => MyItem(
                  title: orderItem[index].title,
                  icon: orderItem[index].icon,
                ),
                itemCount: orderItem.length,
              ),
            ],
          )),
    );
  }
}
