import 'package:nba/common/index.dart';
import 'package:nba/pages/game/models/team_info_model.dart';

class GameInfoModel {
  /// id
  final String id;

  /// 赛况状态
  final GameStatus status;

  /// 主场球队得分
  final int primaryTeamPoint;

  /// 客场球队得分
  final int secondTeamPoint;

  /// 主场球队信息
  final TeamInfoModel primaryTeamInfo;

  /// 客场球队信息
  final TeamInfoModel secondTeamInfo;

  final int startTs;

  /// 其他信息
  final Map<String, dynamic>? other;

  GameInfoModel({
    required this.id,
    required this.status,
    required this.primaryTeamInfo,
    required this.secondTeamInfo,
    required this.primaryTeamPoint,
    required this.secondTeamPoint,
    required this.startTs,
    this.other,
  });
}
