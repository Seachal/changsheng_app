
import 'package:changshengh5/api/SPClassApiManager.dart';
import 'package:changshengh5/api/SPClassHttpCallBack.dart';
import 'package:changshengh5/app/SPClassApplicaion.dart';
import 'package:changshengh5/model/SPClassListEntity.dart';
import 'package:changshengh5/model/SPClassSchemeGuessMatch2.dart';
import 'package:changshengh5/pages/dialogs/SPClassBottomPickAndSearchList.dart';
import 'package:changshengh5/utils/SPClassCommonMethods.dart';
import 'package:changshengh5/utils/SPClassDateUtils.dart';
import 'package:changshengh5/utils/SPClassImageUtil.dart';
import 'package:changshengh5/utils/SPClassMatchDataUtils.dart';
import 'package:changshengh5/utils/SPClassToastUtils.dart';
import 'package:changshengh5/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pickers/pickers.dart';


class SPClassPickSchemeDataDialog extends StatefulWidget {
  SPClassSchemeGuessMatch2 ?spProGuessMatch;
  ValueChanged<SPClassSchemeGuessMatch2>  ?changed;

  SPClassPickSchemeDataDialog(this.changed,{this.spProGuessMatch});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SPClassPickSchemeDataDialogState();
  }
}

class SPClassPickSchemeDataDialogState extends State<SPClassPickSchemeDataDialog> {
  var spProMatchTime = "";
  var LeagueName = "";
   SPClassSchemeGuessMatch2 ?spProGuessMatch ;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    spProMatchTime = SPClassDateUtils.dateFormatByDate(DateTime.now(), "yyyy-MM-dd");
    if(widget.spProGuessMatch!=null){
      spProGuessMatch=widget.spProGuessMatch;
      LeagueName=widget.spProGuessMatch!.spProLeagueName!;
      spProMatchTime=SPClassDateUtils.spFunDateFormatByString(spProGuessMatch!.spProStTime!, "yyyy-MM-dd");
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
                                SPClassImageUtil.spFunGetImagePath("close"),
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
                                    spProMatchTime,
                                    style:TextStyle(color:Color(0xFF333333),fontSize: sp(13),fontWeight: FontWeight.w500,),

                                  )),
                              onTap: () {

                                Pickers.showDatePicker(
                                  context,
                                  onConfirm: (p) {
                                    spProMatchTime ="${p.year}-${p.month!<10?'0${p.month}':p.month}-${p.day}";
                                    LeagueName="";
                                    spProGuessMatch=null;
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
                                SPClassApiManager.spFunGetInstance().spFunSchemeLeagueOfDate<SPClassListEntity<String>>(context: context,queryParameters: {
                                  "match_type":SPClassMatchDataUtils.spFunExpertTypeToMatchType(SPClassApplicaion.spProUserLoginInfo!.spProExpertMatchType!),"date":spProMatchTime
                                },spProCallBack: SPClassHttpCallBack(
                                    spProOnSuccess: (value){
                                      showCupertinoModalPopup(context: context, builder:
                                          (c)=>SPClassBottomPickAndSearchList(spProDialogTitle: "联赛",list: value.spProDataList,changed: (index){
                                        setState(() {
                                          LeagueName=value.spProDataList[index];
                                          spProGuessMatch=null;
                                        });
                                      },));
                                    },onError: (e){},spProOnProgress: (v){}
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
                                    spProGuessMatch!=null ? (spProGuessMatch!.spProTeamOne!+ " vs "+spProGuessMatch!.spProTeamTwo!):"",
                                    style: TextStyle(color:Color(0xFF333333),fontSize: sp(13),fontWeight: FontWeight.w500),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  )),
                              onTap: () {
                                if(LeagueName.isEmpty){
                                  SPClassToastUtils.spFunShowToast(msg: "请选择联赛");
                                  return ;
                                }
                                SPClassApiManager.spFunGetInstance().spFunSchemeGuessMatchList<SPClassSchemeGuessMatch2>(context: context,queryParameters: {
                                  "match_type":SPClassMatchDataUtils.spFunExpertTypeToMatchType(SPClassApplicaion.spProUserLoginInfo!.spProExpertMatchType!),"date":spProMatchTime,
                                  "league_name":LeagueName

                                },spProCallBack: SPClassHttpCallBack(
                                    spProOnSuccess: (value){
                                      showCupertinoModalPopup(context: context, builder:
                                          (c)=>SPClassBottomPickAndSearchList(spProDialogTitle: "队伍",list: value.spProDataList.map((e) =>
                                      (SPClassDateUtils.spFunDateFormatByString(e.spProStTime!, "HH:ss") + " "+e.spProTeamOne!+" vs "+e.spProTeamTwo!)).toList(),
                                        changed: (index){
                                          setState(() {
                                            spProGuessMatch=value.spProDataList[index];
                                          });
                                        },));
                                    },onError: (v){},spProOnProgress: (v){}
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
                                      color:(LeagueName.isNotEmpty&&spProGuessMatch!=null)?  MyColors.main1:Color(0xFFF2F2F2),
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
                                  if((LeagueName.isNotEmpty&&spProGuessMatch!=null)){
                                    spProGuessMatch!.spProLeagueName=LeagueName;
                                    Navigator.of(context).pop();
                                    widget.changed!(spProGuessMatch!);
                                  }else{
                                    SPClassToastUtils.spFunShowToast(msg: "请完善相关信息");
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
