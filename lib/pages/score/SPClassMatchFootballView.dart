import 'package:changshengh5/api/SPClassApiManager.dart';
import 'package:changshengh5/api/SPClassHttpCallBack.dart';
import 'package:changshengh5/app/SPClassApplicaion.dart';
import 'package:changshengh5/model/SPClassGuessMatchInfo.dart';
import 'package:changshengh5/model/SPClassSchemeGuessMatch2.dart';
import 'package:changshengh5/pages/competition/SPClassMatchDetailPage.dart';
import 'package:changshengh5/pages/competition/SPClassMatchListSettingPage.dart';
import 'package:changshengh5/pages/user/publicScheme/SPClassPublicSchemePage.dart';
import 'package:changshengh5/untils/SPClassCommonMethods.dart';
import 'package:changshengh5/untils/SPClassDateUtils.dart';
import 'package:changshengh5/untils/SPClassImageUtil.dart';
import 'package:changshengh5/untils/SPClassMatchDataUtils.dart';
import 'package:changshengh5/untils/SPClassNavigatorUtils.dart';
import 'package:changshengh5/untils/SPClassStringUtils.dart';
import 'package:changshengh5/untils/colors.dart';
import 'package:flutter/material.dart';
import 'package:sprintf/sprintf.dart';


class SPClassMatchFootballView extends StatefulWidget {
  SPClassGuessMatchInfo ?spProMatchItem;
  bool ?spProShwoGroupName;
  bool ?spProShowLeagueName;
  SPClassMatchFootballViewState ?state; 
  
  SPClassMatchFootballView(this.spProMatchItem,
      {this.spProShwoGroupName: false, this.spProShowLeagueName: true});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return state = SPClassMatchFootballViewState();
  }
}

