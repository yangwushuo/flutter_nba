/*
 * @Author: 杨武硕
 * @Date: 2023-08-07 00:57:10
 * @LastEditors: 杨武硕
 * @LastEditTime: 2023-09-23 14:58:29
 * @Descripttion: 
 */
import 'package:logger/logger.dart';

///自定义日志
class MyLogger {
  static late Logger _logger;

  static Future<void> init() async {
    _logger = Logger();
  }

  /// debug日志
  static void debugLog(String info) {
    _logger.d(info);
  }

  /// info日志
  static void infoLog(String info) {
    _logger.i(info);
  }

  /// error日志
  static void errorLog(String info) {
    _logger.e(info);
  }

  /// warn日志
  static void warnLog(String info) {
    _logger.w(info);
  }
}
