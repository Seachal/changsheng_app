import 'dart:async';

import 'package:changshengh5/api/SPClassApiManager.dart';
import 'package:changshengh5/api/SPClassHttpCallBack.dart';
import 'package:changshengh5/app/SPClassApplicaion.dart';
import 'package:changshengh5/model/SPClassBaseModelEntity.dart';
import 'package:changshengh5/model/SPClassGuessMatchInfo.dart';
import 'package:changshengh5/model/SPClassListEntity.dart';
import 'package:changshengh5/model/SPClassSchemeGuessMatch2.dart';
import 'package:changshengh5/model/SPClassSchemePlayWay.dart';
import 'package:changshengh5/pages/competition/SPClassMatchDetailPage.dart';
import 'package:changshengh5/pages/dialogs/SPClassBottomLeaguePage.dart';
import 'package:changshengh5/untils/SPClassCommonMethods.dart';
import 'package:changshengh5/untils/SPClassDateUtils.dart';
import 'package:changshengh5/untils/SPClassImageUtil.dart';
import 'package:changshengh5/untils/SPClassMatchDataUtils.dart';
import 'package:changshengh5/untils/SPClassNavigatorUtils.dart';
import 'package:changshengh5/untils/SPClassToastUtils.dart';
import 'package:changshengh5/untils/colors.dart';
import 'package:changshengh5/widgets/SPClassMarqueeWidget.dart';
import 'package:changshengh5/widgets/SPClassToolBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'SPClassAddSchemeSuccessPage.dart';
import 'SPClassPickSchemeDataDialog.dart';


class SPClassPublicSchemePage extends StatefulWidget {
  SPClassSchemeGuessMatch2 ?spProGuessMatch;

  SPClassPublicSchemePage({this.spProGuessMatch});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SPClassPublicSchemePageState();
  }
}

class SPClassPublicSchemePageState extends State<SPClassPublicSchemePage> {
  var LeagueName = "";
  SPClassSchemeGuessMatch2 ?spProGuessMatch;
  ScrollController ?scrollController;
  Timer? timer;
  List<SPClassSchemePlayWay> spProPlayWays = [];
  var spProPlayWayIndex = 0;
  var spProPlayWayColNum = 2;
  var spProSupportWhich = -1;
  var spProSupportWhich2 = -1;
  var spProCanReturn = false;
  List spProPriceList = [-1, 0, 18, 28, 38, 58];
  int spProPriceIndex = 0;
  var title = "";
  var detail = "";

  var spProCanCommit = false;

  var spProHadKey = false;

  SPClassMarqueeWidget ?spProMarqueeWidget;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    scrollController = ScrollController();

