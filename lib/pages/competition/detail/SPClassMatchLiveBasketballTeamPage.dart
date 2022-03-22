import 'dart:async';
import 'dart:math';

import 'package:changshengh5/api/SPClassApiManager.dart';
import 'package:changshengh5/api/SPClassHttpCallBack.dart';
import 'package:changshengh5/generated/json/base/json_convert_content.dart';
import 'package:changshengh5/model/SPClassBaseModelEntity.dart';
import 'package:changshengh5/model/SPClassGuessMatchInfo.dart';
import 'package:changshengh5/model/SPClassMatchInjuryEntity.dart';
import 'package:changshengh5/model/SPClassMatchIntelligenceEntity.dart';
import 'package:changshengh5/model/SPClassMatchLineupPlayerEntity.dart';
import 'package:changshengh5/model/SPClassPlayerStatListEntity.dart';
import 'package:changshengh5/model/SPClassTextLiveListEntity.dart';
import 'package:changshengh5/pages/common/SPClassNoDataView.dart';
import 'package:changshengh5/utils/SPClassCommonMethods.dart';
import 'package:changshengh5/utils/SPClassImageUtil.dart';
import 'package:changshengh5/utils/SPClassMatchDataUtils.dart';
import 'package:changshengh5/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'dart:math' as math;


class SPClassMatchLiveBasketballTeamPage extends  StatefulWidget{
  SPClassGuessMatchInfo spProGuessInfo;
  SPClassMatchLiveBasketballTeamPage(this.spProGuessInfo,{this.callback});
  ValueChanged<SPClassGuessMatchInfo>? callback;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SPClassMatchLiveBasketballTeamPageState();
  }

}

class SPClassMatchLiveBasketballTeamPageState extends State<SPClassMatchLiveBasketballTeamPage> with TickerProviderStateMixin<SPClassMatchLiveBasketballTeamPage> ,AutomaticKeepAliveClientMixin{
  var spProMatchSection  =["全场"];
  var spProMatchSectionIndex=0;
  List<SPClassTextLiveListTextLiveList> spProOrgTextData=[];
  List<SPClassTextLiveListTextLiveList> spProShowTextData=[];
  Timer ?spProTimer;
  int hour=0;
  int minute=0;
  int second=0;
  bool spProIsDispose=false;

  SPClassPlayerStatListBestPlayerList ?spProBestPlayerList; //全场最佳
  PlayerStatListSum ?spProPlayerStatListSum; //球队数据
  List<SPClassPlayerStatListPlayerStatListItem> ?spProPlayerOneDateList; //球员数据
  List<SPClassPlayerStatListPlayerStatListItem> ?spProPlayerTwoDateList; //球员数据
  bool spProShowBest=true;
  bool spProShowTeamDate=true;
  bool spProShowPlayerDate=true;


  SPClassMatchLineupPlayerEntity ?spProMatchLineupPlayerEntity;
  List<SPClassMatchLineupPlayerMatchLineupPlayerItem> ?spProStartingOnes;//首发主队
  List<SPClassMatchLineupPlayerMatchLineupPlayerItem>? spProStartingTwos;//首发客队
  List<SPClassMatchLineupPlayerMatchLineupPlayerItem>? spProSubstituteOnes;//替补客队
  List<SPClassMatchLineupPlayerMatchLineupPlayerItem> ?spProSubstituteTwos;//替补客队
  SPClassMatchInjuryEntity ?spProMatchInjuryEntity;
  var spProShowTeam=true;
  var spProShowJury=true;

  SPClassMatchIntelligenceMatchIntelligenceItem ?spProMatchIntelligenceItemOne;
  SPClassMatchIntelligenceMatchIntelligenceItem ?spProMatchIntelligenceItemTwo;

  var spProIsLoading=true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();


   spFunDownCount();

