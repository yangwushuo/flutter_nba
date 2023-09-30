import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nba/common/index.dart';

class UserSpace extends StatelessWidget {
  const UserSpace({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 110.sp,
      padding: EdgeInsets.symmetric(horizontal: 18.sp),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              width: 100.sp,
              height: 110.sp,
              padding: EdgeInsets.only(top: 30.sp),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onBackground,
                borderRadius: BorderRadius.circular(15.sp),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 22.sp,
                  ),
                  SizedBox(
                    width: 85.sp,
                    height: 30.sp,
                    child: TextButton(
                      onPressed: null,
                      style: Theme.of(context).textButtonTheme.style,
                      child: Text(
                        "登录",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 14.sp,
                  ),
                  Text(
                    "未登录，请点击登录",
                    style: Theme.of(context).textTheme.titleSmall,
                  )
                ],
              ),
            ),
          ),
          Positioned(
            top: -40.sp,
            left: 22.sp,
            child: Image.asset(
              AssetsImages.default_avatar,
              width: 85.sp,
              height: 85.sp,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
