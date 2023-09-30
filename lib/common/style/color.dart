/*
 * @Author: 杨武硕
 * @Date: 2023-08-13 16:18:29
 * @LastEditors: 杨武硕
 * @LastEditTime: 2023-09-30 18:06:50
 * @Descripttion: 系统主题配置
 */
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

const lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: Color(0xFFFFFFFF),
  onPrimary: Color(0xFF8DC643),
  primaryContainer: Color(0xFF252525),
  onPrimaryContainer: Color(0xFFD8D8D8),
  secondary: Color(0xFFF2F2F2),
  onSecondary: Color(0xFF34C759),
  secondaryContainer: Color(0xFF97F0FF),
  onSecondaryContainer: Color(0xFF001F24),
  tertiary: Color(0xFFdedede),
  onTertiary: Color(0xFFFFFFFF),
  tertiaryContainer: Color(0xFFdedede),
  onTertiaryContainer: Color(0xFFF5F5F5),
  error: Color(0xFFBA1A1A),
  errorContainer: Color(0xFFFFDAD6),
  onError: Color(0xFFFFFFFF),
  onErrorContainer: Color(0xFF410002),
  background: Color(0xFFFAFCFF),
  onBackground: Color(0xFF001F2A),
  surface: Color(0xFFFAFCFF),
  onSurface: Color(0xFF001F2A),
  surfaceVariant: Color(0xFFE2E2EC),
  onSurfaceVariant: Color(0xFF45464F),
  outline: Color(0xFF757680),
  onInverseSurface: Color(0xFFE1F4FF),
  inverseSurface: Color(0xFF003547),
  inversePrimary: Color.fromARGB(255, 153, 153, 153),
  shadow: Color(0xFF333333),
  surfaceTint: Color(0xFFDEDEDE),
  outlineVariant: Color(0xFFC5C6D0),
  scrim: Color(0xFF000000),
);

const darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: Color(0xFFFFFFFF),
  onPrimary: Color(0xFF002B75),
  primaryContainer: Color(0xFFF5F5F5),
  onPrimaryContainer: Color(0xFFD8D8D8),
  secondary: Color(0xFFF1F8FE),
  onSecondary: Color(0xFF00363D),
  secondaryContainer: Color(0xFF004F58),
  onSecondaryContainer: Color(0xFF97F0FF),
  tertiary: Color(0xFFdedede),
  onTertiary: Color(0xFFFFFFFF),
  tertiaryContainer: Color(0xFFdedede),
  onTertiaryContainer: Color(0xFF333333),
  error: Color(0xFFFFB4AB),
  errorContainer: Color(0xFF93000A),
  onError: Color(0xFF690005),
  onErrorContainer: Color(0xFFFFDAD6),
  background: Color(0xFF010101),
  onBackground: Color(0xFF16171b),
  surface: Color(0xFF001F2A),
  onSurface: Color(0xFFBFE9FF),
  surfaceVariant: Color(0xFF45464F),
  onSurfaceVariant: Color(0xFFC5C6D0),
  outline: Color(0xFF214184),
  onInverseSurface: Color(0xFF001F2A),
  inverseSurface: Color(0xFFBFE9FF),
  inversePrimary: Color.fromARGB(255, 153, 153, 153),
  shadow: Color(0xFF333333),
  surfaceTint: Color(0xFFDEDEDE),
  outlineVariant: Color(0xFF214184),
  scrim: Color(0xFF000000),
);

/// 明亮主题
ThemeData lightThemeData = ThemeData(
  brightness: Brightness.light,
  colorScheme: lightColorScheme,
  splashColor: Colors.transparent,
  highlightColor: Colors.transparent,
  useMaterial3: true,
  textTheme: TextTheme(
    titleLarge: TextStyle(
      fontSize: 17.sp,
      fontWeight: FontWeight.w500,
      color: lightColorScheme.primaryContainer,
      height: 1,
    ),
    titleSmall: TextStyle(
      fontSize: 17.sp,
      fontWeight: FontWeight.w500,
      color: lightColorScheme.primaryContainer,
      height: 1,
    ),
  ),
);

/// 暗黑主题
ThemeData darkThemeData = ThemeData(
  brightness: Brightness.dark,
  colorScheme: darkColorScheme,
  splashColor: Colors.transparent,
  highlightColor: Colors.transparent,
  useMaterial3: true,
  textTheme: TextTheme(
    titleLarge: TextStyle(
      fontSize: 17.sp,
      fontWeight: FontWeight.w500,
      color: darkColorScheme.primaryContainer,
      height: 1,
    ),
    titleSmall: TextStyle(
      fontSize: 14.sp,
      fontWeight: FontWeight.w500,
      color: darkColorScheme.primaryContainer,
      height: 1,
    ),
    labelSmall: TextStyle(
      fontSize: 17.sp,
      fontWeight: FontWeight.w500,
      color: darkColorScheme.primaryContainer,
      height: 1,
    ),
    displayLarge: TextStyle(
      fontFamily: 'you_she',
      fontSize: 20.sp,
      fontWeight: FontWeight.w400,
      color: darkColorScheme.primaryContainer,
      letterSpacing: -2,
      height: 1,
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      padding: MaterialStateProperty.all(const EdgeInsets.all(2)),
      backgroundColor: MaterialStateProperty.all(
        darkColorScheme.outlineVariant,
      ),
    ),
  ),
  buttonTheme: ButtonThemeData(
    buttonColor: Colors.blue, // 按钮背景颜色
    textTheme: ButtonTextTheme.primary, // 文本颜色
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0), // 按钮形状
    ),
  ),
);
