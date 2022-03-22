import 'dart:async';

import 'package:changshengh5/api/CSClassApiManager.dart';
import 'package:changshengh5/api/CSClassHttpCallBack.dart';
import 'package:changshengh5/app/CSClassApplicaion.dart';
import 'package:changshengh5/model/CSClassGuessMatchInfo.dart';
import 'package:changshengh5/utils/CSClassCommonMethods.dart';
import 'package:changshengh5/utils/colors.dart';
import 'package:flutter/material.dart';

import 'CSClassMatchDateList.dart';



class CSClassTabMatchInfoPage extends StatefulWidget {
  String ?csProMatchType;
  CSClassTabMatchInfoPageState ?csProState;
  CSClassTabMatchInfoPage(this.csProMatchType);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return csProState=CSClassTabMatchInfoPageState();
  }

}

class CSClassTabMatchInfoPageState extends  State<CSClassTabMatchInfoPage> with TickerProviderStateMixin{
  TabController ?csProTabController;
  List<CSClassMatchDateList> views=[];
  var csProTabTitle =["全部","热门",/*"即时",*/"赛果","赛程","关注"];
  var csProReFreshTime;
  static int csProReTime=30;
   int follow = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    spFollowlist();
    var match_key=(widget.csProMatchType=="足球"? "zq":widget.csProMatchType=="篮球"? "lq":"dj");
    views.add(CSClassMatchDateList(status: "all",csProMatchType:widget.csProMatchType));
    views.add(CSClassMatchDateList(status: "all",csProMatchType:widget.csProMatchType,isHot: true,));
    // views.add(CSClassMatchDateList(status: "in_progress",csProMatchType:widget.csProMatchType));
    views.add(CSClassMatchDateList(status: "over",csProMatchType:widget.csProMatchType,));
    views.add(CSClassMatchDateList(status: "not_started",csProMatchType:widget.csProMatchType));
    views.add(CSClassMatchDateList(status: "my_collected",csProMatchType:widget.csProMatchType));
    csProTabController=TabController(length: csProTabTitle.length,vsync: this,);
    csProTabController?.addListener((){
      if(views[csProTabController!.index].status=="my_collected"){
          CSClassApplicaion.csProEventBus.fire("score:hidden");
      }else{
        CSClassApplicaion.csProEventBus.fire("score:show");
      }
      (views[csProTabController!.index]).csProState!.csMethodOnRefreshPassive();
      switch(csProTabController!.index){
         case 0:
           CSClassApiManager.csMethodGetInstance().csMethodLogAppEvent(csProEventName: "${match_key}_match_list",);
           break;
        case 2:
          CSClassApiManager.csMethodGetInstance().csMethodLogAppEvent(csProEventName: "${match_key}_ended_match",);
          break;
        case 3:
          CSClassApiManager.csMethodGetInstance().csMethodLogAppEvent(csProEventName: "${match_key}_not_started_match",);
          break;
      }
    });
    CSClassApiManager.csMethodGetInstance().csMethodLogAppEvent(csProEventName: "${match_key}_match_list",);

    CSClassApplicaion.csProEventBus.on<String>().listen((event) {
      if(event.startsWith("match:")){
         if(event.contains("全部")){
           csProTabTitle[0]="全部";
         }
         if(event.contains("热门")){
           csProTabTitle[0]="热门";
         }
         setState(() {});
      }
    });

    Timer.periodic(Duration(seconds: csProReTime), (time){
      csMethodRefreshData();
    });

    CSClassApplicaion.csProEventBus.on<String>().listen((event) {
      if(event=="score:refresh"){
        // getSeqNum();
        (views[csProTabController!.index]).csProState!.csMethodOnRefreshPassive();

      }
      if(event == 'updateFollow'){
        spFollowlist();
      }
    });
  }
  Future<void> spFollowlist() async{
    await CSClassApiManager.csMethodGetInstance().csMethodGuessMatchList<CSClassGuessMatchInfo>(
        queryParams: {
          'fetch_type':'my_collected'
        },csProCallBack: CSClassHttpCallBack(
        csProOnSuccess: (list){
          follow = list.csProDataList.length;
          setState(() {});
        },
        onError: (result){
        },csProOnProgress: (v){}
    ));
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  Stack(
      children: <Widget>[
        Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: width(6)),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(bottom: BorderSide(width: 0.4,color: Colors.grey[300]!))
              ),
              child: TabBar(
                  labelColor: MyColors.main1,
                  unselectedLabelColor: Color(0xFF666666),
                  isScrollable: false,
                  indicatorColor: MyColors.main1,
                  labelStyle: TextStyle(fontSize: sp(14),fontWeight: FontWeight.bold),
                  unselectedLabelStyle: TextStyle(fontSize: sp(14),fontWeight: FontWeight.w400),
                  controller: csProTabController,
                  indicatorSize: TabBarIndicatorSize.label,
                  indicatorPadding: EdgeInsets.symmetric(horizontal: width(5)),
                  tabs:csProTabTitle.map((csProTabTitle){
                    return Container(
                      alignment: Alignment.center,
                      height: width(35),
                      child:Text(csProTabTitle,style: TextStyle(letterSpacing: 0,wordSpacing: 0,fontSize: sp(14)),),
                    );
                  }).toList()
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: csProTabController,
                children: views,
              ),
            )
          ],
        ),
      ],
    );
  }

  void csMethodRefreshData(){
    if (csProReFreshTime == null ||
        DateTime.now().difference(csProReFreshTime).inSeconds > csProReTime) {
      (views[csProTabController!.index]).csProState!.csMethodOnRefreshPassive();
      csProReFreshTime=DateTime.now();
    }
  }
  void csMethodRefreshTab(){

    if (csProReFreshTime == null ||
        DateTime.now().difference(csProReFreshTime).inSeconds > csProReTime) {
      (views[csProTabController!.index]).csProState!.csProListScrollController!.jumpTo(0, );
      (views[csProTabController!.index]).csProState!.csMethodOnReFresh();
      csProReFreshTime=DateTime.now();
    }
  }
  void csMethodReFreshByFilter(String leagueVale,String csProIsLottery){
      (views[csProTabController!.index]).csProState!.onReFreshByFilter(leagueVale, csProIsLottery);

  }

  String get csMethodGetCurrentDate =>  (views[csProTabController!.index]).csProState!.dates[(views[csProTabController!.index]).csProState!.csProDateIndex];
  String get csMethodGetLeagueName =>  (views[csProTabController!.index]).csProState!.csMethodLeagueName;
  Map<String,dynamic> get csMethodGetParams =>  (views[csProTabController!.index]).csProState!.csMethodGetMatchListParams(1);
  bool get csMethodIsMatchHot =>  (views[csProTabController!.index]).csProState!.csMethodIsMatchHot;




}