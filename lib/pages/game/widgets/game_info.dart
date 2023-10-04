/*
 * @Author: 杨武硕
 * @Date: 2023-10-03 21:55:09
 * @LastEditors: 杨武硕
 * @LastEditTime: 2023-10-05 02:38:10
 * @Descripttion: 
 */
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nba/common/index.dart';
import 'package:nba/pages/game/models/game_info_model.dart';

class GameInfo extends StatelessWidget {
  @required
  final GameInfoModel gameInfo;

  const GameInfo({
    super.key,
    required this.gameInfo,
  });

  /// 状体提示
  String _getGameStatus() {
    switch (gameInfo.status) {
      case GameStatus.NOTSTART:
        return "未开始";
      case GameStatus.PROGRESS:
        return "进行中";
      case GameStatus.FINISH:
        return "已完成";
      default:
        return "";
    }
  }

  /// 时间格式化
  String _getGameFormatTime() => formatDate(
      DateTime.fromMillisecondsSinceEpoch(gameInfo.startTs), [H, ':', nn]);

  /// 中间比赛详情
  Widget _getMiddleWidget(BuildContext context) {
    switch (gameInfo.status) {
      case GameStatus.NOTSTART:
        return TextButton(
          onPressed: () {},
          child: Text(
            "比赛前瞻",
            style: Theme.of(context)
                .textTheme
                .titleSmall
                ?.copyWith(fontSize: 10.sp),
          ),
        );
      case GameStatus.PROGRESS:
        return Row(
          children: [
            Text(gameInfo.primaryTeamPoint.toString(),
                style: Theme.of(context).textTheme.displayLarge),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10.sp),
              decoration: BoxDecoration(
                border: Border.all(width: 0.5, color: Colors.white10),
              ),
            ),
            Text(gameInfo.primaryTeamPoint.toString(),
                style: Theme.of(context).textTheme.displayLarge),
          ],
        );
      case GameStatus.FINISH:
        return Row(
          children: [
            Text(
              gameInfo.primaryTeamPoint.toString(),
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                    color: gameInfo.primaryTeamPoint > gameInfo.secondTeamPoint
                        ? Colors.white
                        : Colors.white30,
                  ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10.sp),
              decoration: BoxDecoration(
                border: Border.all(width: 0.5, color: Colors.white10),
              ),
            ),
            Text(
              gameInfo.secondTeamPoint.toString(),
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                    color: gameInfo.primaryTeamPoint > gameInfo.secondTeamPoint
                        ? Colors.white30
                        : Colors.white,
                  ),
            ),
          ],
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10.sp),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onBackground,
        borderRadius: BorderRadius.circular(15.sp),
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15.sp, vertical: 10.sp),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: 1,
                  color: Colors.black,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _getGameStatus(),
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall
                      ?.copyWith(fontSize: 12.sp, color: Colors.white54),
                ),
                Text(
                  _getGameFormatTime(),
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall
                      ?.copyWith(fontSize: 12.sp, color: Colors.white54),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15.sp, vertical: 25.sp),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    gameInfo.primaryTeamInfo.logoUrl != null &&
                            gameInfo.primaryTeamInfo.logoUrl!.isNotEmpty
                        ? Image.network(
                            gameInfo.primaryTeamInfo.logoUrl!,
                            width: 40.sp,
                            height: 40.sp,
                          )
                        : Icon(
                            Icons.group_outlined,
                            color: Colors.white54,
                            size: 42.sp,
                          ),
                    SizedBox(
                      width: 10.sp,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          gameInfo.primaryTeamInfo.nameZH,
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        SizedBox(
                          height: 5.sp,
                        ),
                        Text(
                          "${gameInfo.primaryTeamInfo.win}-${gameInfo.primaryTeamInfo.lose}",
                          style:
                              Theme.of(context).textTheme.titleSmall?.copyWith(
                                    fontSize: 12.sp,
                                    color: Colors.white54,
                                  ),
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 22.sp,
                  child: _getMiddleWidget(context),
                ),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          gameInfo.secondTeamInfo.nameZH,
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        SizedBox(
                          height: 5.sp,
                        ),
                        Text(
                          "${gameInfo.secondTeamInfo.win}-${gameInfo.secondTeamInfo.lose}",
                          style:
                              Theme.of(context).textTheme.titleSmall?.copyWith(
                                    fontSize: 12.sp,
                                    color: Colors.white54,
                                  ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 10.sp,
                    ),
                    gameInfo.secondTeamInfo.logoUrl != null &&
                            gameInfo.secondTeamInfo.logoUrl!.isNotEmpty
                        ? Image.network(
                            gameInfo.secondTeamInfo.logoUrl!,
                            width: 40.sp,
                            height: 40.sp,
                          )
                        : Icon(
                            Icons.group_outlined,
                            color: Colors.white54,
                            size: 42.sp,
                          ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
