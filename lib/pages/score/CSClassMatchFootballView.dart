import 'package:changshengh5/api/CSClassApiManager.dart';
import 'package:changshengh5/api/CSClassHttpCallBack.dart';
import 'package:changshengh5/app/CSClassApplicaion.dart';
import 'package:changshengh5/model/CSClassGuessMatchInfo.dart';
import 'package:changshengh5/model/CSClassSchemeGuessMatch2.dart';
import 'package:changshengh5/pages/competition/CSClassMatchDetailPage.dart';
import 'package:changshengh5/pages/competition/CSClassMatchListSettingPage.dart';
import 'package:changshengh5/pages/user/publicScheme/CSClassPublicSchemePage.dart';
import 'package:changshengh5/utils/CSClassCommonMethods.dart';
import 'package:changshengh5/utils/CSClassDateUtils.dart';
import 'package:changshengh5/utils/CSClassImageUtil.dart';
import 'package:changshengh5/utils/CSClassMatchDataUtils.dart';
import 'package:changshengh5/utils/CSClassNavigatorUtils.dart';
import 'package:changshengh5/utils/CSClassStringUtils.dart';
import 'package:changshengh5/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:sprintf/sprintf.dart';


class CSClassMatchFootballView extends StatefulWidget {
  CSClassGuessMatchInfo ?csProMatchItem;
  bool ?csProShwoGroupName;
  bool ?csProShowLeagueName;
  CSClassMatchFootballViewState ?state;
  
  CSClassMatchFootballView(this.csProMatchItem,
      {this.csProShwoGroupName: false, this.csProShowLeagueName: true});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return state = CSClassMatchFootballViewState();
  }
}

