import 'dart:async';
import 'dart:convert';
import 'dart:math' as math;
import 'package:changshengh5/api/CSClassApiManager.dart';
import 'package:changshengh5/api/CSClassHttpCallBack.dart';
import 'package:changshengh5/generated/json/base/json_convert_content.dart';
import 'package:changshengh5/model/CSClassBaseModelEntity.dart';
import 'package:changshengh5/model/CSClassChartDoughnutData.dart';
import 'package:changshengh5/model/CSClassGuessMatchInfo.dart';
import 'package:changshengh5/model/CSClassMatchEventEntity.dart';
import 'package:changshengh5/model/CSClassMatchInjuryEntity.dart';
import 'package:changshengh5/model/CSClassMatchIntelligenceEntity.dart';
import 'package:changshengh5/model/CSClassMatchLineupEntity.dart';
import 'package:changshengh5/model/CSClassMatchLineupPlayerEntity.dart';
import 'package:changshengh5/model/CSClassMatchStatListEntity.dart';
import 'package:changshengh5/pages/common/CSClassLoadingPage.dart';
import 'package:changshengh5/pages/common/CSClassNoDataView.dart';
import 'package:changshengh5/utils/CSClassCommonMethods.dart';
import 'package:changshengh5/utils/CSClassImageUtil.dart';
import 'package:changshengh5/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sprintf/sprintf.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CSClassMatchLiveStatisPage extends  StatefulWidget{
  CSClassGuessMatchInfo ?csProGuessInfo;
  ValueChanged<CSClassGuessMatchInfo> ?callback;

  CSClassMatchLiveStatisPage(this.csProGuessInfo,{this.callback});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CSClassMatchLiveStatisPageState();
  }

}

class CSClassMatchLiveStatisPageState extends State<CSClassMatchLiveStatisPage> with TickerProviderStateMixin<CSClassMatchLiveStatisPage> ,AutomaticKeepAliveClientMixin{
  List<CSClassMatchStatListMatchStat> csProMatchStatList= [];//技术统计
  List<CSClassMatchEventMatchEventItem> csProMatchEventList= []; //比赛事件
  List<CSClassMatchEventMatchEventItem> csProOrgMatchEventList= []; //比赛事件
  var csProEventImages=["ic_football_jin","ic_football_dq","ic_football_wl","ic_football_dqsb","ic_football_jiao","ic_football_h1p","ic_football_hp","ic_football_hr","ic_football_lhbh",];
  var csProEventTitles=["入球","点球","乌龙","射失点球","角球","黄牌","红牌","换人","两黄变红"];

  Timer ?csProTimer;
  int hour=0;
  int minute=0;
  int second=0;

  bool csProIsDispose=false;
  int csProGoalScoreOne=0;
  int csProGoalScoreTwo=0;
  int csProCornerScoreOne=0;
  int csProCornerScoreTwo=0;
  int csProMistakeScoreOne=0;
  int csProMistakeScoreTwo=0;
  int csProPenalScoreOne=0;
  int csProPenalScoreTwo=0;
  Map<String,int> csProEventRecords=Map();

  CSClassMatchLineupEntity ?csProMatchLineupEntity;
  CSClassMatchLineupPlayerEntity ?csProMatchLineupPlayerEntity;
  List<CSClassMatchLineupPlayerMatchLineupPlayerItem> ?csProStartingOnes;//首发主队
  List<CSClassMatchLineupPlayerMatchLineupPlayerItem> ?csProStartingTwos;//首发客队
  List<CSClassMatchLineupPlayerMatchLineupPlayerItem> ?csProSubstituteOnes;//替补客队
  List<CSClassMatchLineupPlayerMatchLineupPlayerItem> ?csProSubstituteTwos;//替补客队

  CSClassMatchInjuryEntity? csProMatchInjuryEntity;
  var csProShowTeam=true;
  var csProShowJury=true;

  CSClassMatchIntelligenceMatchIntelligenceItem ?csProMatchIntelligenceItemOne;
  CSClassMatchIntelligenceMatchIntelligenceItem ?csProMatchIntelligenceItemTwo;
  var csProIsLoading=true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();


