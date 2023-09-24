/*
 * @Author: 杨武硕
 * @Date: 2023-08-08 00:52:28
 * @LastEditors: 杨武硕
 * @LastEditTime: 2023-09-25 00:52:13
 * @Descripttion: 路由表配置
 */
import 'package:go_router/go_router.dart';
import 'package:nba/pages/index.dart';

import './index.dart';

/*
  路由使用规范：
    
*/

/// 页面路由
class RoutePages {
  static GoRouter router = GoRouter(
    // 初始化路径
    initialLocation: RoutePathMap.main,
    // 路由监听
    observers: [
      NavObserver(),
    ],
    routes: [
      GoRoute(
        path: RoutePathMap.main,
        name: RouteNameMap.main,
        builder: (context, state) => const MainPage(),
      ),
      GoRoute(
        path: RoutePathMap.my,
        name: RouteNameMap.my,
        builder: (context, state) => const MyPage(),
      ),
      GoRoute(
        path: RoutePathMap.videoPlay,
        name: RouteNameMap.videoPlay,
        builder: (context, state) => const VideoPage(),
      ),
      GoRoute(
        path: RoutePathMap.more,
        name: RouteNameMap.more,
        builder: (context, state) => const MorePage(),
      )
    ],
  );
}
