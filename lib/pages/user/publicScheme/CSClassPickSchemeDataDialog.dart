
import 'package:changshengh5/api/CSClassApiManager.dart';
import 'package:changshengh5/api/CSClassHttpCallBack.dart';
import 'package:changshengh5/app/CSClassApplicaion.dart';
import 'package:changshengh5/model/CSClassListEntity.dart';
import 'package:changshengh5/model/CSClassSchemeGuessMatch2.dart';
import 'package:changshengh5/pages/dialogs/CSClassBottomPickAndSearchList.dart';
import 'package:changshengh5/utils/CSClassCommonMethods.dart';
import 'package:changshengh5/utils/CSClassDateUtils.dart';
import 'package:changshengh5/utils/CSClassImageUtil.dart';
import 'package:changshengh5/utils/CSClassMatchDataUtils.dart';
import 'package:changshengh5/utils/CSClassToastUtils.dart';
import 'package:changshengh5/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pickers/pickers.dart';


class CSClassPickSchemeDataDialog extends StatefulWidget {
  CSClassSchemeGuessMatch2 ?csProGuessMatch;
  ValueChanged<CSClassSchemeGuessMatch2>  ?changed;

  CSClassPickSchemeDataDialog(this.changed,{this.csProGuessMatch});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CSClassPickSchemeDataDialogState();
  }
}

