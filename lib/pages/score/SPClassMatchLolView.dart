import 'dart:io';

import 'package:changshengh5/api/SPClassApiManager.dart';
import 'package:changshengh5/api/SPClassHttpCallBack.dart';
import 'package:changshengh5/app/SPClassApplicaion.dart';
import 'package:changshengh5/model/SPClassGuessMatchInfo.dart';
import 'package:changshengh5/utils/SPClassCommonMethods.dart';
import 'package:changshengh5/utils/SPClassDateUtils.dart';
import 'package:changshengh5/utils/SPClassImageUtil.dart';
import 'package:changshengh5/utils/SPClassMatchDataUtils.dart';
import 'package:changshengh5/utils/SPClassStringUtils.dart';
import 'package:flutter/material.dart';


class SPClassMatchLolView extends StatefulWidget {
  SPClassGuessMatchInfo spProMatchItem;
  bool spProShwoGroupName;
  bool spProShowLeagueName;

  SPClassMatchLolView(this.spProMatchItem,
      {this.spProShwoGroupName: false, this.spProShowLeagueName: true});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SPClassMatchLolViewState();
  }
}

class SPClassMatchLolViewState extends State<SPClassMatchLolView> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var durationLast;
    if (widget.spProMatchItem.spProIsOver == "1" &&
        widget.spProMatchItem.battles != null) {
      durationLast = Duration(
              seconds: int.parse(widget.spProMatchItem
                  .battles[widget.spProMatchItem.battles.length - 1].duration!))
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
                            widget.spProShowLeagueName
                                ? Container(
                                    margin: EdgeInsets.only(left: width(7)),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: width(5)),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: SPClassMatchDataUtils
                                            .spFunLeagueNameColor(
                                                widget.spProShwoGroupName
                                                    ? widget.spProMatchItem
                                                        .spProGroupName!
                                                    : widget.spProMatchItem
                                                        .spProLeagueName!),
                                        borderRadius:
                                            BorderRadius.circular(width(3))),
                                    constraints: BoxConstraints(
                                      minWidth: width(40),
                                    ),
                                    child: Text(
    (" "+(SPClassStringUtils.spFunIsNum(widget.spProMatchItem.spProLeagueName!.substring(0, 4)) ? widget.spProMatchItem.spProLeagueName!.substring(4).trim() : widget.spProMatchItem.spProLeagueName!)),
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
                              widget.spProMatchItem.spProBoNum == "0"
                                  ? ""
                                  : ("BO"+widget.spProMatchItem.spProBoNum!),
                              style: TextStyle(
                                  fontSize: sp(11), color: Color(0xFF333333)),
                            ),
                            SizedBox(
                              width: width(3),
                            ),
                            Text(
                              SPClassDateUtils.spFunDateFormatByString(
                                  widget.spProMatchItem.spProStTime!, "HH:mm"),
                              style: TextStyle(
                                  fontSize: sp(11), color: Color(0xFF999999)),
                            ),
                          ],
                        ),
                      ),
                      widget.spProMatchItem.spProHalfScore!.isNotEmpty
                          ? Text(
                              "半" + widget.spProMatchItem.spProHalfScore!,
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
                      gradient: SPClassMatchDataUtils.spFunShowLive(
                              widget.spProMatchItem.status!)
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
                          (widget.spProMatchItem.spProIsOver == "1" &&
                                  durationLast != null)
                              ? SPClassStringUtils.spFunSqlitZero(durationLast)
                              : SPClassStringUtils.spFunMatchStatusString(widget.spProMatchItem.spProIsOver == "1", widget.spProMatchItem.spProStatusDesc!, widget.spProMatchItem.spProStTime, status: widget.spProMatchItem.status),
                          style: TextStyle(
                              color: SPClassMatchDataUtils.spFunShowLive(
                                      widget.spProMatchItem.status!)
                                  ? Colors.white
                                  : Color(0xFF999999),
                              fontSize: sp(10)),
                        ),
                      ),
                      SPClassStringUtils.spFunIsNum(
                              widget.spProMatchItem.spProStatusDesc!)
                          ? Positioned(
                              right: 0,
                              top: 3,
                              child: Image.asset(
                                SPClassImageUtil.spFunGetImagePath("gf_minute",
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
                            widget.spProMatchItem.corner!.isNotEmpty
                                ? Image.asset(
                                    SPClassImageUtil.spFunGetImagePath(
                                        "ic_coner_score"),
                                    width: width(11),
                                  )
                                : SizedBox(),
                            Text(
                              widget.spProMatchItem.corner!,
                              style: TextStyle(
                                  color: Color(0xFF999999), fontSize: sp(11)),
                            )
                          ],
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          Image.asset(
                            ((widget.spProMatchItem.spProVideoUrl != null &&
                                        widget.spProMatchItem.spProVideoUrl
                                            !.isNotEmpty) &&
                                    SPClassMatchDataUtils.spFunShowLive(
                                        widget.spProMatchItem.status!))
                                ? SPClassImageUtil.spFunGetImagePath(
                                    "ic_match_live")
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
                                SPClassImageUtil.spFunGetImagePath(
                                    'ic_btn_score_colloect'),
                                width: width(16),
                                color: widget.spProMatchItem.collected == "1"
                                    ? null
                                    : Colors.grey[300],
                              ),
                            ),
                            onTap: () {
                              if (spFunIsLogin(context: context)) {
                                if (!(widget.spProMatchItem.collected == "1")) {
                                  SPClassApiManager.spFunGetInstance()
                                      .spFunCollectMatch(
                                          matchId: widget
                                              .spProMatchItem.spProGuessMatchId,
                                          context: context,
                                          spProCallBack: SPClassHttpCallBack(
                                              spProOnSuccess: (result) {
                                            if (mounted) {
                                              setState(() {
                                                widget.spProMatchItem
                                                    .collected = "1";
                                              });
                                            }
                                          },onError: (e){},spProOnProgress: (v){}
                                          ));
                                } else {
                                  SPClassApiManager.spFunGetInstance()
                                      .spFunDelUserMatch(
                                          matchId: widget
                                              .spProMatchItem.spProGuessMatchId,
                                          context: context,
                                          spProCallBack: SPClassHttpCallBack(
                                              spProOnSuccess: (result) {
                                            if (mounted) {
                                              setState(() {
                                                widget.spProMatchItem
                                                    .collected = "0";
                                              });
                                            }
                                          },onError: (e){},spProOnProgress: (v){}
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
                      SPClassStringUtils.spFunIsEmpty(
                              widget.spProMatchItem.spProIconUrlOne!)
                          ? Image.asset(
                              SPClassImageUtil.spFunGetImagePath(
                                  "ic_lol_match"),
                              height: width(15),
                            )
                          : Image.network(
                              widget.spProMatchItem.spProIconUrlOne!,
                              width: width(21),
                            ),
                      SizedBox(
                        width: width(3),
                      ),
                      Expanded(
                        child: Text(
                          widget.spProMatchItem.spProTeamOne!,
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
                    widget.spProMatchItem.spProScoreOne!,
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
                  child: (widget.spProMatchItem.spProBattleStats != null &&
                          widget.spProMatchItem.spProBattleStats.length > 0 &&
                          widget
                                  .spProMatchItem
                                  .spProBattleStats[widget.spProMatchItem
                                          .spProBattleStats.length -
                                      1]
                                  .spProTeamOne !=
                              null)
                      ? Row(
                          children: <Widget>[
                            Expanded(
                              flex: 2,
                              child: Center(
                                child: Text(
                                  widget.spProMatchItem.spProBattleStats[widget.spProMatchItem.spProBattleStats.length - 1].spProTeamOne!.spProKillNum!,
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
                                  widget.spProMatchItem.spProBattleStats[widget.spProMatchItem.spProBattleStats.length - 1].spProTeamOne!.spProPushTowerNum!,
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
                                  widget.spProMatchItem.spProBattleStats[widget.spProMatchItem.spProBattleStats.length - 1].spProTeamOne!.spProSmallDragonNum!,
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
                                  widget.spProMatchItem.spProBattleStats[widget.spProMatchItem.spProBattleStats.length - 1].spProTeamOne!.spProBigDragonNum!,
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
                                  ("+"+SPClassStringUtils.spFunNumK(widget.spProMatchItem.spProBattleStats[widget.spProMatchItem.spProBattleStats.length - 1].spProTeamOne!.spProMoney!)),
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
                      SPClassStringUtils.spFunIsEmpty(
                              widget.spProMatchItem.spProIconUrlTwo!)
                          ? Image.asset(
                              SPClassImageUtil.spFunGetImagePath(
                                  "ic_lol_match"),
                              height: width(15),
                            )
                          : Image.network(
                              widget.spProMatchItem.spProIconUrlTwo!,
                              width: width(21),
                            ),
                      SizedBox(
                        width: width(3),
                      ),
                      Expanded(
                        child: Text(
                          widget.spProMatchItem.spProTeamTwo!,
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
                    widget.spProMatchItem.spProScoreTwo!,
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
                  child: (widget.spProMatchItem.spProBattleStats != null &&
                          widget.spProMatchItem.spProBattleStats.length > 0 &&
                          widget
                                  .spProMatchItem
                                  .spProBattleStats[widget.spProMatchItem
                                          .spProBattleStats.length -
                                      1]
                                  .spProTeamTwo !=
                              null)
                      ? Row(
                          children: <Widget>[
                            Expanded(
                              flex: 2,
                              child: Center(
                                child: Text(
                                  widget.spProMatchItem.spProBattleStats[widget.spProMatchItem.spProBattleStats.length - 1].spProTeamTwo!.spProKillNum!,
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
                                  widget.spProMatchItem.spProBattleStats[widget.spProMatchItem.spProBattleStats.length - 1].spProTeamTwo!.spProPushTowerNum!,
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
                                  widget.spProMatchItem.spProBattleStats[widget.spProMatchItem.spProBattleStats.length - 1].spProTeamTwo!.spProSmallDragonNum!,
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
                                  widget.spProMatchItem.spProBattleStats[widget.spProMatchItem.spProBattleStats.length - 1].spProTeamTwo!.spProBigDragonNum!,
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
    ("+"+SPClassStringUtils.spFunNumK(widget.spProMatchItem.spProBattleStats[widget.spProMatchItem.spProBattleStats.length - 1].spProTeamTwo!.spProMoney!)),
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
          (widget.spProMatchItem.spProBattleStats != null &&
                  widget.spProMatchItem.spProBattleStats.length > 1)
              ? Column(
                  children: (widget.spProMatchItem.spProBattleStats.sublist(
                          0, widget.spProMatchItem.spProBattleStats.length - 1))
                      .map((item) {
                    var duration = Duration(
                            seconds: int.parse(widget.spProMatchItem.battles
                                .firstWhere((find) =>
                                    find.spProBattleIndex ==
                                    item.spProTeamOne!.spProBattleIndex)
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
                              ("第"+item.spProTeamOne!.spProBattleIndex!+"局"),
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
                                            item.spProTeamOne!.spProIsWin! == "1"
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
                                                  .spProMatchItem.spProTeamOne!,
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
                                      Text(" "+item.spProTeamOne!.spProKillNum!,
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
                                      Text(item.spProTeamTwo!.spProKillNum!+" ",
                                          style: TextStyle(
                                            color: Color(0xFF333333),
                                            fontSize: sp(11),
                                          )),
                                      Text(
                                        widget.spProMatchItem.spProTeamTwo!,
                                        style: TextStyle(
                                          color: Color(0xFF333333),
                                          fontSize: sp(11),
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      item.spProTeamTwo!.spProIsWin! == "1"
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
                                            SPClassStringUtils.spFunSqlitZero(duration)+" "),
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
