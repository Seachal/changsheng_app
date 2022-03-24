import 'dart:async';
import 'dart:math';

import 'package:changshengh5/api/CSClassApiManager.dart';
import 'package:changshengh5/api/CSClassHttpCallBack.dart';
import 'package:changshengh5/generated/json/base/json_convert_content.dart';
import 'package:changshengh5/model/CSClassBaseModelEntity.dart';
import 'package:changshengh5/model/CSClassGuessMatchInfo.dart';
import 'package:changshengh5/model/CSClassMatchInjuryEntity.dart';
import 'package:changshengh5/model/CSClassMatchIntelligenceEntity.dart';
import 'package:changshengh5/model/CSClassMatchLineupPlayerEntity.dart';
import 'package:changshengh5/model/CSClassPlayerStatListEntity.dart';
import 'package:changshengh5/model/CSClassTextLiveListEntity.dart';
import 'package:changshengh5/pages/common/CSClassNoDataView.dart';
import 'package:changshengh5/utils/CSClassCommonMethods.dart';
import 'package:changshengh5/utils/CSClassImageUtil.dart';
import 'package:changshengh5/utils/CSClassMatchDataUtils.dart';
import 'package:changshengh5/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'dart:math' as math;


class CSClassMatchLiveBasketballTeamPage extends  StatefulWidget{
  CSClassGuessMatchInfo csProGuessInfo;
  CSClassMatchLiveBasketballTeamPage(this.csProGuessInfo,{this.callback});
  ValueChanged<CSClassGuessMatchInfo>? callback;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CSClassMatchLiveBasketballTeamPageState();
  }

}

class CSClassMatchLiveBasketballTeamPageState extends State<CSClassMatchLiveBasketballTeamPage> with TickerProviderStateMixin<CSClassMatchLiveBasketballTeamPage> ,AutomaticKeepAliveClientMixin{
  var csProMatchSection  =["全场"];
  var csProMatchSectionIndex=0;
  List<CSClassTextLiveListTextLiveList> csProOrgTextData=[];
  List<CSClassTextLiveListTextLiveList> csProShowTextData=[];
  Timer ?csProTimer;
  int hour=0;
  int minute=0;
  int second=0;
  bool csProIsDispose=false;

  CSClassPlayerStatListBestPlayerList ?csProBestPlayerList; //全场最佳
  PlayerStatListSum ?csProPlayerStatListSum; //球队数据
  List<CSClassPlayerStatListPlayerStatListItem> ?csProPlayerOneDateList; //球员数据
  List<CSClassPlayerStatListPlayerStatListItem> ?csProPlayerTwoDateList; //球员数据
  bool csProShowBest=true;
  bool csProShowTeamDate=true;
  bool csProShowPlayerDate=true;


  CSClassMatchLineupPlayerEntity ?csProMatchLineupPlayerEntity;
  List<CSClassMatchLineupPlayerMatchLineupPlayerItem> ?csProStartingOnes;//首发主队
  List<CSClassMatchLineupPlayerMatchLineupPlayerItem>? csProStartingTwos;//首发客队
  List<CSClassMatchLineupPlayerMatchLineupPlayerItem>? csProSubstituteOnes;//替补客队
  List<CSClassMatchLineupPlayerMatchLineupPlayerItem> ?csProSubstituteTwos;//替补客队
  CSClassMatchInjuryEntity ?csProMatchInjuryEntity;
  var csProShowTeam=true;
  var csProShowJury=true;

  CSClassMatchIntelligenceMatchIntelligenceItem ?csProMatchIntelligenceItemOne;
  CSClassMatchIntelligenceMatchIntelligenceItem ?csProMatchIntelligenceItemTwo;

  var csProIsLoading=true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();


   csMethodDownCount();