class CSClassPickSchemeDataDialogState extends State<CSClassPickSchemeDataDialog> {
  var csProMatchTime = "";
  var LeagueName = "";
   CSClassSchemeGuessMatch2 ?csProGuessMatch ;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    csProMatchTime = CSClassDateUtils.dateFormatByDate(DateTime.now(), "yyyy-MM-dd");
    if(widget.csProGuessMatch!=null){
      csProGuessMatch=widget.csProGuessMatch;
      LeagueName=widget.csProGuessMatch!.csProLeagueName!;
      csProMatchTime=CSClassDateUtils.csMethodDateFormatByString(csProGuessMatch!.csProStTime!, "yyyy-MM-dd");
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(
      child: GestureDetector(
        child: Dialog(
          elevation: 0,
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.zero,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ClipRRect(
                borderRadius:
                BorderRadius.circular(width(12)),
                child: Container(
                  width: width(300),
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(horizontal: width(23)),
                        height: width(46),
                        width: width(300),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                "选择赛事球队",
                                style: TextStyle(color:Color(0xFF333333),fontWeight: FontWeight.w500,fontSize: sp(17),),textAlign: TextAlign.center,
                              ),
                            ),
                            GestureDetector(
                              onTap: (){
                                Navigator.pop(context);
                              },
                              child: Image.asset(
                                CSClassImageUtil.csMethodGetImagePath("close"),
                                width: width(17),
                              ),
                            ),
                          ],
                        ),
                        decoration: BoxDecoration(
                            color: Color(0xFFEEEEEE),
                            borderRadius: BorderRadius.vertical(
                                top:
                                Radius.circular(width(7)))),
                      ),
                      Container(
                        width: width(300),
                        padding: EdgeInsets.symmetric(horizontal: width(24)),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    width: 0.4, color: Colors.grey[300]!))),
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: width(20),
                            ),
                            Row(
                              children: <Widget>[
                                Text(
                                  "比赛时间",
                                  style: TextStyle(
                                      color: Color(0xFF333333),
                                      fontSize: sp(14)),
                                )
                              ],
                            ),
                            SizedBox(
                              height: width(8),
                            ),
                            GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              child: Container(
                                  height: width(35),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 0.5, color: Color(0xFFA8A8A8)),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(
                                            150)),
                                  ),
                                  child: Text(
                                    csProMatchTime,
                                    style:TextStyle(color:Color(0xFF333333),fontSize: sp(13),fontWeight: FontWeight.w500,),

                                  )),
                              onTap: () {

                                Pickers.showDatePicker(
                                  context,
                                  onConfirm: (p) {
                                    csProMatchTime ="${p.year}-${p.month!<10?'0${p.month}':p.month}-${p.day}";
                                    LeagueName="";
                                    csProGuessMatch=null;
                                  },
                                );
                              },
                            ),

                            SizedBox(
                              height: width(18),
                            ),
                            Row(
                              children: <Widget>[
                                Text(
                                  "联赛名",
                                  style: TextStyle(
                                      color: Color(0xFF333333),
                                      fontSize: sp(14)),
                                )
                              ],
                            ),
                            SizedBox(
                              height: width(8),
                            ),
                            GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              child: Container(
                                  height: width(35),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 0.5, color: Color(0xFFA8A8A8)),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(
                                            150)),
                                  ),
                                  child: Text(
                                    LeagueName,
                                    style: TextStyle(color:Color(0xFF333333),fontSize: sp(13),fontWeight: FontWeight.w500),
                                  )),
                              onTap: () {
                                CSClassApiManager.csMethodGetInstance().csMethodSchemeLeagueOfDate<CSClassListEntity<String>>(context: context,queryParameters: {
                                  "match_type":CSClassMatchDataUtils.csMethodExpertTypeToMatchType(CSClassApplicaion.csProUserLoginInfo!.csProExpertMatchType!),"date":csProMatchTime
                                },csProCallBack: CSClassHttpCallBack(
                                    csProOnSuccess: (value){
                                      showCupertinoModalPopup(context: context, builder:
                                          (c)=>CSClassBottomPickAndSearchList(csProDialogTitle: "联赛",list: value.csProDataList,changed: (index){
                                        setState(() {
                                          LeagueName=value.csProDataList[index];
                                          csProGuessMatch=null;
                                        });
                                      },));
                                    },onError: (e){},csProOnProgress: (v){}
                                ));
                              },
                            ),

                            SizedBox(
                              height: width(18),
                            ),
                            Row(
                              children: <Widget>[
                                Text(
                                  "比赛队伍",
                                  style: TextStyle(
                                      color: Color(0xFF333333),
                                      fontSize: sp(14)),
                                )
                              ],
                            ),
                            SizedBox(
                              height: width(8),
                            ),
                            GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              child: Container(
                                  height: width(35),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 0.5, color: Color(0xFFA8A8A8)),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(
                                            150)),
                                  ),
                                  child: Text(
                                    csProGuessMatch!=null ? (csProGuessMatch!.csProTeamOne!+ " vs "+csProGuessMatch!.csProTeamTwo!):"",
                                    style: TextStyle(color:Color(0xFF333333),fontSize: sp(13),fontWeight: FontWeight.w500),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  )),
                              onTap: () {
                                if(LeagueName.isEmpty){
                                  CSClassToastUtils.csMethodShowToast(msg: "请选择联赛");
                                  return ;
                                }
                                CSClassApiManager.csMethodGetInstance().csMethodSchemeGuessMatchList<CSClassSchemeGuessMatch2>(context: context,queryParameters: {
                                  "match_type":CSClassMatchDataUtils.csMethodExpertTypeToMatchType(CSClassApplicaion.csProUserLoginInfo!.csProExpertMatchType!),"date":csProMatchTime,
                                  "league_name":LeagueName

                                },csProCallBack: CSClassHttpCallBack(
                                    csProOnSuccess: (value){
                                      showCupertinoModalPopup(context: context, builder:
                                          (c)=>CSClassBottomPickAndSearchList(csProDialogTitle: "队伍",list: value.csProDataList.map((e) =>
                                      (CSClassDateUtils.csMethodDateFormatByString(e.csProStTime!, "HH:ss") + " "+e.csProTeamOne!+" vs "+e.csProTeamTwo!)).toList(),
                                        changed: (index){
                                          setState(() {
                                            csProGuessMatch=value.csProDataList[index];
                                          });
                                        },));
                                    },onError: (v){},csProOnProgress: (v){}
                                ));
                              },
                            ),


                          ],
                        ),
                      ),
                      SizedBox(
                        height: width(46),
                      ),
                      Container(
                        height: width(45),
                        child: Row(
                          children: <Widget>[
                            Flexible(
                              flex: 1,
                              fit: FlexFit.tight,
                              child: GestureDetector(
                                behavior:HitTestBehavior.opaque,
                                child: Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color:(LeagueName.isNotEmpty&&csProGuessMatch!=null)?  MyColors.main1:Color(0xFFF2F2F2),
                                      borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(
                                              width(7)))),
                                  height: height(45),
                                  child: Text(
                                    "确定",
                                    style: TextStyle(
                                        fontSize: sp(17),
                                        color: Colors.white),
                                  ),
                                ),
                                onTap: ()  {
                                  if((LeagueName.isNotEmpty&&csProGuessMatch!=null)){
                                    csProGuessMatch!.csProLeagueName=LeagueName;
                                    Navigator.of(context).pop();
                                    widget.changed!(csProGuessMatch!);
                                  }else{
                                    CSClassToastUtils.csMethodShowToast(msg: "请完善相关信息");
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        onTap: () {
          Navigator.of(context).pop();
        },
      ),
      onWillPop: () async {
        return true;
      },
    );
  }
}
