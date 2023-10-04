/*
 * @Author: 杨武硕
 * @Date: 2023-10-03 21:54:06
 * @LastEditors: 杨武硕
 * @LastEditTime: 2023-10-05 02:39:22
 * @Descripttion: 
 */
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:nba/common/index.dart';
import 'package:nba/common/services/index.dart';
import 'package:nba/pages/game/models/game_info_model.dart';
import 'package:nba/pages/game/models/team_info_model.dart';
import 'package:nba/pages/game/widgets/game_info.dart';
import 'package:uuid/uuid.dart';

class GameList extends StatefulWidget {
  @required
  final DateTime time;

  const GameList({super.key, required this.time});

  @override
  State<GameList> createState() => _GameListState();
}

class _GameListState extends State<GameList>
    with SingleTickerProviderStateMixin {
  late EasyRefreshController _easyRefreshController;
  late ScrollController _scrollController;
  late AnimationController _rotationController;
  List<GameInfoModel> _games = [];
  @override
  void initState() {
    super.initState();
    _easyRefreshController = EasyRefreshController(controlFinishRefresh: true);
    _scrollController = ScrollController();
    _rotationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 100),
    );
    _rotationController.repeat(); // 循环旋转
  }

  @override
  void dispose() {
    _easyRefreshController.dispose();
    _scrollController.dispose();
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.sp),
      child: EasyRefresh(
        controller: _easyRefreshController,
        onRefresh: _onRefresh,
        callLoadOverOffset: 100.sp,
        callRefreshOverOffset: 100.sp,
        clipBehavior: Clip.none,
        header: BuilderHeader(
          triggerOffset: 100.sp,
          clamping: false,
          position: IndicatorPosition.above,
          processedDuration: Duration.zero,
          springRebound: true,
          hapticFeedback: true,
          builder: createLoadingWidget,
        ),
        child: ListView(
          children: _games.isNotEmpty
              ? _games
                  .map(
                    (model) => FocusedMenuHolder(
                      menuWidth: MediaQuery.of(context).size.width * 0.5,
                      blurSize: 5.0,
                      menuItemExtent: 50.sp,
                      menuBoxDecoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.onBackground,
                        borderRadius: BorderRadius.circular(15.sp),
                      ),
                      duration: const Duration(milliseconds: 100),
                      animateMenuItems: true,
                      blurBackgroundColor: Colors.black45,
                      openWithTap:
                          false, // Open Focused-Menu on Tap rather than Long Press
                      menuOffset: 10
                          .sp, // Offset value to show menuItem from the selected item
                      bottomOffsetHeight:
                          0, // Offset height to consider, for showing the menu item ( for example bottom navigation bar), so that the popup menu will be shown on top of selected item.
                      menuItems: <FocusedMenuItem>[
                        // Add Each FocusedMenuItem  for Menu Options
                        FocusedMenuItem(
                          title: Text(
                            "添加桌面小组件",
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(fontSize: 14.sp),
                          ),
                          backgroundColor: Colors.transparent,
                          trailingIcon: Icon(
                            Icons.add_box_outlined,
                            size: 20.sp,
                          ),
                          onPressed: _addDesk,
                        ),
                      ],
                      onPressed: () => goGameDetail(model),
                      child: GameInfo(gameInfo: model),
                    ),
                  )
                  .toList()
              : [
                  SizedBox(
                    width: double.infinity,
                    height: 300.sp,
                    child: Center(
                      child: Text(
                        "今日没有比赛",
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(color: Colors.white30),
                      ),
                    ),
                  )
                ],
        ),
      ),
    );
  }
}

extension _GameListStateExtension on _GameListState {
  /// 添加桌面
  void _addDesk() {}

  /// 跳转详情页面
  void goGameDetail(GameInfoModel model) {}

