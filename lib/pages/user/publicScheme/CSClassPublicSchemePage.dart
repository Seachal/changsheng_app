import 'dart:async';

import 'package:changshengh5/api/CSClassApiManager.dart';
import 'package:changshengh5/api/CSClassHttpCallBack.dart';
import 'package:changshengh5/app/CSClassApplicaion.dart';
import 'package:changshengh5/model/CSClassBaseModelEntity.dart';
import 'package:changshengh5/model/CSClassGuessMatchInfo.dart';
import 'package:changshengh5/model/CSClassListEntity.dart';
import 'package:changshengh5/model/CSClassSchemeGuessMatch2.dart';
import 'package:changshengh5/model/CSClassSchemePlayWay.dart';
import 'package:changshengh5/pages/competition/CSClassMatchDetailPage.dart';
import 'package:changshengh5/pages/dialogs/CSClassBottomLeaguePage.dart';
import 'package:changshengh5/utils/CSClassCommonMethods.dart';
import 'package:changshengh5/utils/CSClassDateUtils.dart';
import 'package:changshengh5/utils/CSClassImageUtil.dart';
import 'package:changshengh5/utils/CSClassMatchDataUtils.dart';
import 'package:changshengh5/utils/CSClassNavigatorUtils.dart';
import 'package:changshengh5/utils/CSClassToastUtils.dart';
import 'package:changshengh5/utils/colors.dart';
import 'package:changshengh5/widgets/CSClassMarqueeWidget.dart';
import 'package:changshengh5/widgets/CSClassToolBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'CSClassAddSchemeSuccessPage.dart';
import 'CSClassPickSchemeDataDialog.dart';


class CSClassPublicSchemePage extends StatefulWidget {
  CSClassSchemeGuessMatch2 ?csProGuessMatch;

  CSClassPublicSchemePage({this.csProGuessMatch});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CSClassPublicSchemePageState();
  }
}

class CSClassPublicSchemePageState extends State<CSClassPublicSchemePage> {
  var LeagueName = "";
  CSClassSchemeGuessMatch2 ?csProGuessMatch;
  ScrollController ?scrollController;
  Timer? timer;
  List<CSClassSchemePlayWay> csProPlayWays = [];
  var csProPlayWayIndex = 0;
  var csProPlayWayColNum = 2;
  var csProSupportWhich = -1;
  var csProSupportWhich2 = -1;
  var csProCanReturn = false;
  List csProPriceList = [-1, 0, 18, 28, 38, 58];
  int csProPriceIndex = 0;
  var title = "";
  var detail = "";

  var csProCanCommit = false;

  var csProHadKey = false;

  CSClassMarqueeWidget ?csProMarqueeWidget;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    scrollController = ScrollController();