    CSClassApiManager.csMethodGetInstance().csMethodSportMatchData<CSClassBaseModelEntity>(
        context: context,csProGuessMatchId:widget.csProGuessInfo!.csProGuessMatchId!,
        dataKeys:"match_stat;match_lineup;match_lineup_player;match_injury;match_intelligence",
        csProCallBack: CSClassHttpCallBack(
        csProOnSuccess: (result) async {
          csProIsLoading=false;

          var matchStatListEntity= JsonConvert.fromJsonAsT<CSClassMatchStatListEntity>(result.data);
          var csProMatchLineupEntity= JsonConvert.fromJsonAsT<CSClassMatchLineupEntity>(result.data);
          var csProMatchLineupPlayerEntity= JsonConvert.fromJsonAsT<CSClassMatchLineupPlayerEntity>(result.data);
          var csProMatchInjuryEntity= JsonConvert.fromJsonAsT<CSClassMatchInjuryEntity>(result.data);
          var matchIntelligenceEntity= JsonConvert.fromJsonAsT<CSClassMatchIntelligenceEntity>(result.data);


          if(matchIntelligenceEntity.csProMatchIntelligence!=null&&matchIntelligenceEntity.csProMatchIntelligence!.one!=null){
            csProMatchIntelligenceItemOne=matchIntelligenceEntity.csProMatchIntelligence!.one![0];
          }
          if(matchIntelligenceEntity.csProMatchIntelligence!=null&&matchIntelligenceEntity.csProMatchIntelligence!.two!=null){
            csProMatchIntelligenceItemTwo=matchIntelligenceEntity.csProMatchIntelligence!.two![0];
          }

          if(matchStatListEntity!=null&&matchStatListEntity.csProMatchStat!=null){
           csProMatchStatList=matchStatListEntity.csProMatchStat!;
          }
          if(csProMatchLineupEntity!=null&&csProMatchLineupEntity.csProMatchLineup!=null&&csProMatchLineupEntity.csProMatchLineup!.isNotEmpty){
            List<CSClassMatchLineupMatchLineup> dealList=[];
            csProMatchLineupEntity.csProMatchLineup!.forEach((item) {
               if(item.csProTeamOneLineup!.isNotEmpty&&item.csProTeamTwoLineup!.isNotEmpty){
                 dealList.add(item);
               }
            });
            csProMatchLineupEntity.csProMatchLineup=dealList;
            if(dealList.length>0){
              this.csProMatchLineupEntity=csProMatchLineupEntity;

            }
          }

          if(csProMatchLineupPlayerEntity!=null&&csProMatchLineupPlayerEntity.csProMatchLineupPlayer!=null&&
              (csProMatchLineupPlayerEntity.csProMatchLineupPlayer!.one!=null
              ||csProMatchLineupPlayerEntity.csProMatchLineupPlayer!.two!=null)
          ){
            csProStartingOnes=[];
            csProSubstituteOnes=[];
            csProStartingTwos=[];
            csProSubstituteTwos=[];
            if(csProMatchLineupPlayerEntity.csProMatchLineupPlayer!.one!=null){
              csProMatchLineupPlayerEntity.csProMatchLineupPlayer!.one!.forEach((item){
              if(item.csProIsRegular=="1"){
                csProStartingOnes!.add(item);
              }else{
                csProSubstituteOnes!.add(item);
              }
            });
            }
            if(csProMatchLineupPlayerEntity.csProMatchLineupPlayer!.two!=null){
              csProMatchLineupPlayerEntity.csProMatchLineupPlayer!.two!.forEach((item){
                if(item.csProIsRegular=="1"){
                  csProStartingTwos!.add(item);
                }else{
                  csProSubstituteTwos!.add(item);
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
          csMethodGetMatchEvent("");
        },onError: (e){
        csMethodGetMatchEvent("");
      },csProOnProgress: (v){}
    )
    );


  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    if(csProTimer!=null){
      csProTimer!.cancel();
    }
    csProIsDispose=true;
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    super.build(context);
      return csProIsLoading? CSClassLoadingPage():SingleChildScrollView(
      child: Column(
        children: <Widget>[

          (csProMatchStatList.isEmpty&&csProMatchEventList.isEmpty&&csProMatchLineupPlayerEntity==null&&csProMatchLineupEntity==null&&csProMatchInjuryEntity==null&&csProMatchIntelligenceItemOne==null&&csProMatchIntelligenceItemTwo==null)?
          CSClassNoDataView(height:width(400),):SizedBox(),

          matchStat(),

          matchEvent(),


          matchLineUp(),

          matchInjury(),

          matchIntelligence(csProMatchIntelligenceItemOne,widget.csProGuessInfo!.csProTeamOne),
          matchIntelligence(csProMatchIntelligenceItemTwo,widget.csProGuessInfo!.csProTeamTwo),
        ],
      ),
    );
  }

  Widget matchStat(){
    return csProMatchStatList.isEmpty?  SizedBox():Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[

          Container(
            height: height(35),
            padding: EdgeInsets.only(left: width(15),right: width(15)),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: width(4),
                        height: width(15),
                        decoration: BoxDecoration(
                            color: MyColors.main1,
                            borderRadius: BorderRadius.circular(width(2))
                        ),
                      ),
                      SizedBox(width: 5,),
                      Text(widget.csProGuessInfo!.csProTeamOne!,
                        style: TextStyle(
                            fontSize: sp(16),
                            fontWeight: FontWeight.bold),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,)
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(widget.csProGuessInfo!.csProTeamTwo!,
                        style: TextStyle(
                            fontSize: sp(16),
                            fontWeight: FontWeight.bold),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,),
                      SizedBox(width: 5,),
                      Container(
                        width: width(4),
                        height: width(15),
                        decoration: BoxDecoration(
                            color: Color(0xFFFF6A4D),
                            borderRadius: BorderRadius.circular(width(2))
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),//主客队伍标题

          Row(
            children: <Widget>[
              Expanded(
                child:Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Image.asset(CSClassImageUtil.csMethodGetImagePath("ic_football_h1p"),width: width(17),),
                        Text(csMethodFindMatchStat("黄牌",1),style: TextStyle(fontSize: sp(12)),)
                      ],
                    ),
                    SizedBox(width: width(5),),
                    Column(
                      children: <Widget>[
                        Image.asset(CSClassImageUtil.csMethodGetImagePath("ic_football_hp"),width: width(17),),
                        Text(csMethodFindMatchStat("红牌",1),style: TextStyle(fontSize: sp(12)),)
                      ],
                    ),
                    SizedBox(width: width(5),),
                    Column(
                      children: <Widget>[
                        Image.asset(CSClassImageUtil.csMethodGetImagePath("ic_football_jiao"),width: width(17),),
                        Text(csMethodFindMatchStat("角球",1),style: TextStyle(fontSize: sp(12)),)
                      ],
                    ),

                  ],
                ) ,
              ),

              Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(csMethodFindMatchStat("进攻",1),style: TextStyle(fontSize: sp(15),color: Color(0xFF333333)),),
                      Container(
                        height: width(60),
                        width: width(60),
                        child:SfCircularChart(
                          margin: EdgeInsets.zero,
                          title: ChartTitle(text: '' ),
                          legend: Legend(isVisible: false),
                          series: [
                            PieSeries<CSClassChartDoughnutData, String>(
                              explode: true,
                              dataSource: [
                                CSClassChartDoughnutData(double.tryParse(csMethodFindMatchStat("进攻",1)),color: MyColors.main1),
                                CSClassChartDoughnutData(double.tryParse(csMethodFindMatchStat("进攻",2)),color: Color(0xFFFF5F40)),
                              ],
                              xValueMapper: (CSClassChartDoughnutData data, _) => "",
                              yValueMapper: (CSClassChartDoughnutData data, _) => data.percenter,
                              pointColorMapper:(CSClassChartDoughnutData data, _) => data.color,
                              startAngle: 180,
                              endAngle: 180,
                              strokeWidth:2,
                              strokeColor:Colors.white,
                            ),
                          ],
                        ),
                      ),
                      Text(csMethodFindMatchStat("进攻",2),style: TextStyle(fontSize: sp(15),color: Color(0xFF999999)),),

                    ],
                  ),
                  Text("进攻",style: TextStyle(fontSize: sp(15)),)

                ],
              ),

              Expanded(
                child:Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Image.asset(CSClassImageUtil.csMethodGetImagePath("ic_football_jiao"),width: width(17),),
                        Text(csMethodFindMatchStat("角球",2),style: TextStyle(fontSize: sp(12)),)
                      ],
                    ),
                    SizedBox(width: width(5),),
                    Column(
                      children: <Widget>[
                        Image.asset(CSClassImageUtil.csMethodGetImagePath("ic_football_hp"),width: width(17),),
                        Text(csMethodFindMatchStat("红牌",2),style: TextStyle(fontSize: sp(12)),)
                      ],
                    ),
                    SizedBox(width: width(5),),
                    Column(
                      children: <Widget>[
                        Image.asset(CSClassImageUtil.csMethodGetImagePath("ic_football_h1p"),width: width(17),),
                        Text(csMethodFindMatchStat("黄牌",2),style: TextStyle(fontSize: sp(12)),)
                      ],
                    )
                  ],
                ) ,
              )
            ],
          ), //第一层数据
          SizedBox(
            height: width(16),
          ),

          //控球率
          Container(
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.centerRight,
                      width: width(62),
                      child: Text(csMethodFindMatchStat("控球率",1),
                        style: TextStyle(fontSize: sp(12),color: Color(0xFF333333)),
                      ),
                    ),
                    SizedBox(width: width(8),),
                    Expanded(
                      child:  Row(
                        children: <Widget>[
                          Expanded(
                            flex:int.parse(csMethodFindMatchStat("控球率",1).replaceAll("%", "")),
                            child: Container(
                              margin: EdgeInsets.only(right: width(4)),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: MyColors.main1,
                                  borderRadius: BorderRadius.horizontal(left:Radius.circular(300) )
                              ),
                              height: width(7),
                            ),
                          ),
                          Expanded(
                            flex:int.parse(csMethodFindMatchStat("控球率",2).replaceAll("%", "")),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Color(0xFFFF5F40),
                                  borderRadius: BorderRadius.horizontal(right:Radius.circular(300) )
                              ),
                              alignment: Alignment.center,
                              height: width(7),
                            ),
                          ),
                        ],
                      ),
                    ) ,
                    SizedBox(width: width(8),),
                    Container(
                      alignment: Alignment.centerLeft,
                      width: width(62),
                      child: Text(csMethodFindMatchStat("控球率",2),
                        style: TextStyle(fontSize: sp(12),color: Color(0xFF333333)),
                      ),
                    ),
                  ],
                ),
                Text("控球率",
                  style: TextStyle(fontSize: sp(12)),),
                SizedBox(height: width(8),),
              ],
            ),
          ),
          //半场控球率
          Container(
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.centerRight,
                      width: width(62),
                      child: Text(csMethodFindMatchStat("半场控球率",1),
                        style: TextStyle(fontSize: sp(12),color: Color(0xFF333333)),
                      ),
                    ),
                    SizedBox(width: width(8),),
                    Expanded(
                      child:  Row(
                        children: <Widget>[
                          Expanded(
                            flex:int.parse(csMethodFindMatchStat("半场控球率",1).replaceAll("%", "")),
                            child: Container(
                              margin: EdgeInsets.only(right: width(4)),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: MyColors.main1,
                                  borderRadius: BorderRadius.horizontal(left:Radius.circular(300) )
                              ),
                              height: width(7),
                            ),
                          ),
                          Expanded(
                            flex:int.parse(csMethodFindMatchStat("半场控球率",2).replaceAll("%", "")),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Color(0xFFFF5F40),
                                  borderRadius: BorderRadius.horizontal(right:Radius.circular(300) )
                              ),
                              alignment: Alignment.center,
                              height: width(7),
                            ),
                          ),
                        ],
                      ),
                    ) ,
                    SizedBox(width: width(8),),
                    Container(
                      alignment: Alignment.centerLeft,
                      width: width(62),
                      child: Text(csMethodFindMatchStat("半场控球率",2),
                        style: TextStyle(fontSize: sp(12),color: Color(0xFF333333)),
                      ),
                    ),
                  ],
                ),
                Text("半场控球率",
                  style: TextStyle(fontSize: sp(12)),),
                SizedBox(height: width(8),),
              ],
            ),
          ),
          //射正
          Container(
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.centerRight,
                      width: width(62),
                      child: Text((int.parse(csMethodFindMatchStat("射门",1))-int.parse(csMethodFindMatchStat("射门不中",1))).toString(),
                        style: TextStyle(fontSize: sp(12),color: Color(0xFF333333)),
                      ),
                    ),
                    SizedBox(width: width(8),),
                    Expanded(
                      child:  Row(
                        children: <Widget>[
                          Expanded(
                            flex:int.parse(csMethodFindMatchStat("射门",1))-int.parse(csMethodFindMatchStat("射门不中",1)),
                            child: Container(
                              margin: EdgeInsets.only(right: width(4)),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: MyColors.main1,
                                  borderRadius: BorderRadius.horizontal(left:Radius.circular(300) )
                              ),
                              height: width(7),
                            ),
                          ),
                          Expanded(
                            flex:int.parse(csMethodFindMatchStat("射门",2))-int.parse(csMethodFindMatchStat("射门不中",2)),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Color(0xFFFF5F40),
                                  borderRadius: BorderRadius.horizontal(right:Radius.circular(300) )
                              ),
                              alignment: Alignment.center,
                              height: width(7),
                            ),
                          ),
                        ],
                      ),
                    ) ,
                    SizedBox(width: width(8),),
                    Container(
                      alignment: Alignment.centerLeft,
                      width: width(62),
                      child: Text((int.parse(csMethodFindMatchStat("射门",2))-int.parse(csMethodFindMatchStat("射门不中",2))).toString(),
                        style: TextStyle(fontSize: sp(12),color: Color(0xFF333333)),
                      ),
                    ),
                  ],
                ),
                Text("射正",
                  style: TextStyle(fontSize: sp(12)),),
                SizedBox(height: width(8),),
              ],
            ),
          ),
          //射门
          Container(
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.centerRight,
                      width: width(62),
                      child: Text(csMethodFindMatchStat("射门",1),
                        style: TextStyle(fontSize: sp(12),color: Color(0xFF333333)),
                      ),
                    ),
                    SizedBox(width: width(8),),
                    Expanded(
                      child:  Row(
                        children: <Widget>[
                          Expanded(
                            flex:int.parse(csMethodFindMatchStat("射门",1)),
                            child: Container(
                              margin: EdgeInsets.only(right: width(4)),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: MyColors.main1,
                                  borderRadius: BorderRadius.horizontal(left:Radius.circular(300) )
                              ),
                              height: width(7),
                            ),
                          ),
                          Expanded(
                            flex:int.parse(csMethodFindMatchStat("射门",2),),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Color(0xFFFF5F40),
                                  borderRadius: BorderRadius.horizontal(right:Radius.circular(300) )
                              ),
                              alignment: Alignment.center,
                              height: width(7),
                            ),
                          ),
                        ],
                      ),
                    ) ,
                    SizedBox(width: width(8),),
                    Container(
                      alignment: Alignment.centerLeft,
                      width: width(62),
                      child: Text(csMethodFindMatchStat("射门",2),
                        style: TextStyle(fontSize: sp(12),color: Color(0xFF333333)),
                      ),
                    ),
                  ],
                ),
                Text("射正",
                  style: TextStyle(fontSize: sp(12)),),
                SizedBox(height: width(8),),
              ],
            ),
          ),
          SizedBox(height: width(10),),
          myDivider(),
        ],
      ),) ;
  }

  Widget matchEvent(){
    return (csProMatchEventList.length==0)? SizedBox(): Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          AnimatedSize(
            vsync: this,
            duration: Duration(milliseconds: 300),
            child:Column(
              children: <Widget>[
                ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.only(top: height(20),bottom: height(20)),
                    shrinkWrap: true,
                    itemCount: csProMatchEventList.length,
                    itemBuilder: (c,index){
                      var item =csProMatchEventList[index];
                            return Container(
                        child: Stack(
                          alignment: Alignment.center,
                          children: <Widget>[
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                SizedBox(width: width(70),),
                                Expanded(
                                  child:Container(
                                    padding: EdgeInsets.all(width(10)),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border(bottom: BorderSide(width: 0.5,color: Color(0xFFF2F2F2))),

                                    ),
                                    child:  Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Text(item.content,style: TextStyle(fontSize: sp(12),color: Color(0xFF333333)),),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                // Container(
                                //   width: width(40),
                                //   alignment: Alignment.center,
                                //   child: Text(
                                //     sprintf("%s - %s ",[item.csProTeamOneScore,item.csProTeamTwoScore]),
                                //     style: TextStyle(fontSize: sp(12)),
                                //   ),
                                // )


                              ],
                            ),

                            Positioned(
                              left: 0,
                              child: Container(
                                width: width(70),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Image.asset(CSClassImageUtil.csMethodGetImagePath(item.csProEventImage!),width: width(17),),
                                    SizedBox(width: 5,),
                                    Text(item.time!+"'",style: TextStyle(fontSize: sp(12)),),
                                  ],
                                ),
                              ),
                            )


                          ],
                        ),
                      );
                    }),

              ],
            ),
          ),
          myDivider(),

        ],

      ),
    );
  }

  Widget matchLineUp(){
    return (csProMatchLineupPlayerEntity==null&&csProMatchLineupEntity==null)?  SizedBox(): AnimatedSize(
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
                        csProShowTeam? CSClassImageUtil.csMethodGetImagePath("ic_down_arrow"):CSClassImageUtil.csMethodGetImagePath("ic_up_arrow"),
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

            (csProMatchLineupEntity==null)?SizedBox():Stack(
              alignment: Alignment.center,
              children:csMethodBuildLineUpTeam(),
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
                            ( widget.csProGuessInfo!.csProIconUrlOne!.isEmpty)? Image.asset(
                              CSClassImageUtil.csMethodGetImagePath("ic_team_one"),
                              width: width(20),
                            ):Image.network(
                              widget.csProGuessInfo!.csProIconUrlOne!,
                              width: width(20),
                            ),
                            SizedBox(width: 5,),
                            Text(widget.csProGuessInfo!.csProTeamOne!,style: TextStyle(fontSize: sp(12)),)
                          ],

                        ),),
                        Expanded(child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Text(widget.csProGuessInfo!.csProTeamTwo!,style: TextStyle(fontSize: sp(12)),),
                            SizedBox(width: 5,),
                            ( widget.csProGuessInfo!.csProIconUrlTwo!.isEmpty)? Image.asset(
                              CSClassImageUtil.csMethodGetImagePath("ic_team_two"),
                              width: width(20),
                            ):Image.network(
                              widget.csProGuessInfo!.csProIconUrlTwo!,
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
                        Text("首发球员",style: TextStyle(fontWeight: FontWeight.w500,fontSize: width(15)),),
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
                                    child: Text(csProStartingOnes![index].csProShirtNumber!,style: TextStyle(color: Colors.white,fontSize: sp(12),),),
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
                                    child: Text(csProStartingTwos![index].csProShirtNumber!,style:TextStyle(color: Colors.white,fontSize: sp(12),),),
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
                        Text("替补球员",style: TextStyle(fontWeight: FontWeight.w500,fontSize: width(15)),),
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
                                    child: Text(csProSubstituteOnes![index].csProShirtNumber!,style:  TextStyle(color: Colors.white,fontSize: sp(12),),),
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
                                    child: Text(csProSubstituteTwos![index].csProShirtNumber!,style: TextStyle(color: Colors.white,fontSize: sp(12),),),
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
            myDivider(),

          ],

        ),
      ) ,
    );
  }

  Widget matchInjury(){
    return (csProMatchInjuryEntity==null)? SizedBox(): AnimatedSize(
      vsync: this,
      duration: Duration(
          milliseconds: 300
      ),
      child:Container(
        color: Colors.white,
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
                        csProShowJury? CSClassImageUtil.csMethodGetImagePath("ic_down_arrow"):CSClassImageUtil.csMethodGetImagePath("ic_up_arrow"),
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
                            ( widget.csProGuessInfo!.csProIconUrlOne!.isEmpty)? Image.asset(
                              CSClassImageUtil.csMethodGetImagePath("ic_team_one"),
                              width: width(20),
                            ):Image.network(
                              widget.csProGuessInfo!.csProIconUrlOne!,
                              width: width(20),
                            ),
                            SizedBox(width: 5,),
                            Text(widget.csProGuessInfo!.csProTeamOne!,style: TextStyle(fontSize: sp(12)),)
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
                                    child: Text(item.csProShirtNumber!,style: TextStyle(color: Colors.white,fontSize: sp(12),),),
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
                            ( widget.csProGuessInfo!.csProIconUrlTwo!.isEmpty)? Image.asset(
                              CSClassImageUtil.csMethodGetImagePath("ic_team_two"),
                              width: width(20),
                            ):Image.network(
                              widget.csProGuessInfo!.csProIconUrlTwo!,
                              width: width(20),
                            ),
                            SizedBox(width: 5,),
                            Text(widget.csProGuessInfo!.csProTeamTwo!,style: TextStyle(fontSize: sp(12)),)
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
                                    child: Text(item.csProShirtNumber!,style: TextStyle(color: Colors.white,fontSize: sp(12),),),
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
            myDivider(),


          ],

        ),
      ) ,
    );
  }

  Widget matchIntelligence(CSClassMatchIntelligenceMatchIntelligenceItem ?data,String ?name){
    return data==null? SizedBox():AnimatedSize(
      vsync: this,
      duration: Duration(
          milliseconds: 300
      ),
      child:Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(width(6)),
              decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(width: 0.4,color: Color(0xFFDDDDDD)))
              ),
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              child: Text('$name',style:TextStyle(fontSize: sp(16),fontWeight: FontWeight.w500),),
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
                        Text("阵容",style: TextStyle(color: MyColors.main1,fontSize: sp(14),fontWeight: FontWeight.w500,),),
                        SizedBox(height: height(6),),
                        Text(data.information!,style: TextStyle(color: Color(0xFF333333),fontSize: sp(14),fontWeight: FontWeight.w400,),),
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
                        Text("状态",style: TextStyle(color: MyColors.main1,fontSize: sp(14),fontWeight: FontWeight.w500,),),
                        SizedBox(height: height(6),),
                        Text("${data.status}",style: TextStyle(color: Color(0xFF333333),fontSize: sp(14),fontWeight: FontWeight.w400,),),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              padding:(data==null)? EdgeInsets.all(width(5)):null,
              child:(data==null)? Text("暂无数据",style: TextStyle(color: Color(0xFF999999)),):SizedBox(),
            ),
            myDivider(),
          ],

        ),
      ) ,
    );
  }

  Widget myDivider(){
    return Container(
      height: width(6),
      color: Color(0xFFF2F2F2),
    );
  }


  void csMethodSortMatchEvent() {
    List<CSClassMatchEventMatchEventItem> eventList= [];

    csProOrgMatchEventList.forEach((item){
      csProEventTitles.forEach((tile){
        if(item.csProEventName!.contains(tile)){
          item.csProEventImage=csProEventImages[csProEventTitles.indexOf(tile)];
        }
      });
      eventList.add(item);
    });
    eventList.sort((left,right)=>double.parse(left.csProSeqNum!).compareTo(double.parse(right.csProSeqNum!)));
    eventList.forEach((item) {
      csMethodInitMatchEventText(item);
    });
    eventList.sort((left,right)=>double.parse(right.csProSeqNum!).compareTo(double.parse(left.csProSeqNum!)));

    var fisrtItem=CSClassMatchEventMatchEventItem()
      ..content="大家好，欢迎来到常胜体育观看本场直播，比赛即将开始"
      ..time="-"
      ..csProEventImage="ic_match_live_whistle";
    eventList.add(fisrtItem);

    if(widget.csProGuessInfo!.status=="over"){
      var endItem=CSClassMatchEventMatchEventItem()
        ..content=sprintf(
            "随着裁判一声哨响，本场比赛结束，总比分%s-%s，感谢大家关注常胜体育，下次再会！",
            [
              widget.csProGuessInfo!.csProScoreOne!,
              widget.csProGuessInfo!.csProScoreTwo!,
            ]
        )
        ..time="-"
        ..csProEventImage="ic_match_live_whistle"
        ..csProTeamOneScore=widget.csProGuessInfo!.csProScoreOne!
        ..csProTeamTwoScore=widget.csProGuessInfo!.csProScoreTwo!;
      eventList.insert(0,endItem);
    }
    setState(() {
      csProMatchEventList=eventList;
    });
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  void csMethodDownCount() {

    if(widget.csProGuessInfo!.status=="in_progress"){
      csProTimer=  Timer.periodic(Duration(seconds: 1), (timer){
        if(csProTimer==null){
          timer.cancel();
        }else{
          csMethodRefreshTimer();
        }
      });
    }else{

    }


  }

  void csMethodRefreshTimer() {

    DateTime nowTime= DateTime.now();

    Duration duration =DateTime.parse(widget.csProGuessInfo!.csProStTime!).difference(nowTime);

    hour=(duration.inHours);
    minute=(duration.inMinutes-((duration.inHours*60)));
    second=(duration.inSeconds-(duration.inMinutes*60));

    if(hour<=0&&minute<=0&&second<=0){
      csProTimer!.cancel();
      this.csProTimer=null;
      csMethodGetMatchEvent("");
    }
    if(mounted){
      setState(() {

      });
    }
  }

  void csMethodGetMatchEvent(String refSeqNum) async{

    if(csProIsDispose){
      return;
    }
    CSClassApiManager.csMethodGetInstance().csMethodMatchEvent<CSClassMatchEventEntity>(context: context,csProGuessMatchId:widget.csProGuessInfo!.csProGuessMatchId,refSeqNum: refSeqNum,csProCallBack: CSClassHttpCallBack(
        csProOnSuccess: (result) async{
                  csProIsLoading=false;
          if(result.csProMatchEvent!=null&&result.csProMatchEvent!.length>0){
            csProOrgMatchEventList.addAll(result.csProMatchEvent!);
          }else{
            if(result.csProGuessMatch!.csProIsOver=="1"){

            }
          }

          if(result.csProGuessMatch!=null){
            if(result.csProGuessMatch!.csProIsRealtimeOver=="0"){
              await Future.delayed(Duration(seconds: 3),(){
                csMethodGetMatchEvent(csProOrgMatchEventList.length==0? "":csProOrgMatchEventList[csProOrgMatchEventList.length-1].csProSeqNum!);
              });
              widget.csProGuessInfo!.status="in_progress";
            }else{
              widget.csProGuessInfo!.status="over";
            }
            widget.csProGuessInfo!.csProScoreTwo=result.csProGuessMatch!.csProScoreTwo!;
            widget.csProGuessInfo!.csProScoreOne=result.csProGuessMatch!.csProScoreOne!;
            widget.csProGuessInfo!.csProStatusDesc=result.csProGuessMatch!.csProStatusDesc!;
            if(widget.callback!=null){
              widget.callback!(widget.csProGuessInfo!);
            }
          }

          if(csProOrgMatchEventList.length>0|| widget.csProGuessInfo!.status=="in_progress"){
            csMethodSortMatchEvent();
          }
          setState(() {});
        },
        onError: (result) async{
          csProIsLoading=false;
          setState(() {});
          if(csProOrgMatchEventList.length>0||widget.csProGuessInfo!.status=="in_progress"){
            await Future.delayed(Duration(seconds: 1),(){
              csMethodGetMatchEvent(csProOrgMatchEventList.isEmpty? "":csProOrgMatchEventList[csProOrgMatchEventList.length-1].csProSeqNum!);
            });
          }
        },csProOnProgress: (v){}
    ));
  }

  String csMethodFindMatchStat(String type, int i) {

    var item= csProMatchStatList.firstWhere((item) =>(item.csProStatType==type),orElse:()=> CSClassMatchStatListMatchStat());
    if(item!=null&&item.csProStatType!=null){
      if(i==1){
        return item.csProTeamOneVal!;
      }
      if(i==2){
        return item.csProTeamTwoVal!;
      }
    }

    return "0";
  }

  double csMethodFindMatchStatCalc(String type, int i) {


    var item= csProMatchStatList.firstWhere((item) =>(item.csProStatType==type),orElse:()=>CSClassMatchStatListMatchStat() );
    if(item!=null&&item.csProStatType!=null){
      if(i==1){
        if(item.csProTeamOneVal=="0"){
          return 0;
        }
        return double.tryParse(item.csProTeamOneVal!)!/(double.tryParse(item.csProTeamOneVal!)!+double.tryParse(item.csProTeamTwoVal!)!);
      }
      if(i==2){
        if(item.csProTeamTwoVal=="0"){
          return 0;
        }
        return double.tryParse(item.csProTeamTwoVal!)!/(double.tryParse(item.csProTeamOneVal!)!+double.tryParse(item.csProTeamTwoVal!)!);
      }
    }


    return 0;
  }

   csMethodInitMatchEventText(CSClassMatchEventMatchEventItem item) {

    if(item!=null&&item.content.isEmpty){
      item.content=item.csProEventName!;
      item.csProTeamOneScore = csProGoalScoreOne.toString();
      item.csProTeamTwoScore = csProGoalScoreTwo.toString();
       if(item.csProEventName=="入球"){
         if(item.csProWhichTeam=="1"){
           csProGoalScoreOne++;
           item.csProTeamOneScore=csProGoalScoreOne.toString();
         }
         if(item.csProWhichTeam=="2"){
           csProGoalScoreTwo++;
           item.csProTeamTwoScore=csProGoalScoreTwo.toString();
         }
         item.content= sprintf("%s进球啦，这是本场比赛的第%d个进球",
             [
               (item.csProWhichTeam=="1" ? widget.csProGuessInfo!.csProTeamOne!:widget.csProGuessInfo!.csProTeamTwo),
               ( csProGoalScoreOne+csProGoalScoreTwo),

             ]);
       }

       if(item.csProEventName=="角球"){
         if(item.csProWhichTeam=="1"){
           csProCornerScoreOne++;
         }
         if(item.csProWhichTeam=="2"){
           csProCornerScoreTwo++;
         }
         item.content= sprintf("%s获得了本场的第%s个角球",
             [
               (item.csProWhichTeam=="1" ? widget.csProGuessInfo!.csProTeamOne:widget.csProGuessInfo!.csProTeamTwo),
               (item.csProWhichTeam=="1" ? csProCornerScoreOne.toString():csProCornerScoreTwo.toString()),

             ]);
       }

       if(item.csProEventName=="点球"){
         if(item.csProWhichTeam=="1"){
           csProPenalScoreOne++;
         }
         if(item.csProWhichTeam=="2"){
           csProPenalScoreTwo++;
         }
         item.content= sprintf("裁判吹罚,%s获得了点球机会，这是本场比赛的第%s个点球",
             [
               (item.csProWhichTeam=="1" ? widget.csProGuessInfo!.csProTeamOne:widget.csProGuessInfo!.csProTeamTwo),
               (item.csProWhichTeam=="1" ? csProPenalScoreOne.toString():csProPenalScoreTwo.toString()),

             ]);
       }

       if(item.csProEventName=="射失点球"){

         item.content= sprintf("%s点球没劲，可惜了！",
             [
               (item.csProPlayerName!.isNotEmpty ? item.csProPlayerName:(item.csProWhichTeam=="1" ? widget.csProGuessInfo!.csProTeamOne:widget.csProGuessInfo!.csProTeamTwo)),
             ]);
       }

       if(item.csProEventName=="乌龙"){
         if(item.csProWhichTeam=="1"){
           csProMistakeScoreOne++;
         }
         if(item.csProWhichTeam=="2"){
           csProMistakeScoreTwo++;
         }
         item.content= sprintf("哎呀！,%s出现乌龙球，这是本场比赛的第%s个乌龙球",
             [
               (item.csProWhichTeam=="1" ? widget.csProGuessInfo!.csProTeamOne:widget.csProGuessInfo!.csProTeamTwo),
               (item.csProWhichTeam=="1" ? csProMistakeScoreOne.toString():csProMistakeScoreTwo.toString()),

             ]);
       }

       if(item.csProEventName=="黄牌"){
         String keyOne = item.csProEventName!;
         String keyTwo = item.csProEventName!;
         if (item.csProWhichTeam == "1") {
           if (!csProEventRecords.containsKey(keyOne)) {
             csProEventRecords[keyOne] = 0;
           }
           csProEventRecords[keyOne] = csProEventRecords[keyOne] !+ 1;
         }
         if (item.csProWhichTeam == "2") {
           if (!csProEventRecords.containsKey(keyTwo)) {
             csProEventRecords[keyTwo] = 0;
           }
           csProEventRecords[keyTwo] = csProEventRecords[keyTwo] !+ 1;
         }
         item.content= sprintf("裁判出示了第%s张黄牌，%s",
             [
               (item.csProWhichTeam=="1" ? csProEventRecords[keyOne].toString(): csProEventRecords[keyTwo].toString()),
               ("给了"+(item.csProPlayerName!.isEmpty?
               (item.csProWhichTeam == "1"? widget.csProGuessInfo!.csProTeamOne!:widget.csProGuessInfo!.csProTeamTwo!):
               (item.csProPlayerName!))),

             ]);
       }

       if(item.csProEventName=="红牌"){
        String keyOne = item.csProEventName!;
        String keyTwo = item.csProEventName!;
        if (item.csProWhichTeam == "1") {
          if (!csProEventRecords.containsKey(keyOne)) {
            csProEventRecords[keyOne] = 0;
          }
          csProEventRecords[keyOne] = csProEventRecords[keyOne]! + 1;
        }
        if (item.csProWhichTeam == "2") {
          if (!csProEventRecords.containsKey(keyTwo)) {
            csProEventRecords[keyTwo] = 0;
          }
          csProEventRecords[keyTwo] = csProEventRecords[keyTwo]! + 1;
        }


        item.content= sprintf("裁判出示了第%s张红牌，%s",
            [
              (item.csProWhichTeam=="1" ? csProEventRecords[keyOne].toString(): csProEventRecords[keyTwo].toString()),
              ("给了"+(item.csProPlayerName!.isEmpty?
              (item.csProWhichTeam == "1"? widget.csProGuessInfo!.csProTeamOne!:widget.csProGuessInfo!.csProTeamTwo!):
              (item.csProPlayerName!))),
            ]);
      }

      if(item.csProEventName=="两黄变红"){
        String keyOne = "黄牌" ;
        String keyTwo = "黄牌" ;
        if (item.csProWhichTeam == "1") {
          if (!csProEventRecords.containsKey(keyOne)) {
            csProEventRecords[keyOne] = 0;
          }
          csProEventRecords[keyOne] = csProEventRecords[keyOne]! + 1;
        }
        if (item.csProWhichTeam == "2") {
          if (!csProEventRecords.containsKey(keyTwo)) {
            csProEventRecords[keyTwo] = 0;
          }
          csProEventRecords[keyTwo] = csProEventRecords[keyTwo]! + 1;
        }
        item.content= sprintf("裁判出示了第%s张黄牌，还是给了%s,%s被罚下",
            [
              (item.csProWhichTeam=="1" ? csProEventRecords[keyOne].toString(): csProEventRecords[keyTwo].toString()),
              (item.csProPlayerName),
              (item.csProPlayerName),

            ]);
      }

      if(item.csProEventName=="换人"){
        if (item.csProWhichTeam == "1") {
        }
        if (item.csProWhichTeam == "2") {
        }
        item.content= sprintf("比赛暂停,%s换人(%s)",
            [
              (item.csProWhichTeam=="1" ? widget.csProGuessInfo!.csProTeamOne: widget.csProGuessInfo!.csProTeamTwo),
              (item.csProPlayerName),
            ]);
      }
    }
  }

  csMethodLineUpString(String csProTeamOneLineup) {
    List<String> list=[];
    for(var i=0;i<csProTeamOneLineup.length;i++){
      list.add(csProTeamOneLineup.substring(i,i+1));
    }
    return JsonEncoder().convert(list).replaceAll("[", "").replaceAll("]", "").replaceAll(",", "-").replaceAll("\"", "");

  }

  csMethodBuildLineUpTeam() {
    List<Widget> views=[];

    views.add(Image.asset(CSClassImageUtil.csMethodGetImagePath("bg_football_place"),height: width(217),fit: BoxFit.fitHeight,));
    views.add(Positioned(
      left: width(10),
      child:Image.asset(CSClassImageUtil.csMethodGetImagePath("ic_footer_one"),width: width(18)),
    ));
    views.add( Positioned(
      right: width(10),
      child:Image.asset(CSClassImageUtil.csMethodGetImagePath("ic_footer_two"),width: width(18)),
    ));
    views.add(Positioned(
      left: width(10),
      bottom: width(5),
      child:Text(csMethodLineUpString(csProMatchLineupEntity!.csProMatchLineup![0].csProTeamOneLineup!),style: TextStyle(fontSize: width(12)),),
    ));
    views.add(Positioned(
      right: width(10),
      bottom: width(5),
      child:Text(csMethodLineUpString(csProMatchLineupEntity!.csProMatchLineup![0].csProTeamTwoLineup!),style: TextStyle(fontSize: width(12)),),
    ));

    views.add(Positioned(
      left: width(35),
      child: Container(
          width: width(110),
          height: width(163),
          child: csMethodBuildLineUpTeamRow(csProMatchLineupEntity!.csProMatchLineup![0].csProTeamOneLineup,"ic_footer_one")),
    ),
    );
    views.add(Positioned(
      right: width(35),
      child: Container(
          width: width(110),
          height: width(163),
          child: csMethodBuildLineUpTeamRow(csMethodReverseString(csProMatchLineupEntity!.csProMatchLineup![0].csProTeamTwoLineup!),"ic_footer_two")),
    ),
    );


    return views;
  }

  csMethodBuildLineUpTeamRow(csProTeamOneLineup,imageName) {
    List<String> list=[];
    for(var i=0;i<csProTeamOneLineup.length;i++){
      list.add(csProTeamOneLineup.substring(i,i+1));
    }
    return  Row(
      children: list.map((item){
        return Expanded(
            child: Column(
              children: List.filled(int.parse(item), null, growable: false).map((ren){
                return Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    child: Image.asset(CSClassImageUtil.csMethodGetImagePath(imageName.toString()),width: width(18)),
                  ),
                );
              }).toList(),
            ));
      }).toList(),
    );
  }

  csMethodReverseString(String csProTeamTwoLineup) {
    var result ="";
    for(var i=csProTeamTwoLineup.length-1;i>=0;i--){
      result=result+csProTeamTwoLineup.substring(i,i+1);
    }
    return result;

  }
}



