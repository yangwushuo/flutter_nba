import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:nba/common/index.dart';

/// 应用初始化类
class AppInit {
  /// 应用初始化
  static Future<void> init() async {
    WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
    // 初始化开屏图片
    FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
    // 初始化本地存储
    await Storage().init();
    // 初始化日志
    await MyLogger.init();
  }
}
