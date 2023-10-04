/*
 * @Author: 杨武硕
 * @Date: 2023-10-04 18:08:09
 * @LastEditors: 杨武硕
 * @LastEditTime: 2023-10-05 02:26:32
 * @Descripttion: 
 */
class TeamInfoModel {
  final String nameZH;
  final String nameEN;
  final String? logoUrl;
  final int win;
  final int lose;

  TeamInfoModel({
    required this.nameZH,
    required this.nameEN,
    this.logoUrl,
    required this.win,
    required this.lose,
  });
}
