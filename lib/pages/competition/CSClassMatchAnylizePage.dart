import 'dart:math';

import 'package:changshengh5/api/CSClassApiManager.dart';
import 'package:changshengh5/api/CSClassHttpCallBack.dart';
import 'package:changshengh5/app/CSClassApplicaion.dart';
import 'package:changshengh5/model/CSClassAnylizeMatchList.dart';
import 'package:changshengh5/model/CSClassBaseModelEntity.dart';
import 'package:changshengh5/model/CSClassChartDoughnutData.dart';
import 'package:changshengh5/model/CSClassForecast.dart';
import 'package:changshengh5/model/CSClassGuessMatchInfo.dart';
import 'package:changshengh5/pages/common/CSClassLoadingPage.dart';
import 'package:changshengh5/pages/dialogs/CSClassForcecastRuluDialog.dart';
import 'package:changshengh5/utils/CSClassCommonMethods.dart';
import 'package:changshengh5/utils/CSClassDateUtils.dart';
import 'package:changshengh5/utils/CSClassImageUtil.dart';
import 'package:changshengh5/utils/CSClassListUtil.dart';
import 'package:changshengh5/utils/CSClassStringUtils.dart';
import 'package:changshengh5/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:sprintf/sprintf.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CSClassMatchAnylizePage extends StatefulWidget {
  Map<String, dynamic> params;
  CSClassGuessMatchInfo csProGuessMatch;
  int type = 0; //0为足球  1为篮球
  CSClassMatchAnylizePage(this.params, this.csProGuessMatch, this.type);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CSClassMatchAnylizePageState();
  }
}