class SPClassMatchFootballViewState extends State<SPClassMatchFootballView> {
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
                widget.spProShowLeagueName!
                    ? Container(
                  width:width(70),
                  child: Text(
                    widget.spProShwoGroupName!
                        ? widget.spProMatchItem!.spProGroupName!
                        : widget
                        .spProMatchItem!.spProLeagueName!,
                    style: TextStyle(
                      fontSize: sp(10),
                      color: SPClassMatchDataUtils
                          .spFunLeagueNameColor(
                          widget.spProShwoGroupName!
                              ? widget.spProMatchItem!
                              .spProGroupName!
                              : widget.spProMatchItem!
                              .spProLeagueName!),
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
                        SPClassDateUtils.spFunDateFormatByString(
                            widget.spProMatchItem!.spProStTime!,
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
                          SPClassStringUtils.spFunMatchStatusString(
                              widget.spProMatchItem!.spProIsOver == "1",
                              widget.spProMatchItem!.spProStatusDesc!,
                              widget.spProMatchItem!.spProStTime,
                              status: widget.spProMatchItem!.status),
                          style: TextStyle(
                              color: DateTime.parse(
                                  widget.spProMatchItem!.spProStTime!)
                                  .difference(DateTime.now())
                                  .inSeconds >
                                  0
                                  ? Color(0xFF999999)
                                  : Color(0xFFF15558),
                              fontSize: sp(12)),
                        ),
                      ),
                      SPClassStringUtils.spFunIsNum(
                          widget.spProMatchItem!.spProStatusDesc!)
                          ? Positioned(
                        right: 0,
                        top: 3,
                        child: Image.asset(
                          SPClassImageUtil.spFunGetImagePath("gf_minute",
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
                            widget.spProMatchItem!.corner!.isNotEmpty
                                ? Image.asset(
                              SPClassImageUtil.spFunGetImagePath(
                                  "ic_coner_score"),
                              width: width(12),
                            )
                                : SizedBox(),
                            Text(
                              "${widget.spProMatchItem!.corner}",
                              style: TextStyle(
                                  color: Color(0xFF999999), fontSize: sp(12)),
                            ),
                            SizedBox(width: width(5),),
                            widget.spProMatchItem!.spProHalfScore!.isNotEmpty
                                ? Text(
                              "半 " + widget.spProMatchItem!.spProHalfScore!,
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
                (widget.spProMatchItem!.spProSchemeNum == null ||
                    int.tryParse(
                        widget.spProMatchItem!.spProSchemeNum!) ==
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
                          widget.spProMatchItem!.spProSchemeNum! +
                              "观点",
                          style: TextStyle(
                              color: Color(0xFF24AAF0),
                              fontSize: sp(12)),
                        ),
                        Image.asset(
                            SPClassImageUtil.spFunGetImagePath(
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
                    SPClassApiManager.spFunGetInstance()
                        .spFunMatchClick(queryParameters: {
                      "match_id":
                      widget.spProMatchItem!.spProGuessMatchId
                    });
                    SPClassNavigatorUtils.spFunPushRoute(
                        context,
                        SPClassMatchDetailPage(
                          widget.spProMatchItem,
                          spProMatchType: "guess_match_id",
                          spProInitIndex: 3,
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
                      SPClassImageUtil.spFunGetImagePath(
                          'ic_btn_score_colloect'),
                      width: width(16),
                      color: widget.spProMatchItem!.collected! == "1"
                          ? MyColors.main1
                          : Colors.grey[300],
                    ),
                  ),
                  onTap: () {
                    if (spFunIsLogin(context: context)) {
                      if (!(widget.spProMatchItem!.collected == "1")) {
                        SPClassApiManager.spFunGetInstance().spFunCollectMatch(
                            matchId: widget.spProMatchItem!.spProGuessMatchId!,
                            context: context,
                            spProCallBack:
                                SPClassHttpCallBack(
                                    spProOnSuccess: (result) {
                              SPClassApplicaion.spProEventBus
                                  .fire("updateFollow");
                              if (mounted) {
                                setState(() {
                                  widget.spProMatchItem!.collected = "1";
                                });
                              }
                            },onError: (e){},spProOnProgress: (v){}
                                ));
                      } else {
                        SPClassApiManager.spFunGetInstance().spFunDelUserMatch(
                            matchId: widget.spProMatchItem!.spProGuessMatchId!,
                            context: context,
                            spProCallBack:
                                SPClassHttpCallBack(
                                    spProOnSuccess: (result) {
                              SPClassApplicaion.spProEventBus
                                  .fire("updateFollow");
                              if (mounted) {
                                setState(() {
                                  widget.spProMatchItem!.collected = "0";
                                });
                              }
                            },onError: (e){},spProOnProgress: (v){}
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
                                (widget.spProMatchItem!.spProRedCard!
                                            .isNotEmpty &&
                                        int.tryParse(widget
                                                .spProMatchItem!.spProRedCard!
                                                .split("-")[0])! >
                                            0 &&
                                        SPClassMatchListSettingPageState
                                            .spProShowRedCard)
                                    ? Container(
                                        padding: EdgeInsets.all(width(1)),
                                        decoration: BoxDecoration(
                                            color: Color(0xFFDA5548),
                                            borderRadius: BorderRadius.circular(
                                                width(2))),
                                        child: Text(
                                          widget.spProMatchItem!.spProRedCard!
                                              .split("-")[0],
                                          style: TextStyle(
                                              color: Colors.white,
                                          fontSize: sp(11),
                                        ),
                                      ),)
                                    : SizedBox(),
                                (widget.spProMatchItem!.spProYellowCard!
                                            .isNotEmpty &&
                                        int.tryParse(widget
                                                .spProMatchItem!.spProYellowCard!
                                                .split("-")[0])! >
                                            0 &&
                                        SPClassMatchListSettingPageState
                                            .spProShowRedCard)
                                    ? Container(
                                        padding: EdgeInsets.all(width(1)),
                                        margin:
                                            EdgeInsets.only(left: 3, right: 3),
                                        decoration: BoxDecoration(
                                            color: Color(0xFFEDB445),
                                            borderRadius: BorderRadius.circular(
                                                width(2))),
                                        child: Text(
                                          widget.spProMatchItem!.spProYellowCard!
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
                                      widget.spProMatchItem!.spProRankingOne
                                    ]),
                                    style: TextStyle(
                                        fontSize: sp(10),
                                        color: Color(0xFF888888)),
                                  ),
                                  visible:
                                      (widget.spProMatchItem!.spProRankingOne !=
                                              null &&
                                          widget.spProMatchItem!.spProRankingOne!
                                              .isNotEmpty),
                                ),
                                Flexible(
                                  child: Text(
                                    widget.spProMatchItem!.spProTeamOne!,
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
                                !SPClassMatchDataUtils.spFunShowScore(
                                        widget.spProMatchItem!.status!)
                                    ? Text(
                                        "VS",
                                        style: TextStyle(
                                          color: Color(0xFF999999),
                                          fontWeight: FontWeight.bold,
                                          fontSize: sp(17),),
                                      )
                                    : Text(
                                        widget.spProMatchItem!.spProScoreOne! +
                                            " - " +
                                            widget.spProMatchItem!.spProScoreTwo!,
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
                                    widget.spProMatchItem!.spProTeamTwo!,
                                    style:TextStyle(fontSize: sp(13),
                                      fontWeight: FontWeight.bold,),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Visibility(
                                  child: Text(
                                    sprintf("[%s] ", [
                                      widget.spProMatchItem!.spProRankingTwo!
                                    ]),
                                    style: TextStyle(
                                        fontSize: sp(10),
                                        color: Color(0xFF888888)),
                                  ),
                                  visible:
                                      (widget.spProMatchItem!.spProRankingTwo !=
                                              null &&
                                          widget.spProMatchItem!.spProRankingTwo!
                                              .isNotEmpty),
                                ),
                                (widget.spProMatchItem!.spProRedCard!
                                            .isNotEmpty &&
                                        int.tryParse(widget
                                                .spProMatchItem!.spProRedCard!
                                                .split("-")[1])! >
                                            0 &&
                                        SPClassMatchListSettingPageState
                                            .spProShowRedCard)
                                    ? Container(
                                        padding: EdgeInsets.all(width(1)),
                                        decoration: BoxDecoration(
                                            color: Color(0xFFDA5548),
                                            borderRadius: BorderRadius.circular(
                                                width(2))),
                                        child: Text(
                                          widget.spProMatchItem!.spProRedCard!
                                              .split("-")[1],
                                          style: TextStyle(
                                              color: Colors.white,
                                          fontSize: sp(11),
                                        ),
                                      ),)
                                    : SizedBox(),
                                (widget.spProMatchItem!.spProYellowCard!
                                            .isNotEmpty &&
                                        int.tryParse(widget
                                                .spProMatchItem!.spProYellowCard!
                                                .split("-")[1])! >
                                            0 &&
                                        SPClassMatchListSettingPageState
                                            .spProShowRedCard)
                                    ? Container(
                                        padding: EdgeInsets.all(width(1)),
                                        margin:
                                            EdgeInsets.only(left: 3, right: 3),
                                        decoration: BoxDecoration(
                                            color: Color(0xFFEDB445),
                                            borderRadius: BorderRadius.circular(
                                                width(2))),
                                        child: Text(
                                          widget.spProMatchItem!.spProYellowCard!
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
                                  child: widget.spProMatchItem!.spProYaPan !=
                                          null
                                      ? Text(
                                          SPClassStringUtils.spFunSqlitZero(
                                                  widget
                                                      .spProMatchItem
                                                      !.spProYaPan
                                                      !.spProWinOddsOne!)+
                                              " / " +
                                              widget.spProMatchItem!.spProYaPan
                                                  !.spProAddScoreDesc! +
                                              " /" +
                                              SPClassStringUtils.spFunSqlitZero(
                                                  widget
                                                      .spProMatchItem
                                                      !.spProYaPan
                                                      !.spProWinOddsTwo!),
                                          style:
                            TextStyle(
                                color: Color(0xFF999999),fontSize: sp(11),),
                                        )
                                      : SizedBox(),
                                ),
                              ),
                              ((widget.spProMatchItem!.spProVideoUrl != null &&
                                          widget.spProMatchItem!.spProVideoUrl!
                                              .isNotEmpty) &&
                                      SPClassMatchDataUtils.spFunShowLive(
                                          widget.spProMatchItem!.status!) &&
                                      widget
                                          .spProMatchItem!.spProOtScore!.isEmpty)
                                  ? Container(
                                      width: width(15),
                                      child: Image.asset(
                                        SPClassImageUtil.spFunGetImagePath(
                                            "ic_match_live"),
                                        width: width(15),
                                      ),
                                    )
                                  : SizedBox(),
                              Visibility(
                                child: Text(
                                  widget.spProMatchItem!.spProOtScore!,
                                  style: TextStyle(
                                      fontSize: sp(11),
                                      color: Color(0xFF999999)),
                                ),
                                visible: widget
                                    .spProMatchItem!.spProOtScore!.isNotEmpty,
                              ),
                              Expanded(
                                child: Container(
                                  alignment: Alignment.center,
                                  child: widget.spProMatchItem!.spProDaXiao !=
                                          null
                                      ? Text(
                                          SPClassStringUtils.spFunSqlitZero(
                                                  widget
                                                      .spProMatchItem
                                                      !.spProDaXiao
                                                      !.spProWinOddsOne!) +
                                              " /" +
                                              SPClassStringUtils.spFunSqlitZero(
                                                  widget.spProMatchItem
                                                      !.spProMidScore!) +
                                              "球 /" +
                                              SPClassStringUtils.spFunSqlitZero(
                                                  widget
                                                      .spProMatchItem
                                                      !.spProDaXiao
                                                      !.spProWinOddsTwo!),
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
                        visible: SPClassMatchListSettingPageState.SHOW_PANKOU,
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: width(15)),
                  alignment: Alignment.centerLeft,
                  child: SPClassMatchDataUtils.spFunCanAddScheme(
                      widget.spProMatchItem!.spProCanAddScheme!,
                      widget.spProMatchItem!.spProMatchType!,
                      widget.spProMatchItem!.status!)
                      ? GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    child:
                    Container(
                      padding: EdgeInsets.only(top: width(5),),
                      child: Image.asset(
                        SPClassImageUtil.spFunGetImagePath("fabu"),
                        width: width(42),
                      ),
                    ),
                    onTap: () {
                      var spProGuessMatch =
                      SPClassSchemeGuessMatch2.newObject(
                          widget.spProMatchItem!.spProGuessMatchId,
                          widget.spProMatchItem!.spProLeagueName,
                          widget.spProMatchItem!.spProTeamOne,
                          widget.spProMatchItem!.spProTeamTwo,
                          widget.spProMatchItem!.spProStTime);
                      SPClassNavigatorUtils.spFunPushRoute(
                          context,
                          SPClassPublicSchemePage(
                            spProGuessMatch: spProGuessMatch,
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

  void spFunOnfresh(List<SPClassGuessMatchInfo> matchs) {
    var item = matchs.firstWhere(
        (item) =>
            (item.spProGuessMatchId == widget.spProMatchItem!.spProGuessMatchId!),
        orElse: () => new SPClassGuessMatchInfo());
    if (item != null) {
      widget.spProMatchItem = item;
      setState(() {});
    }
  }
}
