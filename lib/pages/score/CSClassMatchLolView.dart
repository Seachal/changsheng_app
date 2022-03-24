import 'dart:io';

import 'package:changshengh5/api/CSClassApiManager.dart';
import 'package:changshengh5/api/CSClassHttpCallBack.dart';
import 'package:changshengh5/app/CSClassApplicaion.dart';
import 'package:changshengh5/model/CSClassGuessMatchInfo.dart';
import 'package:changshengh5/utils/CSClassCommonMethods.dart';
import 'package:changshengh5/utils/CSClassDateUtils.dart';
import 'package:changshengh5/utils/CSClassImageUtil.dart';
import 'package:changshengh5/utils/CSClassMatchDataUtils.dart';
import 'package:changshengh5/utils/CSClassStringUtils.dart';
import 'package:flutter/material.dart';


class CSClassMatchLolView extends StatefulWidget {
  CSClassGuessMatchInfo csProMatchItem;
  bool csProShwoGroupName;
  bool csProShowLeagueName;

  CSClassMatchLolView(this.csProMatchItem,
      {this.csProShwoGroupName: false, this.csProShowLeagueName: true});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CSClassMatchLolViewState();
  }
}

class CSClassMatchLolViewState extends State<CSClassMatchLolView> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var durationLast;
    if (widget.csProMatchItem.csProIsOver == "1" &&
        widget.csProMatchItem.battles != null) {
      durationLast = Duration(
              seconds: int.parse(widget.csProMatchItem
                  .battles[widget.csProMatchItem.battles.length - 1].duration!))
          .toString();
      if (durationLast.startsWith("0:")) {
        durationLast = durationLast.substring(2);
      }
    }
    return Container(
      margin: EdgeInsets.only(top: width(3), right: width(3), left: width(3)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(width(3)),
        color: Colors.white,
      ),
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: width(3), bottom: width(3)),
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(width: 0.4, color: Colors.grey[300]!))),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Row(
                          children: <Widget>[
                            widget.csProShowLeagueName
                                ? Container(
                                    margin: EdgeInsets.only(left: width(7)),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: width(5)),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: CSClassMatchDataUtils
                                            .csMethodLeagueNameColor(
                                                widget.csProShwoGroupName
                                                    ? widget.csProMatchItem
                                                        .csProGroupName!
                                                    : widget.csProMatchItem
                                                        .csProLeagueName!),
                                        borderRadius:
                                            BorderRadius.circular(width(3))),
                                    constraints: BoxConstraints(
                                      minWidth: width(40),
                                    ),
                                    child: Text(
    (" "+(CSClassStringUtils.csMethodIsNum(widget.csProMatchItem.csProLeagueName!.substring(0, 4)) ? widget.csProMatchItem.csProLeagueName!.substring(4).trim() : widget.csProMatchItem.csProLeagueName!)),
                                      style: TextStyle(
                                          fontSize: sp(10.5),
                                          color: Colors.white),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  )
                                : SizedBox(),
                            SizedBox(
                              width: width(3),
                            ),
                            Text(
                              widget.csProMatchItem.csProBoNum == "0"
                                  ? ""
                                  : ("BO"+widget.csProMatchItem.csProBoNum!),
                              style: TextStyle(
                                  fontSize: sp(11), color: Color(0xFF333333)),
                            ),
                            SizedBox(
                              width: width(3),
                            ),
                            Text(
                              CSClassDateUtils.csMethodDateFormatByString(
                                  widget.csProMatchItem.csProStTime!, "HH:mm"),
                              style: TextStyle(
                                  fontSize: sp(11), color: Color(0xFF999999)),
                            ),
                          ],
                        ),
                      ),
                      widget.csProMatchItem.csProHalfScore!.isNotEmpty
                          ? Text(
                              "半" + widget.csProMatchItem.csProHalfScore!,
                              style: TextStyle(
                                  fontSize: sp(11), color: Color(0xFF999999)),
                            )
                          : SizedBox(),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: width(1)),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(300),
                      gradient: CSClassMatchDataUtils.csMethodShowLive(
                              widget.csProMatchItem.status!)
                          ? LinearGradient(colors: [
                              Color(0xFF42CAFC),
                              Color(0xFF21A7EF),
                            ])
                          : null),
                  alignment: Alignment.center,
                  child: Stack(
                    children: <Widget>[
                      Container(
                        padding:
                            EdgeInsets.only(left: width(6), right: width(6)),
                        child: Text(
                          (widget.csProMatchItem.csProIsOver == "1" &&
                                  durationLast != null)
                              ? CSClassStringUtils.csMethodSqlitZero(durationLast)
                              : CSClassStringUtils.csMethodMatchStatusString(widget.csProMatchItem.csProIsOver == "1", widget.csProMatchItem.csProStatusDesc!, widget.csProMatchItem.csProStTime, status: widget.csProMatchItem.status),
                          style: TextStyle(
                              color: CSClassMatchDataUtils.csMethodShowLive(
                                      widget.csProMatchItem.status!)
                                  ? Colors.white
                                  : Color(0xFF999999),
                              fontSize: sp(10)),
                        ),
                      ),
                      CSClassStringUtils.csMethodIsNum(
                              widget.csProMatchItem.csProStatusDesc!)
                          ? Positioned(
                              right: 0,
                              top: 3,
                              child: Image.asset(
                                CSClassImageUtil.csMethodGetImagePath("gf_minute",
                                    format: ".gif"),
                                color: Colors.white,
                              ),
                            )
                          : SizedBox()
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Row(
                          children: <Widget>[
                            widget.csProMatchItem.corner!.isNotEmpty
                                ? Image.asset(
                                    CSClassImageUtil.csMethodGetImagePath(
                                        "cs_coner_score"),
                                    width: width(11),
                                  )
                                : SizedBox(),
                            Text(
                              widget.csProMatchItem.corner!,
                              style: TextStyle(
                                  color: Color(0xFF999999), fontSize: sp(11)),
                            )
                          ],
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          Image.asset(
                            ((widget.csProMatchItem.csProVideoUrl != null &&
                                        widget.csProMatchItem.csProVideoUrl
                                            !.isNotEmpty) &&
                                    CSClassMatchDataUtils.csMethodShowLive(
                                        widget.csProMatchItem.status!))
                                ? CSClassImageUtil.csMethodGetImagePath(
                                    "cs_match_live")
                                : "",
                            width: width(15),
                          ),
                          GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            child: Container(
                              padding: EdgeInsets.all(4),
                              width: width(36),
                              alignment: Alignment.center,
                              child: Image.asset(
                                CSClassImageUtil.csMethodGetImagePath(
                                    'cs_btn_score_colloect'),
                                width: width(16),
                                color: widget.csProMatchItem.collected == "1"
                                    ? null
                                    : Colors.grey[300],
                              ),
                            ),
                            onTap: () {
                              if (csMethodIsLogin(context: context)) {
                                if (!(widget.csProMatchItem.collected == "1")) {
                                  CSClassApiManager.csMethodGetInstance()
                                      .csMethodCollectMatch(
                                          matchId: widget
                                              .csProMatchItem.csProGuessMatchId,
                                          context: context,
                                          csProCallBack: CSClassHttpCallBack(
                                              csProOnSuccess: (result) {
                                            if (mounted) {
                                              setState(() {
                                                widget.csProMatchItem
                                                    .collected = "1";
                                              });
                                            }
                                          },onError: (e){},csProOnProgress: (v){}
                                          ));
                                } else {
                                  CSClassApiManager.csMethodGetInstance()
                                      .csMethodDelUserMatch(
                                          matchId: widget
                                              .csProMatchItem.csProGuessMatchId,
                                          context: context,
                                          csProCallBack: CSClassHttpCallBack(
                                              csProOnSuccess: (result) {
                                            if (mounted) {
                                              setState(() {
                                                widget.csProMatchItem
                                                    .collected = "0";
                                              });
                                            }
                                          },onError: (e){},csProOnProgress: (v){}
                                          ));
                                }
                              }
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: width(5)),
            child: Row(
              children: <Widget>[
                SizedBox(
                  width: width(117),
                ),
                Container(
                  width: width(30),
                  alignment: Alignment.center,
                  child: Text(
                    "比分",
                    style:
                        TextStyle(color: Color(0xFF333333), fontSize: sp(11)),
                  ),
                ),
                SizedBox(
                  width: width(42),
                ),
                Expanded(
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 2,
                        child: Center(
                          child: Text(
                            "击杀",
                            style: TextStyle(
                                color: Color(0xFF333333), fontSize: sp(11)),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Center(
                          child: Text(
                            "推搭",
                            style: TextStyle(
                                color: Color(0xFF333333), fontSize: sp(11)),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Center(
                          child: Text(
                            "小龙",
                            style: TextStyle(
                                color: Color(0xFF333333), fontSize: sp(11)),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Center(
                          child: Text(
                            "大龙",
                            style: TextStyle(
                                color: Color(0xFF333333), fontSize: sp(11)),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Center(
                          child: Text(
                            "经济",
                            style: TextStyle(
                                color: Color(0xFF333333), fontSize: sp(11)),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            child: Row(
              children: <Widget>[
                Container(
                  width: width(117),
                  child: Row(
                    children: <Widget>[
                      SizedBox(
                        width: width(10),
                      ),
                      CSClassStringUtils.csMethodIsEmpty(
                              widget.csProMatchItem.csProIconUrlOne!)
                          ? Image.asset(
                              CSClassImageUtil.csMethodGetImagePath(
                                  "cs_lol_match"),
                              height: width(15),
                            )
                          : Image.network(
                              widget.csProMatchItem.csProIconUrlOne!,
                              width: width(21),
                            ),
                      SizedBox(
                        width: width(3),
                      ),
                      Expanded(
                        child: Text(
                          widget.csProMatchItem.csProTeamOne!,
                          style: TextStyle(fontSize: sp(13),
                            fontWeight: FontWeight.w500,),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  width: width(30),
                  child: Text(
                    widget.csProMatchItem.csProScoreOne!,
                    style: TextStyle(
                        color: Color(0xFFDE3C31),
                        fontWeight: FontWeight.w600,
                        fontSize: sp(15)),
                  ),
                ),
                SizedBox(
                  width: width(42),
                ),
                Expanded(
                  child: (widget.csProMatchItem.csProBattleStats != null &&
                          widget.csProMatchItem.csProBattleStats.length > 0 &&
                          widget
                                  .csProMatchItem
                                  .csProBattleStats[widget.csProMatchItem
                                          .csProBattleStats.length -
                                      1]
                                  .csProTeamOne !=
                              null)
                      ? Row(
                          children: <Widget>[
                            Expanded(
                              flex: 2,
                              child: Center(
                                child: Text(
                                  widget.csProMatchItem.csProBattleStats[widget.csProMatchItem.csProBattleStats.length - 1].csProTeamOne!.csProKillNum!,
                                  style: TextStyle(
                                      color: Color(0xFF999999),
                                      fontSize: sp(11)),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Center(
                                child: Text(
                                  widget.csProMatchItem.csProBattleStats[widget.csProMatchItem.csProBattleStats.length - 1].csProTeamOne!.csProPushTowerNum!,
                                  style: TextStyle(
                                      color: Color(0xFF999999),
                                      fontSize: sp(11)),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Center(
                                child: Text(
                                  widget.csProMatchItem.csProBattleStats[widget.csProMatchItem.csProBattleStats.length - 1].csProTeamOne!.csProSmallDragonNum!,
                                  style: TextStyle(
                                      color: Color(0xFF999999),
                                      fontSize: sp(11)),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Center(
                                child: Text(
                                  widget.csProMatchItem.csProBattleStats[widget.csProMatchItem.csProBattleStats.length - 1].csProTeamOne!.csProBigDragonNum!,
                                  style: TextStyle(
                                      color: Color(0xFF999999),
                                      fontSize: sp(11)),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Center(
                                child: Text(
                                  ("+"+CSClassStringUtils.csMethodNumK(widget.csProMatchItem.csProBattleStats[widget.csProMatchItem.csProBattleStats.length - 1].csProTeamOne!.csProMoney!)),
                                  style: TextStyle(
                                      color: Color(0xFF999999),
                                      fontSize: sp(11)),
                                ),
                              ),
                            ),
                          ],
                        )
                      : SizedBox(),
                ),
                SizedBox(
                  width: width(6),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: width(2), bottom: width(4)),
            child: Row(
              children: <Widget>[
                Container(
                  width: width(117),
                  child: Row(
                    children: <Widget>[
                      SizedBox(
                        width: width(10),
                      ),
                      CSClassStringUtils.csMethodIsEmpty(
                              widget.csProMatchItem.csProIconUrlTwo!)
                          ? Image.asset(
                              CSClassImageUtil.csMethodGetImagePath(
                                  "cs_lol_match"),
                              height: width(15),
                            )
                          : Image.network(
                              widget.csProMatchItem.csProIconUrlTwo!,
                              width: width(21),
                            ),
                      SizedBox(
                        width: width(3),
                      ),
                      Expanded(
                        child: Text(
                          widget.csProMatchItem.csProTeamTwo!,
                          style:TextStyle( fontSize: sp(13),
                            fontWeight: FontWeight.w500,),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  width: width(30),
                  child: Text(
                    widget.csProMatchItem.csProScoreTwo!,
                    style: TextStyle(
                        color: Color(0xFFDE3C31),
                        fontWeight: FontWeight.w600,
                        fontSize: sp(15)),
                  ),
                ),
                SizedBox(
                  width: width(42),
                ),
                Expanded(
                  child: (widget.csProMatchItem.csProBattleStats != null &&
                          widget.csProMatchItem.csProBattleStats.length > 0 &&
                          widget
                                  .csProMatchItem
                                  .csProBattleStats[widget.csProMatchItem
                                          .csProBattleStats.length -
                                      1]
                                  .csProTeamTwo !=
                              null)
                      ? Row(
                          children: <Widget>[
                            Expanded(
                              flex: 2,
                              child: Center(
                                child: Text(
                                  widget.csProMatchItem.csProBattleStats[widget.csProMatchItem.csProBattleStats.length - 1].csProTeamTwo!.csProKillNum!,
                                  style: TextStyle(
                                      color: Color(0xFF999999),
                                      fontSize: sp(11)),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Center(
                                child: Text(
                                  widget.csProMatchItem.csProBattleStats[widget.csProMatchItem.csProBattleStats.length - 1].csProTeamTwo!.csProPushTowerNum!,
                                  style: TextStyle(
                                      color: Color(0xFF999999),
                                      fontSize: sp(11)),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Center(
                                child: Text(
                                  widget.csProMatchItem.csProBattleStats[widget.csProMatchItem.csProBattleStats.length - 1].csProTeamTwo!.csProSmallDragonNum!,
                                  style: TextStyle(
                                      color: Color(0xFF999999),
                                      fontSize: sp(11)),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Center(
                                child: Text(
                                  widget.csProMatchItem.csProBattleStats[widget.csProMatchItem.csProBattleStats.length - 1].csProTeamTwo!.csProBigDragonNum!,
                                  style: TextStyle(
                                      color: Color(0xFF999999),
                                      fontSize: sp(11)),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Center(
                                child: Text(
    ("+"+CSClassStringUtils.csMethodNumK(widget.csProMatchItem.csProBattleStats[widget.csProMatchItem.csProBattleStats.length - 1].csProTeamTwo!.csProMoney!)),
                                  style: TextStyle(
                                      color: Color(0xFF999999),
                                      fontSize: sp(11)),
                                ),
                              ),
                            ),
                          ],
                        )
                      : SizedBox(),
                ),
                SizedBox(
                  width: width(6),
                ),
              ],
            ),
          ),
          (widget.csProMatchItem.csProBattleStats != null &&
                  widget.csProMatchItem.csProBattleStats.length > 1)
              ? Column(
                  children: (widget.csProMatchItem.csProBattleStats.sublist(
                          0, widget.csProMatchItem.csProBattleStats.length - 1))
                      .map((item) {
                    var duration = Duration(
                            seconds: int.parse(widget.csProMatchItem.battles
                                .firstWhere((find) =>
                                    find.csProBattleIndex ==
                                    item.csProTeamOne!.csProBattleIndex)
                                .duration!))
                        .toString();
                    if (duration.startsWith("0:")) {
                      duration = duration.substring(2);
                    }
                    return Container(
                      decoration: BoxDecoration(
                          border: Border(
                              top: BorderSide(
                                  width: 0.4, color: Colors.grey[300]!))),
                      padding: EdgeInsets.symmetric(horizontal: width(10)),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Row(
                              children: <Widget>[
                                Text(
                              ("第"+item.csProTeamOne!.csProBattleIndex!+"局"),
                                  style: TextStyle(
                                      color: Color(0xFF333333),
                                      fontSize: sp(11)),
                                ),
                                Expanded(
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: <Widget>[
                                            item.csProTeamOne!.csProIsWin! == "1"
                                                ? Container(
                                                    margin: EdgeInsets.only(
                                                        right: width(3)),
                                                    width: width(15),
                                                    height: width(15),
                                                    padding: EdgeInsets.only(
                                                        bottom: width(2)),
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    width(3)),
                                                        color:
                                                            Color(0xFF529F31)),
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      "胜",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: sp(10)),
                                                    ),
                                                  )
                                                : SizedBox(),
                                            Text(
                                              widget
                                                  .csProMatchItem.csProTeamOne!,
                                              style: TextStyle(
                                                color: Color(0xFF333333),
                                                fontSize: sp(11),
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            )
                                          ],
                                        ),
                                      ),
                                      Text(" "+item.csProTeamOne!.csProKillNum!,
                                          style: TextStyle(
                                            color: Color(0xFF333333),
                                            fontSize: sp(11),
                                          )),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text("-",
                              style: TextStyle(
                                  color: Color(0xFF999999), fontSize: sp(11))),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Text(item.csProTeamTwo!.csProKillNum!+" ",
                                          style: TextStyle(
                                            color: Color(0xFF333333),
                                            fontSize: sp(11),
                                          )),
                                      Text(
                                        widget.csProMatchItem.csProTeamTwo!,
                                        style: TextStyle(
                                          color: Color(0xFF333333),
                                          fontSize: sp(11),
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      item.csProTeamTwo!.csProIsWin! == "1"
                                          ? Container(
                                              margin: EdgeInsets.only(
                                                  left: width(3)),
                                              width: width(15),
                                              height: width(15),
                                              padding: EdgeInsets.only(
                                                  bottom: width(2)),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          width(3)),
                                                  color: Color(0xFF529F31)),
                                              alignment: Alignment.center,
                                              child: Text(
                                                "胜",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: sp(10)),
                                              ),
                                            )
                                          : SizedBox(),
                                    ],
                                  ),
                                ),
                                RichText(
                                  text: TextSpan(
                                      style: TextStyle(
                                        color: Color(0xFF333333),
                                        fontSize: sp(10),
                                      ),
                                      text: "总时长: ",
                                      children: [
                                        TextSpan(
                                            style: TextStyle(
                                                color: Color(0xFF999999),
                                                fontSize: sp(10)),
                                            text:
                                            CSClassStringUtils.csMethodSqlitZero(duration)+" "),
                                      ]),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                )
              : SizedBox(),
        ],
      ),
    );
  }
}