    CSClassApiManager.csMethodGetInstance().csMethodSportMatchData<CSClassBaseModelEntity>(
        context: context,csProGuessMatchId:widget.csProGuessInfo.csProGuessMatchId,
        dataKeys:"match_lineup_player;match_injury;match_intelligence",
        csProCallBack: CSClassHttpCallBack(
            csProOnSuccess: (result) async {
              csProIsLoading=false;
              var csProMatchLineupPlayerEntity= JsonConvert.fromJsonAsT<CSClassMatchLineupPlayerEntity>(result.data);
              var csProMatchInjuryEntity= JsonConvert.fromJsonAsT<CSClassMatchInjuryEntity>(result.data);
              var matchIntelligenceEntity= JsonConvert.fromJsonAsT<CSClassMatchIntelligenceEntity>(result.data);
              if(matchIntelligenceEntity.csProMatchIntelligence!=null&&matchIntelligenceEntity.csProMatchIntelligence!.one!=null){
                csProMatchIntelligenceItemOne=matchIntelligenceEntity.csProMatchIntelligence!.one![0];
              }
              if(matchIntelligenceEntity.csProMatchIntelligence!=null&&matchIntelligenceEntity.csProMatchIntelligence!.two!=null){
                csProMatchIntelligenceItemTwo=matchIntelligenceEntity.csProMatchIntelligence!.two![0];
              }

              if(csProMatchLineupPlayerEntity!=null&&csProMatchLineupPlayerEntity.csProMatchLineupPlayer!=null&&
                  (csProMatchLineupPlayerEntity.csProMatchLineupPlayer?.one!=null
                      ||csProMatchLineupPlayerEntity.csProMatchLineupPlayer?.two!=null)
              ){
                csProStartingOnes=[];
                csProSubstituteOnes=[];
                csProStartingTwos=[];
                csProSubstituteTwos=[];
                if(csProMatchLineupPlayerEntity.csProMatchLineupPlayer?.one!=null){
                  csProMatchLineupPlayerEntity.csProMatchLineupPlayer?.one?.forEach((item){
                    if(item.csProIsRegular=="1"){
                      csProStartingOnes?.add(item);
                    }else{
                      csProSubstituteOnes?.add(item);
                    }
                  });
                }
                if(csProMatchLineupPlayerEntity.csProMatchLineupPlayer?.two!=null){
                  csProMatchLineupPlayerEntity.csProMatchLineupPlayer?.two?.forEach((item){
                    if(item.csProIsRegular=="1"){
                      csProStartingTwos?.add(item);
                    }else{
                      csProSubstituteTwos?.add(item);
                    }
                  });
                }
                this.csProMatchLineupPlayerEntity=csProMatchLineupPlayerEntity;
              }

              if(csProMatchInjuryEntity!=null&&csProMatchInjuryEntity.csProMatchInjury!=null){
                this.csProMatchInjuryEntity=csProMatchInjuryEntity;
              }
              setState(() {
              });
              csMethodDownCount();
            },onError: (e){
          csMethodDownCount();
        },csProOnProgress: (v){}
        )
    );
    CSClassApiManager.csMethodGetInstance().csMethodPlayerStat<CSClassPlayerStatListEntity>(context: context,csProGuessMatchId:widget.csProGuessInfo.csProGuessMatchId,csProCallBack: CSClassHttpCallBack(
        csProOnSuccess: (result) async {
          if(result!=null){
            if(result.csProBestPlayerList!=null){
              csProBestPlayerList=result.csProBestPlayerList;
            }
            if(result.sum!=null){
              csProPlayerStatListSum=result.sum;
            }

            if(result.csProPlayerStatList!=null){
              if(result.csProPlayerStatList!.one!=null&&result.csProPlayerStatList!.one!.isNotEmpty){
                csProPlayerOneDateList=result.csProPlayerStatList!.one;
                csProPlayerOneDateList!.insert(0,  CSClassPlayerStatListPlayerStatListItem());
              }
              if(result.csProPlayerStatList!.two!=null&&result.csProPlayerStatList!.two!.isNotEmpty){
                csProPlayerTwoDateList=result.csProPlayerStatList?.two;
                csProPlayerTwoDateList?.insert(0, CSClassPlayerStatListPlayerStatListItem());

              }
            }
            if(mounted){
              setState(() {});
            }
          }

          Future.delayed(Duration(milliseconds: 500),(){

            if(csProPlayerStatListSum!=null){
              if(csProPlayerStatListSum!.two!.score!>0&&csProPlayerStatListSum!.one!.score!>0){
                if(csProPlayerStatListSum!.two!.score!>csProPlayerStatListSum!.one!.score!){
                  csProPlayerStatListSum!.two!.csProProgressScore=(60 + (Random().nextInt(20)))/100;
                  csProPlayerStatListSum!.one!.csProProgressScore=(40 + (Random().nextInt(20)))/100;
                }else{
                  csProPlayerStatListSum!.one!.csProProgressScore=(60 + (Random().nextInt(20)))/100;
                  csProPlayerStatListSum!.two!.csProProgressScore=(40 + (Random().nextInt(20)))/100;
                }
              }
              if(csProPlayerStatListSum!.two!.assist!>0&&csProPlayerStatListSum!.one!.assist!>0){
                if(csProPlayerStatListSum!.two!.assist!>csProPlayerStatListSum!.one!.assist!){
                  csProPlayerStatListSum!.two!.csProProgressAssist=(60 + (Random().nextInt(20)))/100;
                  csProPlayerStatListSum!.one!.csProProgressAssist=(40 + (Random().nextInt(20)))/100;
                }else{
                  csProPlayerStatListSum!.one!.csProProgressAssist=(60 + (Random().nextInt(20)))/100;
                  csProPlayerStatListSum!.two!.csProProgressAssist=(40 + (Random().nextInt(20)))/100;
                }
              }
              if(csProPlayerStatListSum!.two!.rebound!>0&&csProPlayerStatListSum!.one!.rebound!>0){
                if(csProPlayerStatListSum!.two!.rebound!>csProPlayerStatListSum!.one!.rebound!){
                  csProPlayerStatListSum!.two!.csProProgressRebound=(60 + (Random().nextInt(20)))/100;
                  csProPlayerStatListSum!.one!.csProProgressRebound=(40 + (Random().nextInt(20)))/100;
                }else{
                  csProPlayerStatListSum!.one!.csProProgressRebound=(60 + (Random().nextInt(20)))/100;
                  csProPlayerStatListSum!.two!.csProProgressRebound=(40 + (Random().nextInt(20)))/100;
                }
              }
              if(csProPlayerStatListSum!.two!.steal!>0&&csProPlayerStatListSum!.one!.steal!>0){
                if(csProPlayerStatListSum!.two!.steal!>csProPlayerStatListSum!.one!.steal!){
                  csProPlayerStatListSum!.two!.csProProgressSteal=(60 + (Random().nextInt(20)))/100;
                  csProPlayerStatListSum!.one!.csProProgressSteal=(40 + (Random().nextInt(20)))/100;
                }else{
                  csProPlayerStatListSum!.one!.csProProgressSteal=(60 + (Random().nextInt(20)))/100;
                  csProPlayerStatListSum!.two!.csProProgressSteal=(40 + (Random().nextInt(20)))/100;
                }
              }
              if(csProPlayerStatListSum!.two!.csProBlockShot!>0&&csProPlayerStatListSum!.one!.csProBlockShot!>0){
                if(csProPlayerStatListSum!.two!.csProBlockShot!>csProPlayerStatListSum!.one!.csProBlockShot!){
                  csProPlayerStatListSum!.two!.csProProgressBlockShot=(60 + (Random().nextInt(20)))/100;
                  csProPlayerStatListSum!.one!.csProProgressBlockShot=(40 + (Random().nextInt(20)))/100;
                }else{
                  csProPlayerStatListSum!.one!.csProProgressBlockShot=(60 + (Random().nextInt(20)))/100;
                  csProPlayerStatListSum!.two!.csProProgressBlockShot=(40 + (Random().nextInt(20)))/100;
                }
              }
              if(csProPlayerStatListSum!.two!.turnover!>0&&csProPlayerStatListSum!.one!.turnover!>0){
                if(csProPlayerStatListSum!.two!.turnover!>csProPlayerStatListSum!.one!.turnover!){
                  csProPlayerStatListSum!.two!.csProProgressTurnover=(60 + (Random().nextInt(20)))/100;
                  csProPlayerStatListSum!.one!.csProProgressTurnover=(40 + (Random().nextInt(20)))/100;
                }else{
                  csProPlayerStatListSum!.one!.csProProgressTurnover=(60 + (Random().nextInt(20)))/100;
                  csProPlayerStatListSum!.two!.csProProgressTurnover=(40 + (Random().nextInt(20)))/100;
                }
              }
              if(mounted){
                setState(() {});
              }
            }


          });

        },onError: (e){},csProOnProgress: (v){}
    ) );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    if(csProTimer!=null){
      csProTimer?.cancel();
    }
    csProIsDispose=true;
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    super.build(context);
    return Scaffold(

      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[

            Visibility(
              child: CSClassNoDataView(height:width(400),),
              visible: (
                  csProShowTextData.length==0
                  &&csProBestPlayerList==null
                  &&csProPlayerStatListSum==null
                  &&csProPlayerOneDateList==null
                  &&csProMatchLineupPlayerEntity==null
                  &&csProMatchInjuryEntity==null
                  &&csProMatchIntelligenceItemOne==null
                  &&csProMatchIntelligenceItemTwo==null),
            ),

            // 节数选择栏
            Visibility(
              child: Container(
                height: width(35),
                color: Color(0xFFF5F6F7),
                child: ListView.builder(
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.horizontal,
                    itemCount: csProMatchSection.length,
                    itemBuilder: (c,index){
                      var item =csProMatchSection[index];
                      return Container(
                        alignment: Alignment.center,
                        child: GestureDetector(
                          child: Container(
                            margin: EdgeInsets.only(left: width(15)),
                            alignment: Alignment.center,
                            child: Text(item,style: TextStyle(color:index==csProMatchSectionIndex? MyColors.main1:Color(0xFF999999),fontSize: sp(15)),),
                          ),
                          onTap: (){
                            csProMatchSectionIndex=index;
                            setState(() {});
                            csMethodInitData();
                          },
                        ),
                      );
                    }),
              ),
              visible: csProShowTextData.length>0,
            ),
            // 直播
            ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: csProShowTextData.length,
                itemBuilder: (c,index){
                  var item =csProShowTextData[index];
                  return Container(
                    color: Colors.white,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: width(77),
                          alignment: Alignment.center,
                          child:Text(item.csProLeftTime!,style: TextStyle(color: Color(0xFF303133),fontSize: sp(12)),),
                        ),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(right: width(15)),
                            alignment: Alignment.centerLeft,
                            width: MediaQuery.of(context).size.width,
                            constraints: BoxConstraints(
                                minHeight: height(40)
                            ),
                            child:  Text(item.msg!,style: TextStyle(fontSize: sp(13),color: MyColors.grey_33),),
                            decoration: BoxDecoration(
                              border: Border(bottom: BorderSide(color: Color(0xFFF5F6F7)))
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                }),

            Visibility(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow:[
                      BoxShadow(
                        offset: Offset(2,5),
                        color: Color(0x0D000000),
                        blurRadius:width(6,),),
                      BoxShadow(
                        offset: Offset(-5,1),
                        color: Color(0x0D000000),
                        blurRadius:width(6,),
                      )

                    ],
                    borderRadius: BorderRadius.circular(width(7))
                ),
                margin: EdgeInsets.only(bottom: height(8),left: width(10),right: width(10),),
                child: Column(
                  children: <Widget>[
                    Container(
                      height: height(35),
                      padding: EdgeInsets.only(left: width(13),right: width(13)),
                      decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(width: 0.4,color: Colors.grey[300]!))
                      ),
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: height(4),
                            height: height(13),
                            decoration: BoxDecoration(
                                color: MyColors.main1,
                                borderRadius: BorderRadius.circular(100)
                            ),
                          ),
                          SizedBox(width: 4,),
                          Text("全场最佳",style: TextStyle(fontWeight: FontWeight.w500,fontSize: sp(14)),),
                          Expanded(
                            child: SizedBox(),
                          ),
                          GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            child: Container(
                              padding: EdgeInsets.all(width(5)),
                              child:  Image.asset(
                                csProShowBest? CSClassImageUtil.csMethodGetImagePath("cs_down_arrow"):CSClassImageUtil.csMethodGetImagePath("cs_up_arrow"),
                                width: width(13),
                              ),
                            ),
                            onTap: (){
                              setState(() {csProShowBest=!csProShowBest;});
                            },
                          )
                        ],
                      ),
                    ),
                    (csProBestPlayerList==null||!csProShowBest)? SizedBox(): Container(
                      padding: EdgeInsets.all(height(17)),
                      child: Column(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(bottom: height(15)),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        child: ( widget.csProGuessInfo.csProIconUrlOne!.isEmpty)? Image.asset(
                                          CSClassImageUtil.csMethodGetImagePath("cs_away_team"),
                                          width: width(20),
                                        ):Image.network(
                                          widget.csProGuessInfo.csProIconUrlOne!,
                                          width: width(20),
                                        ),
                                      ),
                                      SizedBox(width: 4,),
                                      Text(widget.csProGuessInfo.csProTeamOne!,style: TextStyle(fontSize: sp(12)),),


                                    ],
                                  ),
                                ),
                                SizedBox(width: width(80),),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Text(widget.csProGuessInfo.csProTeamTwo!,style: TextStyle(fontSize: sp(12)),),
                                      SizedBox(width: 4,),
                                      Container(
                                        child: ( widget.csProGuessInfo.csProIconUrlTwo!.isEmpty)? Image.asset(
                                          CSClassImageUtil.csMethodGetImagePath("cs_home_team"),
                                          width: width(20),
                                        ):Image.network(
                                          widget.csProGuessInfo.csProIconUrlTwo!,
                                          width: width(20),
                                        ),
                                      ),


                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Container(
                            margin: EdgeInsets.only(bottom: height(10)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[

                                      Expanded(
                                        child:Row(
                                          children: <Widget>[
                                            Container(
                                              child:  Image.asset(
                                                CSClassImageUtil.csMethodGetImagePath("cs_basketball_one_team"),
                                                width: width(20),
                                              ),
                                            ),
                                            SizedBox(width: 4,),
                                            Expanded(
                                              child:Text(CSClassMatchDataUtils.csMethodPlayName(csProBestPlayerList!.oen!.score!.csProPlayerName!),style: TextStyle(fontSize: sp(12)),maxLines: 1,overflow: TextOverflow.ellipsis,),
                                            )
                                          ],
                                        ),
                                      ),
                                      SizedBox(width: 4,),
                                      Text(csProBestPlayerList!.oen!.score!.score!,style: TextStyle(color: Color(0xFFE3494B),fontWeight: FontWeight.w500, fontSize: sp(13),)),

                                    ],
                                  ),
                                ),
                                SizedBox(width: width(10),),
                                Text("得分",style: TextStyle(fontSize: sp(12)),),
                                SizedBox(width: width(10),),

                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[


                                      Text("${csProBestPlayerList!.two!.score!.score!}",style: TextStyle(color: Color(0xFFE3494B),fontWeight: FontWeight.w500,fontSize: sp(13),)),
                                      SizedBox(width: 4,),
                                      Expanded(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: <Widget>[
                                            Expanded(
                                              child:Text("${CSClassMatchDataUtils.csMethodPlayName(csProBestPlayerList!.two!.score!.csProPlayerName!)}",style: TextStyle(fontSize: sp(12)),maxLines: 1,overflow: TextOverflow.ellipsis,textAlign: TextAlign.right,),
                                            ),
                                            SizedBox(width: 4,),

                                            Container(
                                              child:  Image.asset(
                                                CSClassImageUtil.csMethodGetImagePath("cs_basketball_two_team"),
                                                width: width(20),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),


                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: height(10)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[

                                      Expanded(
                                        child: Row(
                                          children: <Widget>[
                                            Container(
                                              child:  Image.asset(
                                                CSClassImageUtil.csMethodGetImagePath("cs_basketball_one_team"),
                                                width: width(20),
                                              ),
                                            ),
                                            SizedBox(width: 4,),
                                            Expanded(
                                              child:Text("${CSClassMatchDataUtils.csMethodPlayName(csProBestPlayerList!.oen!.rebound!.csProPlayerName!)}",style: TextStyle(fontSize: sp(12)),maxLines: 1,overflow: TextOverflow.ellipsis,),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(width: 4,),

                                      Text("${csProBestPlayerList!.oen!.rebound!.rebound!}",style: TextStyle(color: Color(0xFFE3494B),fontWeight: FontWeight.w500,fontSize: sp(13),)),


                                    ],
                                  ),
                                ),
                                SizedBox(width: width(10),),
                                Text("篮板",style: TextStyle(fontSize: sp(12)),),
                                SizedBox(width: width(10),),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Text("${csProBestPlayerList!.two!.rebound!.rebound!}",style:TextStyle(color: Color(0xFFE3494B), fontSize: sp(13),fontWeight: FontWeight.w500),),
                                      SizedBox(width: 4,),
                                      Expanded(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: <Widget>[
                                            Expanded(
                                              child:Text("${CSClassMatchDataUtils.csMethodPlayName(csProBestPlayerList!.two!.rebound!.csProPlayerName!)}",style: TextStyle(fontSize: sp(12)),maxLines: 1,overflow: TextOverflow.ellipsis,textAlign: TextAlign.right,),
                                            ),
                                            SizedBox(width: 4,),
                                            Container(
                                              child:  Image.asset(
                                                CSClassImageUtil.csMethodGetImagePath("cs_basketball_two_team"),
                                                width: width(20),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Expanded(
                                        child: Row(
                                          children: <Widget>[
                                            Container(
                                              child:  Image.asset(
                                                CSClassImageUtil.csMethodGetImagePath("cs_basketball_one_team"),
                                                width: width(20),
                                              ),
                                            ),
                                            SizedBox(width: 4,),
                                            Expanded(
                                              child:Text("${CSClassMatchDataUtils.csMethodPlayName(csProBestPlayerList!.oen!.assist!.csProPlayerName!)}",style: TextStyle(fontSize: sp(12)),maxLines: 1,overflow: TextOverflow.ellipsis,),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(width: 4,),
                                      Text("${csProBestPlayerList!.oen!.assist!.assist!}",style:  TextStyle(color: Color(0xFFE3494B),fontSize: sp(13),fontWeight: FontWeight.w500,)),

                                    ],
                                  ),
                                ),
                                SizedBox(width: width(10),),
                                Text("助攻",style: TextStyle(fontSize: sp(12)),),
                                SizedBox(width: width(10),),

                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Text("${csProBestPlayerList!.two!.assist!.assist!}",style: TextStyle(color: Color(0xFFE3494B),fontSize: sp(13),fontWeight: FontWeight.w500),),
                                      SizedBox(width: 4,),
                                      Expanded(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: <Widget>[
                                            Expanded(
                                              child:Text("${CSClassMatchDataUtils.csMethodPlayName(csProBestPlayerList!.two!.assist!.csProPlayerName!)}",style: TextStyle(fontSize: sp(12)),maxLines: 1,overflow: TextOverflow.ellipsis,textAlign: TextAlign.right,),
                                            ),
                                            SizedBox(width: 4,),

                                            Container(
                                              child:  Image.asset(
                                                CSClassImageUtil.csMethodGetImagePath("cs_basketball_two_team"),
                                                width: width(20),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),


                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    (csProBestPlayerList!=null)?  SizedBox(): Container(
                      padding:EdgeInsets.all(width(5)),
                      child:Text("暂无数据",style: TextStyle(color: Color(0xFF999999)),),
                    )
                  ],

                ),
              ),
              visible: csProBestPlayerList!=null,
            ),

            Visibility(
              child:Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow:[
                      BoxShadow(
                        offset: Offset(2,5),
                        color: Color(0x0D000000),
                        blurRadius:width(6,),),
                      BoxShadow(
                        offset: Offset(-5,1),
                        color: Color(0x0D000000),
                        blurRadius:width(6,),
                      )

                    ],
                    borderRadius: BorderRadius.circular(width(7))
                ),
                margin: EdgeInsets.only(bottom: height(8),left: width(10),right: width(10),),
                child: Column(
                  children: <Widget>[
                    Container(
                      height: height(35),
                      padding: EdgeInsets.only(left: width(13),right: width(13)),
                      decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(width: 0.4,color: Colors.grey[300]!))
                      ),
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: height(4),
                            height: height(13),
                            decoration: BoxDecoration(
                                color: MyColors.main1,
                                borderRadius: BorderRadius.circular(100)
                            ),
                          ),
                          SizedBox(width: 4,),
                          Text("球队数据",style: TextStyle(fontWeight: FontWeight.w500,fontSize: sp(14)),),
                          Expanded(
                            child: SizedBox(),
                          ),
                          GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            child: Container(
                              padding: EdgeInsets.all(width(5)),
                              child:  Image.asset(
                                csProShowTeamDate? CSClassImageUtil.csMethodGetImagePath("cs_down_arrow"):CSClassImageUtil.csMethodGetImagePath("cs_up_arrow"),
                                width: width(13),
                              ),
                            ),
                            onTap: (){
                              setState(() {csProShowTeamDate=!csProShowTeamDate;});
                            },
                          )
                        ],
                      ),
                    ),
                    (csProPlayerStatListSum==null||!csProShowTeamDate)? SizedBox(): Container(
                      padding: EdgeInsets.all(height(17)),
                      child: Column(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(bottom: height(15)),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        child: ( widget.csProGuessInfo.csProIconUrlOne!.isEmpty)? Image.asset(
                                          CSClassImageUtil.csMethodGetImagePath("cs_away_team"),
                                          width: width(20),
                                        ):Image.network(
                                          widget.csProGuessInfo.csProIconUrlOne!,
                                          width: width(20),
                                        ),
                                      ),
                                      SizedBox(width: 4,),
                                      Text(widget.csProGuessInfo.csProTeamOne!,style: TextStyle(fontSize: sp(12)),),


                                    ],
                                  ),
                                ),
                                SizedBox(width: width(80),),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Text(widget.csProGuessInfo.csProTeamTwo!,style: TextStyle(fontSize: sp(12)),),
                                      SizedBox(width: 4,),
                                      Container(
                                        child: ( widget.csProGuessInfo.csProIconUrlTwo!.isEmpty)? Image.asset(
                                          CSClassImageUtil.csMethodGetImagePath("cs_home_team"),
                                          width: width(20),
                                        ):Image.network(
                                          widget.csProGuessInfo.csProIconUrlTwo!,
                                          width: width(20),
                                        ),
                                      ),


                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Text("${csProPlayerStatListSum!.one!.score!.toString()}",style: TextStyle(fontSize: sp(11)),),
                                      Expanded(
                                        child: SizedBox(),
                                      ),
                                      Stack(
                                        alignment: Alignment.centerRight,
                                        children: <Widget>[
                                          Container(
                                            decoration: BoxDecoration(
                                                color: Color(0xFFEBEBEB),
                                                borderRadius: BorderRadius.circular(300)
                                            ),
                                            width: width(85),
                                            height: height(7),
                                          ),
                                          AnimatedSize(
                                            duration: Duration(milliseconds: 800),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color:(csProPlayerStatListSum!.one!.csProProgressScore>=csProPlayerStatListSum!.two!.csProProgressScore)? Colors.red:Color(0xFF888888),
                                                  borderRadius: BorderRadius.circular(300)
                                              ),
                                              width: width(85)*csProPlayerStatListSum!.one!.csProProgressScore,
                                              height: height(7),
                                            ),
                                            vsync: this,
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                Container(width: width(55),
                                  alignment: Alignment.center,
                                  child: Text("得分",maxLines: 1,style: TextStyle(fontSize: sp(12)),overflow: TextOverflow.ellipsis,),
                                ),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Stack(
                                        alignment: Alignment.centerLeft,
                                        children: <Widget>[
                                          Container(
                                            decoration: BoxDecoration(
                                                color: Color(0xFFEBEBEB),
                                                borderRadius: BorderRadius.circular(300)
                                            ),
                                            width: width(85),
                                            height: height(7),
                                          ),
                                          AnimatedSize(
                                            duration: Duration(milliseconds: 800),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color:(csProPlayerStatListSum!.two!.csProProgressScore>=csProPlayerStatListSum!.one!.csProProgressScore)? Colors.red:Color(0xFF888888),
                                                  borderRadius: BorderRadius.circular(300)
                                              ),
                                              width: width(85)*csProPlayerStatListSum!.two!.csProProgressScore,
                                              height: height(7),
                                            ),
                                            vsync: this,
                                          ),
                                        ],
                                      ),
                                      Expanded(
                                        child: SizedBox(),
                                      ),
                                      Text("${csProPlayerStatListSum!.two!.score}",style: TextStyle(fontSize: sp(11)),),

                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Text("${csProPlayerStatListSum!.one!.assist.toString()}",style: TextStyle(fontSize: sp(11)),),
                                      Expanded(
                                        child: SizedBox(),
                                      ),
                                      Stack(
                                        alignment: Alignment.centerRight,
                                        children: <Widget>[
                                          Container(
                                            decoration: BoxDecoration(
                                                color: Color(0xFFEBEBEB),
                                                borderRadius: BorderRadius.circular(300)
                                            ),
                                            width: width(85),
                                            height: height(7),
                                          ),
                                          AnimatedSize(
                                            duration: Duration(milliseconds: 800),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color:(csProPlayerStatListSum!.one!.csProProgressAssist>=csProPlayerStatListSum!.two!.csProProgressAssist)? Colors.red:Color(0xFF888888),
                                                  borderRadius: BorderRadius.circular(300)
                                              ),
                                              width: width(85)*csProPlayerStatListSum!.one!.csProProgressAssist,
                                              height: height(7),
                                            ),
                                            vsync: this,
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                Container(width: width(55),
                                  alignment: Alignment.center,
                                  child: Text("助攻",maxLines: 1,style: TextStyle(fontSize: sp(12)),overflow: TextOverflow.ellipsis,),
                                ),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Stack(
                                        alignment: Alignment.centerLeft,
                                        children: <Widget>[
                                          Container(
                                            decoration: BoxDecoration(
                                                color: Color(0xFFEBEBEB),
                                                borderRadius: BorderRadius.circular(300)
                                            ),
                                            width: width(85),
                                            height: height(7),
                                          ),
                                          AnimatedSize(
                                            duration: Duration(milliseconds: 800),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color:(csProPlayerStatListSum!.two!.csProProgressAssist>=csProPlayerStatListSum!.one!.csProProgressAssist)? Colors.red:Color(0xFF888888),
                                                  borderRadius: BorderRadius.circular(300)
                                              ),
                                              width: width(85)*csProPlayerStatListSum!.two!.csProProgressAssist,
                                              height: height(7),
                                            ),
                                            vsync: this,
                                          ),
                                        ],
                                      ),
                                      Expanded(
                                        child: SizedBox(),
                                      ),
                                      Text("${csProPlayerStatListSum!.two!.assist}",style: TextStyle(fontSize: sp(11)),),

                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Text("${csProPlayerStatListSum!.one!.csProBlockShot.toString()}",style: TextStyle(fontSize: sp(11)),),
                                      Expanded(
                                        child: SizedBox(),
                                      ),
                                      Stack(
                                        alignment: Alignment.centerRight,
                                        children: <Widget>[
                                          Container(
                                            decoration: BoxDecoration(
                                                color: Color(0xFFEBEBEB),
                                                borderRadius: BorderRadius.circular(300)
                                            ),
                                            width: width(85),
                                            height: height(7),
                                          ),
                                          AnimatedSize(
                                            duration: Duration(milliseconds: 800),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color:(csProPlayerStatListSum!.one!.csProProgressBlockShot>=csProPlayerStatListSum!.two!.csProProgressBlockShot)? Colors.red:Color(0xFF888888),
                                                  borderRadius: BorderRadius.circular(300)
                                              ),
                                              width: width(85)*csProPlayerStatListSum!.one!.csProProgressBlockShot,
                                              height: height(7),
                                            ),
                                            vsync: this,
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                Container(width: width(55),
                                  alignment: Alignment.center,
                                  child: Text("盖帽",maxLines: 1,style: TextStyle(fontSize: sp(12)),overflow: TextOverflow.ellipsis,),
                                ),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Stack(
                                        alignment: Alignment.centerLeft,
                                        children: <Widget>[
                                          Container(
                                            decoration: BoxDecoration(
                                                color: Color(0xFFEBEBEB),
                                                borderRadius: BorderRadius.circular(300)
                                            ),
                                            width: width(85),
                                            height: height(7),
                                          ),
                                          AnimatedSize(
                                            duration: Duration(milliseconds: 800),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color:(csProPlayerStatListSum!.two!.csProProgressBlockShot>=csProPlayerStatListSum!.one!.csProProgressBlockShot)? Colors.red:Color(0xFF888888),
                                                  borderRadius: BorderRadius.circular(300)
                                              ),
                                              width: width(85)*csProPlayerStatListSum!.two!.csProProgressBlockShot,
                                              height: height(7),
                                            ),
                                            vsync: this,
                                          ),
                                        ],
                                      ),
                                      Expanded(
                                        child: SizedBox(),
                                      ),
                                      Text("${csProPlayerStatListSum!.two!.csProBlockShot}",style: TextStyle(fontSize: sp(11)),),

                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Text("${csProPlayerStatListSum!.one!.rebound.toString()}",style: TextStyle(fontSize: sp(11)),),
                                      Expanded(
                                        child: SizedBox(),
                                      ),
                                      Stack(
                                        alignment: Alignment.centerRight,
                                        children: <Widget>[
                                          Container(
                                            decoration: BoxDecoration(
                                                color: Color(0xFFEBEBEB),
                                                borderRadius: BorderRadius.circular(300)
                                            ),
                                            width: width(85),
                                            height: height(7),
                                          ),
                                          AnimatedSize(
                                            duration: Duration(milliseconds: 800),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color:(csProPlayerStatListSum!.one!.csProProgressRebound>=csProPlayerStatListSum!.two!.csProProgressRebound)? Colors.red:Color(0xFF888888),
                                                  borderRadius: BorderRadius.circular(300)
                                              ),
                                              width: width(85)*csProPlayerStatListSum!.one!.csProProgressRebound,
                                              height: height(7),
                                            ),
                                            vsync: this,
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                Container(width: width(55),
                                  alignment: Alignment.center,
                                  child: Text("篮板",maxLines: 1,style: TextStyle(fontSize: sp(12)),overflow: TextOverflow.ellipsis,),
                                ),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Stack(
                                        alignment: Alignment.centerLeft,
                                        children: <Widget>[
                                          Container(
                                            decoration: BoxDecoration(
                                                color: Color(0xFFEBEBEB),
                                                borderRadius: BorderRadius.circular(300)
                                            ),
                                            width: width(85),
                                            height: height(7),
                                          ),
                                          AnimatedSize(
                                            duration: Duration(milliseconds: 800),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color:(csProPlayerStatListSum!.two!.csProProgressRebound>=csProPlayerStatListSum!.one!.csProProgressRebound)? Colors.red:Color(0xFF888888),
                                                  borderRadius: BorderRadius.circular(300)
                                              ),
                                              width: width(85)*csProPlayerStatListSum!.two!.csProProgressRebound,
                                              height: height(7),
                                            ),
                                            vsync: this,
                                          ),
                                        ],
                                      ),
                                      Expanded(
                                        child: SizedBox(),
                                      ),
                                      Text("${csProPlayerStatListSum!.two!.rebound}",style: TextStyle(fontSize: sp(11)),),

                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Container(
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Text("${csProPlayerStatListSum!.one!.steal.toString()}",style: TextStyle(fontSize: sp(11)),),
                                      Expanded(
                                        child: SizedBox(),
                                      ),
                                      Stack(
                                        alignment: Alignment.centerRight,
                                        children: <Widget>[
                                          Container(
                                            decoration: BoxDecoration(
                                                color: Color(0xFFEBEBEB),
                                                borderRadius: BorderRadius.circular(300)
                                            ),
                                            width: width(85),
                                            height: height(7),
                                          ),
                                          AnimatedSize(
                                            duration: Duration(milliseconds: 800),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color:(csProPlayerStatListSum!.one!.csProProgressSteal>=csProPlayerStatListSum!.two!.csProProgressSteal)? Colors.red:Color(0xFF888888),
                                                  borderRadius: BorderRadius.circular(300)
                                              ),
                                              width: width(85)*csProPlayerStatListSum!.one!.csProProgressSteal,
                                              height: height(7),
                                            ),
                                            vsync: this,
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                Container(width: width(55),
                                  alignment: Alignment.center,
                                  child: Text("抢断",maxLines: 1,style: TextStyle(fontSize: sp(12)),overflow: TextOverflow.ellipsis,),
                                ),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Stack(
                                        alignment: Alignment.centerLeft,
                                        children: <Widget>[
                                          Container(
                                            decoration: BoxDecoration(
                                                color: Color(0xFFEBEBEB),
                                                borderRadius: BorderRadius.circular(300)
                                            ),
                                            width: width(85),
                                            height: height(7),
                                          ),
                                          AnimatedSize(
                                            duration: Duration(milliseconds: 800),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color:(csProPlayerStatListSum!.two!.csProProgressSteal>=csProPlayerStatListSum!.one!.csProProgressSteal)? Colors.red:Color(0xFF888888),
                                                  borderRadius: BorderRadius.circular(300)
                                              ),
                                              width: width(85)*csProPlayerStatListSum!.two!.csProProgressSteal,
                                              height: height(7),
                                            ),
                                            vsync: this,
                                          ),
                                        ],
                                      ),
                                      Expanded(
                                        child: SizedBox(),
                                      ),
                                      Text("${csProPlayerStatListSum!.two!.steal}",style: TextStyle(fontSize: sp(11)),),

                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Container(
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Text("${csProPlayerStatListSum!.one!.turnover.toString()}",style: TextStyle(fontSize: sp(11)),),
                                      Expanded(
                                        child: SizedBox(),
                                      ),
                                      Stack(
                                        alignment: Alignment.centerRight,
                                        children: <Widget>[
                                          Container(
                                            decoration: BoxDecoration(
                                                color: Color(0xFFEBEBEB),
                                                borderRadius: BorderRadius.circular(300)
                                            ),
                                            width: width(85),
                                            height: height(7),
                                          ),
                                          AnimatedSize(
                                            duration: Duration(milliseconds: 800),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color:(csProPlayerStatListSum!.one!.csProProgressTurnover>=csProPlayerStatListSum!.two!.csProProgressTurnover)? Colors.red:Color(0xFF888888),
                                                  borderRadius: BorderRadius.circular(300)
                                              ),
                                              width: width(85)*csProPlayerStatListSum!.one!.csProProgressTurnover,
                                              height: height(7),
                                            ),
                                            vsync: this,
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                Container(width: width(55),
                                  alignment: Alignment.center,
                                  child: Text("失误",maxLines: 1,style: TextStyle(fontSize: sp(12)),overflow: TextOverflow.ellipsis,),
                                ),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Stack(
                                        alignment: Alignment.centerLeft,
                                        children: <Widget>[
                                          Container(
                                            decoration: BoxDecoration(
                                                color: Color(0xFFEBEBEB),
                                                borderRadius: BorderRadius.circular(300)
                                            ),
                                            width: width(85),
                                            height: height(7),
                                          ),
                                          AnimatedSize(
                                            duration: Duration(milliseconds: 800),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color:(csProPlayerStatListSum!.two!.csProProgressTurnover>=csProPlayerStatListSum!.one!.csProProgressTurnover)? Colors.red:Color(0xFF888888),
                                                  borderRadius: BorderRadius.circular(300)
                                              ),
                                              width: width(85)*csProPlayerStatListSum!.two!.csProProgressTurnover,
                                              height: height(7),
                                            ),
                                            vsync: this,
                                          ),
                                        ],
                                      ),
                                      Expanded(
                                        child: SizedBox(),
                                      ),
                                      Text("${csProPlayerStatListSum!.two!.turnover}",style: TextStyle(fontSize: sp(11)),),

                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    (csProPlayerStatListSum!=null)?  SizedBox(): Container(
                      padding:EdgeInsets.all(width(5)),
                      child:Text("暂无数据",style: TextStyle(color: Color(0xFF999999)),),
                    )
                  ],

                ),
              ),
              visible: csProPlayerStatListSum!=null,
            ),

            Visibility(
              child:  Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow:[
                      BoxShadow(
                        offset: Offset(2,5),
                        color: Color(0x0D000000),
                        blurRadius:width(6,),),
                      BoxShadow(
                        offset: Offset(-5,1),
                        color: Color(0x0D000000),
                        blurRadius:width(6,),
                      )

                    ],
                    borderRadius: BorderRadius.circular(width(7))
                ),
                margin: EdgeInsets.only(bottom: height(8),left: width(10),right: width(10),),
                child: Column(
                  children: <Widget>[
                    Container(
                      height: height(35),
                      padding: EdgeInsets.only(left: width(13),right: width(13)),
                      decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(width: 0.4,color: Colors.grey[300]!))
                      ),
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: height(4),
                            height: height(13),
                            decoration: BoxDecoration(
                                color: MyColors.main1,
                                borderRadius: BorderRadius.circular(100)
                            ),
                          ),
                          SizedBox(width: 4,),
                          Text("球员数据",style: TextStyle(fontWeight: FontWeight.w500,fontSize: sp(14)),),
                          Expanded(
                            child: SizedBox(),
                          ),
                          GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            child: Container(
                              padding: EdgeInsets.all(width(5)),
                              child:  Image.asset(
                                csProShowPlayerDate? CSClassImageUtil.csMethodGetImagePath("cs_down_arrow"):CSClassImageUtil.csMethodGetImagePath("cs_up_arrow"),
                                width: width(13),
                              ),
                            ),
                            onTap: (){
                              setState(() {csProShowPlayerDate=!csProShowPlayerDate;});
                            },
                          )
                        ],
                      ),
                    ),

                    (csProPlayerOneDateList==null||!csProShowPlayerDate)? SizedBox(): Container(
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding:EdgeInsets.only(left: height(17,),right: height(17,)),
                            margin: EdgeInsets.only(top: height(7)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  child: ( widget.csProGuessInfo.csProIconUrlOne!.isEmpty)? Image.asset(
                                    CSClassImageUtil.csMethodGetImagePath("cs_home_team"),
                                    width: width(20),
                                  ):Image.network(
                                    widget.csProGuessInfo.csProIconUrlOne!,
                                    width: width(20),
                                  ),
                                ),
                                SizedBox(width: 4,),
                                Text(widget.csProGuessInfo.csProTeamOne!,style: TextStyle(fontSize: sp(12)),),


                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: height(8),bottom: height(8)),
                            width: width(330),
                            decoration: BoxDecoration(
                                border: Border.all(color: Color(0xFFDDDDDD),width: 0.4)
                            ),
                            alignment: Alignment.center,
                            child: Row(
                              children: <Widget>[
                                Container(
                                  child: Column(
                                    children: csProPlayerOneDateList!.map((item){
                                      var index =csProPlayerOneDateList!.indexOf(item);
                                      return Container(
                                        decoration: BoxDecoration(
                                            color:index==0 ?   Color(0xFFF7F7F7):Colors.white,
                                            border: Border(bottom:BorderSide(color: Color(0xFFDDDDDD),width: 0.4))
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            Container(
                                              alignment: Alignment.center,
                                              height: width(33),
                                              width: width(88),
                                              child: Text( index==0 ? "球员":item.csProPlayerName!,style:TextStyle(fontSize: sp(11),fontWeight:index==0 ?  FontWeight.w500:null),textAlign: TextAlign.center,maxLines: 2,overflow:TextOverflow.ellipsis,),
                                            ),
                                            Container(
                                              color: Color(0xFFDDDDDD),
                                              height: width(33),
                                              width: 0.4,
                                            ),
                                          ],
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                                Expanded(
                                  child:SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child:   Container(
                                      child: Column(
                                        children: csProPlayerOneDateList!.map((item){
                                          var index =csProPlayerOneDateList!.indexOf(item);

                                          return Container(
                                            decoration: BoxDecoration(
                                                color:index==0 ?   Color(0xFFF7F7F7):Colors.white,
                                                border: Border(bottom:BorderSide(color: Color(0xFFDDDDDD),width: 0.4))
                                            ),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: <Widget>[
                                                Container(
                                                  alignment: Alignment.center,
                                                  height: width(33),
                                                  width: width(46.5),
                                                  child: Text(index==0 ?  "状态":(item.csProIsRegular=="1")? "首发":"替补",style: TextStyle(fontSize: sp(11),fontWeight:index==0 ? FontWeight.w500:null),textAlign: TextAlign.center,maxLines: 2,overflow:TextOverflow.ellipsis,),
                                                ),
                                                Container(
                                                  alignment: Alignment.center,
                                                  height: width(33),
                                                  width: width(46.5),
                                                  child: Text(index==0 ?  "时间":item.csProPlayingTime!,style: TextStyle(fontSize: sp(11),fontWeight:index==0 ? FontWeight.w500:null),textAlign: TextAlign.center,maxLines: 2,overflow:TextOverflow.ellipsis,),
                                                ),

                                                Container(
                                                  color: Color(0xFFDDDDDD),
                                                  height: width(33),
                                                  width: 0.4,
                                                ),
                                                Container(
                                                  alignment: Alignment.center,
                                                  height: width(33),
                                                  width: width(48),
                                                  child: Text(index==0 ?  "投篮":item.shot!,style: TextStyle(fontSize: sp(11),fontWeight:index==0 ? FontWeight.w500:null),textAlign: TextAlign.center,maxLines: 2,overflow:TextOverflow.ellipsis,),
                                                ),

                                                Container(
                                                  alignment: Alignment.center,
                                                  height: width(33),
                                                  width: width(48),
                                                  child: Text(index==0 ?  "三分":item.csProThreePoint!,style: TextStyle(fontSize: sp(11),fontWeight:index==0 ? FontWeight.w500:null),textAlign: TextAlign.center,maxLines: 2,overflow:TextOverflow.ellipsis,),
                                                ),
                                                Container(
                                                  alignment: Alignment.center,
                                                  height: width(33),
                                                  width: width(48),
                                                  child: Text(index==0 ?  "罚球":item.csProFreeThrow!,style:TextStyle(fontSize: sp(11),fontWeight:index==0 ? FontWeight.w500:null),textAlign: TextAlign.center,maxLines: 2,overflow:TextOverflow.ellipsis,),
                                                ),
                                                Container(
                                                  color: Color(0xFFDDDDDD),
                                                  height: width(33),
                                                  width: 0.4,
                                                ),
                                                Container(
                                                  alignment: Alignment.center,
                                                  height: width(33),
                                                  width: width(48),
                                                  child: Text(index==0 ?  "抢断":item.steal!,style: TextStyle(fontSize: sp(11),fontWeight:index==0 ? FontWeight.w500:null),textAlign: TextAlign.center,maxLines: 2,overflow:TextOverflow.ellipsis,),
                                                ),

                                                Container(
                                                  alignment: Alignment.center,
                                                  height: width(33),
                                                  width: width(48),
                                                  child: Text(index==0 ?  "盖帽":item.csProBlockShot!,style: TextStyle(fontSize: sp(11),fontWeight:index==0 ? FontWeight.w500:null),textAlign: TextAlign.center,maxLines: 2,overflow:TextOverflow.ellipsis,),
                                                ),
                                                Container(
                                                  alignment: Alignment.center,
                                                  height: width(33),
                                                  width: width(48),
                                                  child: Text(index==0 ?  "失误":item.turnover!,style:TextStyle(fontSize: sp(11),fontWeight:index==0 ? FontWeight.w500:null),textAlign: TextAlign.center,maxLines: 2,overflow:TextOverflow.ellipsis,),
                                                ),
                                                Container(
                                                  alignment: Alignment.center,
                                                  height: width(33),
                                                  width: width(48),
                                                  child: Text(index==0 ?  "犯规":item.foul!,style: TextStyle(fontSize: sp(11),fontWeight:index==0 ? FontWeight.w500:null),textAlign: TextAlign.center,maxLines: 2,overflow:TextOverflow.ellipsis,),
                                                ),
                                              ],
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ),
                                )

                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    (csProPlayerTwoDateList==null||!csProShowPlayerDate)? SizedBox(): Container(
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding:EdgeInsets.only(left: height(17,),right: height(17,)),
                            margin: EdgeInsets.only(top: height(7)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  child: ( widget.csProGuessInfo.csProIconUrlTwo!.isEmpty)? Image.asset(
                                    CSClassImageUtil.csMethodGetImagePath("cs_away_team"),
                                    width: width(20),
                                  ):Image.network(
                                    widget.csProGuessInfo.csProIconUrlTwo!,
                                    width: width(20),
                                  ),
                                ),
                                SizedBox(width: 4,),
                                Text(widget.csProGuessInfo.csProTeamTwo!,style: TextStyle(fontSize: sp(12)),),


                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: height(8),bottom: height(8)),
                            width: width(330),
                            decoration: BoxDecoration(
                                border: Border.all(color: Color(0xFFDDDDDD),width: 0.4)
                            ),
                            alignment: Alignment.center,
                            child: Row(
                              children: <Widget>[
                                Container(
                                  child: Column(
                                    children: csProPlayerTwoDateList!.map((item){
                                      var index =csProPlayerTwoDateList!.indexOf(item);
                                      return Container(
                                        decoration: BoxDecoration(
                                            color:index==0 ?   Color(0xFFF7F7F7):Colors.white,
                                            border: Border(bottom:BorderSide(color: Color(0xFFDDDDDD),width: 0.4))
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            Container(
                                              alignment: Alignment.center,
                                              height: width(33),
                                              width: width(88),
                                              child: Text( index==0 ? "球员":item.csProPlayerName!,style:TextStyle(fontSize: sp(11),fontWeight:index==0 ?  FontWeight.w500:null),textAlign: TextAlign.center,maxLines: 2,overflow:TextOverflow.ellipsis,),
                                            ),
                                            Container(
                                              color: Color(0xFFDDDDDD),
                                              height: width(33),
                                              width: 0.4,
                                            ),
                                          ],
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                                Expanded(
                                  child:SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child:   Container(
                                      child: Column(
                                        children: csProPlayerTwoDateList!.map((item){
                                          var index =csProPlayerTwoDateList!.indexOf(item);

                                          return Container(
                                            decoration: BoxDecoration(
                                                color:index==0 ?   Color(0xFFF7F7F7):Colors.white,
                                                border: Border(bottom:BorderSide(color: Color(0xFFDDDDDD),width: 0.4))
                                            ),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: <Widget>[
                                                Container(
                                                  alignment: Alignment.center,
                                                  height: width(33),
                                                  width: width(46.5),
                                                  child: Text(index==0 ?  "状态":(item.csProIsRegular=="1")? "首发":"替补",style: TextStyle(fontSize: sp(11),fontWeight:index==0 ? FontWeight.w500:null),textAlign: TextAlign.center,maxLines: 2,overflow:TextOverflow.ellipsis,),
                                                ),
                                                Container(
                                                  alignment: Alignment.center,
                                                  height: width(33),
                                                  width: width(46.5),
                                                  child: Text(index==0 ?  "时间":item.csProPlayingTime!,style: TextStyle(fontSize: sp(11),fontWeight:index==0 ? FontWeight.w500:null),textAlign: TextAlign.center,maxLines: 2,overflow:TextOverflow.ellipsis,),
                                                ),

                                                Container(
                                                  color: Color(0xFFDDDDDD),
                                                  height: width(33),
                                                  width: 0.4,
                                                ),
                                                Container(
                                                  alignment: Alignment.center,
                                                  height: width(33),
                                                  width: width(48),
                                                  child: Text(index==0 ?  "投篮":item.shot!,style: TextStyle(fontSize: sp(11),fontWeight:index==0 ? FontWeight.w500:null),textAlign: TextAlign.center,maxLines: 2,overflow:TextOverflow.ellipsis,),
                                                ),

                                                Container(
                                                  alignment: Alignment.center,
                                                  height: width(33),
                                                  width: width(48),
                                                  child: Text(index==0 ?  "三分":item.csProThreePoint!,style: TextStyle(fontSize: sp(11),fontWeight:index==0 ? FontWeight.w500:null),textAlign: TextAlign.center,maxLines: 2,overflow:TextOverflow.ellipsis,),
                                                ),
                                                Container(
                                                  alignment: Alignment.center,
                                                  height: width(33),
                                                  width: width(48),
                                                  child: Text(index==0 ?  "罚球":item.csProFreeThrow!,style: TextStyle(fontSize: sp(11),fontWeight:index==0 ? FontWeight.w500:null),textAlign: TextAlign.center,maxLines: 2,overflow:TextOverflow.ellipsis,),
                                                ),
                                                Container(
                                                  color: Color(0xFFDDDDDD),
                                                  height: width(33),
                                                  width: 0.4,
                                                ),
                                                Container(
                                                  alignment: Alignment.center,
                                                  height: width(33),
                                                  width: width(48),
                                                  child: Text(index==0 ?  "抢断":item.steal!,style: TextStyle(fontSize: sp(11),fontWeight:index==0 ? FontWeight.w500:null),textAlign: TextAlign.center,maxLines: 2,overflow:TextOverflow.ellipsis,),
                                                ),

                                                Container(
                                                  alignment: Alignment.center,
                                                  height: width(33),
                                                  width: width(48),
                                                  child: Text(index==0 ?  "盖帽":item.csProBlockShot!,style: TextStyle(fontSize: sp(11),fontWeight:index==0 ? FontWeight.w500:null),textAlign: TextAlign.center,maxLines: 2,overflow:TextOverflow.ellipsis,),
                                                ),
                                                Container(
                                                  alignment: Alignment.center,
                                                  height: width(33),
                                                  width: width(48),
                                                  child: Text(index==0 ?  "失误":item.turnover!,style: TextStyle(fontSize: sp(11),fontWeight:index==0 ? FontWeight.w500:null),textAlign: TextAlign.center,maxLines: 2,overflow:TextOverflow.ellipsis,),
                                                ),
                                                Container(
                                                  alignment: Alignment.center,
                                                  height: width(33),
                                                  width: width(48),
                                                  child: Text(index==0 ?  "犯规":item.foul!,style: TextStyle(fontSize: sp(11),fontWeight:index==0 ? FontWeight.w500:null),textAlign: TextAlign.center,maxLines: 2,overflow:TextOverflow.ellipsis,),
                                                ),
                                              ],
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ),
                                )

                              ],
                            ),
                          )
                        ],
                      ),
                    ),


                  ],

                ),
              ),
              visible: csProPlayerOneDateList!=null,
            ),

           (csProMatchLineupPlayerEntity==null)?  SizedBox(): AnimatedSize(
              vsync: this,
              duration: Duration(
                  milliseconds: 300
              ),
              child:Container(
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
                margin: EdgeInsets.only(bottom: height(8),left: width(10),right: width(10),),
                child: Column(
                  children: <Widget>[
                    Container(
                      height: height(35),
                      padding: EdgeInsets.only(left: width(13),right: width(13)),
                      decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(width: 0.4,color: Colors.grey[300]!))
                      ),
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: height(4),
                            height: height(14),
                            decoration: BoxDecoration(
                                color: Color(0xFFDE3C31),
                                borderRadius: BorderRadius.circular(100)
                            ),
                          ),
                          SizedBox(width: 4,),
                          Text("首发阵容",style:TextStyle(fontWeight: FontWeight.w500,fontSize: sp(15)),),
                          Expanded(
                            child: SizedBox(),
                          ),
                          GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            child: Container(
                              padding: EdgeInsets.all(width(5)),
                              child:  Image.asset(
                                csProShowTeam? CSClassImageUtil.csMethodGetImagePath("cs_down_arrow"):CSClassImageUtil.csMethodGetImagePath("cs_up_arrow"),
                                width: width(13),
                              ),
                            ),
                            onTap: (){
                              setState(() {csProShowTeam=!csProShowTeam;});
                            },
                          )
                        ],
                      ),
                    ),


                    (csProMatchLineupPlayerEntity==null||!csProShowTeam)?SizedBox(): Container(
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(width(13)),
                            child: Row(
                              children: <Widget>[
                                Expanded(child: Row(
                                  children: <Widget>[
                                    ( widget.csProGuessInfo.csProIconUrlOne!.isEmpty)? Image.asset(
                                      CSClassImageUtil.csMethodGetImagePath("cs_home_team"),
                                      width: width(20),
                                    ):Image.network(
                                      widget.csProGuessInfo.csProIconUrlOne!,
                                      width: width(20),
                                    ),
                                    SizedBox(width: 5,),
                                    Text(widget.csProGuessInfo.csProTeamOne!,style: TextStyle(fontSize: sp(12)),)
                                  ],

                                ),),
                                Expanded(child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Text(widget.csProGuessInfo.csProTeamTwo!,style: TextStyle(fontSize: sp(12)),),
                                    SizedBox(width: 5,),
                                    ( widget.csProGuessInfo.csProIconUrlTwo!.isEmpty)? Image.asset(
                                      CSClassImageUtil.csMethodGetImagePath("cs_away_team"),
                                      width: width(20),
                                    ):Image.network(
                                      widget.csProGuessInfo.csProIconUrlTwo!,
                                      width: width(20),
                                    ),
                                  ],

                                ),),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: width(13),right: width(13)),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  width: height(4),
                                  height: height(14),
                                  decoration: BoxDecoration(
                                      color: Color(0xFFDE3C31),
                                      borderRadius: BorderRadius.circular(100)
                                  ),
                                ),
                                SizedBox(width: 4,),
                                Text("首发球员",style:TextStyle(fontWeight: FontWeight.w500,fontSize: width(15)),),
                                Expanded(child: SizedBox(),),
                              ],
                            ),
                          ),
                          ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.only(left: width(18),right: width(18)),
                              shrinkWrap: true,
                              itemCount: math.max(csProStartingOnes!.length, csProStartingTwos!.length),
                              itemBuilder: (c,index){
                                return  Container(
                                  padding: EdgeInsets.only(top: height(8),bottom: height(8)),
                                  decoration: BoxDecoration(
                                      border: Border(bottom: BorderSide(color: Colors.grey[300]!,width: 0.4))
                                  ),
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(child:(index<=(csProStartingOnes!.length-1))? Row(
                                        children: <Widget>[
                                          Container(
                                            width: width(21),
                                            padding: EdgeInsets.all(width(2)),
                                            alignment: Alignment.center,
                                            decoration: ShapeDecoration(
                                                shape: CircleBorder(),
                                                color: Color(0xFFEA5E5E)
                                            ),
                                            child: Text(csProStartingOnes![index].csProShirtNumber!,style: TextStyle(color: Colors.white,fontSize: sp(12)),),
                                          ),
                                          SizedBox(width: 3,),
                                          Text(csProStartingOnes![index].csProPlayerName!,maxLines: 1,style:TextStyle(fontSize: sp(12)),)
                                        ],
                                      ):SizedBox(),),
                                      Expanded(child:(index<=(csProStartingTwos!.length-1))? Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: <Widget>[
                                          Text(csProStartingTwos![index].csProPlayerName!,maxLines: 1,style:TextStyle(fontSize: sp(12)),),
                                          SizedBox(width: 3,),
                                          Container(
                                            width: width(21),
                                            padding: EdgeInsets.all(width(2)),
                                            alignment: Alignment.center,
                                            decoration: ShapeDecoration(
                                                shape: CircleBorder(),
                                                color: Color(0xFF5D9CEC)
                                            ),
                                            child: Text(csProStartingTwos![index].csProShirtNumber!,style: TextStyle(color: Colors.white,fontSize: sp(12)),),
                                          ),
                                        ],
                                      ):SizedBox(),),
                                    ],
                                  ),
                                );
                              }),
                          SizedBox(height: height(20),),
                          Container(
                            padding: EdgeInsets.only(left: width(13),right: width(13)),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  width: height(4),
                                  height: height(14),
                                  decoration: BoxDecoration(
                                      color: Color(0xFFDE3C31),
                                      borderRadius: BorderRadius.circular(100)
                                  ),
                                ),
                                SizedBox(width: 4,),
                                Text("替补球员",style: TextStyle(fontWeight:FontWeight.w500,fontSize: width(15)),),
                                Expanded(child: SizedBox(),),
                              ],
                            ),
                          ),
                          ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.only(left: width(18),right: width(18)),
                              shrinkWrap: true,
                              itemCount: math.max(csProSubstituteOnes!.length, csProSubstituteTwos!.length),
                              itemBuilder: (c,index){
                                return  Container(
                                  padding: EdgeInsets.only(top: height(8),bottom: height(8)),
                                  decoration: BoxDecoration(
                                      border: Border(bottom: BorderSide(color: Colors.grey[300]!,width: 0.4))
                                  ),
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(child:(index<=(csProSubstituteOnes!.length-1))? Row(
                                        children: <Widget>[
                                          Container(
                                            width: width(21),
                                            padding: EdgeInsets.all(width(2)),
                                            alignment: Alignment.center,
                                            decoration: ShapeDecoration(
                                                shape: CircleBorder(),
                                                color: Color(0xFFEA5E5E)
                                            ),
                                            child: Text(csProSubstituteOnes![index].csProShirtNumber!,style: TextStyle(color: Colors.white,fontSize: sp(12)),),
                                          ),
                                          SizedBox(width: 3,),
                                          Text(csProSubstituteOnes![index].csProPlayerName!,maxLines: 1,style:TextStyle(fontSize: sp(12)),)
                                        ],
                                      ):SizedBox(),),
                                      Expanded(child:(index<=(csProSubstituteTwos!.length-1))? Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: <Widget>[
                                          Text(csProSubstituteTwos![index].csProPlayerName!,maxLines: 1,style:TextStyle(fontSize: sp(12)),),
                                          SizedBox(width: 3,),
                                          Container(
                                            width: width(21),
                                            padding: EdgeInsets.all(width(2)),
                                            alignment: Alignment.center,
                                            decoration: ShapeDecoration(
                                                shape: CircleBorder(),
                                                color: Color(0xFF5D9CEC)
                                            ),
                                            child: Text(csProSubstituteTwos![index].csProShirtNumber!,style: TextStyle(color: Colors.white,fontSize: sp(12)),),
                                          ),
                                        ],
                                      ):SizedBox(),),
                                    ],
                                  ),
                                );
                              })
                        ],
                      ),
                    ),


                  ],

                ),
              ) ,
            ),

            (  csProMatchInjuryEntity==null)? SizedBox(): AnimatedSize(
              vsync: this,
              duration: Duration(
                  milliseconds: 300
              ),
              child:Container(
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
                margin: EdgeInsets.only(bottom: height(8),left: width(10),right: width(10),),
                child: Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      height: height(35),
                      padding: EdgeInsets.only(left: width(13),right: width(13)),
                      decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(width: 0.4,color: Colors.grey[300]!))
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            width: height(4),
                            height: height(14),
                            decoration: BoxDecoration(
                                color: Color(0xFFDE3C31),
                                borderRadius: BorderRadius.circular(100)
                            ),
                          ),
                          SizedBox(width: 4,),
                          Text("伤停信息",style: TextStyle(fontWeight: FontWeight.w500,fontSize: sp(15)),),
                          Expanded(
                            child: SizedBox(),
                          ),
                          GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            child: Container(
                              padding: EdgeInsets.all(width(5)),
                              child:  Image.asset(
                                csProShowJury? CSClassImageUtil.csMethodGetImagePath("cs_down_arrow"):CSClassImageUtil.csMethodGetImagePath("cs_up_arrow"),
                                width: width(13),
                              ),
                            ),
                            onTap: (){
                              setState(() {csProShowJury=!csProShowJury;});
                            },
                          )
                        ],
                      ),
                    ),
                    (  csProMatchInjuryEntity==null||!csProShowJury)? SizedBox():Container(
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  padding: EdgeInsets.only(top: height(8),bottom: height(8),left: width(17)),
                                  color: Color(0xFFF9F9F9),
                                  child: Text("球员",style: TextStyle(fontSize: sp(12),fontWeight: FontWeight.w500),),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.only(top: height(8),bottom: height(8)),
                                  color: Color(0xFFF9F9F9),
                                  child: Text("伤停原因",style: TextStyle(fontSize: sp(12),fontWeight: FontWeight.w500),),
                                ),
                              )
                            ],
                          ),
                          Container(
                            padding: EdgeInsets.all(width(13)),
                            child: Row(
                              children: <Widget>[
                                Expanded(child: Row(
                                  children: <Widget>[
                                    ( widget.csProGuessInfo.csProIconUrlOne!.isEmpty)? Image.asset(
                                      CSClassImageUtil.csMethodGetImagePath("cs_home_team"),
                                      width: width(20),
                                    ):Image.network(
                                      widget.csProGuessInfo.csProIconUrlOne!,
                                      width: width(20),
                                    ),
                                    SizedBox(width: 5,),
                                    Text(widget.csProGuessInfo.csProTeamOne!,style: TextStyle(fontSize: sp(12)),)
                                  ],

                                ),),
                              ],
                            ),
                          ),
                          csProMatchInjuryEntity!.csProMatchInjury!.one==null ? SizedBox():  ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.only(left: width(18),right: width(18)),
                              shrinkWrap: true,
                              itemCount: csProMatchInjuryEntity!.csProMatchInjury!.one!.length,
                              itemBuilder: (c,index){
                                var item =csProMatchInjuryEntity!.csProMatchInjury!.one![index];
                                return  Container(
                                  padding: EdgeInsets.only(top: height(8),bottom: height(8)),
                                  decoration: BoxDecoration(
                                      border: Border(bottom: BorderSide(color: Colors.grey[300]!,width: 0.4))
                                  ),
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(child: Row(
                                        children: <Widget>[
                                          Container(
                                            width: width(21),
                                            padding: EdgeInsets.all(width(2)),
                                            alignment: Alignment.center,
                                            decoration: ShapeDecoration(
                                                shape: CircleBorder(),
                                                color: Color(0xFFDE3C31)
                                            ),
                                            child: Text(item.csProShirtNumber!,style: TextStyle(color: Colors.white,fontSize: sp(12)),),
                                          ),
                                          SizedBox(width: 3,),
                                          Text(item.csProPlayerName!,maxLines: 1,style:TextStyle(fontSize: sp(12)),)
                                        ],
                                      ),),
                                      Expanded(child:Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text(item.reason!,maxLines: 1,style:TextStyle(fontSize: sp(12)),),

                                        ],
                                      )),
                                    ],
                                  ),
                                );
                              }),

                          csProMatchInjuryEntity!.csProMatchInjury!.two==null ?  SizedBox():   Container(
                            padding: EdgeInsets.all(width(13)),
                            child: Row(
                              children: <Widget>[
                                Expanded(child: Row(
                                  children: <Widget>[
                                    ( widget.csProGuessInfo.csProIconUrlTwo!.isEmpty)? Image.asset(
                                      CSClassImageUtil.csMethodGetImagePath("cs_away_team"),
                                      width: width(20),
                                    ):Image.network(
                                      widget.csProGuessInfo.csProIconUrlTwo!,
                                      width: width(20),
                                    ),
                                    SizedBox(width: 5,),
                                    Text(widget.csProGuessInfo.csProTeamTwo!,style: TextStyle(fontSize: sp(12)),)
                                  ],

                                ),),
                              ],
                            ),
                          ),
                          csProMatchInjuryEntity!.csProMatchInjury!.two==null ? SizedBox():      ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.only(left: width(18),right: width(18)),
                              shrinkWrap: true,
                              itemCount: csProMatchInjuryEntity!.csProMatchInjury!.two!.length,
                              itemBuilder: (c,index){
                                var item =csProMatchInjuryEntity!.csProMatchInjury!.two![index];
                                return  Container(
                                  padding: EdgeInsets.only(top: height(8),bottom: height(8)),
                                  decoration: BoxDecoration(
                                      border: Border(bottom: BorderSide(color: Colors.grey[300]!,width: 0.4))
                                  ),
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(child: Row(
                                        children: <Widget>[
                                          Container(
                                            width: width(21),
                                            padding: EdgeInsets.all(width(2)),
                                            alignment: Alignment.center,
                                            decoration: ShapeDecoration(
                                                shape: CircleBorder(),
                                                color: Color(0xFF5D9CEC)
                                            ),
                                            child: Text(item.csProShirtNumber!,style: TextStyle(color: Colors.white,fontSize: sp(12)),),
                                          ),
                                          SizedBox(width: 3,),
                                          Text(item.csProPlayerName!,maxLines: 1,style:TextStyle(fontSize: sp(12)),)
                                        ],
                                      ),),
                                      Expanded(child:Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text(item.reason!,maxLines: 1,style:TextStyle(fontSize: sp(12)),),

                                        ],
                                      )),
                                    ],
                                  ),
                                );
                              })
                        ],
                      ),),


                  ],

                ),
              ) ,
            ),

            csProMatchIntelligenceItemOne==null? SizedBox():AnimatedSize(
              vsync: this,
              duration: Duration(
                  milliseconds: 300
              ),
              child:Container(
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
                margin: EdgeInsets.only(left: width(10),right: width(10),top: width(10)),
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(width(6)),
                      decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(width: 0.4,color: Color(0xFFDDDDDD)))
                      ),
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.center,
                      child: Text(widget.csProGuessInfo.csProTeamOne!,style: TextStyle(fontSize: sp(16),fontWeight: FontWeight.w500),),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(top: height(13),bottom:  height(13),left:  width(25),right: width(25)),
                            decoration: BoxDecoration(
                                border: Border(bottom: BorderSide(width: 0.4,color: Color(0xFFDDDDDD)))
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text("阵容",style:TextStyle(color: Color(0xFFDE3C31),fontSize: sp(14),fontWeight: FontWeight.w500)),
                                SizedBox(height: height(6),),
                                Text("${csProMatchIntelligenceItemOne!.information!}",style:TextStyle(color: Color(0xFF333333),fontSize: sp(14),fontWeight: FontWeight.w400,),),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: height(13),bottom:  height(13),left:  width(25),right: width(25)),
                            decoration: BoxDecoration(
                                border: Border(bottom: BorderSide(width: 0.4,color: Color(0xFFDDDDDD)))
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text("状态",style:TextStyle(color: Color(0xFFDE3C31) ,fontSize: sp(14),fontWeight: FontWeight.w500,),),
                                SizedBox(height: height(6),),
                                Text("${csProMatchIntelligenceItemOne!.status!}",style: TextStyle(color: Color(0xFF333333),fontSize: sp(14),fontWeight: FontWeight.w400,),),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding:(csProMatchIntelligenceItemOne==null)? EdgeInsets.all(width(5)):null,
                      child:(csProMatchIntelligenceItemOne==null)? Text("暂无数据",style: TextStyle(color: Color(0xFF999999)),):SizedBox(),
                    )
                  ],

                ),
              ) ,
            ),

            csProMatchIntelligenceItemTwo==null? SizedBox():AnimatedSize(
              vsync: this,
              duration: Duration(
                  milliseconds: 300
              ),
              child:Container(
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
                margin: EdgeInsets.only(left: width(10),right: width(10),top: width(10)),
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(width(6)),
                      decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(width: 0.4,color: Color(0xFFDDDDDD)))
                      ),
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.center,
                      child: Text(widget.csProGuessInfo.csProTeamTwo??'',style: TextStyle(fontSize: sp(16),fontWeight: FontWeight.w500),),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(top: height(13),bottom:  height(13),left:  width(25),right: width(25)),
                            decoration: BoxDecoration(
                                border: Border(bottom: BorderSide(width: 0.4,color: Color(0xFFDDDDDD)))
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text("阵容",style: TextStyle(color: Color(0xFFDE3C31),fontSize: sp(14),fontWeight: FontWeight.w500,),),
                                SizedBox(height: height(6),),
                                Text(csProMatchIntelligenceItemTwo?.information??'',style:TextStyle(color: Color(0xFF333333),fontSize: sp(14),fontWeight: FontWeight.w400,),),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: height(13),bottom:  height(13),left:  width(25),right: width(25)),
                            decoration: BoxDecoration(
                                border: Border(bottom: BorderSide(width: 0.4,color: Color(0xFFDDDDDD)))
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text("状态",style:TextStyle(color: Color(0xFFDE3C31), fontSize: sp(14),fontWeight: FontWeight.w500,),),
                                SizedBox(height: height(6),),
                                Text(csProMatchIntelligenceItemTwo?.status??'',style:TextStyle(color: Color(0xFF333333),fontSize: sp(14),fontWeight: FontWeight.w400,),),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding:(csProMatchIntelligenceItemTwo==null)? EdgeInsets.all(width(5)):null,
                      child:(csProMatchIntelligenceItemTwo==null)? Text("暂无数据",style: TextStyle(color: Color(0xFF999999)),):SizedBox(),
                    )
                  ],

                ),
              ) ,
            ),


          ],
        ),
      ),
    );
  }


  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  void csMethodInitData() {
    if(csProOrgTextData.length==0){
      return;
    }
    if(csProShowTextData==null){
      csProShowTextData=[];
    }
    csProShowTextData.clear();
    csProOrgTextData.forEach((item){
      if(csProMatchSectionIndex==0){
        csProShowTextData.add(item);
      }else{
        if(csProMatchSectionIndex==int.parse(item.section!)){
          csProShowTextData.add(item);
        }
      }
    });
    setState(() {});
  }

  void csMethodGetLiveText(String refSeqNum) async{

    if(csProIsDispose){
      return;
    }
    CSClassApiManager.csMethodGetInstance().csMethodTextLive<CSClassTextLiveListEntity>(context: context,csProGuessMatchId: widget.csProGuessInfo.csProGuessMatchId,refSeqNum:refSeqNum,csProCallBack: CSClassHttpCallBack(
        csProOnSuccess: (result) async{
          if(result.csProTextLiveList!=null&&result.csProTextLiveList!.isNotEmpty){
            result.csProTextLiveList?.forEach((item){
              if(int.parse(item.section!)>=csProMatchSection.length){
                 if(int.parse(item.section!)>4){
                   csProMatchSection.add("加时"+(int.parse(item.section!)-4).toString());

                 }else{
                   csProMatchSection.add("第"+item.section!+"节");

                 }
              }
            });
            result.csProTextLiveList?.sort((left,right)=>double.parse(right.csProSeqNum!).compareTo(double.parse(left.csProSeqNum!)));
            csProOrgTextData.insertAll(0,result.csProTextLiveList!);
            csMethodInitData();

          }else{
           if(result.csProGuessMatch?.csProIsOver=="1"){
              if(csProOrgTextData.isEmpty){
              }
           }
          }

          if(result.csProGuessMatch!=null&&result.csProGuessMatch?.csProIsRealtimeOver=="0"){
            if(widget.callback!=null){
              widget.csProGuessInfo.status="in_progress";
              widget.csProGuessInfo.csProScoreTwo=result.csProGuessMatch?.csProScoreTwo;
              widget.csProGuessInfo.csProScoreOne=result.csProGuessMatch?.csProScoreOne;
              widget.csProGuessInfo.csProStatusDesc=result.csProGuessMatch?.csProStatusDesc;
              widget.callback!(widget.csProGuessInfo);
            }
            await Future.delayed(Duration(seconds: 3),(){
              csMethodGetLiveText(csProOrgTextData.isEmpty? "":csProOrgTextData[0].csProSeqNum!);
            });
          }
        },
        onError: (result) async{
         if(csProOrgTextData.length>0){
           await Future.delayed(Duration(seconds: 1),(){
             csMethodGetLiveText(csProOrgTextData[0].csProSeqNum!);
           });
         }
    },csProOnProgress: (v){}
    ));
  }


  void csMethodDownCount() {

    if(widget.csProGuessInfo.csProIsOver!="1"){
      csProTimer=  Timer.periodic(Duration(seconds: 1), (timer){
        if(csProTimer==null){
          timer.cancel();
        }else{
          csMethodReFreshTimer();
        }
      });
    }else{
      csMethodGetLiveText("");
    }


  }

  void csMethodReFreshTimer() {

    DateTime nowTime= DateTime.now();

    Duration duration =DateTime.parse(widget.csProGuessInfo.csProStTime!).difference(nowTime);

    hour=(duration.inHours);
    minute=(duration.inMinutes-((duration.inHours*60)));
    second=(duration.inSeconds-(duration.inMinutes*60));

    if(hour<=0&&minute<=0&&second<=0){
      csProTimer?.cancel();
      this.csProTimer=null;
      csMethodGetLiveText("");
      csProShowTextData.add(CSClassTextLiveListTextLiveList()..csProSeqNum="0"..section="0"..csProLeftTime=""..msg="正在实时直播...");

    }
    if(mounted){
      setState(() {

      });
    }
  }

  csMethodBuildDownTimeView() {
    return Container(
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.center,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("距开赛",style: TextStyle(fontSize: sp(12),color: Color(0xFF333333)),),
          SizedBox(width: width(5),),
          Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
                border: Border.all(color:Color(0xFF333333),width: 0.4),
                borderRadius: BorderRadius.circular(width(2))
            ),
            height: width(17),
            width: width(17),
            child:Text(hour.toString(),style: TextStyle(fontSize: sp(12),color: Color(0xFF333333)),),
          ),
          SizedBox(width: width(3),),
          Text(":",style: TextStyle(fontSize: sp(12),color:Color(0xFF333333))),
          SizedBox(width: width(3),),
          Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
                border: Border.all(color:Color(0xFF333333),width: 0.4),
                borderRadius: BorderRadius.circular(width(2))
            ),
            height: width(17),
            width: width(17),
            child:Text(minute.toString(),style: TextStyle(fontSize: sp(12),color: Color(0xFF333333)),),
          ),
          SizedBox(width: width(3),),
          Text(":",style: TextStyle(fontSize: sp(12),color:Color(0xFF333333))),
          SizedBox(width: width(3),),
          Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
                border: Border.all(color:Color(0xFF333333),width: 0.4),
                borderRadius: BorderRadius.circular(width(2))
            ),
            height: width(17),
            width: width(17),
            child:Text(second.toString(),style: TextStyle(fontSize: sp(12),color: Color(0xFF333333)),),
          ),
        ],),
    );
  }

}

