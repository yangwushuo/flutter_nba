/*
 * @Author: 杨武硕
 * @Date: 2023-08-06 19:18:01
 * @LastEditors: 杨武硕
 * @LastEditTime: 2023-08-13 22:36:22
 * @Descripttion: 
 */
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nba/app_init.dart';
import 'package:nba/common/index.dart';

Future<void> main() async {
  await AppInit.init();
  MyLogger.infoLog("启动App开始");
  runApp(const MyApp());
  MyLogger.infoLog("启动App结束");
  runAppFinish();
}

void runAppFinish() {
  FlutterNativeSplash.remove();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      builder: (context, child) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: AppInfo.appName,
          theme: darkThemeData,
          // TODO darkTheme: darkThemeData,
          routerConfig: RoutePages.router,
        );
      },
    );
  }
}