    WidgetsBinding.instance?.addPostFrameCallback((frame) {
      // pickerMatch();
      if (widget.csProGuessMatch != null) {
        csProGuessMatch = widget.csProGuessMatch;
        csMethodInitMarquee();

        csMethodGetPlayList();
      }
      timer = Timer.periodic(Duration(seconds: 4), (timer) {});
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: CSClassToolBar(
        context,
        title: "发布方案",
        csProBgColor: Colors.white,
        iconColor: 0xFF333333,
      ),
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: (){
          FocusScope.of(context).unfocus();
        },
        child: csProGuessMatch != null
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
                                      CSClassDateUtils
                                          .csMethodDateFormatByString(
                                          csProGuessMatch!.csProStTime!,
                                          "MM-dd HH:mm"),
                                      style: TextStyle(
                                          fontSize: sp(12),
                                          color: Color(0xFF999999)),
                                    ),
                                    SizedBox(
                                      width: width(5),
                                    ),
                                    Text(
                                      csProGuessMatch!.csProLeagueName!,
                                      style: TextStyle(
                                          fontSize: sp(12),
                                          color: Color(0xFF999999)),
                                    ),
                                  ],
                                ),
                                csProMarqueeWidget != null
                                    ? Container(
                                  height: width(30),
                                  child: csProMarqueeWidget,
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
                                csProGuessMatch == null ? "选择球队" : "重新选择",
                                style: TextStyle(
                                    color: Color(0xFFEB3E1C),
                                    fontSize: sp(13)),
                              ),
                            ),
                          ),
                          onTap: () {
                            csMethodPickerMatch();
                          },
                        )
                      ],
                    ),
                  ),
                  onTap: () {
                    if (csProGuessMatch == null) {
                      return;
                    }
                    CSClassApiManager.csMethodGetInstance()
                        .csMethodSportMatchData<CSClassGuessMatchInfo>(
                        loading: true,
                        context: context,
                        csProGuessMatchId:
                        csProGuessMatch!.csProGuessMatchId!,
                        dataKeys: "guess_match",
                        csProCallBack: CSClassHttpCallBack(
                            csProOnSuccess: (result) async {
                              CSClassNavigatorUtils.csMethodPushRoute(
                                  context,
                                  CSClassMatchDetailPage(
                                    result,
                                    csProMatchType: "guess_match_id",
                                    csProInitIndex: 1,
                                  ));
                            },onError: (e){},csProOnProgress: (v){}
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
                          children: csProPlayWays.map((way) {
                            return GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              child: Container(
                                width: width(100),
                                height: width(40),
                                margin: EdgeInsets.only(
                                    right: csProPlayWays.indexOf(way) ==
                                        csProPlayWays.length - 1
                                        ? 0
                                        : width(15)),
                                decoration: BoxDecoration(
                                  color: csProPlayWayIndex ==
                                      csProPlayWays.indexOf(way)
                                      ? MyColors.main1
                                      : null,
                                  borderRadius: BorderRadius.circular(150),
                                  border: Border.all(
                                      width: 0.4,
                                      color: csProPlayWayIndex ==
                                          csProPlayWays.indexOf(way)
                                          ? Colors.transparent
                                          : Color(0xFF999999)),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  way.csProPlayingWay! +
                                      ((CSClassMatchDataUtils.csMethodExpertTypeToMatchType(
                                          CSClassApplicaion
                                              .csProUserLoginInfo
                                          !.csProExpertMatchType!) ==
                                          "lol" &&
                                          (way.csProPlayingWay ==
                                              "总击杀" ||
                                              way.csProPlayingWay ==
                                                  "总时长"))
                                          ? (" (第" +
                                          way.csProBattleIndex!.trim() +
                                          "局)")
                                          : ""),
                                  style: TextStyle(
                                      fontSize: sp(17),
                                      color: csProPlayWayIndex ==
                                          csProPlayWays.indexOf(way)
                                          ? Colors.white
                                          : Colors.black),
                                ),
                              ),
                              onTap: () {
                                setState(() {
                                  csProPlayWayIndex =
                                      csProPlayWays.indexOf(way);
                                  csProSupportWhich = -1;
                                  csProSupportWhich2 = -1;
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
                      csProPlayWays.length > 0
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
                                                  color: (csProSupportWhich ==
                                                      1 ||
                                                      csProSupportWhich2 ==
                                                          1)
                                                      ? MyColors.main1
                                                      : Colors.white,
                                                  borderRadius:
                                                  BorderRadius
                                                      .circular(
                                                      150),
                                                  border: Border.all(
                                                      width: 0.4,
                                                      color: (csProSupportWhich ==
                                                          1 ||
                                                          csProSupportWhich2 ==
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
                                                      CSClassMatchDataUtils.csMethodSchemeOptionLeftTitle(
                                                          csProPlayWays[
                                                          csProPlayWayIndex],
                                                          CSClassMatchDataUtils.csMethodExpertTypeToMatchType(CSClassApplicaion
                                                              .csProUserLoginInfo
                                                          !.csProExpertMatchType!),
                                                          guessMatch2:
                                                          csProGuessMatch),
                                                      style: TextStyle(
                                                          color: (csProSupportWhich ==
                                                              1 ||
                                                              csProSupportWhich2 ==
                                                                  1)
                                                              ? Colors
                                                              .white
                                                              : null,
                                                          fontSize:
                                                          sp(17))),
                                                  Text(
                                                    "  (" +
                                                        csProPlayWays[
                                                        csProPlayWayIndex]
                                                            .csProWinOddsOne! +
                                                        ")",
                                                    style: TextStyle(
                                                        color: (csProSupportWhich ==
                                                            1 ||
                                                            csProSupportWhich2 ==
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
                                              if (!CSClassMatchDataUtils
                                                  .csMethodCanPick(
                                                  csProPlayWays[
                                                  csProPlayWayIndex],
                                                  1)) {
                                                CSClassToastUtils
                                                    .csMethodShowToast(
                                                    msg:
                                                    "推介指数偏低，暂不支持");
                                                return;
                                              }
                                              if (csProPlayWays[
                                              csProPlayWayIndex]
                                                  .csProGuessType ==
                                                  "竞彩") {
                                                if (csProSupportWhich ==
                                                    1) {
                                                  csProSupportWhich =
                                                      csProSupportWhich2;
                                                  csProSupportWhich2 =
                                                  -1;
                                                } else if (csProSupportWhich2 ==
                                                    1) {
                                                  csProSupportWhich2 =
                                                  -1;
                                                } else {
                                                  if (csProSupportWhich ==
                                                      -1) {
                                                    csProSupportWhich =
                                                    1;
                                                  } else {
                                                    if (CSClassMatchDataUtils
                                                        .csMethodIsTwoPicker(
                                                        csProPlayWays[
                                                        csProPlayWayIndex],
                                                        csProSupportWhich,
                                                        1)) {
                                                      csProSupportWhich2 =
                                                      1;
                                                    }
                                                  }
                                                }
                                              } else {
                                                csProSupportWhich = 1;
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
                                        //            color:(csProSupportWhich==0||csProSupportWhich2==0) ?Color(0xFFDE3C31):null,
                                        //           border: Border(
                                        //             left: BorderSide(width: 0.4,color: Colors.grey[300]),
                                        //             right: BorderSide(width: 0.4,color: Colors.grey[300]),
                                        //           )
                                        //       ),
                                        //       child: Row(
                                        //         mainAxisAlignment: MainAxisAlignment.center,
                                        //         children: <Widget>[
                                        //           Text(CSClassMatchDataUtils.csMethodSchemeOptionMiddleTitle(csProPlayWays[csProPlayWayIndex],
                                        //               CSClassMatchDataUtils.csMethodExpertTypeToMatchType(CSClassApplicaion.csProUserLoginInfo.csProExpertMatchType),guessMatch2: csProGuessMatch),
                                        //               style: TextStyle(color:(csProSupportWhich==0||csProSupportWhich2==0) ?Colors.white:null )
                                        //           ),
                                        //         ],
                                        //       ),
                                        //     ),
                                        //     onTap: (){
                                        //
                                        //
                                        //       if(csProPlayWays[csProPlayWayIndex].csProPlayingWay.contains("胜平负")){
                                        //         if(!CSClassMatchDataUtils.csMethodCanPick(csProPlayWays[csProPlayWayIndex], 0)){
                                        //           CSClassToastUtils.csMethodShowToast(msg: "推介指数偏低，暂不支持");
                                        //           return;
                                        //         }
                                        //         if(csProPlayWays[csProPlayWayIndex].csProGuessType=="竞彩"){
                                        //           if(csProSupportWhich==0){
                                        //             csProSupportWhich=csProSupportWhich2;
                                        //             csProSupportWhich2=-1;
                                        //           }else if(csProSupportWhich2==0){
                                        //             csProSupportWhich2=-1;
                                        //           }else{
                                        //             if(csProSupportWhich==-1){
                                        //               csProSupportWhich=0;
                                        //             }else{
                                        //               if(CSClassMatchDataUtils.csMethodIsTwoPicker(csProPlayWays[csProPlayWayIndex], csProSupportWhich, 0)){
                                        //                 csProSupportWhich2=0;
                                        //               }
                                        //             }
                                        //           }
                                        //         }else{
                                        //           csProSupportWhich=0;
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
                                                  color: (csProSupportWhich ==
                                                      2 ||
                                                      csProSupportWhich2 ==
                                                          2)
                                                      ? MyColors.main1
                                                      : Colors.white,
                                                  borderRadius:
                                                  BorderRadius
                                                      .circular(
                                                      150),
                                                  border: Border.all(
                                                      width: 0.4,
                                                      color: (csProSupportWhich ==
                                                          2 ||
                                                          csProSupportWhich2 ==
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
                                                      CSClassMatchDataUtils.csMethodSchemeOptionRightTitle(
                                                          csProPlayWays[
                                                          csProPlayWayIndex],
                                                          CSClassMatchDataUtils.csMethodExpertTypeToMatchType(CSClassApplicaion
                                                              .csProUserLoginInfo
                                                          !.csProExpertMatchType!),
                                                          guessMatch2:
                                                          csProGuessMatch),
                                                      style: TextStyle(
                                                          color: (csProSupportWhich ==
                                                              2 ||
                                                              csProSupportWhich2 ==
                                                                  2)
                                                              ? Colors
                                                              .white
                                                              : null,
                                                          fontSize:
                                                          sp(17))),
                                                  Text(
                                                    "  (" +
                                                        csProPlayWays[
                                                        csProPlayWayIndex]
                                                            .csProWinOddsTwo! +
                                                        ")",
                                                    style: TextStyle(
                                                        color: (csProSupportWhich ==
                                                            2 ||
                                                            csProSupportWhich2 ==
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
                                              if (!CSClassMatchDataUtils
                                                  .csMethodCanPick(
                                                  csProPlayWays[
                                                  csProPlayWayIndex],
                                                  2)) {
                                                CSClassToastUtils
                                                    .csMethodShowToast(
                                                    msg:
                                                    "推介指数偏低，暂不支持");
                                                return;
                                              }

                                              if (csProPlayWays[
                                              csProPlayWayIndex]
                                                  .csProGuessType ==
                                                  "竞彩") {
                                                if (csProSupportWhich ==
                                                    2) {
                                                  csProSupportWhich =
                                                      csProSupportWhich2;
                                                  csProSupportWhich2 =
                                                  -1;
                                                } else if (csProSupportWhich2 ==
                                                    2) {
                                                  csProSupportWhich2 =
                                                  -1;
                                                } else {
                                                  if (csProSupportWhich ==
                                                      -1) {
                                                    csProSupportWhich =
                                                    2;
                                                  } else {
                                                    if (CSClassMatchDataUtils
                                                        .csMethodIsTwoPicker(
                                                        csProPlayWays[
                                                        csProPlayWayIndex],
                                                        csProSupportWhich,
                                                        2)) {
                                                      csProSupportWhich2 =
                                                      2;
                                                    }
                                                  }
                                                }
                                              } else {
                                                csProSupportWhich = 2;
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
                    "文章内容：",
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
                      csMethodCheckCommit();
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
                      csMethodCheckCommit();
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
                                color: csProCanReturn
                                    ? Theme.of(context).primaryColor
                                    : Color(0xFFEAE8EB),
                              ),
                              child: Row(
                                mainAxisAlignment: csProCanReturn
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
                              csProCanReturn =!csProCanReturn;
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
                                  (csProPriceList[csProPriceIndex]==-1||csProPriceList[csProPriceIndex]==0)?Container():Image.asset(
                                    CSClassImageUtil.csMethodGetImagePath("zhuanshi"),
                                    width: width(17),
                                  ),
                                  Text(
                                    csProPriceList[csProPriceIndex] == 0
                                        ? "免费"
                                        : csProPriceList[csProPriceIndex] ==
                                        -1
                                        ? "请选择"
                                        : (csProPriceList[
                                    csProPriceIndex]
                                        .toString()),
                                    style: TextStyle(
                                        color: Color(0xFF333333),
                                        fontSize: sp(13)),
                                  ),
                                  SizedBox(
                                    width: width(5),
                                  ),
                                  Image.asset(
                                    CSClassImageUtil.csMethodGetImagePath(
                                      "cs_up_arrow",
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
                                  return CSClassBottomLeaguePage(
                                    csProPriceList.map((price) {
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
                                        csProPriceIndex = index;
                                      });
                                      FocusScope.of(context)
                                          .requestFocus(FocusNode());
                                    },
                                    initialIndex: csProPriceIndex,
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
                      csProGuessMatch == null ? "选择球队" : "重新选择",
                      style: TextStyle(
                          color: Color(0xFFEB3E1C), fontSize: sp(13)),
                    ),
                  ),
                ),
                onTap: () {
                  csMethodPickerMatch();
                },
              ),
            ],
          ),
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
          if (csMethodCheckCommit(showToast: true)) {
            CSClassApiManager.csMethodGetInstance().csMethodAddScheme(
                context: context,
                queryParameters: {
                  "scheme_title": title,
                  "guess_match_id": csProGuessMatch!.csProGuessMatchId!,
                  "can_return": csProCanReturn ? 1 : 0,
                  "support_which": CSClassMatchDataUtils.csMethodGetSupportWitch(
                      csProPlayWays[csProPlayWayIndex], csProSupportWhich),
                  "support_which2": CSClassMatchDataUtils.csMethodGetSupportWitch(
                      csProPlayWays[csProPlayWayIndex], csProSupportWhich2),
                  "diamond": csProPriceList[csProPriceIndex],
                  "win_odds_one":
                      csProPlayWays[csProPlayWayIndex].csProWinOddsOne,
                  "draw_odds": csProPlayWays[csProPlayWayIndex].csProDrawOdds,
                  "win_odds_two":
                      csProPlayWays[csProPlayWayIndex].csProWinOddsTwo,
                  "add_score": csProPlayWays[csProPlayWayIndex].csProAddScore,
                  "mid_score": csProPlayWays[csProPlayWayIndex].csProMidScore,
                  "battle_index":
                      csProPlayWays[csProPlayWayIndex].csProBattleIndex,
                  "guess_type": csProPlayWays[csProPlayWayIndex].csProGuessType,
                  "playing_way":
                      csProPlayWays[csProPlayWayIndex].csProPlayingWay,
                },
                bodyPrams: {"scheme_detail": detail.replaceAll("\n", "<br/>")},
                csProCallBack: CSClassHttpCallBack(csProOnSuccess: (value) {
                  Navigator.of(context).pop();
                  CSClassApplicaion.csProEventBus.fire("refresh:myscheme");
                  CSClassNavigatorUtils.csMethodPushRoute(
                      context, CSClassAddSchemeSuccessPage());
                },onError: (e){},csProOnProgress: (v){}
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

  void csMethodPickerMatch() {
    showDialog(
        context: context,
        builder: (c) => CSClassPickSchemeDataDialog(
              (value) {
                csProMarqueeWidget = null;
                csProGuessMatch = value;
                setState(() {});
                csMethodInitMarquee();

                csMethodGetPlayList();
              },
              csProGuessMatch: csProGuessMatch,
            ));
  }

  bool csMethodCheckCommit({bool showToast: false}) {
    var result = true;
    if (csProGuessMatch == null) {
      if (showToast) {
        CSClassToastUtils.csMethodShowToast(msg: "请选择比赛");
      }
      result = false;
    } else if (csProSupportWhich == -1) {
      if (showToast) {
        CSClassToastUtils.csMethodShowToast(msg: "请选择推荐结果");
      }
      result = false;
    } else if (csProSupportWhich == -1) {
      if (showToast) {
        CSClassToastUtils.csMethodShowToast(msg: "请选择推荐结果");
      }
      result = false;
    } else if (title.isEmpty) {
      if (showToast) {
        CSClassToastUtils.csMethodShowToast(msg: "请填写标题");
      }
      result = false;
    } else if (detail.isEmpty) {
      if (showToast) {
        CSClassToastUtils.csMethodShowToast(msg: "请填写内容");
      }
      result = false;
    } else if (detail.length < 100) {
      if (showToast) {
        CSClassToastUtils.csMethodShowToast(msg: "文章内容不少于100字");
      }
      result = false;
    } else if (csProPriceList[csProPriceIndex] == -1) {
      if (showToast) {
        CSClassToastUtils.csMethodShowToast(msg: "请选择价格");
      }
      result = false;
    }
    setState(() {
      csProCanCommit = result;
    });
    return result;
  }

  void csMethodGetPlayList() {
    CSClassApiManager.csMethodGetInstance()
        .csMethodPlayingWayOdds<CSClassBaseModelEntity>(
            context: context,
            queryParameters: {
              "guess_match_id": csProGuessMatch!.csProGuessMatchId!
            },
            csProCallBack: CSClassHttpCallBack(csProOnSuccess: (value) {
              setState(() {
                var csProOddsList = new CSClassListEntity<CSClassSchemePlayWay>(
                    key: "playing_way_list",
                    object: new CSClassSchemePlayWay());
                csProOddsList.fromJson(value.data);
                var csProPriceList =
                    new CSClassListEntity<String>(key: "price_list");
                csProPriceList.fromJson(value.data);
                csProPriceList.csProDataList.insert(0, "-1");
                csProPlayWays = csProOddsList.csProDataList;
                csProPriceIndex = 0;
                this.csProPriceList = csProPriceList.csProDataList
                    .map((e) => int.tryParse(e))
                    .toList();
                csProPlayWayColNum = csProPlayWays.length == 3 ? 3 : 2;
              });
              FocusScope.of(context).requestFocus(FocusNode());
            },onError: (v){},csProOnProgress: (v){}
            ));
  }

  void csMethodInitMarquee() {
    setState(() {
      csProMarqueeWidget = CSClassMarqueeWidget(
        child: Row(
          children: <Widget>[
            Text(
              csProGuessMatch!.csProTeamOne!,
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
              csProGuessMatch!.csProTeamTwo! + "",
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