    SPClassApiManager.spFunGetInstance().spFunSportMatchData<SPClassBaseModelEntity>(
        context: context,spProGuessMatchId:widget.spProGuessInfo.spProGuessMatchId,
        dataKeys:"match_lineup_player;match_injury;match_intelligence",
        spProCallBack: SPClassHttpCallBack(
            spProOnSuccess: (result) async {
              spProIsLoading=false;
              var spProMatchLineupPlayerEntity= JsonConvert.fromJsonAsT<SPClassMatchLineupPlayerEntity>(result.data);
              var spProMatchInjuryEntity= JsonConvert.fromJsonAsT<SPClassMatchInjuryEntity>(result.data);
              var matchIntelligenceEntity= JsonConvert.fromJsonAsT<SPClassMatchIntelligenceEntity>(result.data);
              if(matchIntelligenceEntity.spProMatchIntelligence!=null&&matchIntelligenceEntity.spProMatchIntelligence!.one!=null){
                spProMatchIntelligenceItemOne=matchIntelligenceEntity.spProMatchIntelligence!.one![0];
              }
              if(matchIntelligenceEntity.spProMatchIntelligence!=null&&matchIntelligenceEntity.spProMatchIntelligence!.two!=null){
                spProMatchIntelligenceItemTwo=matchIntelligenceEntity.spProMatchIntelligence!.two![0];
              }

              if(spProMatchLineupPlayerEntity!=null&&spProMatchLineupPlayerEntity.spProMatchLineupPlayer!=null&&
                  (spProMatchLineupPlayerEntity.spProMatchLineupPlayer?.one!=null
                      ||spProMatchLineupPlayerEntity.spProMatchLineupPlayer?.two!=null)
              ){
                spProStartingOnes=[];
                spProSubstituteOnes=[];
                spProStartingTwos=[];
                spProSubstituteTwos=[];
                if(spProMatchLineupPlayerEntity.spProMatchLineupPlayer?.one!=null){
                  spProMatchLineupPlayerEntity.spProMatchLineupPlayer?.one?.forEach((item){
                    if(item.spProIsRegular=="1"){
                      spProStartingOnes?.add(item);
                    }else{
                      spProSubstituteOnes?.add(item);
                    }
                  });
                }
                if(spProMatchLineupPlayerEntity.spProMatchLineupPlayer?.two!=null){
                  spProMatchLineupPlayerEntity.spProMatchLineupPlayer?.two?.forEach((item){
                    if(item.spProIsRegular=="1"){
                      spProStartingTwos?.add(item);
                    }else{
                      spProSubstituteTwos?.add(item);
                    }
                  });
                }
                this.spProMatchLineupPlayerEntity=spProMatchLineupPlayerEntity;
              }

              if(spProMatchInjuryEntity!=null&&spProMatchInjuryEntity.spProMatchInjury!=null){
                this.spProMatchInjuryEntity=spProMatchInjuryEntity;
              }
              setState(() {
              });
              spFunDownCount();
            },onError: (e){
          spFunDownCount();
        },spProOnProgress: (v){}
        )
    );
    SPClassApiManager.spFunGetInstance().spFunPlayerStat<SPClassPlayerStatListEntity>(context: context,spProGuessMatchId:widget.spProGuessInfo.spProGuessMatchId,spProCallBack: SPClassHttpCallBack(
        spProOnSuccess: (result) async {
          if(result!=null){
            if(result.spProBestPlayerList!=null){
              spProBestPlayerList=result.spProBestPlayerList;
            }
            if(result.sum!=null){
              spProPlayerStatListSum=result.sum;
            }

            if(result.spProPlayerStatList!=null){
              if(result.spProPlayerStatList!.one!=null&&result.spProPlayerStatList!.one!.isNotEmpty){
                spProPlayerOneDateList=result.spProPlayerStatList!.one;
                spProPlayerOneDateList!.insert(0,  SPClassPlayerStatListPlayerStatListItem());
              }
              if(result.spProPlayerStatList!.two!=null&&result.spProPlayerStatList!.two!.isNotEmpty){
                spProPlayerTwoDateList=result.spProPlayerStatList?.two;
                spProPlayerTwoDateList?.insert(0, SPClassPlayerStatListPlayerStatListItem());

              }
            }
            if(mounted){
              setState(() {});
            }
          }

          Future.delayed(Duration(milliseconds: 500),(){

            if(spProPlayerStatListSum!=null){
              if(spProPlayerStatListSum!.two!.score!>0&&spProPlayerStatListSum!.one!.score!>0){
                if(spProPlayerStatListSum!.two!.score!>spProPlayerStatListSum!.one!.score!){
                  spProPlayerStatListSum!.two!.spProProgressScore=(60 + (Random().nextInt(20)))/100;
                  spProPlayerStatListSum!.one!.spProProgressScore=(40 + (Random().nextInt(20)))/100;
                }else{
                  spProPlayerStatListSum!.one!.spProProgressScore=(60 + (Random().nextInt(20)))/100;
                  spProPlayerStatListSum!.two!.spProProgressScore=(40 + (Random().nextInt(20)))/100;
                }
              }
              if(spProPlayerStatListSum!.two!.assist!>0&&spProPlayerStatListSum!.one!.assist!>0){
                if(spProPlayerStatListSum!.two!.assist!>spProPlayerStatListSum!.one!.assist!){
                  spProPlayerStatListSum!.two!.spProProgressAssist=(60 + (Random().nextInt(20)))/100;
                  spProPlayerStatListSum!.one!.spProProgressAssist=(40 + (Random().nextInt(20)))/100;
                }else{
                  spProPlayerStatListSum!.one!.spProProgressAssist=(60 + (Random().nextInt(20)))/100;
                  spProPlayerStatListSum!.two!.spProProgressAssist=(40 + (Random().nextInt(20)))/100;
                }
              }
              if(spProPlayerStatListSum!.two!.rebound!>0&&spProPlayerStatListSum!.one!.rebound!>0){
                if(spProPlayerStatListSum!.two!.rebound!>spProPlayerStatListSum!.one!.rebound!){
                  spProPlayerStatListSum!.two!.spProProgressRebound=(60 + (Random().nextInt(20)))/100;
                  spProPlayerStatListSum!.one!.spProProgressRebound=(40 + (Random().nextInt(20)))/100;
                }else{
                  spProPlayerStatListSum!.one!.spProProgressRebound=(60 + (Random().nextInt(20)))/100;
                  spProPlayerStatListSum!.two!.spProProgressRebound=(40 + (Random().nextInt(20)))/100;
                }
              }
              if(spProPlayerStatListSum!.two!.steal!>0&&spProPlayerStatListSum!.one!.steal!>0){
                if(spProPlayerStatListSum!.two!.steal!>spProPlayerStatListSum!.one!.steal!){
                  spProPlayerStatListSum!.two!.spProProgressSteal=(60 + (Random().nextInt(20)))/100;
                  spProPlayerStatListSum!.one!.spProProgressSteal=(40 + (Random().nextInt(20)))/100;
                }else{
                  spProPlayerStatListSum!.one!.spProProgressSteal=(60 + (Random().nextInt(20)))/100;
                  spProPlayerStatListSum!.two!.spProProgressSteal=(40 + (Random().nextInt(20)))/100;
                }
              }
              if(spProPlayerStatListSum!.two!.spProBlockShot!>0&&spProPlayerStatListSum!.one!.spProBlockShot!>0){
                if(spProPlayerStatListSum!.two!.spProBlockShot!>spProPlayerStatListSum!.one!.spProBlockShot!){
                  spProPlayerStatListSum!.two!.spProProgressBlockShot=(60 + (Random().nextInt(20)))/100;
                  spProPlayerStatListSum!.one!.spProProgressBlockShot=(40 + (Random().nextInt(20)))/100;
                }else{
                  spProPlayerStatListSum!.one!.spProProgressBlockShot=(60 + (Random().nextInt(20)))/100;
                  spProPlayerStatListSum!.two!.spProProgressBlockShot=(40 + (Random().nextInt(20)))/100;
                }
              }
              if(spProPlayerStatListSum!.two!.turnover!>0&&spProPlayerStatListSum!.one!.turnover!>0){
                if(spProPlayerStatListSum!.two!.turnover!>spProPlayerStatListSum!.one!.turnover!){
                  spProPlayerStatListSum!.two!.spProProgressTurnover=(60 + (Random().nextInt(20)))/100;
                  spProPlayerStatListSum!.one!.spProProgressTurnover=(40 + (Random().nextInt(20)))/100;
                }else{
                  spProPlayerStatListSum!.one!.spProProgressTurnover=(60 + (Random().nextInt(20)))/100;
                  spProPlayerStatListSum!.two!.spProProgressTurnover=(40 + (Random().nextInt(20)))/100;
                }
              }
              if(mounted){
                setState(() {});
              }
            }


          });

        },onError: (e){},spProOnProgress: (v){}
    ) );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    if(spProTimer!=null){
      spProTimer?.cancel();
    }
    spProIsDispose=true;
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
              child: SPClassNoDataView(height:width(400),),
              visible: (
                  spProShowTextData.length==0
                  &&spProBestPlayerList==null
                  &&spProPlayerStatListSum==null
                  &&spProPlayerOneDateList==null
                  &&spProMatchLineupPlayerEntity==null
                  &&spProMatchInjuryEntity==null
                  &&spProMatchIntelligenceItemOne==null
                  &&spProMatchIntelligenceItemTwo==null),
            ),

            // 节数选择栏
            Visibility(
              child: Container(
                height: width(35),
                color: Color(0xFFF5F6F7),
                child: ListView.builder(
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.horizontal,
                    itemCount: spProMatchSection.length,
                    itemBuilder: (c,index){
                      var item =spProMatchSection[index];
                      return Container(
                        alignment: Alignment.center,
                        child: GestureDetector(
                          child: Container(
                            margin: EdgeInsets.only(left: width(15)),
                            alignment: Alignment.center,
                            child: Text(item,style: TextStyle(color:index==spProMatchSectionIndex? MyColors.main1:Color(0xFF999999),fontSize: sp(15)),),
                          ),
                          onTap: (){
                            spProMatchSectionIndex=index;
                            setState(() {});
                            spFunInitData();
                          },
                        ),
                      );
                    }),
              ),
              visible: spProShowTextData.length>0,
            ),
            // 直播
            ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: spProShowTextData.length,
                itemBuilder: (c,index){
                  var item =spProShowTextData[index];
                  return Container(
                    color: Colors.white,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: width(77),
                          alignment: Alignment.center,
                          child:Text(item.spProLeftTime!,style: TextStyle(color: Color(0xFF303133),fontSize: sp(12)),),
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
                                spProShowBest? SPClassImageUtil.spFunGetImagePath("ic_down_arrow"):SPClassImageUtil.spFunGetImagePath("ic_up_arrow"),
                                width: width(13),
                              ),
                            ),
                            onTap: (){
                              setState(() {spProShowBest=!spProShowBest;});
                            },
                          )
                        ],
                      ),
                    ),
                    (spProBestPlayerList==null||!spProShowBest)? SizedBox(): Container(
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
                                        child: ( widget.spProGuessInfo.spProIconUrlOne!.isEmpty)? Image.asset(
                                          SPClassImageUtil.spFunGetImagePath("ic_team_two"),
                                          width: width(20),
                                        ):Image.network(
                                          widget.spProGuessInfo.spProIconUrlOne!,
                                          width: width(20),
                                        ),
                                      ),
                                      SizedBox(width: 4,),
                                      Text(widget.spProGuessInfo.spProTeamOne!,style: TextStyle(fontSize: sp(12)),),


                                    ],
                                  ),
                                ),
                                SizedBox(width: width(80),),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Text(widget.spProGuessInfo.spProTeamTwo!,style: TextStyle(fontSize: sp(12)),),
                                      SizedBox(width: 4,),
                                      Container(
                                        child: ( widget.spProGuessInfo.spProIconUrlTwo!.isEmpty)? Image.asset(
                                          SPClassImageUtil.spFunGetImagePath("ic_team_one"),
                                          width: width(20),
                                        ):Image.network(
                                          widget.spProGuessInfo.spProIconUrlTwo!,
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
                                                SPClassImageUtil.spFunGetImagePath("ic_basketball_one_team"),
                                                width: width(20),
                                              ),
                                            ),
                                            SizedBox(width: 4,),
                                            Expanded(
                                              child:Text(SPClassMatchDataUtils.spFunPlayName(spProBestPlayerList!.oen!.score!.spProPlayerName!),style: TextStyle(fontSize: sp(12)),maxLines: 1,overflow: TextOverflow.ellipsis,),
                                            )
                                          ],
                                        ),
                                      ),
                                      SizedBox(width: 4,),
                                      Text(spProBestPlayerList!.oen!.score!.score!,style: TextStyle(color: Color(0xFFE3494B),fontWeight: FontWeight.w500, fontSize: sp(13),)),

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


                                      Text("${spProBestPlayerList!.two!.score!.score!}",style: TextStyle(color: Color(0xFFE3494B),fontWeight: FontWeight.w500,fontSize: sp(13),)),
                                      SizedBox(width: 4,),
                                      Expanded(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: <Widget>[
                                            Expanded(
                                              child:Text("${SPClassMatchDataUtils.spFunPlayName(spProBestPlayerList!.two!.score!.spProPlayerName!)}",style: TextStyle(fontSize: sp(12)),maxLines: 1,overflow: TextOverflow.ellipsis,textAlign: TextAlign.right,),
                                            ),
                                            SizedBox(width: 4,),

                                            Container(
                                              child:  Image.asset(
                                                SPClassImageUtil.spFunGetImagePath("ic_basketball_two_team"),
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
                                                SPClassImageUtil.spFunGetImagePath("ic_basketball_one_team"),
                                                width: width(20),
                                              ),
                                            ),
                                            SizedBox(width: 4,),
                                            Expanded(
                                              child:Text("${SPClassMatchDataUtils.spFunPlayName(spProBestPlayerList!.oen!.rebound!.spProPlayerName!)}",style: TextStyle(fontSize: sp(12)),maxLines: 1,overflow: TextOverflow.ellipsis,),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(width: 4,),

                                      Text("${spProBestPlayerList!.oen!.rebound!.rebound!}",style: TextStyle(color: Color(0xFFE3494B),fontWeight: FontWeight.w500,fontSize: sp(13),)),


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
                                      Text("${spProBestPlayerList!.two!.rebound!.rebound!}",style:TextStyle(color: Color(0xFFE3494B), fontSize: sp(13),fontWeight: FontWeight.w500),),
                                      SizedBox(width: 4,),
                                      Expanded(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: <Widget>[
                                            Expanded(
                                              child:Text("${SPClassMatchDataUtils.spFunPlayName(spProBestPlayerList!.two!.rebound!.spProPlayerName!)}",style: TextStyle(fontSize: sp(12)),maxLines: 1,overflow: TextOverflow.ellipsis,textAlign: TextAlign.right,),
                                            ),
                                            SizedBox(width: 4,),
                                            Container(
                                              child:  Image.asset(
                                                SPClassImageUtil.spFunGetImagePath("ic_basketball_two_team"),
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
                                                SPClassImageUtil.spFunGetImagePath("ic_basketball_one_team"),
                                                width: width(20),
                                              ),
                                            ),
                                            SizedBox(width: 4,),
                                            Expanded(
                                              child:Text("${SPClassMatchDataUtils.spFunPlayName(spProBestPlayerList!.oen!.assist!.spProPlayerName!)}",style: TextStyle(fontSize: sp(12)),maxLines: 1,overflow: TextOverflow.ellipsis,),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(width: 4,),
                                      Text("${spProBestPlayerList!.oen!.assist!.assist!}",style:  TextStyle(color: Color(0xFFE3494B),fontSize: sp(13),fontWeight: FontWeight.w500,)),

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
                                      Text("${spProBestPlayerList!.two!.assist!.assist!}",style: TextStyle(color: Color(0xFFE3494B),fontSize: sp(13),fontWeight: FontWeight.w500),),
                                      SizedBox(width: 4,),
                                      Expanded(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: <Widget>[
                                            Expanded(
                                              child:Text("${SPClassMatchDataUtils.spFunPlayName(spProBestPlayerList!.two!.assist!.spProPlayerName!)}",style: TextStyle(fontSize: sp(12)),maxLines: 1,overflow: TextOverflow.ellipsis,textAlign: TextAlign.right,),
                                            ),
                                            SizedBox(width: 4,),

                                            Container(
                                              child:  Image.asset(
                                                SPClassImageUtil.spFunGetImagePath("ic_basketball_two_team"),
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
                    (spProBestPlayerList!=null)?  SizedBox(): Container(
                      padding:EdgeInsets.all(width(5)),
                      child:Text("暂无数据",style: TextStyle(color: Color(0xFF999999)),),
                    )
                  ],

                ),
              ),
              visible: spProBestPlayerList!=null,
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
                                spProShowTeamDate? SPClassImageUtil.spFunGetImagePath("ic_down_arrow"):SPClassImageUtil.spFunGetImagePath("ic_up_arrow"),
                                width: width(13),
                              ),
                            ),
                            onTap: (){
                              setState(() {spProShowTeamDate=!spProShowTeamDate;});
                            },
                          )
                        ],
                      ),
                    ),
                    (spProPlayerStatListSum==null||!spProShowTeamDate)? SizedBox(): Container(
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
                                        child: ( widget.spProGuessInfo.spProIconUrlOne!.isEmpty)? Image.asset(
                                          SPClassImageUtil.spFunGetImagePath("ic_team_two"),
                                          width: width(20),
                                        ):Image.network(
                                          widget.spProGuessInfo.spProIconUrlOne!,
                                          width: width(20),
                                        ),
                                      ),
                                      SizedBox(width: 4,),
                                      Text(widget.spProGuessInfo.spProTeamOne!,style: TextStyle(fontSize: sp(12)),),


                                    ],
                                  ),
                                ),
                                SizedBox(width: width(80),),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Text(widget.spProGuessInfo.spProTeamTwo!,style: TextStyle(fontSize: sp(12)),),
                                      SizedBox(width: 4,),
                                      Container(
                                        child: ( widget.spProGuessInfo.spProIconUrlTwo!.isEmpty)? Image.asset(
                                          SPClassImageUtil.spFunGetImagePath("ic_team_one"),
                                          width: width(20),
                                        ):Image.network(
                                          widget.spProGuessInfo.spProIconUrlTwo!,
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
                                      Text("${spProPlayerStatListSum!.one!.score!.toString()}",style: TextStyle(fontSize: sp(11)),),
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
                                                  color:(spProPlayerStatListSum!.one!.spProProgressScore>=spProPlayerStatListSum!.two!.spProProgressScore)? Colors.red:Color(0xFF888888),
                                                  borderRadius: BorderRadius.circular(300)
                                              ),
                                              width: width(85)*spProPlayerStatListSum!.one!.spProProgressScore,
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
                                                  color:(spProPlayerStatListSum!.two!.spProProgressScore>=spProPlayerStatListSum!.one!.spProProgressScore)? Colors.red:Color(0xFF888888),
                                                  borderRadius: BorderRadius.circular(300)
                                              ),
                                              width: width(85)*spProPlayerStatListSum!.two!.spProProgressScore,
                                              height: height(7),
                                            ),
                                            vsync: this,
                                          ),
                                        ],
                                      ),
                                      Expanded(
                                        child: SizedBox(),
                                      ),
                                      Text("${spProPlayerStatListSum!.two!.score}",style: TextStyle(fontSize: sp(11)),),

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
                                      Text("${spProPlayerStatListSum!.one!.assist.toString()}",style: TextStyle(fontSize: sp(11)),),
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
                                                  color:(spProPlayerStatListSum!.one!.spProProgressAssist>=spProPlayerStatListSum!.two!.spProProgressAssist)? Colors.red:Color(0xFF888888),
                                                  borderRadius: BorderRadius.circular(300)
                                              ),
                                              width: width(85)*spProPlayerStatListSum!.one!.spProProgressAssist,
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
                                                  color:(spProPlayerStatListSum!.two!.spProProgressAssist>=spProPlayerStatListSum!.one!.spProProgressAssist)? Colors.red:Color(0xFF888888),
                                                  borderRadius: BorderRadius.circular(300)
                                              ),
                                              width: width(85)*spProPlayerStatListSum!.two!.spProProgressAssist,
                                              height: height(7),
                                            ),
                                            vsync: this,
                                          ),
                                        ],
                                      ),
                                      Expanded(
                                        child: SizedBox(),
                                      ),
                                      Text("${spProPlayerStatListSum!.two!.assist}",style: TextStyle(fontSize: sp(11)),),

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
                                      Text("${spProPlayerStatListSum!.one!.spProBlockShot.toString()}",style: TextStyle(fontSize: sp(11)),),
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
                                                  color:(spProPlayerStatListSum!.one!.spProProgressBlockShot>=spProPlayerStatListSum!.two!.spProProgressBlockShot)? Colors.red:Color(0xFF888888),
                                                  borderRadius: BorderRadius.circular(300)
                                              ),
                                              width: width(85)*spProPlayerStatListSum!.one!.spProProgressBlockShot,
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
                                                  color:(spProPlayerStatListSum!.two!.spProProgressBlockShot>=spProPlayerStatListSum!.one!.spProProgressBlockShot)? Colors.red:Color(0xFF888888),
                                                  borderRadius: BorderRadius.circular(300)
                                              ),
                                              width: width(85)*spProPlayerStatListSum!.two!.spProProgressBlockShot,
                                              height: height(7),
                                            ),
                                            vsync: this,
                                          ),
                                        ],
                                      ),
                                      Expanded(
                                        child: SizedBox(),
                                      ),
                                      Text("${spProPlayerStatListSum!.two!.spProBlockShot}",style: TextStyle(fontSize: sp(11)),),

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
                                      Text("${spProPlayerStatListSum!.one!.rebound.toString()}",style: TextStyle(fontSize: sp(11)),),
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
                                                  color:(spProPlayerStatListSum!.one!.spProProgressRebound>=spProPlayerStatListSum!.two!.spProProgressRebound)? Colors.red:Color(0xFF888888),
                                                  borderRadius: BorderRadius.circular(300)
                                              ),
                                              width: width(85)*spProPlayerStatListSum!.one!.spProProgressRebound,
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
                                                  color:(spProPlayerStatListSum!.two!.spProProgressRebound>=spProPlayerStatListSum!.one!.spProProgressRebound)? Colors.red:Color(0xFF888888),
                                                  borderRadius: BorderRadius.circular(300)
                                              ),
                                              width: width(85)*spProPlayerStatListSum!.two!.spProProgressRebound,
                                              height: height(7),
                                            ),
                                            vsync: this,
                                          ),
                                        ],
                                      ),
                                      Expanded(
                                        child: SizedBox(),
                                      ),
                                      Text("${spProPlayerStatListSum!.two!.rebound}",style: TextStyle(fontSize: sp(11)),),

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
                                      Text("${spProPlayerStatListSum!.one!.steal.toString()}",style: TextStyle(fontSize: sp(11)),),
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
                                                  color:(spProPlayerStatListSum!.one!.spProProgressSteal>=spProPlayerStatListSum!.two!.spProProgressSteal)? Colors.red:Color(0xFF888888),
                                                  borderRadius: BorderRadius.circular(300)
                                              ),
                                              width: width(85)*spProPlayerStatListSum!.one!.spProProgressSteal,
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
                                                  color:(spProPlayerStatListSum!.two!.spProProgressSteal>=spProPlayerStatListSum!.one!.spProProgressSteal)? Colors.red:Color(0xFF888888),
                                                  borderRadius: BorderRadius.circular(300)
                                              ),
                                              width: width(85)*spProPlayerStatListSum!.two!.spProProgressSteal,
                                              height: height(7),
                                            ),
                                            vsync: this,
                                          ),
                                        ],
                                      ),
                                      Expanded(
                                        child: SizedBox(),
                                      ),
                                      Text("${spProPlayerStatListSum!.two!.steal}",style: TextStyle(fontSize: sp(11)),),

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
                                      Text("${spProPlayerStatListSum!.one!.turnover.toString()}",style: TextStyle(fontSize: sp(11)),),
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
                                                  color:(spProPlayerStatListSum!.one!.spProProgressTurnover>=spProPlayerStatListSum!.two!.spProProgressTurnover)? Colors.red:Color(0xFF888888),
                                                  borderRadius: BorderRadius.circular(300)
                                              ),
                                              width: width(85)*spProPlayerStatListSum!.one!.spProProgressTurnover,
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
                                                  color:(spProPlayerStatListSum!.two!.spProProgressTurnover>=spProPlayerStatListSum!.one!.spProProgressTurnover)? Colors.red:Color(0xFF888888),
                                                  borderRadius: BorderRadius.circular(300)
                                              ),
                                              width: width(85)*spProPlayerStatListSum!.two!.spProProgressTurnover,
                                              height: height(7),
                                            ),
                                            vsync: this,
                                          ),
                                        ],
                                      ),
                                      Expanded(
                                        child: SizedBox(),
                                      ),
                                      Text("${spProPlayerStatListSum!.two!.turnover}",style: TextStyle(fontSize: sp(11)),),

                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    (spProPlayerStatListSum!=null)?  SizedBox(): Container(
                      padding:EdgeInsets.all(width(5)),
                      child:Text("暂无数据",style: TextStyle(color: Color(0xFF999999)),),
                    )
                  ],

                ),
              ),
              visible: spProPlayerStatListSum!=null,
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
                                spProShowPlayerDate? SPClassImageUtil.spFunGetImagePath("ic_down_arrow"):SPClassImageUtil.spFunGetImagePath("ic_up_arrow"),
                                width: width(13),
                              ),
                            ),
                            onTap: (){
                              setState(() {spProShowPlayerDate=!spProShowPlayerDate;});
                            },
                          )
                        ],
                      ),
                    ),

                    (spProPlayerOneDateList==null||!spProShowPlayerDate)? SizedBox(): Container(
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding:EdgeInsets.only(left: height(17,),right: height(17,)),
                            margin: EdgeInsets.only(top: height(7)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  child: ( widget.spProGuessInfo.spProIconUrlOne!.isEmpty)? Image.asset(
                                    SPClassImageUtil.spFunGetImagePath("ic_team_one"),
                                    width: width(20),
                                  ):Image.network(
                                    widget.spProGuessInfo.spProIconUrlOne!,
                                    width: width(20),
                                  ),
                                ),
                                SizedBox(width: 4,),
                                Text(widget.spProGuessInfo.spProTeamOne!,style: TextStyle(fontSize: sp(12)),),


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
                                    children: spProPlayerOneDateList!.map((item){
                                      var index =spProPlayerOneDateList!.indexOf(item);
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
                                              child: Text( index==0 ? "球员":item.spProPlayerName!,style:TextStyle(fontSize: sp(11),fontWeight:index==0 ?  FontWeight.w500:null),textAlign: TextAlign.center,maxLines: 2,overflow:TextOverflow.ellipsis,),
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
                                        children: spProPlayerOneDateList!.map((item){
                                          var index =spProPlayerOneDateList!.indexOf(item);

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
                                                  child: Text(index==0 ?  "状态":(item.spProIsRegular=="1")? "首发":"替补",style: TextStyle(fontSize: sp(11),fontWeight:index==0 ? FontWeight.w500:null),textAlign: TextAlign.center,maxLines: 2,overflow:TextOverflow.ellipsis,),
                                                ),
                                                Container(
                                                  alignment: Alignment.center,
                                                  height: width(33),
                                                  width: width(46.5),
                                                  child: Text(index==0 ?  "时间":item.spProPlayingTime!,style: TextStyle(fontSize: sp(11),fontWeight:index==0 ? FontWeight.w500:null),textAlign: TextAlign.center,maxLines: 2,overflow:TextOverflow.ellipsis,),
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
                                                  child: Text(index==0 ?  "三分":item.spProThreePoint!,style: TextStyle(fontSize: sp(11),fontWeight:index==0 ? FontWeight.w500:null),textAlign: TextAlign.center,maxLines: 2,overflow:TextOverflow.ellipsis,),
                                                ),
                                                Container(
                                                  alignment: Alignment.center,
                                                  height: width(33),
                                                  width: width(48),
                                                  child: Text(index==0 ?  "罚球":item.spProFreeThrow!,style:TextStyle(fontSize: sp(11),fontWeight:index==0 ? FontWeight.w500:null),textAlign: TextAlign.center,maxLines: 2,overflow:TextOverflow.ellipsis,),
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
                                                  child: Text(index==0 ?  "盖帽":item.spProBlockShot!,style: TextStyle(fontSize: sp(11),fontWeight:index==0 ? FontWeight.w500:null),textAlign: TextAlign.center,maxLines: 2,overflow:TextOverflow.ellipsis,),
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
                    (spProPlayerTwoDateList==null||!spProShowPlayerDate)? SizedBox(): Container(
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding:EdgeInsets.only(left: height(17,),right: height(17,)),
                            margin: EdgeInsets.only(top: height(7)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  child: ( widget.spProGuessInfo.spProIconUrlTwo!.isEmpty)? Image.asset(
                                    SPClassImageUtil.spFunGetImagePath("ic_team_two"),
                                    width: width(20),
                                  ):Image.network(
                                    widget.spProGuessInfo.spProIconUrlTwo!,
                                    width: width(20),
                                  ),
                                ),
                                SizedBox(width: 4,),
                                Text(widget.spProGuessInfo.spProTeamTwo!,style: TextStyle(fontSize: sp(12)),),


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
                                    children: spProPlayerTwoDateList!.map((item){
                                      var index =spProPlayerTwoDateList!.indexOf(item);
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
                                              child: Text( index==0 ? "球员":item.spProPlayerName!,style:TextStyle(fontSize: sp(11),fontWeight:index==0 ?  FontWeight.w500:null),textAlign: TextAlign.center,maxLines: 2,overflow:TextOverflow.ellipsis,),
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
                                        children: spProPlayerTwoDateList!.map((item){
                                          var index =spProPlayerTwoDateList!.indexOf(item);

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
                                                  child: Text(index==0 ?  "状态":(item.spProIsRegular=="1")? "首发":"替补",style: TextStyle(fontSize: sp(11),fontWeight:index==0 ? FontWeight.w500:null),textAlign: TextAlign.center,maxLines: 2,overflow:TextOverflow.ellipsis,),
                                                ),
                                                Container(
                                                  alignment: Alignment.center,
                                                  height: width(33),
                                                  width: width(46.5),
                                                  child: Text(index==0 ?  "时间":item.spProPlayingTime!,style: TextStyle(fontSize: sp(11),fontWeight:index==0 ? FontWeight.w500:null),textAlign: TextAlign.center,maxLines: 2,overflow:TextOverflow.ellipsis,),
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
                                                  child: Text(index==0 ?  "三分":item.spProThreePoint!,style: TextStyle(fontSize: sp(11),fontWeight:index==0 ? FontWeight.w500:null),textAlign: TextAlign.center,maxLines: 2,overflow:TextOverflow.ellipsis,),
                                                ),
                                                Container(
                                                  alignment: Alignment.center,
                                                  height: width(33),
                                                  width: width(48),
                                                  child: Text(index==0 ?  "罚球":item.spProFreeThrow!,style: TextStyle(fontSize: sp(11),fontWeight:index==0 ? FontWeight.w500:null),textAlign: TextAlign.center,maxLines: 2,overflow:TextOverflow.ellipsis,),
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
                                                  child: Text(index==0 ?  "盖帽":item.spProBlockShot!,style: TextStyle(fontSize: sp(11),fontWeight:index==0 ? FontWeight.w500:null),textAlign: TextAlign.center,maxLines: 2,overflow:TextOverflow.ellipsis,),
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
              visible: spProPlayerOneDateList!=null,
            ),

           (spProMatchLineupPlayerEntity==null)?  SizedBox(): AnimatedSize(
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
                                spProShowTeam? SPClassImageUtil.spFunGetImagePath("ic_down_arrow"):SPClassImageUtil.spFunGetImagePath("ic_up_arrow"),
                                width: width(13),
                              ),
                            ),
                            onTap: (){
                              setState(() {spProShowTeam=!spProShowTeam;});
                            },
                          )
                        ],
                      ),
                    ),


                    (spProMatchLineupPlayerEntity==null||!spProShowTeam)?SizedBox(): Container(
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(width(13)),
                            child: Row(
                              children: <Widget>[
                                Expanded(child: Row(
                                  children: <Widget>[
                                    ( widget.spProGuessInfo.spProIconUrlOne!.isEmpty)? Image.asset(
                                      SPClassImageUtil.spFunGetImagePath("ic_team_one"),
                                      width: width(20),
                                    ):Image.network(
                                      widget.spProGuessInfo.spProIconUrlOne!,
                                      width: width(20),
                                    ),
                                    SizedBox(width: 5,),
                                    Text(widget.spProGuessInfo.spProTeamOne!,style: TextStyle(fontSize: sp(12)),)
                                  ],

                                ),),
                                Expanded(child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Text(widget.spProGuessInfo.spProTeamTwo!,style: TextStyle(fontSize: sp(12)),),
                                    SizedBox(width: 5,),
                                    ( widget.spProGuessInfo.spProIconUrlTwo!.isEmpty)? Image.asset(
                                      SPClassImageUtil.spFunGetImagePath("ic_team_two"),
                                      width: width(20),
                                    ):Image.network(
                                      widget.spProGuessInfo.spProIconUrlTwo!,
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
                              itemCount: math.max(spProStartingOnes!.length, spProStartingTwos!.length),
                              itemBuilder: (c,index){
                                return  Container(
                                  padding: EdgeInsets.only(top: height(8),bottom: height(8)),
                                  decoration: BoxDecoration(
                                      border: Border(bottom: BorderSide(color: Colors.grey[300]!,width: 0.4))
                                  ),
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(child:(index<=(spProStartingOnes!.length-1))? Row(
                                        children: <Widget>[
                                          Container(
                                            width: width(21),
                                            padding: EdgeInsets.all(width(2)),
                                            alignment: Alignment.center,
                                            decoration: ShapeDecoration(
                                                shape: CircleBorder(),
                                                color: Color(0xFFEA5E5E)
                                            ),
                                            child: Text(spProStartingOnes![index].spProShirtNumber!,style: TextStyle(color: Colors.white,fontSize: sp(12)),),
                                          ),
                                          SizedBox(width: 3,),
                                          Text(spProStartingOnes![index].spProPlayerName!,maxLines: 1,style:TextStyle(fontSize: sp(12)),)
                                        ],
                                      ):SizedBox(),),
                                      Expanded(child:(index<=(spProStartingTwos!.length-1))? Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: <Widget>[
                                          Text(spProStartingTwos![index].spProPlayerName!,maxLines: 1,style:TextStyle(fontSize: sp(12)),),
                                          SizedBox(width: 3,),
                                          Container(
                                            width: width(21),
                                            padding: EdgeInsets.all(width(2)),
                                            alignment: Alignment.center,
                                            decoration: ShapeDecoration(
                                                shape: CircleBorder(),
                                                color: Color(0xFF5D9CEC)
                                            ),
                                            child: Text(spProStartingTwos![index].spProShirtNumber!,style: TextStyle(color: Colors.white,fontSize: sp(12)),),
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
                              itemCount: math.max(spProSubstituteOnes!.length, spProSubstituteTwos!.length),
                              itemBuilder: (c,index){
                                return  Container(
                                  padding: EdgeInsets.only(top: height(8),bottom: height(8)),
                                  decoration: BoxDecoration(
                                      border: Border(bottom: BorderSide(color: Colors.grey[300]!,width: 0.4))
                                  ),
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(child:(index<=(spProSubstituteOnes!.length-1))? Row(
                                        children: <Widget>[
                                          Container(
                                            width: width(21),
                                            padding: EdgeInsets.all(width(2)),
                                            alignment: Alignment.center,
                                            decoration: ShapeDecoration(
                                                shape: CircleBorder(),
                                                color: Color(0xFFEA5E5E)
                                            ),
                                            child: Text(spProSubstituteOnes![index].spProShirtNumber!,style: TextStyle(color: Colors.white,fontSize: sp(12)),),
                                          ),
                                          SizedBox(width: 3,),
                                          Text(spProSubstituteOnes![index].spProPlayerName!,maxLines: 1,style:TextStyle(fontSize: sp(12)),)
                                        ],
                                      ):SizedBox(),),
                                      Expanded(child:(index<=(spProSubstituteTwos!.length-1))? Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: <Widget>[
                                          Text(spProSubstituteTwos![index].spProPlayerName!,maxLines: 1,style:TextStyle(fontSize: sp(12)),),
                                          SizedBox(width: 3,),
                                          Container(
                                            width: width(21),
                                            padding: EdgeInsets.all(width(2)),
                                            alignment: Alignment.center,
                                            decoration: ShapeDecoration(
                                                shape: CircleBorder(),
                                                color: Color(0xFF5D9CEC)
                                            ),
                                            child: Text(spProSubstituteTwos![index].spProShirtNumber!,style: TextStyle(color: Colors.white,fontSize: sp(12)),),
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

            (  spProMatchInjuryEntity==null)? SizedBox(): AnimatedSize(
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
                                spProShowJury? SPClassImageUtil.spFunGetImagePath("ic_down_arrow"):SPClassImageUtil.spFunGetImagePath("ic_up_arrow"),
                                width: width(13),
                              ),
                            ),
                            onTap: (){
                              setState(() {spProShowJury=!spProShowJury;});
                            },
                          )
                        ],
                      ),
                    ),
                    (  spProMatchInjuryEntity==null||!spProShowJury)? SizedBox():Container(
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
                                    ( widget.spProGuessInfo.spProIconUrlOne!.isEmpty)? Image.asset(
                                      SPClassImageUtil.spFunGetImagePath("ic_team_one"),
                                      width: width(20),
                                    ):Image.network(
                                      widget.spProGuessInfo.spProIconUrlOne!,
                                      width: width(20),
                                    ),
                                    SizedBox(width: 5,),
                                    Text(widget.spProGuessInfo.spProTeamOne!,style: TextStyle(fontSize: sp(12)),)
                                  ],

                                ),),
                              ],
                            ),
                          ),
                          spProMatchInjuryEntity!.spProMatchInjury!.one==null ? SizedBox():  ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.only(left: width(18),right: width(18)),
                              shrinkWrap: true,
                              itemCount: spProMatchInjuryEntity!.spProMatchInjury!.one!.length,
                              itemBuilder: (c,index){
                                var item =spProMatchInjuryEntity!.spProMatchInjury!.one![index];
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
                                            child: Text(item.spProShirtNumber!,style: TextStyle(color: Colors.white,fontSize: sp(12)),),
                                          ),
                                          SizedBox(width: 3,),
                                          Text(item.spProPlayerName!,maxLines: 1,style:TextStyle(fontSize: sp(12)),)
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

                          spProMatchInjuryEntity!.spProMatchInjury!.two==null ?  SizedBox():   Container(
                            padding: EdgeInsets.all(width(13)),
                            child: Row(
                              children: <Widget>[
                                Expanded(child: Row(
                                  children: <Widget>[
                                    ( widget.spProGuessInfo.spProIconUrlTwo!.isEmpty)? Image.asset(
                                      SPClassImageUtil.spFunGetImagePath("ic_team_two"),
                                      width: width(20),
                                    ):Image.network(
                                      widget.spProGuessInfo.spProIconUrlTwo!,
                                      width: width(20),
                                    ),
                                    SizedBox(width: 5,),
                                    Text(widget.spProGuessInfo.spProTeamTwo!,style: TextStyle(fontSize: sp(12)),)
                                  ],

                                ),),
                              ],
                            ),
                          ),
                          spProMatchInjuryEntity!.spProMatchInjury!.two==null ? SizedBox():      ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.only(left: width(18),right: width(18)),
                              shrinkWrap: true,
                              itemCount: spProMatchInjuryEntity!.spProMatchInjury!.two!.length,
                              itemBuilder: (c,index){
                                var item =spProMatchInjuryEntity!.spProMatchInjury!.two![index];
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
                                            child: Text(item.spProShirtNumber!,style: TextStyle(color: Colors.white,fontSize: sp(12)),),
                                          ),
                                          SizedBox(width: 3,),
                                          Text(item.spProPlayerName!,maxLines: 1,style:TextStyle(fontSize: sp(12)),)
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

            spProMatchIntelligenceItemOne==null? SizedBox():AnimatedSize(
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
                      child: Text(widget.spProGuessInfo.spProTeamOne!,style: TextStyle(fontSize: sp(16),fontWeight: FontWeight.w500),),
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
                                Text("${spProMatchIntelligenceItemOne!.information!}",style:TextStyle(color: Color(0xFF333333),fontSize: sp(14),fontWeight: FontWeight.w400,),),
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
                                Text("${spProMatchIntelligenceItemOne!.status!}",style: TextStyle(color: Color(0xFF333333),fontSize: sp(14),fontWeight: FontWeight.w400,),),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding:(spProMatchIntelligenceItemOne==null)? EdgeInsets.all(width(5)):null,
                      child:(spProMatchIntelligenceItemOne==null)? Text("暂无数据",style: TextStyle(color: Color(0xFF999999)),):SizedBox(),
                    )
                  ],

                ),
              ) ,
            ),

            spProMatchIntelligenceItemTwo==null? SizedBox():AnimatedSize(
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
                      child: Text(widget.spProGuessInfo.spProTeamTwo??'',style: TextStyle(fontSize: sp(16),fontWeight: FontWeight.w500),),
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
                                Text(spProMatchIntelligenceItemTwo?.information??'',style:TextStyle(color: Color(0xFF333333),fontSize: sp(14),fontWeight: FontWeight.w400,),),
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
                                Text(spProMatchIntelligenceItemTwo?.status??'',style:TextStyle(color: Color(0xFF333333),fontSize: sp(14),fontWeight: FontWeight.w400,),),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding:(spProMatchIntelligenceItemTwo==null)? EdgeInsets.all(width(5)):null,
                      child:(spProMatchIntelligenceItemTwo==null)? Text("暂无数据",style: TextStyle(color: Color(0xFF999999)),):SizedBox(),
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

  void spFunInitData() {
    if(spProOrgTextData.length==0){
      return;
    }
    if(spProShowTextData==null){
      spProShowTextData=[];
    }
    spProShowTextData.clear();
    spProOrgTextData.forEach((item){
      if(spProMatchSectionIndex==0){
        spProShowTextData.add(item);
      }else{
        if(spProMatchSectionIndex==int.parse(item.section!)){
          spProShowTextData.add(item);
        }
      }
    });
    setState(() {});
  }

  void spFunGetLiveText(String refSeqNum) async{

    if(spProIsDispose){
      return;
    }
    SPClassApiManager.spFunGetInstance().spFunTextLive<SPClassTextLiveListEntity>(context: context,spProGuessMatchId: widget.spProGuessInfo.spProGuessMatchId,refSeqNum:refSeqNum,spProCallBack: SPClassHttpCallBack(
        spProOnSuccess: (result) async{
          if(result.spProTextLiveList!=null&&result.spProTextLiveList!.isNotEmpty){
            result.spProTextLiveList?.forEach((item){
              if(int.parse(item.section!)>=spProMatchSection.length){
                 if(int.parse(item.section!)>4){
                   spProMatchSection.add("加时"+(int.parse(item.section!)-4).toString());

                 }else{
                   spProMatchSection.add("第"+item.section!+"节");

                 }
              }
            });
            result.spProTextLiveList?.sort((left,right)=>double.parse(right.spProSeqNum!).compareTo(double.parse(left.spProSeqNum!)));
            spProOrgTextData.insertAll(0,result.spProTextLiveList!);
            spFunInitData();

          }else{
           if(result.spProGuessMatch?.spProIsOver=="1"){
              if(spProOrgTextData.isEmpty){
              }
           }
          }

          if(result.spProGuessMatch!=null&&result.spProGuessMatch?.spProIsRealtimeOver=="0"){
            if(widget.callback!=null){
              widget.spProGuessInfo.status="in_progress";
              widget.spProGuessInfo.spProScoreTwo=result.spProGuessMatch?.spProScoreTwo;
              widget.spProGuessInfo.spProScoreOne=result.spProGuessMatch?.spProScoreOne;
              widget.spProGuessInfo.spProStatusDesc=result.spProGuessMatch?.spProStatusDesc;
              widget.callback!(widget.spProGuessInfo);
            }
            await Future.delayed(Duration(seconds: 3),(){
              spFunGetLiveText(spProOrgTextData.isEmpty? "":spProOrgTextData[0].spProSeqNum!);
            });
          }
        },
        onError: (result) async{
         if(spProOrgTextData.length>0){
           await Future.delayed(Duration(seconds: 1),(){
             spFunGetLiveText(spProOrgTextData[0].spProSeqNum!);
           });
         }
    },spProOnProgress: (v){}
    ));
  }


  void spFunDownCount() {

    if(widget.spProGuessInfo.spProIsOver!="1"){
      spProTimer=  Timer.periodic(Duration(seconds: 1), (timer){
        if(spProTimer==null){
          timer.cancel();
        }else{
          spFunReFreshTimer();
        }
      });
    }else{
      spFunGetLiveText("");
    }


  }

  void spFunReFreshTimer() {

    DateTime nowTime= DateTime.now();

    Duration duration =DateTime.parse(widget.spProGuessInfo.spProStTime!).difference(nowTime);

    hour=(duration.inHours);
    minute=(duration.inMinutes-((duration.inHours*60)));
    second=(duration.inSeconds-(duration.inMinutes*60));

    if(hour<=0&&minute<=0&&second<=0){
      spProTimer?.cancel();
      this.spProTimer=null;
      spFunGetLiveText("");
      spProShowTextData.add(SPClassTextLiveListTextLiveList()..spProSeqNum="0"..section="0"..spProLeftTime=""..msg="正在实时直播...");

    }
    if(mounted){
      setState(() {

      });
    }
  }

  spFunBuildDownTimeView() {
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