    WidgetsBinding.instance?.addPostFrameCallback((frame) {
      // pickerMatch();
      if (widget.spProGuessMatch != null) {
        spProGuessMatch = widget.spProGuessMatch;
        spFunInitMarquee();

        spFunGetPlayList();
      }
      timer = Timer.periodic(Duration(seconds: 4), (timer) {});
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: SPClassToolBar(
        context,
        title: "发布方案",
        spProBgColor: Colors.white,
        iconColor: 0xFF333333,
      ),
      backgroundColor: Colors.white,
      body: spProGuessMatch != null
          ? Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: width(12),
                    ),
                    // 队伍选择
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      child: Container(
                        color: Color(0xFFF6F6F6),
                        height: width(67),
                        padding: EdgeInsets.symmetric(horizontal: width(15)),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: GestureDetector(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Text(
                                          SPClassDateUtils
                                              .spFunDateFormatByString(
                                                  spProGuessMatch!.spProStTime!,
                                                  "MM-dd HH:mm"),
                                          style: TextStyle(
                                              fontSize: sp(12),
                                              color: Color(0xFF999999)),
                                        ),
                                        SizedBox(
                                          width: width(5),
                                        ),
                                        Text(
                                          spProGuessMatch!.spProLeagueName!,
                                          style: TextStyle(
                                              fontSize: sp(12),
                                              color: Color(0xFF999999)),
                                        ),
                                      ],
                                    ),
                                    spProMarqueeWidget != null
                                        ? Container(
                                            height: width(30),
                                            child: spProMarqueeWidget,
                                          )
                                        : SizedBox(),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: width(8),
                            ),
                            GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: width(6),
                                      horizontal: width(12)),
                                  margin: EdgeInsets.only(left: width(3)),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 0.4, color: Color(0xFFEB3E1C)),
                                      borderRadius: BorderRadius.circular(150)),
                                  child: Text(
                                    spProGuessMatch == null ? "选择球队" : "重新选择",
                                    style: TextStyle(
                                        color: Color(0xFFEB3E1C),
                                        fontSize: sp(13)),
                                  ),
                                ),
                              ),
                              onTap: () {
                                spFunPickerMatch();
                              },
                            )
                          ],
                        ),
                      ),
                      onTap: () {
                        if (spProGuessMatch == null) {
                          return;
                        }
                        SPClassApiManager.spFunGetInstance()
                            .spFunSportMatchData<SPClassGuessMatchInfo>(
                                loading: true,
                                context: context,
                                spProGuessMatchId:
                                    spProGuessMatch!.spProGuessMatchId!,
                                dataKeys: "guess_match",
                                spProCallBack: SPClassHttpCallBack(
                                    spProOnSuccess: (result) async {
                                  SPClassNavigatorUtils.spFunPushRoute(
                                      context,
                                      SPClassMatchDetailPage(
                                        result,
                                        spProMatchType: "guess_match_id",
                                        spProInitIndex: 1,
                                      ));
                                },onError: (e){},spProOnProgress: (v){}
                                ));
                      },
                    ),
                    SizedBox(
                      height: width(8),
                    ),
                    // 推荐玩法
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: width(16)),
                      color: Colors.white,
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: width(19),
                          ),
                          Row(
                            children: <Widget>[
                              Text(
                                "推荐玩法：",
                                style: TextStyle(
                                    color: Color(0xFF333333),
                                    fontWeight: FontWeight.w500,
                                  fontSize: sp(15),
                                ),
                                
                              )
                            ],
                          ),
                          SizedBox(
                            height: width(10),
                          ),
                          Container(
                            child: Row(
                              children: spProPlayWays.map((way) {
                                return GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  child: Container(
                                    width: width(100),
                                    height: width(40),
                                    margin: EdgeInsets.only(
                                        right: spProPlayWays.indexOf(way) ==
                                                spProPlayWays.length - 1
                                            ? 0
                                            : width(15)),
                                    decoration: BoxDecoration(
                                      color: spProPlayWayIndex ==
                                              spProPlayWays.indexOf(way)
                                          ? MyColors.main1
                                          : null,
                                      borderRadius: BorderRadius.circular(150),
                                      border: Border.all(
                                          width: 0.4,
                                          color: spProPlayWayIndex ==
                                                  spProPlayWays.indexOf(way)
                                              ? Colors.transparent
                                              : Color(0xFF999999)),
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      way.spProPlayingWay! +
                                          ((SPClassMatchDataUtils.spFunExpertTypeToMatchType(
                                                          SPClassApplicaion
                                                              .spProUserLoginInfo
                                                              !.spProExpertMatchType!) ==
                                                      "lol" &&
                                                  (way.spProPlayingWay ==
                                                          "总击杀" ||
                                                      way.spProPlayingWay ==
                                                          "总时长"))
                                              ? (" (第" +
                                                  way.spProBattleIndex!.trim() +
                                                  "局)")
                                              : ""),
                                      style: TextStyle(
                                          fontSize: sp(17),
                                          color: spProPlayWayIndex ==
                                                  spProPlayWays.indexOf(way)
                                              ? Colors.white
                                              : Colors.black),
                                    ),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      spProPlayWayIndex =
                                          spProPlayWays.indexOf(way);
                                      spProSupportWhich = -1;
                                      spProSupportWhich2 = -1;
                                    });
                                  },
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // 推荐结果
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: width(16)),
                      color: Colors.white,
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: width(19),
                          ),
                          Row(
                            children: <Widget>[
                              Text(
                                "推荐结果：",
                                style:  TextStyle(
                                    color: Color(0xFF333333),
                                    fontWeight: FontWeight.w500,
                                  fontSize: sp(15),
                                ),
                                
                              )
                            ],
                          ),
                          SizedBox(
                            height: width(10),
                          ),
                          spProPlayWays.length > 0
                              ? Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Row(
                                        children: <Widget>[
                                          Expanded(
                                            child: Container(
                                              child: Row(
                                                children: <Widget>[
                                                  Expanded(
                                                    child: GestureDetector(
                                                      behavior: HitTestBehavior
                                                          .opaque,
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                            color: (spProSupportWhich ==
                                                                        1 ||
                                                                    spProSupportWhich2 ==
                                                                        1)
                                                                ? MyColors.main1
                                                                : Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        150),
                                                            border: Border.all(
                                                                width: 0.4,
                                                                color: (spProSupportWhich ==
                                                                            1 ||
                                                                        spProSupportWhich2 ==
                                                                            1)
                                                                    ? Colors
                                                                        .transparent
                                                                    : Color(
                                                                        0xFF999999))),
                                                        height: width(40),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: <Widget>[
                                                            Text(
                                                                SPClassMatchDataUtils.spFunSchemeOptionLeftTitle(
                                                                    spProPlayWays[
                                                                        spProPlayWayIndex],
                                                                    SPClassMatchDataUtils.spFunExpertTypeToMatchType(SPClassApplicaion
                                                                        .spProUserLoginInfo
                                                                        !.spProExpertMatchType!),
                                                                    guessMatch2:
                                                                        spProGuessMatch),
                                                                style: TextStyle(
                                                                    color: (spProSupportWhich ==
                                                                                1 ||
                                                                            spProSupportWhich2 ==
                                                                                1)
                                                                        ? Colors
                                                                            .white
                                                                        : null,
                                                                    fontSize:
                                                                        sp(17))),
                                                            Text(
                                                              "  (" +
                                                                  spProPlayWays[
                                                                          spProPlayWayIndex]
                                                                      .spProWinOddsOne! +
                                                                  ")",
                                                              style: TextStyle(
                                                                  color: (spProSupportWhich ==
                                                                              1 ||
                                                                          spProSupportWhich2 ==
                                                                              1)
                                                                      ? Colors
                                                                          .white
                                                                      : null,
                                                                  fontSize:
                                                                      sp(17)),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      onTap: () {
                                                        if (!SPClassMatchDataUtils
                                                            .spFunCanPick(
                                                                spProPlayWays[
                                                                    spProPlayWayIndex],
                                                                1)) {
                                                          SPClassToastUtils
                                                              .spFunShowToast(
                                                                  msg:
                                                                      "推介指数偏低，暂不支持");
                                                          return;
                                                        }
                                                        if (spProPlayWays[
                                                                    spProPlayWayIndex]
                                                                .spProGuessType ==
                                                            "竞彩") {
                                                          if (spProSupportWhich ==
                                                              1) {
                                                            spProSupportWhich =
                                                                spProSupportWhich2;
                                                            spProSupportWhich2 =
                                                                -1;
                                                          } else if (spProSupportWhich2 ==
                                                              1) {
                                                            spProSupportWhich2 =
                                                                -1;
                                                          } else {
                                                            if (spProSupportWhich ==
                                                                -1) {
                                                              spProSupportWhich =
                                                                  1;
                                                            } else {
                                                              if (SPClassMatchDataUtils
                                                                  .spFunIsTwoPicker(
                                                                      spProPlayWays[
                                                                          spProPlayWayIndex],
                                                                      spProSupportWhich,
                                                                      1)) {
                                                                spProSupportWhich2 =
                                                                    1;
                                                              }
                                                            }
                                                          }
                                                        } else {
                                                          spProSupportWhich = 1;
                                                        }
                                                        setState(() {});
                                                      },
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: width(15),
                                                  ),

                                                  // Expanded(
                                                  //   child: GestureDetector(
                                                  //     child: Container(
                                                  //       height: width(37),
                                                  //        decoration:BoxDecoration(
                                                  //            color:(spProSupportWhich==0||spProSupportWhich2==0) ?Color(0xFFDE3C31):null,
                                                  //           border: Border(
                                                  //             left: BorderSide(width: 0.4,color: Colors.grey[300]),
                                                  //             right: BorderSide(width: 0.4,color: Colors.grey[300]),
                                                  //           )
                                                  //       ),
                                                  //       child: Row(
                                                  //         mainAxisAlignment: MainAxisAlignment.center,
                                                  //         children: <Widget>[
                                                  //           Text(SPClassMatchDataUtils.spFunSchemeOptionMiddleTitle(spProPlayWays[spProPlayWayIndex],
                                                  //               SPClassMatchDataUtils.spFunExpertTypeToMatchType(SPClassApplicaion.spProUserLoginInfo.spProExpertMatchType),guessMatch2: spProGuessMatch),
                                                  //               style: TextStyle(color:(spProSupportWhich==0||spProSupportWhich2==0) ?Colors.white:null )
                                                  //           ),
                                                  //         ],
                                                  //       ),
                                                  //     ),
                                                  //     onTap: (){
                                                  //
                                                  //
                                                  //       if(spProPlayWays[spProPlayWayIndex].spProPlayingWay.contains("胜平负")){
                                                  //         if(!SPClassMatchDataUtils.spFunCanPick(spProPlayWays[spProPlayWayIndex], 0)){
                                                  //           SPClassToastUtils.spFunShowToast(msg: "推介指数偏低，暂不支持");
                                                  //           return;
                                                  //         }
                                                  //         if(spProPlayWays[spProPlayWayIndex].spProGuessType=="竞彩"){
                                                  //           if(spProSupportWhich==0){
                                                  //             spProSupportWhich=spProSupportWhich2;
                                                  //             spProSupportWhich2=-1;
                                                  //           }else if(spProSupportWhich2==0){
                                                  //             spProSupportWhich2=-1;
                                                  //           }else{
                                                  //             if(spProSupportWhich==-1){
                                                  //               spProSupportWhich=0;
                                                  //             }else{
                                                  //               if(SPClassMatchDataUtils.spFunIsTwoPicker(spProPlayWays[spProPlayWayIndex], spProSupportWhich, 0)){
                                                  //                 spProSupportWhich2=0;
                                                  //               }
                                                  //             }
                                                  //           }
                                                  //         }else{
                                                  //           spProSupportWhich=0;
                                                  //         }
                                                  //
                                                  //         setState(() {});
                                                  //       }
                                                  //
                                                  //     },
                                                  //   )
                                                  // ),

                                                  Expanded(
                                                    child: GestureDetector(
                                                      behavior: HitTestBehavior
                                                          .opaque,
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                            color: (spProSupportWhich ==
                                                                        2 ||
                                                                    spProSupportWhich2 ==
                                                                        2)
                                                                ? MyColors.main1
                                                                : Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        150),
                                                            border: Border.all(
                                                                width: 0.4,
                                                                color: (spProSupportWhich ==
                                                                            2 ||
                                                                        spProSupportWhich2 ==
                                                                            2)
                                                                    ? Colors
                                                                        .transparent
                                                                    : Color(
                                                                        0xFF999999))),
                                                        height: width(37),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: <Widget>[
                                                            Text(
                                                                SPClassMatchDataUtils.spFunSchemeOptionRightTitle(
                                                                    spProPlayWays[
                                                                        spProPlayWayIndex],
                                                                    SPClassMatchDataUtils.spFunExpertTypeToMatchType(SPClassApplicaion
                                                                        .spProUserLoginInfo
                                                                        !.spProExpertMatchType!),
                                                                    guessMatch2:
                                                                        spProGuessMatch),
                                                                style: TextStyle(
                                                                    color: (spProSupportWhich ==
                                                                                2 ||
                                                                            spProSupportWhich2 ==
                                                                                2)
                                                                        ? Colors
                                                                            .white
                                                                        : null,
                                                                    fontSize:
                                                                        sp(17))),
                                                            Text(
                                                              "  (" +
                                                                  spProPlayWays[
                                                                          spProPlayWayIndex]
                                                                      .spProWinOddsTwo! +
                                                                  ")",
                                                              style: TextStyle(
                                                                  color: (spProSupportWhich ==
                                                                              2 ||
                                                                          spProSupportWhich2 ==
                                                                              2)
                                                                      ? Colors
                                                                          .white
                                                                      : null,
                                                                  fontSize:
                                                                      sp(17)),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      onTap: () {
                                                        if (!SPClassMatchDataUtils
                                                            .spFunCanPick(
                                                                spProPlayWays[
                                                                    spProPlayWayIndex],
                                                                2)) {
                                                          SPClassToastUtils
                                                              .spFunShowToast(
                                                                  msg:
                                                                      "推介指数偏低，暂不支持");
                                                          return;
                                                        }

                                                        if (spProPlayWays[
                                                                    spProPlayWayIndex]
                                                                .spProGuessType ==
                                                            "竞彩") {
                                                          if (spProSupportWhich ==
                                                              2) {
                                                            spProSupportWhich =
                                                                spProSupportWhich2;
                                                            spProSupportWhich2 =
                                                                -1;
                                                          } else if (spProSupportWhich2 ==
                                                              2) {
                                                            spProSupportWhich2 =
                                                                -1;
                                                          } else {
                                                            if (spProSupportWhich ==
                                                                -1) {
                                                              spProSupportWhich =
                                                                  2;
                                                            } else {
                                                              if (SPClassMatchDataUtils
                                                                  .spFunIsTwoPicker(
                                                                      spProPlayWays[
                                                                          spProPlayWayIndex],
                                                                      spProSupportWhich,
                                                                      2)) {
                                                                spProSupportWhich2 =
                                                                    2;
                                                              }
                                                            }
                                                          }
                                                        } else {
                                                          spProSupportWhich = 2;
                                                        }

                                                        setState(() {});
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                )
                              : SizedBox(),
                        ],
                      ),
                    ),

                    Container(
                      padding: EdgeInsets.only(
                          left: width(15), top: width(28), bottom: width(15)),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "推荐结果：",
                        style: TextStyle(
                            color: Color(0xFF333333),
                            fontWeight: FontWeight.w500,fontSize: sp(15)),
                          
                      ),
                    ),

                    // 输入的内容
                    Container(
                      margin:
                          EdgeInsets.only(left: width(15), right: width(15)),
                      padding: EdgeInsets.symmetric(
                        horizontal: width(15),
                      ),
                      decoration: BoxDecoration(
                          color: Color(0xFFF7F7F7),
                          borderRadius: BorderRadius.circular(width(6))),
                      height: width(36),
                      child: TextField(
                        maxLength: 50,
                        autofocus: false,
                        buildCounter: (
                          BuildContext ?context, {
                           int ?currentLength,
                           int ?maxLength,
                           bool ?isFocused,
                        }) {
                          //自定义的显示格式
                          return SizedBox();
                        },
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: sp(14),
                        ),
                        decoration: InputDecoration(
                          hintText: "请输入标题",
                          border: InputBorder.none,
                          contentPadding:
                              EdgeInsets.symmetric(vertical: width(0)),
                        ),
                        onChanged: (value) {
                          title = value;
                          spFunCheckCommit();
                        },
                      ),
                    ),

                    Container(
                      constraints: BoxConstraints(
                        maxHeight: double.maxFinite,
                        minHeight: width(102),
                      ),
                      decoration: BoxDecoration(
                          color: Color(0xFFF7F7F7),
                          borderRadius: BorderRadius.circular(width(6))),
                      margin: EdgeInsets.only(
                          left: width(15), right: width(15), top: width(4)),
                      padding: EdgeInsets.symmetric(
                        horizontal: width(15),
                      ),
                      child: TextField(
                        keyboardType: TextInputType.multiline,
                        autofocus: false,
                        style: TextStyle(
                          fontSize: sp(14),
                        ),
                        decoration: InputDecoration(
                          hintMaxLines: 6,
                          hintText:
                              "文章内容不少于100字，涉嫌抄袭，广告，擅留微信、QQ等联系方式将给予不通过文章处理；",
                          border: InputBorder.none,
                        ),
                        maxLines: null,
                        onChanged: (value) {
                          detail = value;
                          spFunCheckCommit();
                        },
                      ),
                    ),

                    // 方案价格
                    // Container(
                    //   padding: EdgeInsets.symmetric(horizontal: width(15)),
                    //   child: Row(
                    //     children: <Widget>[
                    //       Text('方案价格：',style: TextStyle(fontSize: sp(13),color: MyColors.grey_33),)
                    //     ],
                    //   ),
                    // ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: width(16)),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border:
                              Border.all(width: 0.4, color: Colors.grey[300]!)),
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: width(10),
                          ),
                          Row(
                            children: <Widget>[
                              Text(
                                "不中包退",
                                style: TextStyle(
                                    color: Color(0xFF333333),
                                    fontSize: sp(14),
                                    fontWeight: FontWeight.w600),
                              ),
                              Expanded(
                                child: SizedBox(),
                              ),
                              GestureDetector(
                                child: Container(
                                  width: width(50),
                                  height: width(27),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(300),
                                    color: spProCanReturn
                                        ? Theme.of(context).primaryColor
                                        : Color(0xFFEAE8EB),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: spProCanReturn
                                        ? MainAxisAlignment.start
                                        : MainAxisAlignment.end,
                                    children: <Widget>[
                                      Container(
                                        margin:
                                            EdgeInsets.only(left: 2, right: 2),
                                        width: width(23),
                                        height: width(23),
                                        decoration: ShapeDecoration(
                                            shadows: [
                                              BoxShadow(
                                                  offset: Offset(1, 1),
                                                  color: Colors.black
                                                      .withOpacity(0.2)),
                                            ],
                                            shape: CircleBorder(),
                                            color: Colors.white),
                                      )
                                    ],
                                  ),
                                ),
                                onTap: () {
                                  spProCanReturn =!spProCanReturn;
                                  setState(() {

                                  });
                                },
                              ),
                            ],
                          ),
                          SizedBox(
                            height: width(10),
                          ),
                        ],
                      ),
                    ),

                    Container(
                      padding: EdgeInsets.symmetric(horizontal: width(16)),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border:
                              Border.all(width: 0.4, color: Colors.grey[300]!)),
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: width(10),
                          ),
                          Row(
                            children: <Widget>[
                              Text(
                                "价格方案",
                                style: TextStyle(
                                    color: Color(0xFF333333),
                                    fontSize: sp(14),
                                    fontWeight: FontWeight.w600),
                              ),
                              Expanded(
                                child: SizedBox(),
                              ),
                              GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 3, horizontal: 6),
                                  child: Row(
                                    children: <Widget>[
                                      (spProPriceList[spProPriceIndex]==-1||spProPriceList[spProPriceIndex]==0)?Container():Image.asset(
                                        SPClassImageUtil.spFunGetImagePath("zhuanshi"),
                                        width: width(17),
                                      ),
                                      Text(
                                        spProPriceList[spProPriceIndex] == 0
                                            ? "免费"
                                            : spProPriceList[spProPriceIndex] ==
                                                    -1
                                                ? "请选择"
                                                : (spProPriceList[
                                                            spProPriceIndex]
                                                        .toString()),
                                        style: TextStyle(
                                            color: Color(0xFF333333),
                                            fontSize: sp(13)),
                                      ),
                                      SizedBox(
                                        width: width(5),
                                      ),
                                      Image.asset(
                                        SPClassImageUtil.spFunGetImagePath(
                                          "ic_up_arrow",
                                        ),
                                        width: width(13),
                                      )
                                    ],
                                  ),
                                ),
                                onTap: () {
                                  showModalBottomSheet(
                                    context: context,
                                    builder: (BuildContext c) {
                                      return SPClassBottomLeaguePage(
                                        spProPriceList.map((price) {
                                          if (price == 0) {
                                            return "免费";
                                          }
                                          if (price == -1) {
                                            return "请选择";
                                          }
                                          return (price.toString() + "钻石");
                                        }).toList(),
                                        "请选择",
                                        (index) {
                                          setState(() {
                                            spProPriceIndex = index;
                                          });
                                          FocusScope.of(context)
                                              .requestFocus(FocusNode());
                                        },
                                        initialIndex: spProPriceIndex,
                                      );
                                    },
                                  );
                                },
                              )
                            ],
                          ),
                          SizedBox(
                            height: width(10),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height(50),
                    ),
                  ],
                ),
              ),
            )
          : Container(
              padding: EdgeInsets.symmetric(horizontal: width(14)),
              margin: EdgeInsets.only(top: width(12)),
              height: width(67),
              decoration: BoxDecoration(
                color: Color(0xFFF7F7F7),
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      "你还未选择球队",
                      style:
                          TextStyle(color: Color(0xFF666666), fontSize: sp(15)),
                    ),
                  ),
                  SizedBox(
                    height: width(10),
                  ),
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: width(6), horizontal: width(12)),
                        margin: EdgeInsets.only(left: width(3)),
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 0.4, color: Color(0xFFEB3E1C)),
                            borderRadius: BorderRadius.circular(150)),
                        child: Text(
                          spProGuessMatch == null ? "选择球队" : "重新选择",
                          style: TextStyle(
                              color: Color(0xFFEB3E1C), fontSize: sp(13)),
                        ),
                      ),
                    ),
                    onTap: () {
                      spFunPickerMatch();
                    },
                  ),
                ],
              ),
            ),
      bottomNavigationBar: GestureDetector(
        child: Container(
          alignment: Alignment.center,
          height: width(61),
          color: MyColors.main1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                "立即发布",
                style: TextStyle(fontSize: sp(15), color: Colors.white),
              )
            ],
          ),
        ),
        onTap: () async {
          if (spFunCheckCommit(showToast: true)) {
            SPClassApiManager.spFunGetInstance().spFunAddScheme(
                context: context,
                queryParameters: {
                  "scheme_title": title,
                  "guess_match_id": spProGuessMatch!.spProGuessMatchId!,
                  "can_return": spProCanReturn ? 1 : 0,
                  "support_which": SPClassMatchDataUtils.spFunGetSupportWitch(
                      spProPlayWays[spProPlayWayIndex], spProSupportWhich),
                  "support_which2": SPClassMatchDataUtils.spFunGetSupportWitch(
                      spProPlayWays[spProPlayWayIndex], spProSupportWhich2),
                  "diamond": spProPriceList[spProPriceIndex],
                  "win_odds_one":
                      spProPlayWays[spProPlayWayIndex].spProWinOddsOne,
                  "draw_odds": spProPlayWays[spProPlayWayIndex].spProDrawOdds,
                  "win_odds_two":
                      spProPlayWays[spProPlayWayIndex].spProWinOddsTwo,
                  "add_score": spProPlayWays[spProPlayWayIndex].spProAddScore,
                  "mid_score": spProPlayWays[spProPlayWayIndex].spProMidScore,
                  "battle_index":
                      spProPlayWays[spProPlayWayIndex].spProBattleIndex,
                  "guess_type": spProPlayWays[spProPlayWayIndex].spProGuessType,
                  "playing_way":
                      spProPlayWays[spProPlayWayIndex].spProPlayingWay,
                },
                bodyPrams: {"scheme_detail": detail.replaceAll("\n", "<br/>")},
                spProCallBack: SPClassHttpCallBack(spProOnSuccess: (value) {
                  Navigator.of(context).pop();
                  SPClassApplicaion.spProEventBus.fire("refresh:myscheme");
                  SPClassNavigatorUtils.spFunPushRoute(
                      context, SPClassAddSchemeSuccessPage());
                },onError: (e){},spProOnProgress: (v){}
                ));
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    timer?.cancel();
  }

  void spFunPickerMatch() {
    showDialog(
        context: context,
        builder: (c) => SPClassPickSchemeDataDialog(
              (value) {
                spProMarqueeWidget = null;
                spProGuessMatch = value;
                setState(() {});
                spFunInitMarquee();

                spFunGetPlayList();
              },
              spProGuessMatch: spProGuessMatch,
            ));
  }

  bool spFunCheckCommit({bool showToast: false}) {
    var result = true;
    if (spProGuessMatch == null) {
      if (showToast) {
        SPClassToastUtils.spFunShowToast(msg: "请选择比赛");
      }
      result = false;
    } else if (spProSupportWhich == -1) {
      if (showToast) {
        SPClassToastUtils.spFunShowToast(msg: "请选择推荐结果");
      }
      result = false;
    } else if (spProSupportWhich == -1) {
      if (showToast) {
        SPClassToastUtils.spFunShowToast(msg: "请选择推荐结果");
      }
      result = false;
    } else if (title.isEmpty) {
      if (showToast) {
        SPClassToastUtils.spFunShowToast(msg: "请填写标题");
      }
      result = false;
    } else if (detail.isEmpty) {
      if (showToast) {
        SPClassToastUtils.spFunShowToast(msg: "请填写内容");
      }
      result = false;
    } else if (detail.length < 100) {
      if (showToast) {
        SPClassToastUtils.spFunShowToast(msg: "文章内容不少于100字");
      }
      result = false;
    } else if (spProPriceList[spProPriceIndex] == -1) {
      if (showToast) {
        SPClassToastUtils.spFunShowToast(msg: "请选择价格");
      }
      result = false;
    }
    setState(() {
      spProCanCommit = result;
    });
    return result;
  }

  void spFunGetPlayList() {
    SPClassApiManager.spFunGetInstance()
        .spFunPlayingWayOdds<SPClassBaseModelEntity>(
            context: context,
            queryParameters: {
              "guess_match_id": spProGuessMatch!.spProGuessMatchId!
            },
            spProCallBack: SPClassHttpCallBack(spProOnSuccess: (value) {
              setState(() {
                var spProOddsList = new SPClassListEntity<SPClassSchemePlayWay>(
                    key: "playing_way_list",
                    object: new SPClassSchemePlayWay());
                spProOddsList.fromJson(value.data);
                var spProPriceList =
                    new SPClassListEntity<String>(key: "price_list");
                spProPriceList.fromJson(value.data);
                spProPriceList.spProDataList.insert(0, "-1");
                spProPlayWays = spProOddsList.spProDataList;
                spProPriceIndex = 0;
                this.spProPriceList = spProPriceList.spProDataList
                    .map((e) => int.tryParse(e))
                    .toList();
                spProPlayWayColNum = spProPlayWays.length == 3 ? 3 : 2;
              });
              FocusScope.of(context).requestFocus(FocusNode());
            }));
  }

  void spFunInitMarquee() {
    setState(() {
      spProMarqueeWidget = SPClassMarqueeWidget(
        child: Row(
          children: <Widget>[
            Text(
              spProGuessMatch!.spProTeamOne!,
              style: TextStyle(
                color: Color(0xFF333333),
                fontSize: sp(16),
                fontWeight: FontWeight.w500,
              ),
              overflow: TextOverflow.ellipsis, maxLines: 1,
              // style: TextStyle(fontSize: sp(16),color: Color(0xFF333333)),
            ),
            Text(
              " VS ",
              style: TextStyle(fontSize: sp(16), color: Color(0xFFB5B5B5)),
            ),
            Text(
              spProGuessMatch!.spProTeamTwo! + "",
              style: TextStyle(
                color: Color(0xFF333333),
                fontSize: sp(16),
                fontWeight: FontWeight.w500,
              ),
              
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ],
        ),
      );
    });
  }
}
