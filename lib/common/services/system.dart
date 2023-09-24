import 'package:flutter/services.dart';

class SystemService {
  static final SystemService _instance = SystemService._internal();
  factory SystemService() => _instance;

  SystemService._internal();

  // 震动
  void shock() async {
    HapticFeedback.mediumImpact();
  }
}