  /// 刷新
  void _onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 3000));
    _games.clear();
    // 模拟
    _games.addAll(
      [
        GameInfoModel(
          id: const Uuid().v4(),
          status: GameStatus.FINISH,
          primaryTeamInfo: TeamInfoModel(
            nameZH: "独行侠",
            nameEN: "dallas_mavericks",
            logoUrl:
                'https://ssl.gstatic.com/onebox/media/sports/logos/xxxlj9RpmAKJ9P9phstWCQ_96x96.png',
            win: 22,
            lose: 19,
          ),
          secondTeamInfo: TeamInfoModel(
            nameZH: "森林狼",
            nameEN: "minnesota_timberwolves",
            logoUrl:
                'https://ssl.gstatic.com/onebox/media/sports/logos/21Zm6e_zGiWXsaLCQyjVig_96x96.png',
            win: 1,
            lose: 32,
          ),
          primaryTeamPoint: 100,
          secondTeamPoint: 90,
          startTs: DateTime.now()
              .add(const Duration(hours: 9))
              .millisecondsSinceEpoch,
        ),
        GameInfoModel(
          id: const Uuid().v4(),
          status: GameStatus.PROGRESS,
          primaryTeamInfo: TeamInfoModel(
            nameZH: "勇士",
            nameEN: "golden_state_warriors",
            logoUrl:
                'https://ssl.gstatic.com/onebox/media/sports/logos/ovwlyYHRKZ90s7zn_qlMCg_96x96.png',
            win: 22,
            lose: 19,
          ),
          secondTeamInfo: TeamInfoModel(
            nameZH: "湖人",
            nameEN: "los_angeles_lakers",
            logoUrl:
                'https://ssl.gstatic.com/onebox/media/sports/logos/4ndR-n-gall7_h3f7NYcpQ_96x96.png',
            win: 1,
            lose: 32,
          ),
          primaryTeamPoint: 100,
          secondTeamPoint: 90,
          startTs: DateTime.now()
              .add(const Duration(hours: -1))
              .millisecondsSinceEpoch,
        ),
      ],
    );
    if (mounted) {
      _easyRefreshController.finishRefresh(IndicatorResult.success);
      _easyRefreshController.resetHeader();
      setState(() {});
    }
  }

  /// 加载图标
  Widget createLoadingWidget(BuildContext contenxt, IndicatorState state) {
    switch (state.mode) {
      case IndicatorMode.inactive:
        return const SizedBox();
      case IndicatorMode.ready:
      case IndicatorMode.armed:
      case IndicatorMode.drag:
        return SizedBox(
          height: state.offset.sp,
          child: UnconstrainedBox(
            child: RotationTransition(
              turns: AlwaysStoppedAnimation(state.offset.sp / 60),
              child: Image.asset(
                AssetsImages.basketball_icon,
                width: state.offset.sp * 0.3 >= 30.sp
                    ? 30.sp
                    : state.offset.sp * 0.3,
                height: state.offset.sp * 0.3 >= 30.sp
                    ? 30.sp
                    : state.offset.sp * 0.3,
                color: Colors.white54,
                fit: BoxFit.contain,
              ),
            ),
          ),
        );
      case IndicatorMode.processing:
        return SizedBox(
          height: state.offset.sp,
          child: UnconstrainedBox(
            child: RotationTransition(
              turns: _rotationController
                  .drive(Tween(begin: state.offset.sp / 360, end: 60)),
              child: Image.asset(
                AssetsImages.basketball_icon,
                width: state.offset.sp * 0.3 >= 30.sp
                    ? 30.sp
                    : state.offset.sp * 0.3,
                height: state.offset.sp * 0.3 >= 30.sp
                    ? 30.sp
                    : state.offset.sp * 0.3,
                color: Colors.white54,
                fit: BoxFit.contain,
              ),
            ),
          ),
        );
      case IndicatorMode.processed:
        return SizedBox(
          height: state.offset.sp,
          child: UnconstrainedBox(
            child: RotationTransition(
              turns: AlwaysStoppedAnimation(state.offset.sp / -60),
              child: Image.asset(
                AssetsImages.basketball_icon,
                width: state.offset.sp * 0.3 >= 30.sp
                    ? 30.sp
                    : state.offset.sp * 0.3,
                height: state.offset.sp * 0.3 >= 30.sp
                    ? 30.sp
                    : state.offset.sp * 0.3,
                color: Colors.white54,
                fit: BoxFit.contain,
              ),
            ),
          ),
        );
      case IndicatorMode.done:
        return SizedBox(
          height: state.offset.sp,
          child: UnconstrainedBox(
            child: RotationTransition(
              turns: AlwaysStoppedAnimation(state.offset.sp / 60),
              child: Image.asset(
                AssetsImages.basketball_icon,
                width: state.offset.sp * 0.3 >= 30.sp
                    ? 30.sp
                    : state.offset.sp * 0.3,
                height: state.offset.sp * 0.3 >= 30.sp
                    ? 30.sp
                    : state.offset.sp * 0.3,
                color: Colors.white54,
                fit: BoxFit.contain,
              ),
            ),
          ),
        );
      default:
        return const SizedBox();
    }
  }
}