class CSClassMatchAnylizePageState extends State<CSClassMatchAnylizePage>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  CSClassAnylizeMatchList? csProAnylizeMatchList;
  int csProHistoryIndex = 0;
  int csProHistoryOneIndex = 0;
  int csProHistoryTwoIndex = 0;

  var csProPointsKey = "总";
  List<CSClassTeamPointsList> csProTeamPointsList = []; //积分排名

  var csProHistoryKey = "全部";
  List<CSClassEntityHistory> csProHistoryList = []; //对赛往绩

  var csProHistoryOneKey = "全部";
  List<CSClassEntityHistory> csProHistoryOne = []; //近期战绩

  var csProHistoryTwoKey = "全部";
  List<CSClassEntityHistory> csProHistoryTwo = []; //近期战绩 客队

  List<CSClassEntityHistory> csProFutureListOne = []; //未来赛事
  List<CSClassEntityHistory> csProFutureListTwo = []; //未来赛事

  var csProIsLoading = true;

  CSClassForecast? csProForecastInfo;
  bool isShowjifen = true;
  bool isShowHistory = true;
  bool isShowjinqiOne = true;
  bool isShowjinqiTwo = true;
  bool isShowFuture = true;

  bool isShowMorejifen = false;
  bool isShowMoreHistory = false;
  bool isShowMorejinqiOne = false;
  bool isShowMorejinqiTwo = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    CSClassApiManager().csMethodMatchAnalyse(
        queryParameters: widget.params,
        csProCallBack: CSClassHttpCallBack<CSClassAnylizeMatchList>(
            csProOnSuccess: (list) {
              csProAnylizeMatchList = list;
              csProIsLoading = false;
              if (csProAnylizeMatchList != null) {
                csMethodInitPointData();
                if (csProAnylizeMatchList!.history != null &&
                    csProAnylizeMatchList!.history!.length > 0) {
                  csProHistoryList.clear();
                  csProHistoryList.addAll(csProAnylizeMatchList!.history!);
                }
                if (csProAnylizeMatchList!.csProTeamOneHistory != null &&
                    csProAnylizeMatchList!.csProTeamOneHistory!.length > 0) {
                  csProHistoryOne
                      .addAll(csProAnylizeMatchList!.csProTeamOneHistory!);
                }
                if (csProAnylizeMatchList!.csProTeamTwoHistory != null &&
                    csProAnylizeMatchList!.csProTeamTwoHistory!.isNotEmpty) {
                  csProHistoryTwo
                      .addAll(csProAnylizeMatchList!.csProTeamTwoHistory!);
                }
                csMethodInitFutureList();
              }

              setState(() {});
            },
            onError: (e) {
              csProIsLoading = false;
              setState(() {});
            },
            csProOnProgress: (v) {}));

    //   getForecastInfo();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    super.build(context);
    return csProIsLoading
        ? CSClassLoadingPage()
        : SingleChildScrollView(
            child: Column(
              children: [
                /// 预测
                Visibility(
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(2, 5),
                              color: Color(0x0C000000),
                              blurRadius: width(
                                6,
                              ),
                            ),
                            BoxShadow(
                              offset: Offset(-5, 1),
                              color: Color(0x0C000000),
                              blurRadius: width(
                                6,
                              ),
                            )
                          ],
                          borderRadius: BorderRadius.circular(width(7)),
                        ),
                        margin: EdgeInsets.only(
                            left: width(10), right: width(10), top: width(10)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(
                              height: width(30),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      csMethodGetSupportRate(1),
                                      style: TextStyle(fontSize: sp(10)),
                                    ),
                                    SizedBox(
                                      height: width(5),
                                    ),
                                    AnimatedSize(
                                      vsync: this,
                                      duration: Duration(milliseconds: 300),
                                      child: Container(
                                        width: width(27),
                                        height: csMethodGetForecastHeight(1),
                                        decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                                begin: Alignment.topCenter,
                                                end: Alignment.bottomCenter,
                                                stops: [
                                              csMethodGetUserSupport(1),
                                              0.0
                                            ],
                                                colors: [
                                              Color(0xFFF14B0B),
                                              Color(0xFFF1150B),
                                            ])),
                                      ),
                                    ),
                                    SizedBox(
                                      height: width(5),
                                    ),
                                    Text(
                                      "主胜",
                                      style: TextStyle(fontSize: sp(12)),
                                    ),
                                    GestureDetector(
                                      child: Container(
                                        decoration: (csProForecastInfo !=
                                                    null &&
                                                csProForecastInfo!
                                                        .csProSupportWhich !=
                                                    null &&
                                                csProForecastInfo!
                                                        .csProSupportWhich ==
                                                    "1")
                                            ? BoxDecoration(boxShadow: [
                                                BoxShadow(
                                                    color: Color(0x66FF9613)
                                                        .withOpacity(0.1),
                                                    offset: Offset(5, 1),
                                                    blurRadius: width(10))
                                              ])
                                            : null,
                                        padding: EdgeInsets.all(width(8)),
                                        child: Image.asset(
                                          CSClassImageUtil.csMethodGetImagePath(
                                              (csProForecastInfo != null &&
                                                      csProForecastInfo!
                                                              .csProSupportWhich !=
                                                          null &&
                                                      csProForecastInfo!
                                                              .csProSupportWhich ==
                                                          "1")
                                                  ? "ic_forecast_gooded"
                                                  : "ic_forecast_good"),
                                          width: width(16),
                                        ),
                                      ),
                                      onTap: () {
                                        csMethodSupportForecast("1");
                                      },
                                    )
                                  ],
                                ),
                                SizedBox(
                                  width: width(67),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      csMethodGetSupportRate(0),
                                      style: TextStyle(fontSize: sp(10)),
                                    ),
                                    SizedBox(
                                      height: width(5),
                                    ),
                                    AnimatedSize(
                                      vsync: this,
                                      duration: Duration(milliseconds: 300),
                                      child: Container(
                                        width: width(27),
                                        height: csMethodGetForecastHeight(0),
                                        decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                                begin: Alignment.topCenter,
                                                end: Alignment.bottomCenter,
                                                stops: [
                                              csMethodGetUserSupport(0),
                                              0.0
                                            ],
                                                colors: [
                                              Color(0xFFB1B1B1),
                                              Color(0x91030000),
                                            ])),
                                      ),
                                    ),
                                    SizedBox(
                                      height: width(5),
                                    ),
                                    Text(
                                      "平局",
                                      style: TextStyle(fontSize: sp(12)),
                                    ),
                                    GestureDetector(
                                      child: Container(
                                        decoration: (csProForecastInfo !=
                                                    null &&
                                                csProForecastInfo!
                                                        .csProSupportWhich !=
                                                    null &&
                                                csProForecastInfo!
                                                        .csProSupportWhich ==
                                                    "0")
                                            ? BoxDecoration(boxShadow: [
                                                BoxShadow(
                                                    color: Color(0x66FF9613)
                                                        .withOpacity(0.1),
                                                    offset: Offset(5, 1),
                                                    blurRadius: width(10))
                                              ])
                                            : null,
                                        padding: EdgeInsets.all(width(8)),
                                        child: Image.asset(
                                          CSClassImageUtil.csMethodGetImagePath(
                                              (csProForecastInfo != null &&
                                                      csProForecastInfo!
                                                              .csProSupportWhich !=
                                                          null &&
                                                      csProForecastInfo!
                                                              .csProSupportWhich ==
                                                          "0")
                                                  ? "ic_forecast_gooded"
                                                  : "ic_forecast_good"),
                                          width: width(16),
                                        ),
                                      ),
                                      onTap: () {
                                        csMethodSupportForecast("0");
                                      },
                                    )
                                  ],
                                ),
                                SizedBox(
                                  width: width(67),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      csMethodGetSupportRate(2),
                                      style: TextStyle(fontSize: sp(10)),
                                    ),
                                    SizedBox(
                                      height: width(5),
                                    ),
                                    AnimatedSize(
                                      vsync: this,
                                      duration: Duration(milliseconds: 300),
                                      child: Container(
                                        width: width(27),
                                        height: csMethodGetForecastHeight(2),
                                        decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                                begin: Alignment.topCenter,
                                                end: Alignment.bottomCenter,
                                                stops: [
                                              csMethodGetUserSupport(2),
                                              0.0
                                            ],
                                                colors: [
                                              Color(0xFF2CDDFF),
                                              Color(0xFF1489FA),
                                            ])),
                                      ),
                                    ),
                                    SizedBox(
                                      height: width(5),
                                    ),
                                    Text(
                                      "客胜",
                                      style: TextStyle(fontSize: sp(12)),
                                    ),
                                    GestureDetector(
                                      child: Container(
                                        decoration: (csProForecastInfo !=
                                                    null &&
                                                csProForecastInfo!
                                                        .csProSupportWhich !=
                                                    null &&
                                                csProForecastInfo!
                                                        .csProSupportWhich ==
                                                    "2")
                                            ? BoxDecoration(boxShadow: [
                                                BoxShadow(
                                                    color: Color(0x66FF9613)
                                                        .withOpacity(0.1),
                                                    offset: Offset(5, 1),
                                                    blurRadius: width(10))
                                              ])
                                            : null,
                                        padding: EdgeInsets.all(width(8)),
                                        child: Image.asset(
                                          CSClassImageUtil.csMethodGetImagePath(
                                              (csProForecastInfo != null &&
                                                      csProForecastInfo!
                                                              .csProSupportWhich !=
                                                          null &&
                                                      csProForecastInfo!
                                                              .csProSupportWhich ==
                                                          "2")
                                                  ? "ic_forecast_gooded"
                                                  : "ic_forecast_good"),
                                          width: width(16),
                                        ),
                                      ),
                                      onTap: () {
                                        csMethodSupportForecast("2");
                                      },
                                    )
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: width(10),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: width(10),
                        child: Stack(
                          alignment: Alignment.topCenter,
                          children: <Widget>[
                            Image.asset(
                              CSClassImageUtil.csMethodGetImagePath(
                                  "bg_title_forecast"),
                              width: width(124),
                            ),
                            Text(
                              "全民预测",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: sp(16),
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: width(15),
                        right: width(25),
                        child: GestureDetector(
                          child: Row(
                            children: <Widget>[
                              Container(
                                alignment: Alignment.center,
                                child: Text(
                                  "?",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: sp(8)),
                                ),
                                width: width(16),
                                height: width(16),
                                decoration: BoxDecoration(
                                    color: Color(0xFFB5B5B5),
                                    shape: BoxShape.circle),
                              ),
                            ],
                          ),
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (c) => CSClassForcecastRuluDialog());
                          },
                        ),
                      )
                    ],
                  ),
                  visible: (csProForecastInfo != null),
                ),

                /// 能力对比
                Visibility(
                  child: AnimatedSize(
                    vsync: this,
                    duration: Duration(milliseconds: 300),
                    child: Container(
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          ///近期战绩
                          (csMethodGetMatchAllPointsScore(1, "全部") +
                                      csMethodGetMatchAllPointsScore(2, "全部") ==
                                  0)
                              ? SizedBox(
                                  height: width(20),
                                )
                              : Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: width(7),
                                      vertical: width(20)),
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                        alignment: Alignment.center,
                                        child: Text(
                                          '【主】',
                                          style: TextStyle(
                                            fontSize: sp(14),
                                            color: MyColors.main2,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.center,
                                        child: Text(
                                          sprintf("%d胜%d平%d负", [
                                            csMethodGetMatchCount(
                                                csMethodGetHistoryOneList("全部")
                                                    .take(
                                                        csMethodGetMinListLength(
                                                            "全部"))
                                                    .toList(),
                                                1),
                                            csMethodGetMatchCount(
                                                csMethodGetHistoryOneList("全部")
                                                    .take(
                                                        csMethodGetMinListLength(
                                                            "全部"))
                                                    .toList(),
                                                0),
                                            csMethodGetMatchCount(
                                                csMethodGetHistoryOneList("全部")
                                                    .take(
                                                        csMethodGetMinListLength(
                                                            "全部"))
                                                    .toList(),
                                                2),
                                          ]),
                                          style: TextStyle(
                                              fontSize: sp(14),
                                              color: Color(0xFF333333),
                                              ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          "近期战绩",
                                          style: TextStyle(fontSize: sp(12)),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.center,
                                        child: Text(
                                          sprintf("%d胜%d平%d负", [
                                            csMethodGetMatchCount(
                                                csMethodGetHistoryTwoList("全部")
                                                    .take(
                                                        csMethodGetMinListLength(
                                                            "全部"))
                                                    .toList(),
                                                1,
                                                winTeam: 2),
                                            csMethodGetMatchCount(
                                                csMethodGetHistoryTwoList("全部")
                                                    .take(
                                                        csMethodGetMinListLength(
                                                            "全部"))
                                                    .toList(),
                                                0,
                                                winTeam: 2),
                                            csMethodGetMatchCount(
                                                csMethodGetHistoryTwoList("全部")
                                                    .take(
                                                        csMethodGetMinListLength(
                                                            "全部"))
                                                    .toList(),
                                                2,
                                                winTeam: 2),
                                          ]),
                                          style: TextStyle(
                                              fontSize: sp(14),
                                              color: Color(0xFF333333),
                                              ),
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.center,
                                        child: Text(
                                          '【客】',
                                          style: TextStyle(
                                            fontSize: sp(14),
                                            color: MyColors.main1,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                          (csMethodGetHistoryOneList("同主客")
                                      .take(csMethodGetMinListLength("同主客"))
                                      .toList()
                                      .length ==
                                  0)
                              ? SizedBox()
                              : Container(
                                  child: Column(
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            alignment: Alignment.centerRight,
                                            width: width(62),
                                            child: Text(
                                              sprintf("%d胜%d平%d负", [
                                                csMethodGetMatchCount(
                                                    csMethodGetHistoryOneList(
                                                            "同主客")
                                                        .take(
                                                            csMethodGetMinListLength(
                                                                "同主客"))
                                                        .toList(),
                                                    1),
                                                csMethodGetMatchCount(
                                                    csMethodGetHistoryOneList(
                                                            "同主客")
                                                        .take(
                                                            csMethodGetMinListLength(
                                                                "同主客"))
                                                        .toList(),
                                                    0),
                                                csMethodGetMatchCount(
                                                    csMethodGetHistoryOneList(
                                                            "同主客")
                                                        .take(
                                                            csMethodGetMinListLength(
                                                                "同主客"))
                                                        .toList(),
                                                    2),
                                              ]),
                                              style: TextStyle(
                                                  fontSize: sp(10),
                                                  color: Color(0xFF333333)),
                                            ),
                                          ),
                                          SizedBox(
                                            width: width(8),
                                          ),
                                          Expanded(
                                            child: Row(
                                              children: <Widget>[
                                                Expanded(
                                                  flex:
                                                      (csMethodGetMatchAllPointsScore(
                                                                  1, "同主客") *
                                                              100)
                                                          .toInt(),
                                                  child: Container(
                                                    margin: EdgeInsets.only(
                                                        right: 2),
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(
                                                        color: MyColors.main2,
                                                        borderRadius: BorderRadius
                                                            .horizontal(
                                                                left: Radius
                                                                    .circular(
                                                                        300))),
                                                    height: width(7),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex:
                                                      (csMethodGetMatchAllPointsScore(
                                                                  2, "同主客") *
                                                              100)
                                                          .toInt(),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        color:
                                                            MyColors.main1,
                                                        borderRadius: BorderRadius
                                                            .horizontal(
                                                                right: Radius
                                                                    .circular(
                                                                        300))),
                                                    alignment: Alignment.center,
                                                    height: width(7),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            width: width(8),
                                          ),
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            width: width(62),
                                            child: Text(
                                              sprintf("%d胜%d平%d负", [
                                                csMethodGetMatchCount(
                                                    csMethodGetHistoryTwoList(
                                                            "同主客")
                                                        .take(
                                                            csMethodGetMinListLength(
                                                                "同主客"))
                                                        .toList(),
                                                    1,
                                                    winTeam: 2),
                                                csMethodGetMatchCount(
                                                    csMethodGetHistoryTwoList(
                                                            "同主客")
                                                        .take(
                                                            csMethodGetMinListLength(
                                                                "同主客"))
                                                        .toList(),
                                                    0,
                                                    winTeam: 2),
                                                csMethodGetMatchCount(
                                                    csMethodGetHistoryTwoList(
                                                            "同主客")
                                                        .take(
                                                            csMethodGetMinListLength(
                                                                "同主客"))
                                                        .toList(),
                                                    2,
                                                    winTeam: 2),
                                              ]),
                                              style: TextStyle(
                                                  fontSize: sp(10),
                                                  color: Color(0xFF333333)),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        "同主客战绩",
                                        style: TextStyle(fontSize: sp(12)),
                                      ),
                                      SizedBox(
                                        height: width(8),
                                      ),
                                    ],
                                  ),
                                ),

                          ///能力指数
                          Visibility(
                            child: Container(
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Container(
                                        alignment: Alignment.centerRight,
                                        width: width(62),
                                        child: Text(
                                          (csMethodGetMatchAllPointsScore(
                                                      1, "全部") +
                                                  csMethodGetMatchAllPointsScore(
                                                      1, "同主客") +
                                                  csMethodAvgWinOrLose25Score(
                                                      true, 1) +
                                                  csMethodAvgWinOrLose25Score(
                                                      false, 1))
                                              .toStringAsFixed(0),
                                          style: TextStyle(
                                              fontSize: sp(12),
                                              color: Color(0xFF333333)),
                                        ),
                                      ),
                                      SizedBox(
                                        width: width(8),
                                      ),
                                      Expanded(
                                        child: Row(
                                          children: <Widget>[
                                            Expanded(
                                              flex: (csMethodGetMatchAllPointsScore(1,
                                                          "全部") +
                                                      csMethodGetMatchAllPointsScore(1,
                                                          "同主客") +
                                                      csMethodAvgWinOrLose25Score(
                                                          true, 1) +
                                                      csMethodAvgWinOrLose25Score(
                                                          false, 1))
                                                  .toInt(),
                                              child: Container(
                                                margin:
                                                    EdgeInsets.only(right: 2),
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                    color: MyColors.main2,
                                                    borderRadius:
                                                        BorderRadius.horizontal(
                                                            left:
                                                                Radius.circular(
                                                                    300))),
                                                height: width(7),
                                              ),
                                            ),
                                            Expanded(
                                              flex: (csMethodGetMatchAllPointsScore(2,
                                                          "全部") +
                                                      csMethodGetMatchAllPointsScore(2,
                                                          "同主客") +
                                                      csMethodAvgWinOrLose25Score(
                                                          true, 2) +
                                                      csMethodAvgWinOrLose25Score(
                                                          false, 2))
                                                  .toInt(),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: MyColors.main1,
                                                    borderRadius:
                                                        BorderRadius.horizontal(
                                                            right:
                                                                Radius.circular(
                                                                    300))),
                                                alignment: Alignment.center,
                                                height: width(7),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: width(8),
                                      ),
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        width: width(62),
                                        child: Text(
                                          (csMethodGetMatchAllPointsScore(
                                                      2, "全部") +
                                                  csMethodGetMatchAllPointsScore(
                                                      2, "同主客") +
                                                  csMethodAvgWinOrLose25Score(
                                                      true, 2) +
                                                  csMethodAvgWinOrLose25Score(
                                                      false, 2))
                                              .toStringAsFixed(0),
                                          style: TextStyle(
                                              fontSize: sp(12),
                                              color: Color(0xFF333333)),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "能力指数",
                                    style: TextStyle(fontSize: sp(12)),
                                  ),
                                  SizedBox(
                                    height: width(8),
                                  ),
                                ],
                              ),
                            ),
                            visible: !((csMethodGetMatchAllPointsScore(
                                            1, "全部") +
                                        csMethodGetMatchAllPointsScore(
                                            1, "同主客") +
                                        csMethodAvgWinOrLose25Score(true, 1) +
                                        csMethodAvgWinOrLose25Score(
                                            false, 1)) ==
                                    0 &&
                                (csMethodGetMatchAllPointsScore(2, "全部") +
                                        csMethodGetMatchAllPointsScore(
                                            2, "同主客") +
                                        csMethodAvgWinOrLose25Score(true, 2) +
                                        csMethodAvgWinOrLose25Score(
                                            false, 2)) ==
                                    0),
                          ),

                          ///场均进球
                          Visibility(
                            child: Container(
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Container(
                                        alignment: Alignment.centerRight,
                                        width: width(62),
                                        child: Text(
                                          sprintf("%s", [
                                            CSClassStringUtils.csMethodSqlitZero(
                                                csMethodAvgWinOrLoseScoreOne(
                                                        true)
                                                    .toStringAsFixed(2))
                                          ]),
                                          style: TextStyle(
                                              fontSize: sp(12),
                                              color: Color(0xFF333333)),
                                        ),
                                      ),
                                      SizedBox(
                                        width: width(8),
                                      ),
                                      Expanded(
                                        child: Row(
                                          children: <Widget>[
                                            Expanded(
                                              flex:
                                                  (csMethodAvgWinOrLoseScoreOne(
                                                              true) *
                                                          100)
                                                      .toInt(),
                                              child: Container(
                                                margin:
                                                    EdgeInsets.only(right: 2),
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                    color: MyColors.main2,
                                                    borderRadius:
                                                        BorderRadius.horizontal(
                                                            left:
                                                                Radius.circular(
                                                                    300))),
                                                height: width(7),
                                              ),
                                            ),
                                            Expanded(
                                              flex:
                                                  (csMethodAvgWinOrLoseScoreTwo(
                                                              true) *
                                                          100)
                                                      .toInt(),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: MyColors.main1,
                                                    borderRadius:
                                                        BorderRadius.horizontal(
                                                            right:
                                                                Radius.circular(
                                                                    300))),
                                                alignment: Alignment.center,
                                                height: width(7),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: width(8),
                                      ),
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        width: width(62),
                                        child: Text(
                                          sprintf("%s", [
                                            CSClassStringUtils.csMethodSqlitZero(
                                                csMethodAvgWinOrLoseScoreTwo(
                                                        true)
                                                    .toStringAsFixed(2))
                                          ]),
                                          style: TextStyle(
                                              fontSize: sp(12),
                                              color: Color(0xFF333333)),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    widget.type == 0 ? "场均进球" : "场均得分",
                                    style: TextStyle(fontSize: sp(12)),
                                  ),
                                  SizedBox(
                                    height: width(8),
                                  ),
                                ],
                              ),
                            ),
                            visible: !(CSClassStringUtils.csMethodSqlitZero(
                                        csMethodAvgWinOrLoseScoreOne(true)
                                            .toStringAsFixed(2)) ==
                                    '0' &&
                                CSClassStringUtils.csMethodSqlitZero(
                                        csMethodAvgWinOrLoseScoreTwo(true)
                                            .toStringAsFixed(2)) ==
                                    '0'),
                          ),

                          ///场均失球
                          Visibility(
                              child: Container(
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Container(
                                          alignment: Alignment.centerRight,
                                          width: width(62),
                                          child: Text(
                                            sprintf("%s", [
                                              CSClassStringUtils.csMethodSqlitZero(
                                                  csMethodAvgWinOrLoseScoreOne(
                                                          false)
                                                      .toStringAsFixed(2))
                                            ]),
                                            style: TextStyle(
                                                fontSize: sp(12),
                                                color: Color(0xFF333333)),
                                          ),
                                        ),
                                        SizedBox(
                                          width: width(8),
                                        ),
                                        Expanded(
                                          child: Row(
                                            children: <Widget>[
                                              Expanded(
                                                flex:
                                                    (csMethodAvgWinOrLoseScoreTwo(
                                                                false) *
                                                            100)
                                                        .toInt(),
                                                child: Container(
                                                  margin:
                                                      EdgeInsets.only(right: 2),
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                      color: MyColors.main2,
                                                      borderRadius: BorderRadius
                                                          .horizontal(
                                                              left: Radius
                                                                  .circular(
                                                                      300))),
                                                  height: width(7),
                                                ),
                                              ),
                                              Expanded(
                                                flex:
                                                    (csMethodAvgWinOrLoseScoreOne(
                                                                false) *
                                                            100)
                                                        .toInt(),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      color: MyColors.main1,
                                                      borderRadius: BorderRadius
                                                          .horizontal(
                                                              right: Radius
                                                                  .circular(
                                                                      300))),
                                                  alignment: Alignment.center,
                                                  height: width(7),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          width: width(8),
                                        ),
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          width: width(62),
                                          child: Text(
                                            sprintf("%s", [
                                              CSClassStringUtils.csMethodSqlitZero(
                                                  csMethodAvgWinOrLoseScoreTwo(
                                                          false)
                                                      .toStringAsFixed(2))
                                            ]),
                                            style: TextStyle(
                                                fontSize: sp(12),
                                                color: Color(0xFF333333)),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      widget.type == 0 ? "场均失球" : "场均失分",
                                      style: TextStyle(fontSize: sp(12)),
                                    ),
                                    SizedBox(
                                      height: width(8),
                                    ),
                                  ],
                                ),
                              ),
                              visible: !(CSClassStringUtils.csMethodSqlitZero(
                                          csMethodAvgWinOrLoseScoreOne(false)
                                              .toStringAsFixed(2)) ==
                                      '0' &&
                                  CSClassStringUtils.csMethodSqlitZero(
                                          csMethodAvgWinOrLoseScoreTwo(false)
                                              .toStringAsFixed(2)) ==
                                      '0')),

                          myDivider(),
                        ],
                      ),
                    ),
                  ),
                  visible:
                      (CSClassListUtil.csMethodIsNotEmpty(csProHistoryList) ||
                          CSClassListUtil.csMethodIsNotEmpty(csProHistoryOne) ||
                          CSClassListUtil.csMethodIsNotEmpty(csProHistoryTwo)),
                ),

                /// 积分排名
                Visibility(
                  child: AnimatedSize(
                    vsync: this,
                    duration: Duration(milliseconds: 300),
                    child: Container(
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(
                              left: width(16),
                              right: width(16),
                            ),
                            height: width(28),
                            color: Color(0xFFDAE6F2),
                            child: Row(
                              children: <Widget>[
                                Container(
                                    margin: EdgeInsets.only(
                                        top: width(3), right: width(8)),
                                    width: width(2),
                                    height: width(12),
                                    color: MyColors.grey_33),
                                Expanded(
                                  child: Text(
                                    "积分排名",
                                    style: TextStyle(
                                        fontSize: sp(14),
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                GestureDetector(
                                  behavior: HitTestBehavior.translucent,
                                  onTap: () {
                                    setState(() {
                                      csProPointsKey = "总";
                                    });
                                  },
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: width(16),
                                      ),
                                      Image.asset(
                                        CSClassImageUtil.csMethodGetImagePath(
                                            csProPointsKey == "总"
                                                ? 'cs_select'
                                                : 'cs_unselect'),
                                        width: width(14),
                                      ),
                                      SizedBox(
                                        width: width(4),
                                      ),
                                      Text(
                                        "总",
                                        style: TextStyle(
                                            fontSize: sp(12),
                                            color: MyColors.grey_33),
                                      ),
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  behavior: HitTestBehavior.translucent,
                                  onTap: () {
                                    setState(() {
                                      csProPointsKey = "主";
                                    });
                                  },
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: width(16),
                                      ),
                                      Image.asset(
                                        CSClassImageUtil.csMethodGetImagePath(
                                            csProPointsKey == "主"
                                                ? 'cs_select'
                                                : 'cs_unselect'),
                                        width: width(14),
                                      ),
                                      SizedBox(
                                        width: width(4),
                                      ),
                                      Text(
                                        "主",
                                        style: TextStyle(
                                            fontSize: sp(12),
                                            color: MyColors.grey_33),
                                      ),
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  behavior: HitTestBehavior.translucent,
                                  onTap: () {
                                    setState(() {
                                      csProPointsKey = "客";
                                    });
                                  },
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: width(16),
                                      ),
                                      Image.asset(
                                        CSClassImageUtil.csMethodGetImagePath(
                                            csProPointsKey == "客"
                                                ? 'cs_select'
                                                : 'cs_unselect'),
                                        width: width(14),
                                      ),
                                      SizedBox(
                                        width: width(4),
                                      ),
                                      Text(
                                        "客",
                                        style: TextStyle(
                                            fontSize: sp(12),
                                            color: MyColors.grey_33),
                                      ),
                                    ],
                                  ),
                                ),
                                // 显示隐藏
                                GestureDetector(
                                  behavior: HitTestBehavior.translucent,
                                  onTap: () {
                                    isShowjifen = !isShowjifen;
                                    setState(() {});
                                  },
                                  child: Container(
                                    padding: EdgeInsets.only(left: width(24)),
                                    child: Image.asset(
                                      CSClassImageUtil.csMethodGetImagePath(
                                          isShowjifen
                                              ? 'ic_down_arrow'
                                              : 'ic_up_arrow'),
                                      width: width(14),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          isShowjifen
                              ? Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Color(0xFFDDDDDD),
                                          width: 0.4)),
                                  alignment: Alignment.center,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        height: width(27),
                                        decoration: BoxDecoration(
                                            color: Color(0xFFF7F7F7),
                                            border: Border(
                                                bottom: BorderSide(
                                                    color: Color(0xFFDDDDDD),
                                                    width: 0.4))),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            SizedBox(
                                              width: width(15),
                                            ),
                                            Expanded(
                                              child: Container(
                                                alignment: Alignment.center,
                                                child: Text(
                                                  "球队",
                                                  style: TextStyle(
                                                      fontSize: sp(11),
                                                      color: Color(0xFF888888)),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Container(
                                                alignment: Alignment.center,
                                                child: Text(
                                                  "排名",
                                                  style: TextStyle(
                                                      fontSize: sp(11),
                                                      color: Color(0xFF888888)),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Container(
                                                alignment: Alignment.center,
                                                child: Text(
                                                  "积分",
                                                  style: TextStyle(
                                                      fontSize: sp(11),
                                                      color: Color(0xFF888888)),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Container(
                                                alignment: Alignment.center,
                                                child: Text(
                                                  "场次",
                                                  style: TextStyle(
                                                      fontSize: sp(11),
                                                      color: Color(0xFF888888)),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Container(
                                                alignment: Alignment.center,
                                                width: width(40),
                                                child: Text(
                                                  "胜率",
                                                  style: TextStyle(
                                                      fontSize: sp(11),
                                                      color: Color(0xFF888888)),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Container(
                                                alignment: Alignment.center,
                                                child: Text(
                                                  "胜/平/负",
                                                  style: TextStyle(
                                                      fontSize: sp(11),
                                                      color: Color(0xFF888888)),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Container(
                                                alignment: Alignment.center,
                                                child: Text(
                                                  "进/失",
                                                  style: TextStyle(
                                                      fontSize: sp(11),
                                                      color: Color(0xFF888888)),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        child: Column(
                                          children: csMethodGetTeamPoints(
                                                  csProPointsKey)
                                              .map((item) {
                                            return Container(
                                              height: width(34),
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  border: Border(
                                                      bottom: BorderSide(
                                                          color:
                                                              Color(0xFFDDDDDD),
                                                          width: 0.4))),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  SizedBox(
                                                    width: width(15),
                                                  ),
                                                  Expanded(
                                                    child: Container(
                                                      alignment:
                                                          Alignment.center,
                                                      child: Text(
                                                        item.csProTeamName!,
                                                        style: TextStyle(
                                                            fontSize: sp(11),
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Container(
                                                      alignment:
                                                          Alignment.center,
                                                      child: Text(
                                                        item.ranking!,
                                                        style: TextStyle(
                                                            fontSize: sp(11),
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Container(
                                                      alignment:
                                                          Alignment.center,
                                                      child: Text(
                                                        item.points!,
                                                        style: TextStyle(
                                                            fontSize: sp(11),
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Container(
                                                      alignment:
                                                          Alignment.center,
                                                      child: Text(
                                                        item.csProMatchNum!,
                                                        style: TextStyle(
                                                            fontSize: sp(11),
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Container(
                                                      alignment:
                                                          Alignment.center,
                                                      width: width(40),
                                                      child: Text(
                                                        sprintf("%s%", [
                                                          (double.parse(item
                                                                      .csProWinRate!) *
                                                                  100)
                                                              .toStringAsFixed(
                                                                  0)
                                                        ]),
                                                        style: TextStyle(
                                                            fontSize: sp(11),
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Container(
                                                      alignment:
                                                          Alignment.center,
                                                      child: Text(
                                                        sprintf("%s/%s/%s", [
                                                          item.csProWinNum,
                                                          item.csProDrawNum,
                                                          item.csProLoseNum
                                                        ]),
                                                        style: TextStyle(
                                                            fontSize: sp(11),
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Container(
                                                      alignment:
                                                          Alignment.center,
                                                      child: Text(
                                                        sprintf("%s/%s", [
                                                          item.score,
                                                          item.csProLoseScore
                                                        ]),
                                                        style: TextStyle(
                                                            fontSize: sp(11),
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          }).toList(),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              : Container(),
                          myDivider(),
                        ],
                      ),
                    ),
                  ),
                  visible:
                      CSClassListUtil.csMethodIsNotEmpty(csProTeamPointsList),
                ),

                /// 历史战绩
                Visibility(
                  child: Container(
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(
                            left: width(16),
                            right: width(16),
                          ),
                          height: width(28),
                          color: Color(0xFFDAE6F2),
                          child: Row(
                            children: <Widget>[
                              Container(
                                  margin: EdgeInsets.only(
                                      top: width(3), right: width(8)),
                                  width: width(2),
                                  height: width(12),
                                  color: MyColors.grey_33),
                              Expanded(
                                child: Text(
                                  "对赛往绩",
                                  style: TextStyle(
                                      fontSize: sp(14),
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              GestureDetector(
                                behavior: HitTestBehavior.translucent,
                                onTap: () {
                                  setState(() {
                                    csProHistoryKey = "全部";
                                  });
                                },
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: width(16),
                                    ),
                                    Image.asset(
                                      CSClassImageUtil.csMethodGetImagePath(
                                          csProHistoryKey == "全部"
                                              ? 'cs_select'
                                              : 'cs_unselect'),
                                      width: width(14),
                                    ),
                                    SizedBox(
                                      width: width(4),
                                    ),
                                    Text(
                                      "全部",
                                      style: TextStyle(
                                          fontSize: sp(12),
                                          color: MyColors.grey_33),
                                    ),
                                  ],
                                ),
                              ),
                              GestureDetector(
                                behavior: HitTestBehavior.translucent,
                                onTap: () {
                                  setState(() {
                                    csProHistoryKey = "主场";
                                  });
                                },
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: width(16),
                                    ),
                                    Image.asset(
                                      CSClassImageUtil.csMethodGetImagePath(
                                          csProHistoryKey == "主场"
                                              ? 'cs_select'
                                              : 'cs_unselect'),
                                      width: width(14),
                                    ),
                                    SizedBox(
                                      width: width(4),
                                    ),
                                    Text(
                                      "同主客",
                                      style: TextStyle(
                                          fontSize: sp(12),
                                          color: MyColors.grey_33),
                                    ),
                                  ],
                                ),
                              ),
                              // 显示隐藏
                              GestureDetector(
                                behavior: HitTestBehavior.translucent,
                                onTap: () {
                                  isShowHistory = !isShowHistory;
                                  setState(() {});
                                },
                                child: Container(
                                  padding: EdgeInsets.only(left: width(24)),
                                  child: Image.asset(
                                    CSClassImageUtil.csMethodGetImagePath(
                                        isShowHistory
                                            ? 'ic_down_arrow'
                                            : 'ic_up_arrow'),
                                    width: width(14),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        isShowHistory
                            ? Column(
                                children: [
                                  // Row(
                                  //   crossAxisAlignment: CrossAxisAlignment.center,
                                  //   children: <Widget>[
                                  //     SizedBox(
                                  //       width: width(13),
                                  //     ),
                                  //     Expanded(
                                  //       child: Row(
                                  //         crossAxisAlignment: CrossAxisAlignment.center,
                                  //         children: <Widget>[
                                  //           Text(
                                  //             '${widget.csProGuessMatch.csProTeamOne}VS${widget.csProGuessMatch.csProTeamTwo}',
                                  //             style: TextStyle(fontSize: sp(13)),
                                  //           ),
                                  //           Text(
                                  //             sprintf("  (%d场)", [
                                  //               csMethodGetHistoryList(csProHistoryKey)
                                  //                   .length
                                  //             ]),
                                  //             style: TextStyle(fontSize: sp(12)),
                                  //           ),
                                  //         ],
                                  //       ),
                                  //     ),
                                  //   ],
                                  // ),
                                  SizedBox(
                                    height: width(10),
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(
                                        horizontal: height(11)),
                                    child: Column(
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            Text(
                                              '${widget.csProGuessMatch.csProTeamOne}:',
                                              style: TextStyle(
                                                fontSize: sp(15),
                                                color: Color(0xFF333333),
                                              ),
                                            ),
                                            Text(
                                              sprintf(
                                                "  %d胜%d平%d负",
                                                [
                                                  csMethodGetMatchCount(
                                                      csMethodGetHistoryList(
                                                          csProHistoryKey),
                                                      1),
                                                  csMethodGetMatchCount(
                                                      csMethodGetHistoryList(
                                                          csProHistoryKey),
                                                      0),
                                                  csMethodGetMatchCount(
                                                      csMethodGetHistoryList(
                                                          csProHistoryKey),
                                                      2),
                                                ],
                                              ),
                                              style:
                                                  TextStyle(fontSize: sp(12)),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 3),
                                        Row(
                                          children: <Widget>[
                                            csMethodGetMatchRate(
                                                        csMethodGetHistoryList(
                                                            csProHistoryKey),
                                                        1) ==
                                                    0
                                                ? SizedBox()
                                                : Container(
                                                    margin: EdgeInsets.only(
                                                        right: width(4)),
                                                    decoration: BoxDecoration(
                                                        color: MyColors.main2,
                                                        borderRadius: BorderRadius
                                                            .horizontal(
                                                                left: Radius
                                                                    .circular(
                                                                        150))),
                                                    alignment: Alignment.center,
                                                    width: width(318) *
                                                        csMethodGetMatchRate(
                                                            csMethodGetHistoryList(
                                                                csProHistoryKey),
                                                            1),
                                                    height: width(10),
                                                  ),
                                            csMethodGetMatchRate(
                                                        csMethodGetHistoryList(
                                                            csProHistoryKey),
                                                        0) ==
                                                    0
                                                ? SizedBox()
                                                : Container(
                                                    margin: EdgeInsets.only(
                                                        right: width(4)),
                                                    alignment: Alignment.center,
                                                    width: width(318) *
                                                        csMethodGetMatchRate(
                                                            csMethodGetHistoryList(
                                                                csProHistoryKey),
                                                            0),
                                                    height: width(10),
                                                    color: Color(0xFF5FB349),
                                                  ),
                                            csMethodGetMatchRate(
                                                        csMethodGetHistoryList(
                                                            csProHistoryKey),
                                                        2) ==
                                                    0
                                                ? SizedBox()
                                                : Expanded(
                                                    child: Container(
                                                      alignment:
                                                          Alignment.center,
                                                      width: width(318) *
                                                          csMethodGetMatchRate(
                                                              csMethodGetHistoryList(
                                                                  csProHistoryKey),
                                                              2),
                                                      height: width(10),
                                                      decoration: BoxDecoration(
                                                          color:
                                                              Colors.black,
                                                          borderRadius: BorderRadius
                                                              .horizontal(
                                                                  right: Radius
                                                                      .circular(
                                                                          150))),
                                                    ),
                                                  ),
                                          ],
                                        ),
                                        Row(
                                          children: <Widget>[
                                            csMethodGetMatchRate(
                                                        csMethodGetHistoryList(
                                                            csProHistoryKey),
                                                        1) ==
                                                    0
                                                ? SizedBox()
                                                : Container(
                                                    margin: EdgeInsets.only(
                                                        right: width(4)),
                                                    alignment: Alignment.center,
                                                    width: width(318) *
                                                        csMethodGetMatchRate(
                                                            csMethodGetHistoryList(
                                                                csProHistoryKey),
                                                            1),
                                                    child: Text(
                                                      sprintf("%d胜", [
                                                        csMethodGetMatchCount(
                                                            csMethodGetHistoryList(
                                                                csProHistoryKey),
                                                            1),
                                                      ]),
                                                      style: TextStyle(
                                                        color:
                                                            Color(0xFF333333),
                                                        fontSize: sp(12),
                                                      ),
                                                    ),
                                                  ),
                                            csMethodGetMatchRate(
                                                        csMethodGetHistoryList(
                                                            csProHistoryKey),
                                                        0) ==
                                                    0
                                                ? SizedBox()
                                                : Container(
                                                    margin: EdgeInsets.only(
                                                        right: width(4)),
                                                    alignment: Alignment.center,
                                                    width: width(318) *
                                                        csMethodGetMatchRate(
                                                            csMethodGetHistoryList(
                                                                csProHistoryKey),
                                                            0),
                                                    child: Text(
                                                      sprintf("%d平", [
                                                        csMethodGetMatchCount(
                                                            csMethodGetHistoryList(
                                                                csProHistoryKey),
                                                            0),
                                                      ]),
                                                      style: TextStyle(
                                                        color:
                                                            Color(0xFF333333),
                                                        fontSize: sp(12),
                                                      ),
                                                    ),
                                                  ),
                                            csMethodGetMatchRate(
                                                        csMethodGetHistoryList(
                                                            csProHistoryKey),
                                                        2) ==
                                                    0
                                                ? SizedBox()
                                                : Expanded(
                                                    child: Container(
                                                      alignment:
                                                          Alignment.center,
                                                      width: width(318) *
                                                          csMethodGetMatchRate(
                                                              csMethodGetHistoryList(
                                                                  csProHistoryKey),
                                                              2),
                                                      child: Text(
                                                        sprintf("%d负", [
                                                          csMethodGetMatchCount(
                                                              csMethodGetHistoryList(
                                                                  csProHistoryKey),
                                                              2),
                                                        ]),
                                                        style: TextStyle(
                                                          color:
                                                              Color(0xFF333333),
                                                          fontSize: sp(12),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  // 盘口
                                  Container(
                                    margin: EdgeInsets.symmetric(
                                        horizontal: height(11),
                                        vertical: height(8)),
                                    child: Column(
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            Text(
                                              '${widget.csProGuessMatch.csProTeamOne}:',
                                              style: TextStyle(
                                                fontSize: sp(15),
                                                color: Color(0xFF333333),
                                              ),
                                            ),
                                            Text(
                                              sprintf("  盘路 %d赢%d走%d输 %s%s", [
                                                csMethodGetMatchPanKouCount(
                                                    csMethodGetHistoryList(
                                                        csProHistoryKey,
                                                        isPanKou: true),
                                                    1),
                                                csMethodGetMatchPanKouCount(
                                                    csMethodGetHistoryList(
                                                        csProHistoryKey,
                                                        isPanKou: true),
                                                    0),
                                                csMethodGetMatchPanKouCount(
                                                    csMethodGetHistoryList(
                                                        csProHistoryKey,
                                                        isPanKou: true),
                                                    2),
                                                (csMethodGetMatchPanKouCount(
                                                            csMethodGetHistoryList(
                                                                csProHistoryKey,
                                                                isPanKou: true),
                                                            3) ==
                                                        0
                                                    ? ""
                                                    : (" " +
                                                        (csMethodGetMatchPanKouCount(
                                                                    csMethodGetHistoryList(
                                                                        csProHistoryKey,
                                                                        isPanKou:
                                                                            true),
                                                                    3)
                                                                .toString() +
                                                            "大"))),
                                                (csMethodGetMatchPanKouCount(
                                                            csMethodGetHistoryList(
                                                                csProHistoryKey,
                                                                isPanKou: true),
                                                            4) ==
                                                        0
                                                    ? ""
                                                    : (" " +
                                                        (csMethodGetMatchPanKouCount(
                                                                    csMethodGetHistoryList(
                                                                        csProHistoryKey,
                                                                        isPanKou:
                                                                            true),
                                                                    4)
                                                                .toString() +
                                                            "小"))),
                                              ]),
                                              style:
                                                  TextStyle(fontSize: sp(12)),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 3),
                                        Row(
                                          children: <Widget>[
                                            csMethodGetMatchPanKouRate(
                                                        csMethodGetHistoryList(
                                                            csProHistoryKey,
                                                            isPanKou: true),
                                                        1) ==
                                                    0
                                                ? SizedBox()
                                                : Container(
                                                    margin: EdgeInsets.only(
                                                        right: width(4)),
                                                    decoration: BoxDecoration(
                                                        color: MyColors.main2,
                                                        borderRadius: BorderRadius
                                                            .horizontal(
                                                                left: Radius
                                                                    .circular(
                                                                        150))),
                                                    alignment: Alignment.center,
                                                    width: width(318) *
                                                        csMethodGetMatchPanKouRate(
                                                            csMethodGetHistoryList(
                                                                csProHistoryKey,
                                                                isPanKou: true),
                                                            1),
                                                    height: width(10),
                                                  ),
                                            csMethodGetMatchPanKouRate(
                                                        csMethodGetHistoryList(
                                                            csProHistoryKey,
                                                            isPanKou: true),
                                                        0) ==
                                                    0
                                                ? SizedBox()
                                                : Container(
                                                    margin: EdgeInsets.only(
                                                        right: width(4)),
                                                    alignment: Alignment.center,
                                                    width: width(318) *
                                                        csMethodGetMatchPanKouRate(
                                                            csMethodGetHistoryList(
                                                                csProHistoryKey,
                                                                isPanKou: true),
                                                            0),
                                                    height: width(10),
                                                    color: Color(0xFF5FB349),
                                                  ),
                                            csMethodGetMatchPanKouRate(
                                                        csMethodGetHistoryList(
                                                            csProHistoryKey,
                                                            isPanKou: true),
                                                        2) ==
                                                    0
                                                ? SizedBox()
                                                : Expanded(
                                                    child: Container(
                                                      alignment:
                                                          Alignment.center,
                                                      width: width(318) *
                                                          csMethodGetMatchPanKouRate(
                                                              csMethodGetHistoryList(
                                                                  csProHistoryKey,
                                                                  isPanKou:
                                                                      true),
                                                              2),
                                                      height: width(10),
                                                      decoration: BoxDecoration(
                                                          color:
                                                              Colors.black,
                                                          borderRadius: BorderRadius
                                                              .horizontal(
                                                                  right: Radius
                                                                      .circular(
                                                                          150))),
                                                    ),
                                                  ),
                                          ],
                                        ),
                                        Row(
                                          children: <Widget>[
                                            csMethodGetMatchPanKouRate(
                                                        csMethodGetHistoryList(
                                                            csProHistoryKey,
                                                            isPanKou: true),
                                                        1) ==
                                                    0
                                                ? SizedBox()
                                                : Container(
                                                    margin: EdgeInsets.only(
                                                        right: width(4)),
                                                    alignment: Alignment.center,
                                                    width: width(318) *
                                                        csMethodGetMatchPanKouRate(
                                                            csMethodGetHistoryList(
                                                                csProHistoryKey,
                                                                isPanKou: true),
                                                            1),
                                                    child: Text(
                                                      sprintf("%d赢", [
                                                        csMethodGetMatchPanKouCount(
                                                            csMethodGetHistoryList(
                                                                csProHistoryKey,
                                                                isPanKou: true),
                                                            1),
                                                      ]),
                                                      style: TextStyle(
                                                        color:
                                                            Color(0xFF333333),
                                                        fontSize: sp(12),
                                                      ),
                                                    ),
                                                  ),
                                            csMethodGetMatchPanKouRate(
                                                        csMethodGetHistoryList(
                                                            csProHistoryKey,
                                                            isPanKou: true),
                                                        0) ==
                                                    0
                                                ? SizedBox()
                                                : Container(
                                                    margin: EdgeInsets.only(
                                                        right: width(4)),
                                                    alignment: Alignment.center,
                                                    width: width(318) *
                                                        csMethodGetMatchPanKouRate(
                                                            csMethodGetHistoryList(
                                                                csProHistoryKey,
                                                                isPanKou: true),
                                                            0),
                                                    child: Text(
                                                      sprintf("%d走", [
                                                        csMethodGetMatchPanKouCount(
                                                            csMethodGetHistoryList(
                                                                csProHistoryKey,
                                                                isPanKou: true),
                                                            0),
                                                      ]),
                                                      style: TextStyle(
                                                        color:
                                                            Color(0xFF333333),
                                                        fontSize: sp(12),
                                                      ),
                                                    ),
                                                  ),
                                            csMethodGetMatchPanKouRate(
                                                        csMethodGetHistoryList(
                                                            csProHistoryKey,
                                                            isPanKou: true),
                                                        2) ==
                                                    0
                                                ? SizedBox()
                                                : Expanded(
                                                    child: Container(
                                                      alignment:
                                                          Alignment.center,
                                                      width: width(318) *
                                                          csMethodGetMatchPanKouRate(
                                                              csMethodGetHistoryList(
                                                                  csProHistoryKey,
                                                                  isPanKou:
                                                                      true),
                                                              2),
                                                      child: Text(
                                                        sprintf("%d输", [
                                                          csMethodGetMatchPanKouCount(
                                                              csMethodGetHistoryList(
                                                                  csProHistoryKey,
                                                                  isPanKou:
                                                                      true),
                                                              2),
                                                        ]),
                                                        style: TextStyle(
                                                          color:
                                                              Color(0xFF333333),
                                                          fontSize: sp(12),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),

                                  // 对对赛往绩
                                  matchListItem(csMethodGetHistoryList(
                                      csProHistoryKey),isShowMoreHistory),
                                  GestureDetector(
                                    behavior: HitTestBehavior.translucent,
                                    onTap: (){
                                      isShowMoreHistory =true;
                                      setState(() {
                                      });
                                    },
                                    child: (isShowMoreHistory||csMethodGetHistoryList(
                                        csProHistoryKey).length<10)?Container():Container(
                                      height: width(28),
                                      color: Color(0xFFF2F9FF),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text('点击查看全部赛事',style: TextStyle(color: Color(0xFF1B8DE0),fontSize: sp(12)),),
                                          SizedBox(width: width(4),),
                                          Image.asset(
                                            CSClassImageUtil.csMethodGetImagePath(
                                                'ic_up_arrow'),
                                            width: width(12),color: Color(0xFF1B8DE0),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )

                                ],
                              )
                            : Container(),
                        myDivider(),
                      ],
                    ),
                  ),
                  visible: CSClassListUtil.csMethodIsNotEmpty(csProHistoryList),
                ),

                /// 近期战绩
                Visibility(
                  child: Container(
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(
                            left: width(16),
                            right: width(16),
                          ),
                          height: width(42),
                          color: Colors.white,
                          child: Row(
                            children: <Widget>[
                              Container(
                                  margin: EdgeInsets.only(
                                      top: width(3), right: width(8)),
                                  width: width(2),
                                  height: width(12),
                                  color: MyColors.grey_33),
                              Expanded(
                                child: Text(
                                  "近期战绩",
                                  style: TextStyle(
                                      fontSize: sp(14),
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          child: Column(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.only(
                                  left: width(15),
                                  right: width(15),
                                ),
                                height: width(28),
                                color: Color(0xFFDAE6F2),
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(150)),
                                      child:
                                          CSClassImageUtil.csMethodNetWordImage(
                                        placeholder: "cs_home_team",
                                        url: widget
                                            .csProGuessMatch.csProIconUrlOne!,
                                        width: width(20),
                                      ),
                                    ),
                                    SizedBox(width: width(4)),
                                    Expanded(
                                      child: Text(
                                        CSClassStringUtils.csMethodMaxLength(
                                            widget
                                                .csProGuessMatch.csProTeamOne!,
                                            length: 6),
                                        style: TextStyle(
                                          fontSize: sp(14),
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      behavior: HitTestBehavior.translucent,
                                      onTap: () {
                                        setState(() {
                                          csProHistoryOneKey = "全部";
                                        });
                                      },
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: width(16),
                                          ),
                                          Image.asset(
                                            CSClassImageUtil
                                                .csMethodGetImagePath(
                                                    csProHistoryOneKey == "全部"
                                                        ? 'cs_select'
                                                        : 'cs_unselect'),
                                            width: width(14),
                                          ),
                                          SizedBox(
                                            width: width(4),
                                          ),
                                          Text(
                                            "全部",
                                            style: TextStyle(
                                                fontSize: sp(12),
                                                color: MyColors.grey_33),
                                          ),
                                        ],
                                      ),
                                    ),
                                    GestureDetector(
                                      behavior: HitTestBehavior.translucent,
                                      onTap: () {
                                        setState(() {
                                          csProHistoryOneKey = "主场";
                                        });
                                      },
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: width(16),
                                          ),
                                          Image.asset(
                                            CSClassImageUtil
                                                .csMethodGetImagePath(
                                                    csProHistoryOneKey == "主场"
                                                        ? 'cs_select'
                                                        : 'cs_unselect'),
                                            width: width(14),
                                          ),
                                          SizedBox(
                                            width: width(4),
                                          ),
                                          Text(
                                            "同主客",
                                            style: TextStyle(
                                                fontSize: sp(12),
                                                color: MyColors.grey_33),
                                          ),
                                        ],
                                      ),
                                    ),
                                    // 显示隐藏
                                    GestureDetector(
                                      behavior: HitTestBehavior.translucent,
                                      onTap: () {
                                        isShowjinqiOne = !isShowjinqiOne;
                                        setState(() {});
                                      },
                                      child: Container(
                                        padding:
                                            EdgeInsets.only(left: width(24)),
                                        child: Image.asset(
                                          CSClassImageUtil.csMethodGetImagePath(
                                              isShowjinqiOne
                                                  ? 'ic_down_arrow'
                                                  : 'ic_up_arrow'),
                                          width: width(14),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // Container(
                              //   margin: EdgeInsets.only(
                              //       left: width(15),
                              //       right: width(15),
                              //       top: width(24),
                              //       bottom: width(10)),
                              //   child: Row(
                              //     children: <Widget>[
                              //       Text(
                              //         "近期战绩",
                              //         style: TextStyle(
                              //             fontSize: sp(16),
                              //             fontWeight: FontWeight.bold),
                              //       ),
                              //       SizedBox(
                              //         width: width(4),
                              //       ),
                              //       Container(
                              //           constraints:
                              //               BoxConstraints(maxWidth: width(79)),
                              //           child: Text(
                              //             '${widget.csProGuessMatch.csProTeamOne}:',
                              //             style: TextStyle(fontSize: sp(12)),
                              //             maxLines: 1,
                              //             overflow: TextOverflow.ellipsis,
                              //           )),
                              //       Text(
                              //         sprintf("%d胜%d平%d负", [
                              //           csMethodGetMatchCount(
                              //               csMethodGetHistoryOneList(
                              //                   csProHistoryOneKey),
                              //               1),
                              //           csMethodGetMatchCount(
                              //               csMethodGetHistoryOneList(
                              //                   csProHistoryOneKey),
                              //               0),
                              //           csMethodGetMatchCount(
                              //               csMethodGetHistoryOneList(
                              //                   csProHistoryOneKey),
                              //               2),
                              //         ]),
                              //         style: TextStyle(
                              //           fontSize: sp(12),
                              //         ),
                              //         textAlign: TextAlign.center,
                              //       ),
                              //       Expanded(
                              //         child: SizedBox(),
                              //       ),
                              //       Container(
                              //         width: width(93),
                              //         height: width(27),
                              //         child: Row(
                              //           children: <Widget>[
                              //             Expanded(
                              //               child: FlatButton(
                              //                 padding: EdgeInsets.zero,
                              //                 child: Container(
                              //                   decoration: BoxDecoration(
                              //                       borderRadius:
                              //                           BorderRadius.horizontal(
                              //                               left:
                              //                                   Radius.circular(
                              //                                       width(12))),
                              //                       // border: Border.all(color: csProHistoryOneKey=="全部"? Color(0xFFDE3C31):Color(0xFFC4C4C4),width: 0.4),
                              //                       color: csProHistoryOneKey ==
                              //                               "全部"
                              //                           ? MyColors.main1
                              //                           : Color(0xFFF2F2F2)),
                              //                   alignment: Alignment.center,
                              //                   child: Text(
                              //                     "全部",
                              //                     style: TextStyle(
                              //                         fontSize: sp(14),
                              //                         color:
                              //                             csProHistoryOneKey ==
                              //                                     "全部"
                              //                                 ? Colors.white
                              //                                 : Color(
                              //                                     0xFF999999)),
                              //                   ),
                              //                 ),
                              //                 onPressed: () {
                              //                   setState(() {
                              //                     csProHistoryOneKey = "全部";
                              //                   });
                              //                 },
                              //               ),
                              //             ),
                              //             Expanded(
                              //               child: FlatButton(
                              //                 padding: EdgeInsets.zero,
                              //                 child: Container(
                              //                   decoration: BoxDecoration(
                              //                       borderRadius:
                              //                           BorderRadius.horizontal(
                              //                               right:
                              //                                   Radius.circular(
                              //                                       width(12))),
                              //                       color: csProHistoryOneKey ==
                              //                               "主场"
                              //                           ? MyColors.main1
                              //                           : Color(0xFFF2F2F2)),
                              //                   alignment: Alignment.center,
                              //                   child: Text(
                              //                     "主场",
                              //                     style: TextStyle(
                              //                         fontSize: sp(14),
                              //                         color:
                              //                             csProHistoryOneKey ==
                              //                                     "主场"
                              //                                 ? Colors.white
                              //                                 : Color(
                              //                                     0xFF999999)),
                              //                   ),
                              //                 ),
                              //                 onPressed: () {
                              //                   setState(() {
                              //                     csProHistoryOneKey = "主场";
                              //                   });
                              //                 },
                              //               ),
                              //             ),
                              //           ],
                              //         ),
                              //       )
                              //     ],
                              //   ),
                              // ),

                              isShowjinqiOne
                                  ? Column(
                                      children: [
                                        SizedBox(
                                          height: width(16),
                                        ),
                                        Row(
                                          children: <Widget>[
                                            Expanded(
                                              child: Center(
                                                child: Column(
                                                  children: <Widget>[
                                                    Text("胜率",
                                                        style: TextStyle(
                                                          fontSize: sp(12),
                                                        )),
                                                    Stack(
                                                      alignment:
                                                          Alignment.center,
                                                      children: <Widget>[
                                                        Container(
                                                          height: width(64),
                                                          width: width(64),
                                                          child:
                                                              SfCircularChart(
                                                            margin:
                                                                EdgeInsets.zero,
                                                            title: ChartTitle(
                                                                text: ''),
                                                            legend: Legend(
                                                                isVisible:
                                                                    false),
                                                            series: [
                                                              DoughnutSeries<CSClassChartDoughnutData, String>(
                                                                explode: false,
                                                                explodeIndex: 0,
                                                                radius: width(30).toString(),
                                                                innerRadius: width(22).toString(),
                                                                dataSource: [
                                                                  CSClassChartDoughnutData(csMethodGetMatchCount(csMethodGetHistoryOneList(csProHistoryOneKey), 1)*1.0,color: Color(0xFFFF6A4D)),
                                                                  CSClassChartDoughnutData(csMethodGetMatchCount(csMethodGetHistoryOneList(csProHistoryOneKey), 2)*1.0,color: Color(0xFF5FB349)),
                                                                  CSClassChartDoughnutData(csMethodGetMatchCount(csMethodGetHistoryOneList(csProHistoryOneKey), 0)*1.0,color: Color(0xFF333333)),

                                                                ],
                                                                xValueMapper:
                                                                    (CSClassChartDoughnutData
                                                                                data,
                                                                            _) =>
                                                                        "",
                                                                yValueMapper:
                                                                    (CSClassChartDoughnutData
                                                                                data,
                                                                            _) =>
                                                                        data.percenter,
                                                                pointColorMapper:
                                                                    (CSClassChartDoughnutData
                                                                                data,
                                                                            _) =>
                                                                        data.color,
                                                                startAngle: 90,
                                                                endAngle: 90,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Text(
                                                          sprintf(
                                                              "%d胜%d平\n%d负", [
                                                            csMethodGetMatchCount(
                                                                csMethodGetHistoryOneList(
                                                                    csProHistoryOneKey),
                                                                1),
                                                            csMethodGetMatchCount(
                                                                csMethodGetHistoryOneList(
                                                                    csProHistoryOneKey),
                                                                0),
                                                            csMethodGetMatchCount(
                                                                csMethodGetHistoryOneList(
                                                                    csProHistoryOneKey),
                                                                2),
                                                          ]),
                                                          // sprintf("%s%", [
                                                          //   (csMethodGetMatchRate(
                                                          //       csMethodGetHistoryOneList(
                                                          //           csProHistoryOneKey),
                                                          //       1) *
                                                          //       100)
                                                          //       .toStringAsFixed(0)
                                                          // ]),
                                                          style: TextStyle(
                                                            fontSize: sp(10),
                                                          ),
                                                          textAlign:
                                                              TextAlign.center,
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Center(
                                                child: Column(
                                                  children: <Widget>[
                                                    Text("赢盘率",
                                                        style: TextStyle(
                                                          fontSize: sp(12),
                                                        )),
                                                    Stack(
                                                      alignment:
                                                          Alignment.center,
                                                      children: <Widget>[
                                                        Container(
                                                          height: width(64),
                                                          width: width(64),
                                                          child:
                                                              SfCircularChart(
                                                            margin:
                                                                EdgeInsets.zero,
                                                            title: ChartTitle(
                                                                text: ''),
                                                            legend: Legend(
                                                                isVisible:
                                                                    false),
                                                            series: [
                                                              DoughnutSeries<
                                                                  CSClassChartDoughnutData,
                                                                  String>(
                                                                explode: false,
                                                                explodeIndex: 0,
                                                                radius: width(
                                                                        30)
                                                                    .toString(),
                                                                innerRadius: width(
                                                                        22)
                                                                    .toString(),
                                                                dataSource: [
                                                                  CSClassChartDoughnutData(
                                                                      csMethodGetMatchPanKouRate(
                                                                          csMethodGetHistoryOneList(
                                                                              csProHistoryOneKey),
                                                                          1),
                                                                      color: Color(
                                                                          0xFFFF6A4D)),
                                                                  CSClassChartDoughnutData(
                                                                      1 -
                                                                          csMethodGetMatchPanKouRate(
                                                                              csMethodGetHistoryOneList(
                                                                                  csProHistoryOneKey),
                                                                              1),
                                                                      color: Color(
                                                                          0xFFE6E6E6)),
                                                                ],
                                                                xValueMapper:
                                                                    (CSClassChartDoughnutData
                                                                                data,
                                                                            _) =>
                                                                        "",
                                                                yValueMapper:
                                                                    (CSClassChartDoughnutData
                                                                                data,
                                                                            _) =>
                                                                        data.percenter,
                                                                pointColorMapper:
                                                                    (CSClassChartDoughnutData
                                                                                data,
                                                                            _) =>
                                                                        data.color,
                                                                startAngle: 90,
                                                                endAngle: 90,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Text(
                                                            sprintf("%s%", [
                                                              (csMethodGetMatchPanKouRate(
                                                                          csMethodGetHistoryOneList(
                                                                              csProHistoryOneKey),
                                                                          1) *
                                                                      100)
                                                                  .toStringAsFixed(
                                                                      0)
                                                            ]),
                                                            style: TextStyle(
                                                              fontSize: sp(10),
                                                            ))
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Center(
                                                child: Column(
                                                  children: <Widget>[
                                                    Text("大率",
                                                        style: TextStyle(
                                                          fontSize: sp(12),
                                                        )),
                                                    Stack(
                                                      alignment:
                                                          Alignment.center,
                                                      children: <Widget>[
                                                        Container(
                                                          height: width(64),
                                                          width: width(64),
                                                          child:
                                                              SfCircularChart(
                                                            margin:
                                                                EdgeInsets.zero,
                                                            title: ChartTitle(
                                                                text: ''),
                                                            legend: Legend(
                                                                isVisible:
                                                                    false),
                                                            series: [
                                                              DoughnutSeries<
                                                                  CSClassChartDoughnutData,
                                                                  String>(
                                                                explode: false,
                                                                explodeIndex: 0,
                                                                radius: width(
                                                                        30)
                                                                    .toString(),
                                                                innerRadius: width(
                                                                        22)
                                                                    .toString(),
                                                                dataSource: [
                                                                  CSClassChartDoughnutData(
                                                                      csMethodGetMatchBigRate(
                                                                          csMethodGetHistoryOneList(
                                                                              csProHistoryOneKey),
                                                                          1),
                                                                      color: Color(
                                                                          0xFFFF6A4D)),
                                                                  CSClassChartDoughnutData(
                                                                      1 -
                                                                          csMethodGetMatchBigRate(
                                                                              csMethodGetHistoryOneList(
                                                                                  csProHistoryOneKey),
                                                                              1),
                                                                      color: Color(
                                                                          0xFFE6E6E6)),
                                                                ],
                                                                xValueMapper:
                                                                    (CSClassChartDoughnutData
                                                                                data,
                                                                            _) =>
                                                                        "",
                                                                yValueMapper:
                                                                    (CSClassChartDoughnutData
                                                                                data,
                                                                            _) =>
                                                                        data.percenter,
                                                                pointColorMapper:
                                                                    (CSClassChartDoughnutData
                                                                                data,
                                                                            _) =>
                                                                        data.color,
                                                                startAngle: 90,
                                                                endAngle: 90,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Text(
                                                            sprintf("%s%", [
                                                              (csMethodGetMatchBigRate(
                                                                          csMethodGetHistoryOneList(
                                                                              csProHistoryOneKey),
                                                                          1) *
                                                                      100)
                                                                  .toStringAsFixed(
                                                                      0)
                                                            ]),
                                                            style: TextStyle(
                                                              fontSize: sp(10),
                                                            ))
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: width(16),
                                        ),
                                        matchListItem(csMethodGetHistoryOneList(
                                            csProHistoryOneKey),isShowMorejinqiOne,),
                                        GestureDetector(
                                          behavior: HitTestBehavior.translucent,
                                          onTap: (){
                                            isShowMorejinqiOne =true;
                                            setState(() {
                                            });
                                          },
                                          child: (isShowMorejinqiOne||csMethodGetHistoryOneList(
                                              csProHistoryOneKey).length<10)?Container():Container(
                                            height: width(28),
                                            color: Color(0xFFF2F9FF),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text('点击查看全部赛事',style: TextStyle(color: Color(0xFF1B8DE0),fontSize: sp(12)),),
                                                SizedBox(width: width(4),),
                                                Image.asset(
                                                  CSClassImageUtil.csMethodGetImagePath(
                                                      'ic_up_arrow'),
                                                  width: width(12),color: Color(0xFF1B8DE0),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )

                                      ],
                                    )
                                  : Container(),
                            ],
                          ),
                        ),
                        myDivider(),
                        Column(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(
                                left: width(15),
                                right: width(15),
                              ),
                              height: width(28),
                              color: Color(0xFFDAE6F2),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(150)),
                                    child:
                                        CSClassImageUtil.csMethodNetWordImage(
                                      placeholder: "cs_away_team",
                                      url: widget
                                          .csProGuessMatch.csProIconUrlTwo!,
                                      width: width(20),
                                    ),
                                  ),
                                  SizedBox(width: width(4)),
                                  Expanded(
                                    child: Text(
                                      CSClassStringUtils.csMethodMaxLength(
                                          widget.csProGuessMatch.csProTeamTwo!,
                                          length: 6),
                                      style: TextStyle(
                                        fontSize: sp(14),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    behavior: HitTestBehavior.translucent,
                                    onTap: () {
                                      setState(() {
                                        csProHistoryTwoKey = "全部";
                                      });
                                    },
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: width(16),
                                        ),
                                        Image.asset(
                                          CSClassImageUtil.csMethodGetImagePath(
                                              csProHistoryTwoKey == "全部"
                                                  ? 'cs_select'
                                                  : 'cs_unselect'),
                                          width: width(14),
                                        ),
                                        SizedBox(
                                          width: width(4),
                                        ),
                                        Text(
                                          "全部",
                                          style: TextStyle(
                                              fontSize: sp(12),
                                              color: MyColors.grey_33),
                                        ),
                                      ],
                                    ),
                                  ),
                                  GestureDetector(
                                    behavior: HitTestBehavior.translucent,
                                    onTap: () {
                                      setState(() {
                                        csProHistoryTwoKey = "主场";
                                      });
                                    },
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: width(16),
                                        ),
                                        Image.asset(
                                          CSClassImageUtil.csMethodGetImagePath(
                                              csProHistoryTwoKey == "主场"
                                                  ? 'cs_select'
                                                  : 'cs_unselect'),
                                          width: width(14),
                                        ),
                                        SizedBox(
                                          width: width(4),
                                        ),
                                        Text(
                                          "同主客",
                                          style: TextStyle(
                                              fontSize: sp(12),
                                              color: MyColors.grey_33),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // 显示隐藏
                                  GestureDetector(
                                    behavior: HitTestBehavior.translucent,
                                    onTap: () {
                                      isShowjinqiTwo = !isShowjinqiTwo;
                                      setState(() {});
                                    },
                                    child: Container(
                                      padding: EdgeInsets.only(left: width(24)),
                                      child: Image.asset(
                                        CSClassImageUtil.csMethodGetImagePath(
                                            isShowjinqiTwo
                                                ? 'ic_down_arrow'
                                                : 'ic_up_arrow'),
                                        width: width(14),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            isShowjinqiTwo
                                ? Column(
                                    children: [
                                      SizedBox(
                                        height: width(16),
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Expanded(
                                            child: Center(
                                              child: Column(
                                                children: <Widget>[
                                                  Text("胜率",
                                                      style: TextStyle(
                                                        fontSize: sp(12),
                                                      )),
                                                  Stack(
                                                    alignment: Alignment.center,
                                                    children: <Widget>[
                                                      Container(
                                                        height: width(64),
                                                        width: width(64),
                                                        child: SfCircularChart(
                                                          margin:
                                                              EdgeInsets.zero,
                                                          title: ChartTitle(
                                                              text: ''),
                                                          legend: Legend(
                                                              isVisible: false),
                                                          series: [
                                                            DoughnutSeries<
                                                                CSClassChartDoughnutData,
                                                                String>(
                                                              explode: false,
                                                              explodeIndex: 0,
                                                              radius: width(30)
                                                                  .toString(),
                                                              innerRadius: width(
                                                                      22)
                                                                  .toString(),
                                                              dataSource: [
                                                                CSClassChartDoughnutData(csMethodGetMatchCount(csMethodGetHistoryTwoList(csProHistoryTwoKey), 1,winTeam: 2)*1.0,color: Color(0xFFFF6A4D)),
                                                                CSClassChartDoughnutData(csMethodGetMatchCount(csMethodGetHistoryTwoList(csProHistoryTwoKey), 2,winTeam: 2)*1.0,color: Color(0xFF5FB349)),
                                                                CSClassChartDoughnutData(csMethodGetMatchCount(csMethodGetHistoryTwoList(csProHistoryTwoKey), 0,winTeam: 2)*1.0,color: Color(0xFF333333)),

                                                              ],
                                                              xValueMapper:
                                                                  (CSClassChartDoughnutData
                                                                              data,
                                                                          _) =>
                                                                      "",
                                                              yValueMapper:
                                                                  (CSClassChartDoughnutData
                                                                              data,
                                                                          _) =>
                                                                      data.percenter,
                                                              pointColorMapper:
                                                                  (CSClassChartDoughnutData
                                                                              data,
                                                                          _) =>
                                                                      data.color,
                                                              startAngle: 90,
                                                              endAngle: 90,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Text(
                                                        sprintf("%d胜%d平\n%d负", [
                                                          csMethodGetMatchCount(
                                                              csMethodGetHistoryTwoList(
                                                                  csProHistoryTwoKey),
                                                              1,
                                                              winTeam: 2),
                                                          csMethodGetMatchCount(
                                                              csMethodGetHistoryTwoList(
                                                                  csProHistoryTwoKey),
                                                              0,
                                                              winTeam: 2),
                                                          csMethodGetMatchCount(
                                                              csMethodGetHistoryTwoList(
                                                                  csProHistoryTwoKey),
                                                              2,
                                                              winTeam: 2),
                                                        ]),
                                                        style: TextStyle(
                                                          fontSize: sp(10),
                                                        ),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Center(
                                              child: Column(
                                                children: <Widget>[
                                                  Text("赢盘率",
                                                      style: TextStyle(
                                                        fontSize: sp(12),
                                                      )),
                                                  Stack(
                                                    alignment: Alignment.center,
                                                    children: <Widget>[
                                                      Container(
                                                        height: width(64),
                                                        width: width(64),
                                                        child: SfCircularChart(
                                                          margin:
                                                              EdgeInsets.zero,
                                                          title: ChartTitle(
                                                              text: ''),
                                                          legend: Legend(
                                                              isVisible: false),
                                                          series: [
                                                            DoughnutSeries<
                                                                CSClassChartDoughnutData,
                                                                String>(
                                                              explode: false,
                                                              explodeIndex: 0,
                                                              radius: width(30)
                                                                  .toString(),
                                                              innerRadius: width(
                                                                      22)
                                                                  .toString(),
                                                              dataSource: [
                                                                CSClassChartDoughnutData(
                                                                    csMethodGetMatchPanKouRate(
                                                                        csMethodGetHistoryTwoList(
                                                                            csProHistoryTwoKey),
                                                                        1),
                                                                    color: Color(
                                                                        0xFFFF5F40)),
                                                                CSClassChartDoughnutData(
                                                                    1 -
                                                                        csMethodGetMatchPanKouRate(
                                                                            csMethodGetHistoryTwoList(
                                                                                csProHistoryTwoKey),
                                                                            1),
                                                                    color: Color(
                                                                        0xFEBEBEB)),
                                                              ],
                                                              xValueMapper:
                                                                  (CSClassChartDoughnutData
                                                                              data,
                                                                          _) =>
                                                                      "",
                                                              yValueMapper:
                                                                  (CSClassChartDoughnutData
                                                                              data,
                                                                          _) =>
                                                                      data.percenter,
                                                              pointColorMapper:
                                                                  (CSClassChartDoughnutData
                                                                              data,
                                                                          _) =>
                                                                      data.color,
                                                              startAngle: 90,
                                                              endAngle: 90,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Text(
                                                          sprintf("%s%", [
                                                            (csMethodGetMatchPanKouRate(
                                                                        csMethodGetHistoryTwoList(
                                                                            csProHistoryTwoKey),
                                                                        1) *
                                                                    100)
                                                                .toStringAsFixed(
                                                                    0)
                                                          ]),
                                                          style: TextStyle(
                                                            fontSize: sp(10),
                                                          ))
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Center(
                                              child: Column(
                                                children: <Widget>[
                                                  Text("大率",
                                                      style: TextStyle(
                                                        fontSize: sp(12),
                                                      )),
                                                  Stack(
                                                    alignment: Alignment.center,
                                                    children: <Widget>[
                                                      Container(
                                                        height: width(64),
                                                        width: width(64),
                                                        child: SfCircularChart(
                                                          margin:
                                                              EdgeInsets.zero,
                                                          title: ChartTitle(
                                                              text: ''),
                                                          legend: Legend(
                                                              isVisible: false),
                                                          series: [
                                                            DoughnutSeries<
                                                                CSClassChartDoughnutData,
                                                                String>(
                                                              explode: false,
                                                              explodeIndex: 0,
                                                              radius: width(30)
                                                                  .toString(),
                                                              innerRadius: width(
                                                                      22)
                                                                  .toString(),
                                                              dataSource: [
                                                                CSClassChartDoughnutData(
                                                                    csMethodGetMatchBigRate(
                                                                        csMethodGetHistoryTwoList(
                                                                            csProHistoryTwoKey),
                                                                        1),
                                                                    color: Color(
                                                                        0xFFFF6A4D)),
                                                                CSClassChartDoughnutData(
                                                                    1 -
                                                                        csMethodGetMatchBigRate(
                                                                            csMethodGetHistoryTwoList(
                                                                                csProHistoryTwoKey),
                                                                            1),
                                                                    color: Color(
                                                                        0xFFE6E6E6)),
                                                              ],
                                                              xValueMapper:
                                                                  (CSClassChartDoughnutData
                                                                              data,
                                                                          _) =>
                                                                      "",
                                                              yValueMapper:
                                                                  (CSClassChartDoughnutData
                                                                              data,
                                                                          _) =>
                                                                      data.percenter,
                                                              pointColorMapper:
                                                                  (CSClassChartDoughnutData
                                                                              data,
                                                                          _) =>
                                                                      data.color,
                                                              startAngle: 90,
                                                              endAngle: 90,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Text(
                                                          sprintf("%s%", [
                                                            (csMethodGetMatchBigRate(
                                                                        csMethodGetHistoryTwoList(
                                                                            csProHistoryTwoKey),
                                                                        1) *
                                                                    100)
                                                                .toStringAsFixed(
                                                                    0)
                                                          ]),
                                                          style: TextStyle(
                                                            fontSize: sp(10),
                                                          ))
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: width(16),
                                      ),
                                      matchListItem(csMethodGetHistoryTwoList(
                                          csProHistoryTwoKey),isShowMorejinqiTwo,team: 2),
                                      GestureDetector(
                                        behavior: HitTestBehavior.translucent,
                                        onTap: (){
                                          isShowMorejinqiTwo =true;
                                          setState(() {
                                          });
                                        },
                                        child:(isShowMorejinqiTwo||csMethodGetHistoryTwoList(
                                            csProHistoryTwoKey).length<10)?Container(): Container(
                                          height: width(28),
                                          color: Color(0xFFF2F9FF),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text('点击查看全部赛事',style: TextStyle(color: Color(0xFF1B8DE0),fontSize: sp(12)),),
                                              SizedBox(width: width(4),),
                                              Image.asset(
                                                CSClassImageUtil.csMethodGetImagePath(
                                                    'ic_up_arrow'),
                                                width: width(12),color: Color(0xFF1B8DE0),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )

                                    ],
                                  )
                                : Container()
                          ],
                        ),
                        myDivider(),
                      ],
                    ),
                  ),
                  visible: !(csProHistoryOne.length == 0 &&
                      csProHistoryTwo.length == 0),
                ),

                /// 未来赛事
                Visibility(
                  child:  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow:[
                          BoxShadow(
                            offset: Offset(2,5),
                            color: Color(0x0C000000),
                            blurRadius:width(6,),),
                          BoxShadow(
                            offset: Offset(-5,1),
                            color: Color(0x0C000000),
                            blurRadius:width(6,),
                          )
                        ],
                        borderRadius: BorderRadius.circular(width(7))
                    ),
                    margin: EdgeInsets.only(/*left: width(10),right: width(10),*/top: width(10)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(
                            left: width(16),
                            right: width(16),
                          ),
                          height: width(28),
                          color: Color(0xFFDAE6F2),
                          child: Row(
                            children: <Widget>[
                              Container(
                                  margin: EdgeInsets.only(
                                      top: width(3), right: width(8)),
                                  width: width(2),
                                  height: width(12),
                                  color: MyColors.grey_33),
                              Expanded(
                                child: Text(
                                  "未来赛事",
                                  style: TextStyle(
                                      fontSize: sp(14),
                                      fontWeight: FontWeight.bold),
                                ),
                              ),

                              // 显示隐藏
                              GestureDetector(
                                behavior: HitTestBehavior.translucent,
                                onTap: () {
                                  isShowFuture = !isShowFuture;
                                  setState(() {});
                                },
                                child: Container(
                                  padding: EdgeInsets.only(left: width(24)),
                                  child: Image.asset(
                                    CSClassImageUtil.csMethodGetImagePath(
                                        isShowFuture
                                            ? 'ic_down_arrow'
                                            : 'ic_up_arrow'),
                                    width: width(14),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        isShowFuture? AnimatedSize(
                          vsync: this,
                          duration: Duration(
                              milliseconds: 300
                          ),
                          child:Column(
                            children: <Widget>[

                              Visibility(
                                child:Column(
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.only(top: width(8),left: width(16)),
                                        child: Row(
                                          children: <Widget>[
                                            ( widget.csProGuessMatch.csProIconUrlOne!.isEmpty)? Image.asset(
                                              CSClassImageUtil.csMethodGetImagePath("cs_home_team"),
                                              width: width(20),
                                            ):Image.network(
                                              widget.csProGuessMatch.csProIconUrlOne!,
                                              width: width(20),
                                            ),
                                            SizedBox(width: 5,),
                                            Text(widget.csProGuessMatch.csProTeamOne!,style: TextStyle(fontSize: sp(12)),)
                                          ],

                                        ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: height(8),bottom: height(8)),
                                      decoration: BoxDecoration(
                                          border: Border.all(color: Color(0xFFDDDDDD),width: 0.4)
                                      ),
                                      alignment: Alignment.center,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Container(
                                            decoration: BoxDecoration(
                                                color: Color(0xFFF7F7F7),
                                                border: Border(bottom:BorderSide(color: Color(0xFFDDDDDD),width: 0.4))
                                            ),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: <Widget>[
                                                Expanded(
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    height: width(40),
                                                    child: Text("赛事日期",style: TextStyle(fontSize: sp(11),color: Color(0xFF888888)),),
                                                  ),
                                                ) ,

                                                Expanded(
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    height: width(40),
                                                    child: Text("主队",style: TextStyle(fontSize: sp(11),color: Color(0xFF888888)),),
                                                  ),
                                                ) ,

                                                Container(
                                                  alignment: Alignment.center,
                                                  height: width(40),
                                                  width: width(30),
                                                  child: Text("",style: TextStyle(fontSize: sp(11),color: Color(0xFF888888)),),
                                                ),


                                                Expanded(
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    height: width(40),
                                                    child: Text("客队",style: TextStyle(fontSize: sp(11),color: Color(0xFF888888)),),
                                                  ),
                                                ) ,

                                                Expanded(
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    width: width(40),
                                                    child: Text("间隔",style: TextStyle(fontSize: sp(11),color: Color(0xFF888888)),),
                                                  ),
                                                ) ,


                                              ],
                                            ),
                                          ),

                                          Container(
                                            child: Column(
                                              children: csProFutureListOne.map((item){
                                                return Container(
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      border: Border(bottom:BorderSide(color: Color(0xFFDDDDDD),width: 0.4))
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: <Widget>[
                                                      Expanded(
                                                        child: Container(
                                                          alignment: Alignment.center,
                                                          height: width(40),
                                                          child: Text(sprintf("%s%s%s",
                                                              [item.csProLeagueName,"\n",CSClassDateUtils.csMethodDateFormatByString(item.csProStTime!, "yyyy.M.dd")]
                                                          ),style: TextStyle(
                                                            fontSize: sp(11),
                                                            color: Color(0xFF666666),
                                                          ),textAlign: TextAlign.center,),
                                                        ),
                                                      ) ,

                                                      Expanded(
                                                        child: Container(
                                                          alignment: Alignment.center,
                                                          height: width(40),
                                                          child: Text(item.csProTeamOne!,style: TextStyle(
                                                            fontSize: sp(11),
                                                            color: csMethodGetTeamTextColor(item, 1),
                                                          ),
                                                            maxLines: 1,
                                                            overflow: TextOverflow.ellipsis,
                                                          ),
                                                        ),
                                                      ) ,

                                                      Container(
                                                        alignment: Alignment.center,
                                                        height: width(40),
                                                        width: width(30),
                                                        child: Text("vs",style: TextStyle(
                                                          fontSize: sp(14),
                                                          color: Color(0xFF888888),
                                                        ),
                                                          maxLines: 1,
                                                          overflow: TextOverflow.ellipsis,
                                                        ),
                                                      ),

                                                      Expanded(
                                                        child: Container(
                                                          alignment: Alignment.center,
                                                          height: width(40),
                                                          child: Text(item.csProTeamTwo!,style: TextStyle(
                                                            fontSize: sp(11),
                                                            color: csMethodGetTeamTextColor(item, 2),
                                                          ),
                                                            maxLines: 1,
                                                            overflow: TextOverflow.ellipsis,
                                                          ),
                                                        ),
                                                      ) ,


                                                      Expanded(
                                                        child: Container(
                                                          alignment: Alignment.center,
                                                          height: width(40),
                                                          child: Text("${(DateTime.parse(item.csProStTime!).difference(DateTime.now()).inDays+1).toString()}"+
                                                              "天",style: TextStyle(
                                                            fontSize: sp(11),
                                                          ),textAlign: TextAlign.center,),
                                                        ),
                                                      ) ,


                                                    ],
                                                  ),
                                                );
                                              }).toList(),
                                            ),
                                          )

                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                visible: CSClassListUtil.csMethodIsNotEmpty(csProFutureListOne),
                              ),

                              Visibility(
                                child:Column(
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.only(top: width(8),left: width(16)),

                                      child: Row(
                                          children: <Widget>[
                                            ( widget.csProGuessMatch.csProIconUrlTwo!.isEmpty)? Image.asset(
                                              CSClassImageUtil.csMethodGetImagePath("cs_away_team"),
                                              width: width(20),
                                            ):Image.network(
                                              widget.csProGuessMatch.csProIconUrlTwo!,
                                              width: width(20),
                                            ),
                                            SizedBox(width: 5,),
                                            Text(widget.csProGuessMatch.csProTeamTwo!,style: TextStyle(fontSize: sp(12)),)
                                          ],

                                        ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: height(8),bottom: height(8)),
                                      decoration: BoxDecoration(
                                          border: Border.all(color: Color(0xFFDDDDDD),width: 0.4)
                                      ),
                                      alignment: Alignment.center,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Container(
                                            decoration: BoxDecoration(
                                                color: Color(0xFFF7F7F7),
                                                border: Border(bottom:BorderSide(color: Color(0xFFDDDDDD),width: 0.4))
                                            ),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: <Widget>[
                                                Expanded(
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    height: width(40),
                                                    child: Text("赛事日期",style: TextStyle(fontSize: sp(11),color: Color(0xFF888888)),),
                                                  ),
                                                ) ,

                                                Expanded(
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    height: width(40),
                                                    child: Text("主队",style: TextStyle(fontSize: sp(11),color: Color(0xFF888888)),),
                                                  ),
                                                ) ,

                                                Container(
                                                  alignment: Alignment.center,
                                                  height: width(40),
                                                  width: width(30),
                                                  child: Text("",style: TextStyle(fontSize: sp(11),color: Color(0xFF888888)),),
                                                ),


                                                Expanded(
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    height: width(40),
                                                    child: Text("客队",style: TextStyle(fontSize: sp(11),color: Color(0xFF888888)),),
                                                  ),
                                                ) ,

                                                Expanded(
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    width: width(40),
                                                    child: Text("间隔",style: TextStyle(fontSize: sp(11),color: Color(0xFF888888)),),
                                                  ),
                                                ) ,


                                              ],
                                            ),
                                          ),

                                          Container(
                                            child: Column(
                                              children: csProFutureListTwo.map((item){
                                                return Container(
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      border: Border(bottom:BorderSide(color: Color(0xFFDDDDDD),width: 0.4))
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: <Widget>[
                                                      Expanded(
                                                        child: Container(
                                                          alignment: Alignment.center,
                                                          height: width(40),
                                                          child: Text(sprintf("%s%s%s",
                                                              [item.csProLeagueName,"\n",CSClassDateUtils.csMethodDateFormatByString(item.csProStTime!, "yyyy.M.dd")]
                                                          ),style: TextStyle(
                                                            fontSize: sp(11),
                                                            color: Color(0xFF666666),
                                                          ),textAlign: TextAlign.center,),
                                                        ),
                                                      ) ,

                                                      Expanded(
                                                        child: Container(
                                                          alignment: Alignment.center,
                                                          height: width(40),
                                                          child: Text(item.csProTeamOne!,style: TextStyle(
                                                            fontSize: sp(11),
                                                            color: csMethodGetTeamTextColor(item,1,isOne:false),
                                                          ),
                                                            maxLines: 1,
                                                            overflow: TextOverflow.ellipsis,
                                                          ),
                                                        ),
                                                      ) ,

                                                      Container(
                                                        alignment: Alignment.center,
                                                        height: width(40),
                                                        width: width(30),
                                                        child: Text("vs",style: TextStyle(
                                                          fontSize: sp(14),
                                                          color: Color(0xFF888888),
                                                        ),
                                                          maxLines: 1,
                                                          overflow: TextOverflow.ellipsis,
                                                        ),
                                                      ),

                                                      Expanded(
                                                        child: Container(
                                                          alignment: Alignment.center,
                                                          height: width(40),
                                                          child: Text(item.csProTeamTwo!,style: TextStyle(
                                                            fontSize: sp(11),
                                                            color: csMethodGetTeamTextColor(item,2,isOne:false),
                                                          ),
                                                            maxLines: 1,
                                                            overflow: TextOverflow.ellipsis,
                                                          ),
                                                        ),
                                                      ) ,


                                                      Expanded(
                                                        child: Container(
                                                          alignment: Alignment.center,
                                                          height: width(40),
                                                          child: Text("${(DateTime.parse(item.csProStTime!).difference(DateTime.now()).inDays+1).toString()}"+
                                                              "天",style: TextStyle(
                                                            fontSize: sp(11),
                                                          ),textAlign: TextAlign.center,),
                                                        ),
                                                      ) ,


                                                    ],
                                                  ),
                                                );
                                              }).toList(),
                                            ),
                                          )

                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                visible: CSClassListUtil.csMethodIsNotEmpty(csProFutureListTwo),
                              ),

                            ],
                          ) ,
                        ):Container(),

                        myDivider(),
                      ],

                    ),
                  ),
                  visible:(CSClassListUtil.csMethodIsNotEmpty(csProFutureListOne)||CSClassListUtil.csMethodIsNotEmpty(csProFutureListTwo)),
                ),
              ],
            ),
          );
  }
  
  Widget matchListItem(List<CSClassEntityHistory> data,isShowMore,{int team=1}){
    List<CSClassEntityHistory> showList =[];
    if(data.length>10&&isShowMore==false){
      showList=data.sublist(0,10);
    }else{
      showList =data;
    }
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
              color: Color(0xFFDDDDDD),
              width: 0.4)),
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            height: width(27),
            decoration: BoxDecoration(
                color: Color(0xFFF7F7F7),
                border: Border(
                    bottom: BorderSide(
                        color: Color(
                            0xFFDDDDDD),
                        width: 0.4))),
            child: Row(
              mainAxisAlignment:
              MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Container(
                    alignment:
                    Alignment.center,
                    child: Text(
                      "赛事日期",
                      style: TextStyle(
                          fontSize: sp(11),
                          color: Color(
                              0xFF303133)),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment:
                    Alignment.center,
                    child: Text(
                      "主队",
                      style: TextStyle(
                          fontSize: sp(11),
                          color: Color(
                              0xFF303133)),
                    ),
                  ),
                ),
                Container(
                  alignment:
                  Alignment.center,
                  width: width(60),
                  child: Text(
                    "比分",
                    style: TextStyle(
                        fontSize: sp(11),
                        color: Color(
                            0xFF303133)),
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment:
                    Alignment.center,
                    child: Text(
                      "客队",
                      style: TextStyle(
                          fontSize: sp(11),
                          color: Color(
                              0xFF303133)),
                    ),
                  ),
                ),
                Container(
                  alignment:
                  Alignment.center,
                  child: Text(
                    "让球",
                    style: TextStyle(
                        fontSize: sp(11),
                        color: Color(
                            0xFF303133)),
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment:
                    Alignment.center,
                    width: width(40),
                    child: Text(
                      "进球数",
                      style: TextStyle(
                          fontSize: sp(11),
                          color: Color(
                              0xFF303133)),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            child: Column(
              children:
              showList.map((item) {
                return Container(
                  height: width(36),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(
                          bottom: BorderSide(
                              color: Color(
                                  0xFFDDDDDD),
                              width: 0.4))),
                  child: Row(
                    mainAxisAlignment:
                    MainAxisAlignment
                        .center,
                    children: <Widget>[
                      SizedBox(width: width(12),),
                      Expanded(
                        child: Container(
                          alignment:
                          Alignment
                              .center,
                          child: Text(
                            sprintf(
                                "%s%s%s",
                                [
                                  CSClassDateUtils.csMethodDateFormatByString(
                                      item.csProMatchDate!,
                                      "yyyy.M.dd"),
                                  "\n",
                                  item.csProLeagueName,
                                ]),
                            style:
                            TextStyle(
                              fontSize:
                              sp(11),
                              color: MyColors.grey_33,
                            ),
                            textAlign:
                            TextAlign
                                .center,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment
                              .center,
                          child: Text(
                            item.csProTeamOne!,
                            style:
                            TextStyle(
                              fontSize:
                              sp(11),
                              color: csMethodGetTeamTextColor(item,1,isOne:team==1 ),
                              // color: Color(
                              //     0xFF333333),
                            ),
                            maxLines: 1,
                            overflow:
                            TextOverflow
                                .ellipsis,
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment
                            .center,
                        width: width(60),
                        child: Text(
                          item.csProScoreOne! +
                              " : " +
                              item.csProScoreTwo!,
                          style: TextStyle(
                              fontSize:
                              sp(11),
                              color:
                              csMethodGetResultColor(
                                  item,winTeam: team),
                              fontWeight:
                              FontWeight
                                  .bold),
                          maxLines: 1,
                          overflow:
                          TextOverflow
                              .ellipsis,
                        ),
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment
                              .center,
                          child: Text(
                            item.csProTeamTwo!,
                            style:
                            TextStyle(
                              fontSize:
                              sp(11),
                              color: csMethodGetTeamTextColor(item,2,isOne:team==1 ),
                              // Color(
                              //     0xFF333333),
                            ),
                            maxLines: 1,
                            overflow:
                            TextOverflow
                                .ellipsis,
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment
                            .center,
                        width: width(40),
                        child: Text(
                          item.csProWinOrLose!
                              .isEmpty
                              ? "--"
                              : sprintf(
                              "%s%s%s",
                              [
                                (item.csProAddScore!.isEmpty
                                    ? "--"
                                    : CSClassStringUtils.csMethodSqlitZero(item.csProAddScore!)),
                                "\n",
                                item.csProWinOrLose,
                              ]),
                          style: TextStyle(
                            fontSize:
                            sp(11),
                            color: csMethodGetColorByText(
                                item.csProWinOrLose!),
                          ),
                          textAlign:
                          TextAlign
                              .center,
                        ),
                        // Text(csMethodGetHistoryResultText(item),style: TextStyle(
                        //   fontSize: sp(11),
                        //   color: csMethodGetResultColor(item),
                        // ),
                        //   maxLines: 1,
                        //   overflow: TextOverflow.ellipsis,
                        // ),
                      ),
                      Expanded(
                        child: Container(
                          alignment:
                          Alignment
                              .center,
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment
                                .center,
                            children: <
                                Widget>[
                              Expanded(
                                child:
                                Center(
                                  child:
                                  Text(
                                    item.csProBigOrSmall!.isEmpty
                                        ? "--"
                                        : sprintf("%s%s%s", [
                                      ((item.csProMidScore!.isEmpty || double.tryParse(item.csProMidScore!) == 0) ? "--" : CSClassStringUtils.csMethodSqlitZero(item.csProMidScore!)),
                                      "\n",
                                      item.csProBigOrSmall,
                                    ]),
                                    style:
                                    TextStyle(
                                      fontSize:
                                      sp(11),
                                      color:
                                      csMethodGetColorByText(item.csProBigOrSmall!),
                                    ),
                                    textAlign:
                                    TextAlign.center,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget myDivider() {
    return Container(
      height: width(6),
      color: Color(0xFFF2F2F2),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  csMethodGetColorByText(String item) {
    if (item == "赢" || item == "大") {
      return Colors.red;
    } else if (item == "走") {
      return Colors.blue;
    } else if (item == "小" || item == "输") {
      return Colors.green;
    } else {
      return Color(0xFF888888);
    }
  }

  csMethodGetResultColor(CSClassEntityHistory itemHistory, {int winTeam: 1}) {
    if (csMethodIsHistoryWin(itemHistory, value: winTeam)) {
      return Color(0xFFE3494B);
    } else if (csMethodIsHistoryDraw(itemHistory)) {
      return Color(0xFF888888);
    } else if (csMethodIsHistoryLose(itemHistory, value: winTeam)) {
      return Color(0xFF439642);
    } else {
      return Color(0xFF333333);
    }
  }

  bool csMethodIsHistoryWin(CSClassEntityHistory? itemHistory, {int value: 1}) {
    int realValue = value;
    if (itemHistory == null ||
        itemHistory.csProScoreOne==null ||
        itemHistory.csProScoreTwo==null) {
      return false;
    }

    if (realValue == 1) {
      if (widget.csProGuessMatch.csProTeamOneId != null) {
        if (widget.csProGuessMatch.csProTeamOneId ==
            itemHistory.csProTeamOneId) {
          if (double.parse(itemHistory.csProScoreOne!) >
              double.parse(itemHistory.csProScoreTwo!)) {
            return true;
          }
        }
        if (widget.csProGuessMatch.csProTeamOneId ==
            itemHistory.csProTeamTwoId) {
          if (double.parse(itemHistory.csProScoreTwo!) >
              double.parse(itemHistory.csProScoreOne!)) {
            return true;
          }
        }
      }
    }

    if (realValue == 2) {
      if (widget.csProGuessMatch.csProTeamTwoId != null) {
        if (widget.csProGuessMatch.csProTeamTwoId ==
            itemHistory.csProTeamOneId) {
          if (double.parse(itemHistory.csProScoreOne!) >
              double.parse(itemHistory.csProScoreTwo!)) {
            return true;
          }
        }
        if (widget.csProGuessMatch.csProTeamTwoId ==
            itemHistory.csProTeamTwoId) {
          if (double.parse(itemHistory.csProScoreTwo!) >
              double.parse(itemHistory.csProScoreOne!)) {
            return true;
          }
        }
      }
    }

    return false;
  }

  csMethodIsHistoryLose(CSClassEntityHistory? itemHistory, {int value: 1}) {
    int realValue = value;

    if (itemHistory == null ||
        itemHistory.csProScoreOne==null ||
        itemHistory.csProScoreTwo==null) {
      return false;
    }

    if (realValue == 1) {
      if (widget.csProGuessMatch.csProTeamOneId != null) {
        if (widget.csProGuessMatch.csProTeamOneId ==
            itemHistory.csProTeamOneId) {
          if (double.parse(itemHistory.csProScoreOne!) <
              double.parse(itemHistory.csProScoreTwo!)) {
            return true;
          }
        }
        if (widget.csProGuessMatch.csProTeamOneId ==
            itemHistory.csProTeamTwoId) {
          if (double.parse(itemHistory.csProScoreTwo!) <
              double.parse(itemHistory.csProScoreOne!)) {
            return true;
          }
        }
      }
    }

    if (realValue == 2) {
      if (widget.csProGuessMatch.csProTeamTwoId != null) {
        if (widget.csProGuessMatch.csProTeamTwoId ==
            itemHistory.csProTeamOneId) {
          if (double.parse(itemHistory.csProScoreOne!) <
              double.parse(itemHistory.csProScoreTwo!)) {
            return true;
          }
        }
        if (widget.csProGuessMatch.csProTeamTwoId ==
            itemHistory.csProTeamTwoId) {
          if (double.parse(itemHistory.csProScoreTwo!) <
              double.parse(itemHistory.csProScoreOne!)) {
            return true;
          }
        }
      }
    }

    return false;
  }

  csMethodIsHistoryDraw(CSClassEntityHistory? itemHistory) {
    if (itemHistory == null ||
        itemHistory.csProScoreOne!.isEmpty ||
        itemHistory.csProScoreTwo!.isEmpty) {
      return false;
    }

    if (itemHistory.csProScoreTwo == itemHistory.csProScoreOne) {
      return true;
    }

    return false;
  }

  csMethodGetHistoryResultText(CSClassEntityHistory? itemHistory,
      {int winTeam: 1}) {
    if (itemHistory == null ||
        itemHistory.csProScoreOne!.isEmpty ||
        itemHistory.csProScoreTwo!.isEmpty) {
      return "";
    }

    if (itemHistory.csProScoreTwo == itemHistory.csProScoreOne) {
      return "平";
    }

    if (csMethodIsHistoryWin(itemHistory, value: winTeam)) {
      return "胜";
    } else if (csMethodIsHistoryLose(itemHistory, value: winTeam)) {
      return "负";
    }
    return "";
  }

  List<CSClassEntityHistory> csMethodGetFilterList(
      List<CSClassEntityHistory>? history, int? csProHistoryIndex,
      {String? value}) {
    String realValue = widget.csProGuessMatch.csProTeamOne!;

    if (value != null) {
      realValue = value;
    }
    if (csProHistoryIndex == 0) {
      return history!;
    } else {
      List<CSClassEntityHistory> list = [];
      for (var item in history!) {
        if (realValue == item.csProTeamOne) {
          list.add(item);
        }
      }
      return list;
    }
  }

  List<CSClassEntityHistory> csMethodGetFilterListNum(
      List<CSClassEntityHistory>? history, int? num) {
    if (num == -1) {
      return history!;
    } else {
      return history!.take(num!).toList();
    }
  }

  void csMethodInitPointData() {
    if (csProAnylizeMatchList!.csProTeamPointsList != null &&
        csProAnylizeMatchList!.csProTeamPointsList!.isNotEmpty) {
      csProTeamPointsList = csProAnylizeMatchList!.csProTeamPointsList!;
    }
  }

  void csMethodInitFutureList() {
    if (csProAnylizeMatchList != null &&
        (csProAnylizeMatchList!.csProTeamOneFuture != null &&
            csProAnylizeMatchList!.csProTeamOneFuture!.isNotEmpty)) {
      csProFutureListOne = csProAnylizeMatchList!.csProTeamOneFuture!;
    }
    if (csProAnylizeMatchList != null &&
        (csProAnylizeMatchList!.csProTeamTwoFuture != null &&
            csProAnylizeMatchList!.csProTeamTwoFuture!.isNotEmpty)) {
      csProFutureListTwo = csProAnylizeMatchList!.csProTeamTwoFuture!;
    }
    if (mounted) {
      setState(() {});
    }
  }

  List<CSClassTeamPointsList> csMethodGetTeamPoints(String? csProPointsKey) {
    List<CSClassTeamPointsList> list = [];
    csProTeamPointsList.forEach((item) {
      if (item.type!.contains(csProPointsKey!)) {
        list.add(item);
      }
    });

    return list;
  }

  List<CSClassEntityHistory> csMethodGetHistoryList(String? csProHistoryKey,
      {bool isPanKou: false}) {
    List<CSClassEntityHistory> list = [];
    csProHistoryList.forEach((item) {
      if (isPanKou) {
        if (csProHistoryKey == "主场") {
          if (item.csProTeamOne == widget.csProGuessMatch.csProTeamOne) {
            if ((item.csProWinOrLose!.isNotEmpty)) {
              list.add(item);
            }
          }
        } else {
          if ((item.csProWinOrLose!.isNotEmpty)) {
            list.add(item);
          }
        }
      } else {
        if (csProHistoryKey == "主场") {
          if (item.csProTeamOne == widget.csProGuessMatch.csProTeamOne) {
            list.add(item);
          }
        } else {
          list.add(item);
        }
      }
    });

    return list;
  }

  List<CSClassEntityHistory> csMethodGetHistoryOneList(
      String? csProHistoryKey) {
    List<CSClassEntityHistory> list = [];
    csProHistoryOne.forEach((item) {
      if (csProHistoryKey == "主场") {
        if (item.csProTeamOne == widget.csProGuessMatch.csProTeamOne) {
          list.add(item);
        }
      } else if (csProHistoryKey == "同主客") {
        if (item.csProTeamOne == widget.csProGuessMatch.csProTeamOne &&
            item.csProTeamTwo == widget.csProGuessMatch.csProTeamTwo) {
          list.add(item);
        }
      } else {
        list.add(item);
      }
    });

    return list;
  }

  List<CSClassEntityHistory> csMethodGetHistoryTwoList(
      String? csProHistoryKey) {
    List<CSClassEntityHistory> list = [];
    csProHistoryTwo.forEach((item) {
      if (csProHistoryKey == "主场") {
        if (item.csProTeamOne == widget.csProGuessMatch.csProTeamTwo) {
          list.add(item);
        }
      } else if (csProHistoryKey == "同主客") {
        if (item.csProTeamOne == widget.csProGuessMatch.csProTeamOne &&
            item.csProTeamTwo == widget.csProGuessMatch.csProTeamTwo) {
          list.add(item);
        }
      } else if (csProHistoryKey == "客场") {
        if (item.csProTeamTwo == widget.csProGuessMatch.csProTeamTwo) {
          list.add(item);
        }
      } else {
        list.add(item);
      }
    });

    return list;
  }

  //value 1 =win ; 2=lose;
  double csMethodGetMatchPanKouRate(
      List<CSClassEntityHistory>? valueList, value) {
    var valueCount = 0.0;
    valueList!.forEach((item) {
      if (value == 1 && item.csProWinOrLose == "赢") {
        valueCount += 1;
      }
      if (value == 2 && item.csProWinOrLose == "输") {
        valueCount += 1;
      }
      if (value == 0 && item.csProWinOrLose == "走") {
        valueCount += 1;
      }
    });
    if (valueCount == 0) {
      return 0;
    }

    return valueCount / valueList.length;
  }

//  1大 2小
  double csMethodGetMatchBigRate(List<CSClassEntityHistory> valueList, value) {
    var valueCount = 0.0;
    valueList.forEach((item) {
      if (value == 1 && item.csProBigOrSmall == '大') {
        valueCount += 1;
      }
      if (value == 2 && item.csProBigOrSmall == '小') {
        valueCount += 1;
      }
    });
    if (valueCount == 0) {
      return 0;
    }

    return valueCount / valueList.length;
  }

  //value 1 =win ; 2=lose; 0=draw;
  double csMethodGetMatchRate(List<CSClassEntityHistory>? valueList, value,
      {int winTeam: 1}) {
    var valueCount = 0.0;
    valueList!.forEach((item) {
      if (value == 1 && csMethodIsHistoryWin(item, value: winTeam)) {
        valueCount += 1;
      }
      if (value == 2 && csMethodIsHistoryLose(item, value: winTeam)) {
        valueCount += 1;
      }
      if (value == 0 && csMethodIsHistoryDraw(item)) {
        valueCount += 1;
      }
    });
    if (valueCount == 0) {
      return 0;
    }

    return valueCount / valueList.length;
  }

  //value 1 =win ; 2=lose; 0=draw;

  int csMethodGetMatchCount(List<CSClassEntityHistory>? valueList, value,
      {int winTeam: 1}) {
    var valueCount = 0;
    valueList!.forEach((item) {
      if (value == 1 && csMethodIsHistoryWin(item, value: winTeam)) {
        valueCount += 1;
      }
      if (value == 2 && csMethodIsHistoryLose(item, value: winTeam)) {
        valueCount += 1;
      }
      if (value == 0 && csMethodIsHistoryDraw(item)) {
        valueCount += 1;
      }
    });

    return valueCount;
  }

  //value 1 =win ; 2=lose; 0=draw;

  int csMethodGetMatchPanKouCount(List<CSClassEntityHistory>? valueList, value,
      {int winTeam: 1}) {
    var valueCount = 0;
    valueList!.forEach((item) {
      if (value == 1 && item.csProWinOrLose == "赢") {
        valueCount += 1;
      }
      if (value == 2 && item.csProWinOrLose == "输") {
        valueCount += 1;
      }
      if (value == 0 && item.csProWinOrLose == "走") {
        valueCount += 1;
      }
      if (value == 3 && item.csProBigOrSmall == "大") {
        valueCount += 1;
      }
      if (value == 4 && item.csProBigOrSmall == "小") {
        valueCount += 1;
      }
    });

    return valueCount;
  }

  double csMethodGetMatchAllPointsScore(int? team, key) {
    var result = 0.0;
    var one = 0;
    var two = 0;

    one = (csMethodGetMatchCount(
                csMethodGetHistoryOneList(key)
                    .take(csMethodGetMinListLength(key))
                    .toList(),
                1) *
            3) +
        (csMethodGetMatchCount(
                csMethodGetHistoryOneList(key)
                    .take(csMethodGetMinListLength(key))
                    .toList(),
                0) *
            1);
    two = (csMethodGetMatchCount(
                csMethodGetHistoryTwoList(key)
                    .take(csMethodGetMinListLength(key))
                    .toList(),
                1,
                winTeam: 2) *
            3) +
        (csMethodGetMatchCount(
                csMethodGetHistoryTwoList(key)
                    .take(csMethodGetMinListLength(key))
                    .toList(),
                0,
                winTeam: 2) *
            1);

    if (team == 1 && one == 0) {
      return 0;
    }
    if (team == 2 && two == 0) {
      return 0;
    }

    if (team == 1) {
      result = one / (one + two) * 25;
    }
    if (team == 2) {
      result = two / (one + two) * 25;
    }

    return result;
  }

  double csMethodAvgWinOrLoseScoreOne(bool? csProIsWin) {
    var result = 0.0;
    var winCount = 0;
    var loseCount = 0;

    csMethodGetHistoryOneList("全部")
        .take(csMethodGetMinListLength("全部"))
        .toList()
        .forEach((item) {
      if (item.csProTeamOne == widget.csProGuessMatch.csProTeamOne) {
        winCount += int.parse(item.csProScoreOne!);
      }
      if (item.csProTeamTwo == widget.csProGuessMatch.csProTeamOne) {
        winCount += int.parse(item.csProScoreTwo!);
      }

      if (item.csProTeamOne != widget.csProGuessMatch.csProTeamOne) {
        loseCount += int.parse(item.csProScoreOne!);
      }
      if (item.csProTeamTwo != widget.csProGuessMatch.csProTeamOne) {
        loseCount += int.parse(item.csProScoreTwo!);
      }
    });
    if (csProIsWin! && winCount == 0) {
      return 0;
    }
    if (!csProIsWin && loseCount == 0) {
      return 0;
    }

    if (csProIsWin) {
      result = winCount /
          csMethodGetHistoryOneList("全部")
              .take(csMethodGetMinListLength("全部"))
              .toList()
              .length;
    }
    if (!csProIsWin) {
      result = loseCount /
          csMethodGetHistoryOneList("全部")
              .take(csMethodGetMinListLength("全部"))
              .toList()
              .length;
    }

    return result;
  }

  double csMethodAvgWinOrLoseScoreTwo(bool? csProIsWin) {
    var result = 0.0;
    var winCount = 0;
    var loseCount = 0;

    csMethodGetHistoryTwoList("全部")
        .take(csMethodGetMinListLength("全部"))
        .toList()
        .forEach((item) {
      if (item.csProTeamOne == widget.csProGuessMatch.csProTeamTwo) {
        winCount += int.parse(item.csProScoreOne!);
      }
      if (item.csProTeamTwo == widget.csProGuessMatch.csProTeamTwo) {
        winCount += int.parse(item.csProScoreTwo!);
      }

      if (item.csProTeamOne != widget.csProGuessMatch.csProTeamTwo) {
        loseCount += int.parse(item.csProScoreOne!);
      }
      if (item.csProTeamTwo != widget.csProGuessMatch.csProTeamTwo) {
        loseCount += int.parse(item.csProScoreTwo!);
      }
    });

    if (csProIsWin! && winCount == 0) {
      return 0;
    }
    if (!csProIsWin && loseCount == 0) {
      return 0;
    }

    if (csProIsWin) {
      result = winCount /
          csMethodGetHistoryTwoList("全部")
              .take(csMethodGetMinListLength("全部"))
              .toList()
              .length;
    }
    if (!csProIsWin) {
      result = loseCount /
          csMethodGetHistoryTwoList("全部")
              .take(csMethodGetMinListLength("全部"))
              .toList()
              .length;
    }

    return result;
  }

  double csMethodAvgWinOrLose25Score(bool? csProIsWin, int? team) {
    var result = 0.0;
    var value = 0.0;

    if (team == 1) {
      value = (csMethodAvgWinOrLoseScoreOne(csProIsWin));
    } else {
      value = (csMethodAvgWinOrLoseScoreTwo(csProIsWin));
    }

    if (value == 0) {
      return 0;
    }

    result = (value /
        (csMethodAvgWinOrLoseScoreOne(csProIsWin) +
            csMethodAvgWinOrLoseScoreTwo(csProIsWin)) *
        25);

    return result;
  }

  int csMethodGetMinListLength(String key) {
    return min(csMethodGetHistoryOneList(key).take(10).toList().length,
        csMethodGetHistoryTwoList(key).take(10).toList().length);
  }

  Color csMethodGetTeamTextColor(CSClassEntityHistory? team, int? i,
      {bool isOne: true}) {
    if (isOne) {
      // 主队在主场
      if (i == 1 &&
          (team!.csProTeamOne! == widget.csProGuessMatch.csProTeamOne ||
              widget.csProGuessMatch.csProTeamOneId == team.csProTeamOneId!)) {
        if(csMethodIsHistoryWin(team, value: 1)){
          return Colors.red;
        }else if(csMethodIsHistoryLose(team, value: 1)){
          return Colors.green;
        }
      }
      // 主队在客场
      if (i == 2 &&
          (team!.csProTeamTwo == widget.csProGuessMatch.csProTeamOne ||
              widget.csProGuessMatch.csProTeamOneId == team.csProTeamTwoId)) {
        if(csMethodIsHistoryWin(team, value: 1)){
          return Colors.red;
        }else if(csMethodIsHistoryLose(team, value: 1)){
          return Colors.green;
        }
        // return Colors.deepPurpleAccent;
      }
    }

    // 客队
    if (!isOne) {
      // 客队在主场
      if (i == 1 &&
          (team!.csProTeamOne == widget.csProGuessMatch.csProTeamTwo ||
              widget.csProGuessMatch.csProTeamTwoId == team.csProTeamOneId)) {
        if(csMethodIsHistoryWin(team, value: 2)){
          return Colors.red;
        }else if(csMethodIsHistoryLose(team, value: 2)){
          return Colors.green;
        }
      }

      if (i == 2 &&
          (team!.csProTeamTwo == widget.csProGuessMatch.csProTeamTwo ||
              widget.csProGuessMatch.csProTeamTwoId == team.csProTeamTwoId)) {
        if(csMethodIsHistoryWin(team, value: 2)){
          return Colors.red;
        }else if(csMethodIsHistoryLose(team, value: 2)){
          return Colors.green;
        }
      }
    }

    return MyColors.grey_33;
  }

  double csMethodGetForecastHeight(int i) {
    if (csProForecastInfo != null) {
      if (i == 1) {
        return double.tryParse(csProForecastInfo!.csProWinPOne!)! * width(50);
      }
      if (i == 0) {
        return double.tryParse(csProForecastInfo!.csProDrawP!)! * width(50);
      }
      if (i == 2) {
        return double.tryParse(csProForecastInfo!.csProWinPTwo!)! * width(50);
      }
    }
    return 0.0;
  }

  double csMethodGetUserSupport(int i) {
    if (csProForecastInfo != null) {
      var supportOne = double.tryParse(csProForecastInfo!.csProSupportOneNum!);
      var supportTwo = double.tryParse(csProForecastInfo!.csProSupportTwoNum!);
      var supportDraw =
          double.tryParse(csProForecastInfo!.csProSupportDrawNum!);
      double allNum = (supportOne! + supportTwo! + supportDraw!);
      if (allNum == 0) {
        return 0;
      }
      if (i == 1) {
        return (supportOne / allNum) * 0.5;
      }
      if (i == 0) {
        return (supportDraw / allNum) * 0.5;
      }
      if (i == 0) {
        return (supportTwo / allNum) * 0.5;
      }
    }
    return 0.0;
  }

  String csMethodGetSupportRate(int i) {
    if (csProForecastInfo != null) {
      if (i == 1) {
        return (double.tryParse(csProForecastInfo!.csProWinPOne!)! * 100)
                .toStringAsFixed(0) +
            "%";
      }
      if (i == 0) {
        return (double.tryParse(csProForecastInfo!.csProDrawP!)! * 100)
                .toStringAsFixed(0) +
            "%";
      }
      if (i == 2) {
        return (double.tryParse(csProForecastInfo!.csProWinPTwo!)! * 100)
                .toStringAsFixed(0) +
            "%";
      }
    }
    return "";
  }

  void csMethodGetForecastInfo() {
    Api.csMethodMatchForecast<CSClassForecast>(
        queryParameters: {
          "guess_match_id": widget.csProGuessMatch.csProGuessMatchId
        },
        csProCallBack: CSClassHttpCallBack(
            csProOnSuccess: (result) {
              if (result.csProWinPTwo != null) {
                csProForecastInfo = result;
                setState(() {});
              }
            },
            onError: (e) {},
            csProOnProgress: (v) {}));
  }

  void csMethodSupportForecast(String witch) {
    if (csMethodIsLogin(context: context)) {
      Api.csMethodForecastAdd<CSClassBaseModelEntity>(
          queryParameters: {
            "guess_match_id": widget.csProGuessMatch.csProGuessMatchId,
            "support_which": witch,
          },
          csProCallBack: CSClassHttpCallBack(
              csProOnSuccess: (result) {
                csMethodGetForecastInfo();
              },
              onError: (e) {},
              csProOnProgress: (v) {}));
    }
  }


}
