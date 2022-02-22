import 'dart:io';

import 'package:changshengh5/api/SPClassApiManager.dart';
import 'package:changshengh5/api/SPClassHttpCallBack.dart';
import 'package:changshengh5/app/SPClassApplicaion.dart';
import 'package:changshengh5/model/SPClassSchemeListEntity.dart';
import 'package:changshengh5/pages/anylise/SPClassExpertDetailPage.dart';
import 'package:changshengh5/pages/competition/scheme/SPClassSchemeDetailPage.dart';
import 'package:changshengh5/untils/SPClassCommonMethods.dart';
import 'package:changshengh5/untils/SPClassDateUtils.dart';
import 'package:changshengh5/untils/SPClassImageUtil.dart';
import 'package:changshengh5/untils/SPClassMatchDataUtils.dart';
import 'package:changshengh5/untils/SPClassNavigatorUtils.dart';
import 'package:changshengh5/untils/SPClassStringUtils.dart';
import 'package:changshengh5/untils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SPClassSchemeItemView extends StatelessWidget {
  SPClassSchemeListSchemeList item;
  bool spProShowRate;
  bool spProShowProFit;
  bool spProCanClick;
  bool spProShowLine;
  SPClassSchemeItemView(this.item,
      {this.spProShowRate: true,
      this.spProShowProFit: true,
      this.spProCanClick: true,
      this.spProShowLine: true});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: EdgeInsets.only(
            left: width(13),
            right: width(13),
            top: width(12),
            bottom: width(12)),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
                bottom: BorderSide(
                    width: 0.5,
                    color: spProShowLine ? Color(0xFFF2F2F2) : Colors.white))),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    GestureDetector(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(width(20)),
                        child: (item.expert?.spProAvatarUrl == null ||
                                item.expert!.spProAvatarUrl!.isEmpty)
                            ? Image.asset(
                                SPClassImageUtil.spFunGetImagePath(
                                    "ic_default_avater"),
                                width: width(40),
                                height: width(40),
                              )
                            : Image.network(
                                item.expert!.spProAvatarUrl!,
                                width: width(40),
                                height: width(40),
                                fit: BoxFit.cover,
                              ),
                      ),
                      onTap: () {
                        if (spProCanClick) {
                          SPClassApiManager.spFunGetInstance().spFunExpertInfo(
                              queryParameters: {"expert_uid": item.spProUserId},
                              context: context,
                              spProCallBack:
                                  SPClassHttpCallBack(spProOnSuccess: (info) {
                                SPClassNavigatorUtils.spFunPushRoute(
                                    context, SPClassExpertDetailPage(info));
                              },onError: (v){},spProOnProgress: (v){}
                              ));
                        }
                      },
                    ),
                    Positioned(
                      right: 0,
                      top: 0,
                      child: (item.expert!.spProNewSchemeNum != "null" &&
                              int.parse(item.expert!.spProNewSchemeNum!) > 0)
                          ? Container(
                              alignment: Alignment.center,
                              width: width(13),
                              height: width(13),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(width(6)),
                                color: Color(0xFFE3494B),
                              ),
                              child: Text(
                                item.expert!.spProNewSchemeNum!,
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
                                "${item.expert!.spProNickName!}",
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
                                getTime(item.spProAddTime!),
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
                                          item.expert!.spProLast10Result!.length
                                              .toString() +
                                          "中" +
                                          "${item.expert!.spProLast10CorrectNum}",
                                      style: TextStyle(
                                          fontSize: sp(12),
                                          color: Color(0xFFF7F7F7),
                                          letterSpacing: 1),
                                    ),
                                  ),
                                  visible: (item.expert!.spProSchemeNum !=
                                          null &&
                                      (double.tryParse(item.expert!
                                                  .spProLast10CorrectNum!)! /
                                              double.tryParse(item.expert!
                                                  .spProLast10Result!.length
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
                                      "${item.expert!.spProCurrentRedNum!}连红",
                                      style: TextStyle(
                                          fontSize: sp(12),
                                          color: Color(0xFFF7F7F7),
                                          letterSpacing: 1),
                                    ),
                                  ),
                                  visible: int.tryParse(
                                          item.expert!.spProCurrentRedNum!)! >
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
                                  visible: item.spProCanReturn! &&
                                      item.spProDiamond != "0" &&
                                      item.spProIsOver == "0",
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                spProShowProFit
                    ? Flexible(
                        fit: FlexFit.tight,
                        flex: 1,
                        child:
                            double.tryParse(item.expert!.spProRecentProfit!)! <=
                                    0
                                ? SizedBox()
                                : Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      RichText(
                                        text: TextSpan(
                                            text: spProShowRate
                                                ? (double.tryParse(item.expert!
                                                            .spProRecentProfitSum!)! *
                                                        100)
                                                    .toStringAsFixed(0)
                                                : "",
                                            style: TextStyle(
                                                fontSize: sp(27),
                                                fontWeight: FontWeight.w500,
                                                color: Color(0xFFEB3E1C)),
                                            children: [
                                              TextSpan(
                                                text: spProShowRate ? '%' : '',
                                                style: TextStyle(
                                                  fontSize: sp(10),
                                                  color: Color(0xFFEB3E1C),
                                                ),
                                              )
                                            ]),
                                      ),
                                      Text(
                                        spProShowRate ? "近10场回报率" : "",
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
                        child: SPClassMatchDataUtils.spFunCalcBestCorrectRate(
                                    item.expert!.spProLast10Result!) <
                                0.7
                            ? SizedBox()
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  RichText(
                                    text: TextSpan(
                                        text: spProShowRate
                                            ? (SPClassMatchDataUtils
                                                        .spFunCalcBestCorrectRate(item
                                                            .expert!
                                                            .spProLast10Result!) *
                                                    100)
                                                .toStringAsFixed(0)
                                            : "",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: sp(27),
                                            color: Color(0xFFEB3E1C)),
                                        children: [
                                          TextSpan(
                                            text: spProShowRate ? '%' : '',
                                            style: TextStyle(
                                              fontSize: sp(10),
                                              color: Color(0xFFEB3E1C),
                                            ),
                                          )
                                        ]),
                                  ),
                                  Text(
                                    spProShowRate ? "近期胜率" : "",
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
                          fontSize: sp(15),
                        ),
                      ),
                    ),
                    padding: EdgeInsets.only(
                        left: width(12 +
                            SPClassMatchDataUtils.spFunPayWayName(
                                        item.spProGuessType,
                                        item.spProMatchType,
                                        item.spProPlayingWay)
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
                              color: SPClassMatchDataUtils.getFontColors(
                                  item.spProGuessType,
                                  item.spProMatchType,
                                  item.spProPlayingWay),
                              width: 0.5),
                          color: SPClassMatchDataUtils.getColors(
                              item.spProGuessType!,
                              item.spProMatchType!,
                              item.spProPlayingWay!),
                          borderRadius: BorderRadius.circular(width(4))),
                      child: Text(
                        SPClassMatchDataUtils.spFunPayWayName(item.spProGuessType, item.spProMatchType, item.spProPlayingWay),
                        style: TextStyle(
                          color: SPClassMatchDataUtils.getFontColors(
                              item.spProGuessType,
                              item.spProMatchType,
                              item.spProPlayingWay),
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
                        SPClassDateUtils.spFunDateFormatByString(
                            item.spProStTime!, "MM-dd    HH:mm"),
                        style: TextStyle(
                            fontSize: sp(11), color: MyColors.grey_99),
                      ),
                      SizedBox(
                        width: width(8),
                      ),
                      Text(
                        item.spProLeagueName!,
                        style: TextStyle(
                            fontSize: sp(11), color: MyColors.grey_99),
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
                          SPClassStringUtils.spFunMaxLength(item.spProTeamOne!,
                              length: 5),
                          style: TextStyle(
                              fontSize: sp(11), color: MyColors.grey_66),
                          maxLines: 1,
                        ),
                        Text(
                          " VS ",
                          style: TextStyle(
                              fontSize: sp(13), color: Color(0xFF999999)),
                          maxLines: 1,
                        ),
                        Text(
                          SPClassStringUtils.spFunMaxLength(item.spProTeamTwo!,
                              length: 5),
                          style: TextStyle(
                              fontSize: sp(11), color: MyColors.grey_66),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: width(8)),
                    child: (item.spProIsOver == "1" ||
                            item.spProDiamond == "0" ||
                            item.spProIsBought == "1")
                        ? Text(
                            '免费',
                            style: TextStyle(
                                color: Color(0xFF4D97FF), fontSize: sp(14)),
                          )
                        : Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Image.asset(
                                SPClassImageUtil.spFunGetImagePath("zhuanshi"),
                                width: width(17),
                              ),
                              Text(
                                '${item.spProDiamond}',
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
        if (spFunIsLogin(context: context)) {
          SPClassApiManager.spFunGetInstance().spFunSchemeDetail(
              queryParameters: {"scheme_id": item.spProSchemeId},
              context: context,
              spProCallBack: SPClassHttpCallBack(
                  spProOnSuccess: (value) {
                SPClassNavigatorUtils.spFunPushRoute(
                    context, SPClassSchemeDetailPage(value));
              },onError: (v){},spProOnProgress: (v){}
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