class CSClassMatchFootballViewState extends State<CSClassMatchFootballView> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.only(bottom: width(3),top: width(3)),
      padding: EdgeInsets.symmetric(vertical: width(4)),
      decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            // stops: [0.5,1],
            colors: [
              Colors.white,
              Color(0xFFF7F7F7)
            ]
          ),
          boxShadow: [
          BoxShadow(
            offset: Offset(0,1),
            color: Color(0xFFD9D9D9),
            blurRadius:width(3,),),
        ]
      ),
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: width(3), bottom: width(3)),
            child: Row(
              children: <Widget>[
                widget.csProShowLeagueName!
                    ? Container(
                  width:width(70),
                  child: Text(
                    widget.csProShwoGroupName!
                        ? widget.csProMatchItem!.csProGroupName??''
                        : widget
                        .csProMatchItem!.csProLeagueName??'',
                    style: TextStyle(
                      fontSize: sp(10),
                      color: CSClassMatchDataUtils
                          .csMethodLeagueNameColor(
                          widget.csProShwoGroupName!
                              ? widget.csProMatchItem!
                              .csProGroupName??''
                              : widget.csProMatchItem!
                              .csProLeagueName??''),
                    ),
                    maxLines: 1,overflow: TextOverflow.ellipsis,
                  ),
                  padding: EdgeInsets.only(left: width(15)),
                )
                    : SizedBox(width:width(70),),
                // 左
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        CSClassDateUtils.csMethodDateFormatByString(
                            widget.csProMatchItem!.csProStTime!,
                            "MM/dd HH:mm"),
                        style: TextStyle(
                            fontSize: sp(12), color: Color(0xFF999999)),
                      ),
                    ],
                  ),
                ),
                // 中
                Container(
                  alignment: Alignment.center,
                  child: Stack(
                    children: <Widget>[
                      Container(
                        padding:
                        EdgeInsets.only(left: width(6), right: width(6)),
                        child: Text(
                          CSClassStringUtils.csMethodMatchStatusString(
                              widget.csProMatchItem!.csProIsOver == "1",
                              widget.csProMatchItem!.csProStatusDesc!,
                              widget.csProMatchItem!.csProStTime,
                              status: widget.csProMatchItem!.status),
                          style: TextStyle(
                              color: DateTime.parse(
                                  widget.csProMatchItem!.csProStTime!)
                                  .difference(DateTime.now())
                                  .inSeconds >
                                  0
                                  ? Color(0xFF999999)
                                  : Color(0xFFF15558),
                              fontSize: sp(12)),
                        ),
                      ),
                      CSClassStringUtils.csMethodIsNum(
                          widget.csProMatchItem!.csProStatusDesc!)
                          ? Positioned(
                        right: 0,
                        top: 3,
                        child: Image.asset(
                          CSClassImageUtil.csMethodGetImagePath("gf_minute",
                              format: ".gif"),
                          color: Color(0xFFF15558),
                        ),
                      )
                          : SizedBox()
                    ],
                  ),
                ),
                // 右
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Row(
                          children: <Widget>[
                            widget.csProMatchItem!.corner!.isNotEmpty
                                ? Image.asset(
                              CSClassImageUtil.csMethodGetImagePath(
                                  "ic_coner_score"),
                              width: width(12),
                            )
                                : SizedBox(),
                            Text(
                              "${widget.csProMatchItem!.corner}",
                              style: TextStyle(
                                  color: Color(0xFF999999), fontSize: sp(12)),
                            ),
                            SizedBox(width: width(5),),
                            widget.csProMatchItem!.csProHalfScore!.isNotEmpty
                                ? Text(
                              "半 " + widget.csProMatchItem!.csProHalfScore!,
                              style: TextStyle(
                                  fontSize: sp(12), color: Color(0xFF999999)),
                            )
                                : SizedBox(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // 观点
                (widget.csProMatchItem!.csProSchemeNum == null ||
                    int.tryParse(
                        widget.csProMatchItem!.csProSchemeNum!) ==
                        0)
                    ? SizedBox(
                  width: width(70),
                )
                    : GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    width: width(70),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          widget.csProMatchItem!.csProSchemeNum! +
                              "观点",
                          style: TextStyle(
                              color: Color(0xFF24AAF0),
                              fontSize: sp(12)),
                        ),
                        Image.asset(
                            CSClassImageUtil.csMethodGetImagePath(
                                "ic_btn_right"),
                            height: width(7),
                            color: Color(0xFF24AAF0)),
                        SizedBox(
                          width: width(15),
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    CSClassApiManager.csMethodGetInstance()
                        .csMethodMatchClick(queryParameters: {
                      "match_id":
                      widget.csProMatchItem!.csProGuessMatchId
                    });
                    CSClassNavigatorUtils.csMethodPushRoute(
                        context,
                        CSClassMatchDetailPage(
                          widget.csProMatchItem,
                          csProMatchType: "guess_match_id",
                          csProInitIndex: 3,
                        ));
                  },
                )
              ],
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    padding: EdgeInsets.all(4),
                    margin: EdgeInsets.only(right: width(12)),
                    width: width(45),
                    alignment: Alignment.center,
                    child: Image.asset(
                      CSClassImageUtil.csMethodGetImagePath(
                          'ic_btn_score_colloect'),
                      width: width(16),
                      color: widget.csProMatchItem!.collected! == "1"
                          ? MyColors.main1
                          : Colors.grey[300],
                    ),
                  ),
                  onTap: () {
                    if (csMethodIsLogin(context: context)) {
                      if (!(widget.csProMatchItem!.collected == "1")) {
                        CSClassApiManager.csMethodGetInstance().csMethodCollectMatch(
                            matchId: widget.csProMatchItem!.csProGuessMatchId!,
                            context: context,
                            csProCallBack:
                                CSClassHttpCallBack(
                                    csProOnSuccess: (result) {
                              CSClassApplicaion.csProEventBus
                                  .fire("updateFollow");
                              if (mounted) {
                                setState(() {
                                  widget.csProMatchItem!.collected = "1";
                                });
                              }
                            },onError: (e){},csProOnProgress: (v){}
                                ));
                      } else {
                        CSClassApiManager.csMethodGetInstance().csMethodDelUserMatch(
                            matchId: widget.csProMatchItem!.csProGuessMatchId!,
                            context: context,
                            csProCallBack:
                                CSClassHttpCallBack(
                                    csProOnSuccess: (result) {
                              CSClassApplicaion.csProEventBus
                                  .fire("updateFollow");
                              if (mounted) {
                                setState(() {
                                  widget.csProMatchItem!.collected = "0";
                                });
                              }
                            },onError: (e){},csProOnProgress: (v){}
                            ));
                      }
                    }
                  },
                ),
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                (widget.csProMatchItem!.csProRedCard!
                                            .isNotEmpty &&
                                        int.tryParse(widget
                                                .csProMatchItem!.csProRedCard!
                                                .split("-")[0])! >
                                            0 &&
                                        CSClassMatchListSettingPageState
                                            .csProShowRedCard)
                                    ? Container(
                                        padding: EdgeInsets.all(width(1)),
                                        decoration: BoxDecoration(
                                            color: Color(0xFFDA5548),
                                            borderRadius: BorderRadius.circular(
                                                width(2))),
                                        child: Text(
                                          widget.csProMatchItem!.csProRedCard!
                                              .split("-")[0],
                                          style: TextStyle(
                                              color: Colors.white,
                                          fontSize: sp(11),
                                        ),
                                      ),)
                                    : SizedBox(),
                                (widget.csProMatchItem!.csProYellowCard!
                                            .isNotEmpty &&
                                        int.tryParse(widget
                                                .csProMatchItem!.csProYellowCard!
                                                .split("-")[0])! >
                                            0 &&
                                        CSClassMatchListSettingPageState
                                            .csProShowRedCard)
                                    ? Container(
                                        padding: EdgeInsets.all(width(1)),
                                        margin:
                                            EdgeInsets.only(left: 3, right: 3),
                                        decoration: BoxDecoration(
                                            color: Color(0xFFEDB445),
                                            borderRadius: BorderRadius.circular(
                                                width(2))),
                                        child: Text(
                                          widget.csProMatchItem!.csProYellowCard!
                                              .split("-")[0],
                                          style: TextStyle(
                                              color: Colors.white,
                                          fontSize: sp(11),
                                        ),
                                      ),)
                                    : SizedBox(),
                                Visibility(
                                  child: Text(
                                    sprintf("[%s] ", [
                                      widget.csProMatchItem!.csProRankingOne
                                    ]),
                                    style: TextStyle(
                                        fontSize: sp(10),
                                        color: Color(0xFF888888)),
                                  ),
                                  visible:
                                      (widget.csProMatchItem!.csProRankingOne !=
                                              null &&
                                          widget.csProMatchItem!.csProRankingOne!
                                              .isNotEmpty),
                                ),
                                Flexible(
                                  child: Text(
                                    widget.csProMatchItem!.csProTeamOne!,
                                    style: TextStyle(fontSize: sp(13),
                                      fontWeight: FontWeight.bold,),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: width(7)),
                            alignment: Alignment.center,
                            child: Column(
                              children: <Widget>[
                                !CSClassMatchDataUtils.csMethodShowScore(
                                        widget.csProMatchItem!.status!)
                                    ? Text(
                                        "VS",
                                        style: TextStyle(
                                          color: Color(0xFF999999),
                                          fontWeight: FontWeight.bold,
                                          fontSize: sp(17),),
                                      )
                                    : Text(
                                        widget.csProMatchItem!.csProScoreOne! +
                                            " - " +
                                            widget.csProMatchItem!.csProScoreTwo!,
                                        style: TextStyle(
                                          color: Color(0xFFDE3C31),
                                          fontWeight: FontWeight.w500,
                                          fontSize: sp(17),),
                                      ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Flexible(
                                  child: Text(
                                    widget.csProMatchItem!.csProTeamTwo!,
                                    style:TextStyle(fontSize: sp(13),
                                      fontWeight: FontWeight.bold,),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Visibility(
                                  child: Text(
                                    sprintf("[%s] ", [
                                      widget.csProMatchItem!.csProRankingTwo!
                                    ]),
                                    style: TextStyle(
                                        fontSize: sp(10),
                                        color: Color(0xFF888888)),
                                  ),
                                  visible:
                                      (widget.csProMatchItem!.csProRankingTwo !=
                                              null &&
                                          widget.csProMatchItem!.csProRankingTwo!
                                              .isNotEmpty),
                                ),
                                (widget.csProMatchItem!.csProRedCard!
                                            .isNotEmpty &&
                                        int.tryParse(widget
                                                .csProMatchItem!.csProRedCard!
                                                .split("-")[1])! >
                                            0 &&
                                        CSClassMatchListSettingPageState
                                            .csProShowRedCard)
                                    ? Container(
                                        padding: EdgeInsets.all(width(1)),
                                        decoration: BoxDecoration(
                                            color: Color(0xFFDA5548),
                                            borderRadius: BorderRadius.circular(
                                                width(2))),
                                        child: Text(
                                          widget.csProMatchItem!.csProRedCard!
                                              .split("-")[1],
                                          style: TextStyle(
                                              color: Colors.white,
                                          fontSize: sp(11),
                                        ),
                                      ),)
                                    : SizedBox(),
                                (widget.csProMatchItem!.csProYellowCard!
                                            .isNotEmpty &&
                                        int.tryParse(widget
                                                .csProMatchItem!.csProYellowCard!
                                                .split("-")[1])! >
                                            0 &&
                                        CSClassMatchListSettingPageState
                                            .csProShowRedCard)
                                    ? Container(
                                        padding: EdgeInsets.all(width(1)),
                                        margin:
                                            EdgeInsets.only(left: 3, right: 3),
                                        decoration: BoxDecoration(
                                            color: Color(0xFFEDB445),
                                            borderRadius: BorderRadius.circular(
                                                width(2))),
                                        child: Text(
                                          widget.csProMatchItem!.csProYellowCard!
                                              .split("-")[1],
                                          style: TextStyle(
                                              color: Colors.white,
                                          fontSize: sp(11),
                                        ),
                                      ))
                                    : SizedBox(),
                              ],
                            ),
                          ),

                        ],
                      ),
                      Visibility(
                        child: Container(
                          margin: EdgeInsets.only(top: height(3),bottom: width(4)),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  alignment: Alignment.center,
                                  child: widget.csProMatchItem!.csProYaPan !=
                                          null
                                      ? Text(
                                          CSClassStringUtils.csMethodSqlitZero(
                                                  widget
                                                      .csProMatchItem
                                                      !.csProYaPan
                                                      !.csProWinOddsOne!)+
                                              " / " +
                                              widget.csProMatchItem!.csProYaPan
                                                  !.csProAddScoreDesc! +
                                              " /" +
                                              CSClassStringUtils.csMethodSqlitZero(
                                                  widget
                                                      .csProMatchItem
                                                      !.csProYaPan
                                                      !.csProWinOddsTwo!),
                                          style:
                            TextStyle(
                                color: Color(0xFF999999),fontSize: sp(11),),
                                        )
                                      : SizedBox(),
                                ),
                              ),
                              ((widget.csProMatchItem!.csProVideoUrl != null &&
                                          widget.csProMatchItem!.csProVideoUrl!
                                              .isNotEmpty) &&
                                      CSClassMatchDataUtils.csMethodShowLive(
                                          widget.csProMatchItem!.status!) &&
                                      widget
                                          .csProMatchItem!.csProOtScore!.isEmpty)
                                  ? Container(
                                      width: width(15),
                                      child: Image.asset(
                                        CSClassImageUtil.csMethodGetImagePath(
                                            "ic_match_live"),
                                        width: width(15),
                                      ),
                                    )
                                  : SizedBox(),
                              Visibility(
                                child: Text(
                                  widget.csProMatchItem!.csProOtScore!,
                                  style: TextStyle(
                                      fontSize: sp(11),
                                      color: Color(0xFF999999)),
                                ),
                                visible: widget
                                    .csProMatchItem!.csProOtScore!.isNotEmpty,
                              ),
                              Expanded(
                                child: Container(
                                  alignment: Alignment.center,
                                  child: widget.csProMatchItem!.csProDaXiao !=
                                          null
                                      ? Text(
                                          CSClassStringUtils.csMethodSqlitZero(
                                                  widget
                                                      .csProMatchItem
                                                      !.csProDaXiao
                                                      !.csProWinOddsOne!) +
                                              " /" +
                                              CSClassStringUtils.csMethodSqlitZero(
                                                  widget.csProMatchItem
                                                      !.csProMidScore!) +
                                              "球 /" +
                                              CSClassStringUtils.csMethodSqlitZero(
                                                  widget
                                                      .csProMatchItem
                                                      !.csProDaXiao
                                                      !.csProWinOddsTwo!),
                                          style:
                                   TextStyle(
                                       fontSize: sp(11),
                                      color: Color(0xFF999999)),
                                        )
                                      : SizedBox(),
                                ),
                              )
                            ],
                          ),
                        ),
                        visible: CSClassMatchListSettingPageState.SHOW_PANKOU,
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: width(15)),
                  alignment: Alignment.centerLeft,
                  child: CSClassMatchDataUtils.csMethodCanAddScheme(
                      widget.csProMatchItem!.csProCanAddScheme!,
                      widget.csProMatchItem!.csProMatchType!,
                      widget.csProMatchItem!.status!)
                      ? GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    child:
                    Container(
                      padding: EdgeInsets.only(top: width(5),),
                      child: Image.asset(
                        CSClassImageUtil.csMethodGetImagePath("fabu"),
                        width: width(42),
                      ),
                    ),
                    onTap: () {
                      var csProGuessMatch =
                      CSClassSchemeGuessMatch2.newObject(
                          widget.csProMatchItem!.csProGuessMatchId,
                          widget.csProMatchItem!.csProLeagueName,
                          widget.csProMatchItem!.csProTeamOne,
                          widget.csProMatchItem!.csProTeamTwo,
                          widget.csProMatchItem!.csProStTime);
                      CSClassNavigatorUtils.csMethodPushRoute(
                          context,
                          CSClassPublicSchemePage(
                            csProGuessMatch: csProGuessMatch,
                          ));
                    },
                  )
                      : SizedBox(
                    width: width(45),
                  ),
                )

              ],
            ),
          ),
        ],
      ),
    );
  }

  void csMethodOnfresh(List<CSClassGuessMatchInfo> matchs) {
    var item = matchs.firstWhere(
        (item) =>
            (item.csProGuessMatchId == widget.csProMatchItem!.csProGuessMatchId!),
        orElse: () => new CSClassGuessMatchInfo());
    if (item != null) {
      widget.csProMatchItem = item;
      setState(() {});
    }
  }
}
