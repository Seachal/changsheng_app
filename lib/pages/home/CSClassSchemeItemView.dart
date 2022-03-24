import 'dart:io';

import 'package:changshengh5/api/CSClassApiManager.dart';
import 'package:changshengh5/api/CSClassHttpCallBack.dart';
import 'package:changshengh5/app/CSClassApplicaion.dart';
import 'package:changshengh5/model/CSClassSchemeListEntity.dart';
import 'package:changshengh5/pages/anylise/CSClassExpertDetailPage.dart';
import 'package:changshengh5/pages/competition/scheme/CSClassSchemeDetailPage.dart';
import 'package:changshengh5/utils/CSClassCommonMethods.dart';
import 'package:changshengh5/utils/CSClassDateUtils.dart';
import 'package:changshengh5/utils/CSClassImageUtil.dart';
import 'package:changshengh5/utils/CSClassMatchDataUtils.dart';
import 'package:changshengh5/utils/CSClassNavigatorUtils.dart';
import 'package:changshengh5/utils/CSClassStringUtils.dart';
import 'package:changshengh5/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CSClassSchemeItemView extends StatelessWidget {
  CSClassSchemeListSchemeList item;
  bool csProShowRate;
  bool csProShowProFit;
  bool csProCanClick;
  bool csProShowLine;
  CSClassSchemeItemView(this.item,
      {this.csProShowRate: true,
      this.csProShowProFit: true,
      this.csProCanClick: true,
      this.csProShowLine: true});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: EdgeInsets.only(
            left: width(13),
            right: width(13),
            top: width(6),
            bottom: width(6)),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
                bottom: BorderSide(
                    width: 0.5,
                    color: csProShowLine ? Color(0xFFF2F2F2) : Colors.white))),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    GestureDetector(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(width(20)),
                        child: (item.expert?.csProAvatarUrl == null ||
                                item.expert!.csProAvatarUrl!.isEmpty)
                            ? Image.asset(
                                CSClassImageUtil.csMethodGetImagePath(
                                    "cs_default_avater"),
                                width: width(40),
                                height: width(40),
                              )
                            : Image.network(
                                item.expert!.csProAvatarUrl!,
                                width: width(40),
                                height: width(40),
                                fit: BoxFit.cover,
                              ),
                      ),
                      onTap: () {
                        if (csProCanClick) {
                          CSClassApiManager.csMethodGetInstance().csMethodExpertInfo(
                              queryParameters: {"expert_uid": item.csProUserId},
                              context: context,
                              csProCallBack:
                                  CSClassHttpCallBack(csProOnSuccess: (info) {
                                CSClassNavigatorUtils.csMethodPushRoute(
                                    context, CSClassExpertDetailPage(info));
                              },onError: (v){},csProOnProgress: (v){}
                              ));
                        }
                      },
                    ),
                    Positioned(
                      right: 0,
                      top: 0,
                      child: (item.expert!.csProNewSchemeNum != "null" &&
                              int.parse(item.expert!.csProNewSchemeNum!) > 0)
                          ? Container(
                              alignment: Alignment.center,
                              width: width(13),
                              height: width(13),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(width(6)),
                                color: Color(0xFFE3494B),
                              ),
                              child: Text(
                                item.expert!.csProNewSchemeNum!,
                                style: TextStyle(
                                    fontSize: sp(8), color: Colors.white),
                              ),
                            )
                          : Container(),
                    )
                  ],
                ),
                SizedBox(
                  width: width(5),
                ),
                Container(
                  height: width(44),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text(
                                "${item.expert!.csProNickName!}",
                                style: TextStyle(
                                  color: Color(0xFF333333),
                                  fontSize: sp(15),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Text(
                                getTime(item.csProAddTime!),
                                style: TextStyle(
                                  color: MyColors.grey_99,
                                  fontSize: sp(10),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.only(top: width(2)),
                            child: Row(
                              children: <Widget>[
                                Visibility(
                                  child: Container(
                                    padding: EdgeInsets.only(
                                        left: width(8),
                                        right: width(8),
                                        top: width(0.8)),
                                    margin: EdgeInsets.only(right: width(4)),
                                    alignment: Alignment.center,
                                    height: width(16),
                                    // constraints:
                                    //     BoxConstraints(minWidth: width(52)),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                        gradient: LinearGradient(colors: [
                                          Color(0xFFFF6A4C),
                                          Color(0xFFFF8D66),
                                        ])),
                                    child: Text(
                                      "近" +
                                          item.expert!.csProLast10Result!.length
                                              .toString() +
                                          "中" +
                                          "${item.expert!.csProLast10CorrectNum}",
                                      style: TextStyle(
                                          fontSize: sp(9),
                                          color: Color(0xFFF7F7F7),
                                          letterSpacing: 1),
                                    ),
                                  ),
                                  visible: (item.expert!.csProSchemeNum !=
                                          null &&
                                      (double.tryParse(item.expert!
                                                  .csProLast10CorrectNum!)! /
                                              double.tryParse(item.expert!
                                                  .csProLast10Result!.length
                                                  .toString())!) >=
                                          0.6),
                                ),
                                Visibility(
                                  child: Container(
                                    margin: EdgeInsets.only(right: width(4)),
                                    padding: EdgeInsets.only(
                                        left: width(8),
                                        right: width(8),
                                        top: width(0.8)),
                                    alignment: Alignment.center,
                                    height: width(16),
                                    // constraints:
                                    //     BoxConstraints(minWidth: width(52)),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                        gradient: LinearGradient(colors: [
                                          Color(0xFFFFA64D),
                                          Color(0xFFFFB44D),
                                        ])),
                                    child: Text(
                                      "${item.expert!.csProCurrentRedNum!}连红",
                                      style: TextStyle(
                                          fontSize: sp(9),
                                          color: Color(0xFFF7F7F7),
                                          letterSpacing: 1),
                                    ),
                                  ),
                                  visible: int.tryParse(
                                          item.expert!.csProCurrentRedNum!)! >
                                      2,
                                ),
                                Visibility(
                                  child: Container(
                                    padding: EdgeInsets.only(
                                        left: width(6),
                                        right: width(6),
                                        top: width(0.8)),
                                    alignment: Alignment.center,
                                    height: width(16),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Color(0xFF1B8DE0), width: 0.5),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text(
                                      "不中退",
                                      style: TextStyle(
                                          fontSize: sp(9),
                                          color: Color(0xFF1B8DE0),
                                          letterSpacing: 1),
                                    ),
                                  ),
                                  visible: item.csProCanReturn! &&
                                      item.csProDiamond != "0" &&
                                      item.csProIsOver == "0",
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                csProShowProFit
                    ? Flexible(
                        fit: FlexFit.tight,
                        flex: 1,
                        child:
                            double.tryParse(item.expert!.csProRecentProfit!)! <=
                                    0
                                ? SizedBox()
                                : Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      RichText(
                                        text: TextSpan(
                                            text: csProShowRate
                                                ? (double.tryParse(item.expert!
                                                            .csProRecentProfitSum!)! *
                                                        100)
                                                    .toStringAsFixed(0)
                                                : "",
                                            style: TextStyle(
                                                fontSize: sp(27),
                                                fontWeight: FontWeight.w500,
                                                color: Color(0xFFEB3E1C)),
                                            children: [
                                              TextSpan(
                                                text: csProShowRate ? '%' : '',
                                                style: TextStyle(
                                                  fontSize: sp(10),
                                                  color: Color(0xFFEB3E1C),
                                                ),
                                              )
                                            ]),
                                      ),
                                      Text(
                                        csProShowRate ? "近10场回报率" : "",
                                        style: TextStyle(
                                            height: 0.6,
                                            fontSize: sp(10),
                                            color: Color(0xFF666666)),
                                      )
                                    ],
                                  ),
                      )
                    : Flexible(
                        fit: FlexFit.tight,
                        flex: 1,
                        child: CSClassMatchDataUtils.csMethodCalcBestCorrectRate(
                                    item.expert!.csProLast10Result!) <
                                0.7
                            ? SizedBox()
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  RichText(
                                    text: TextSpan(
                                        text: csProShowRate
                                            ? (CSClassMatchDataUtils
                                                        .csMethodCalcBestCorrectRate(item
                                                            .expert!
                                                            .csProLast10Result!) *
                                                    100)
                                                .toStringAsFixed(0)
                                            : "",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: sp(27),
                                            color: Color(0xFFEB3E1C)),
                                        children: [
                                          TextSpan(
                                            text: csProShowRate ? '%' : '',
                                            style: TextStyle(
                                              fontSize: sp(10),
                                              color: Color(0xFFEB3E1C),
                                            ),
                                          )
                                        ]),
                                  ),
                                  Text(
                                    csProShowRate ? "近10场胜率" : "",
                                    style: TextStyle(
                                        height: 0.6,
                                        fontSize: sp(10),
                                        color: Color(0xFF666666)),
                                  )
                                ],
                              ),
                      )
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: width(6)),
              alignment: Alignment.centerLeft,
              child: Stack(
                children: <Widget>[
                  Container(
                    child: RichText(
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(
                        text: item.title,
                        style: TextStyle(
                          color: Color(0xFF333333),
                          fontSize: sp(14),
                        ),
                      ),
                    ),
                    padding: EdgeInsets.only(
                        left: width(12 +
                            CSClassMatchDataUtils.csMethodPayWayName(
                                        item.csProGuessType,
                                        item.csProMatchType,
                                        item.csProPlayingWay)
                                    .length *
                                9)),
                  ),
                  Positioned(
                    top: width(4),
                    left: 0,
                    child: Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(left: width(4), right: width(4)),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: CSClassMatchDataUtils.getFontColors(
                                  item.csProGuessType,
                                  item.csProMatchType,
                                  item.csProPlayingWay),
                              width: 0.5),
                          color: CSClassMatchDataUtils.getColors(
                              item.csProGuessType!,
                              item.csProMatchType!,
                              item.csProPlayingWay!),
                          borderRadius: BorderRadius.circular(width(4))),
                      child: Text(
                        CSClassMatchDataUtils.csMethodPayWayName(item.csProGuessType, item.csProMatchType, item.csProPlayingWay),
                        style: TextStyle(
                          color: CSClassMatchDataUtils.getFontColors(
                              item.csProGuessType,
                              item.csProMatchType,
                              item.csProPlayingWay),
                          fontSize: sp(9),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: width(6),
            ),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(
                  left: width(8), top: width(4), bottom: width(4)),
              decoration: BoxDecoration(
                  color: Color(0xFFF5F6F7),
                  borderRadius: BorderRadius.circular(width(4))),
              child: Row(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(
                        CSClassDateUtils.csMethodDateFormatByString(
                            item.csProStTime!, "MM-dd    HH:mm"),
                        style: TextStyle(
                            fontSize: sp(11), color: MyColors.grey_99),
                      ),
                      SizedBox(
                        width: width(8),
                      ),
                      Text(
                        item.csProLeagueName!,
                        style: TextStyle(
                            fontSize: sp(11), color:CSClassMatchDataUtils
                            .csMethodLeagueNameColor(item.csProLeagueName!)),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(left: width(4), right: width(8)),
                    width: 0.5,
                    height: height(9),
                    color: Colors.grey[300],
                  ),
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          CSClassStringUtils.csMethodMaxLength(item.csProTeamOne!,
                              length: 5),
                          style: TextStyle(
                              fontSize: sp(12), color: MyColors.grey_33),
                          maxLines: 1,
                        ),
                        Text(
                          " VS ",
                          style: TextStyle(
                            height: 1.6,
                              fontSize: sp(10), color: MyColors.grey_33),
                          maxLines: 1,
                        ),
                        Text(
                          CSClassStringUtils.csMethodMaxLength(item.csProTeamTwo!,
                              length: 5),
                          style: TextStyle(
                              fontSize: sp(12), color: MyColors.grey_33),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: width(8)),
                    child: (item.csProIsOver == "1" ||
                            item.csProIsBought == "1")
                        ? Text(
                            '查看',
                            style: TextStyle(
                                color: MyColors.grey_99, fontSize: sp(14)),
                          ):
                    item.csProDiamond == "0"?Text(
                      '免费',
                      style: TextStyle(
                          color: Color(0xFF4D97FF), fontSize: sp(14)),
                    )
                        : Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Image.asset(
                                CSClassImageUtil.csMethodGetImagePath("zhuanshi"),
                                width: width(17),
                              ),
                              Text(
                                '${item.csProDiamond}',
                                style: TextStyle(
                                    color: MyColors.main1, fontSize: sp(13)),
                              ),
                            ],
                          ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        if (csMethodIsLogin(context: context)) {
          CSClassApiManager.csMethodGetInstance().csMethodSchemeDetail(
              queryParameters: {"scheme_id": item.csProSchemeId},
              context: context,
              csProCallBack: CSClassHttpCallBack(
                  csProOnSuccess: (value) {
                CSClassNavigatorUtils.csMethodPushRoute(
                    context, CSClassSchemeDetailPage(value));
              },onError: (v){},csProOnProgress: (v){}
              ));
        }
      },
    );
  }

  getTime(String spTime) {
    String time = '刚刚';
    DateTime nowTime = new DateTime.now();
    int sec = nowTime.difference(DateTime.parse(spTime)).inSeconds;
    if (sec < 180) {
      time = '刚刚';
    } else if (sec >= 180 && sec < 3600) {
      time = '${(sec / 60).floor()}分钟前';
    } else if (sec >= 3600 && sec < 86400) {
      time = '${(sec / 3600).floor()}小时前';
    } else {
      time = '${(sec / 86400).floor() > 7 ? 7 : (sec / 86400).floor()}天前';
    }
    return time;
  }
}
