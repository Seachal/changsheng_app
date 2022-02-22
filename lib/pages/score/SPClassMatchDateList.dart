
import 'dart:convert';

import 'package:changshengh5/api/SPClassApiManager.dart';
import 'package:changshengh5/api/SPClassHttpCallBack.dart';
import 'package:changshengh5/app/SPClassApplicaion.dart';
import 'package:changshengh5/model/SPClassGuessMatchInfo.dart';
import 'package:changshengh5/model/SPClassLeagueFilter.dart';
import 'package:changshengh5/pages/common/SPClassNoDataView.dart';
import 'package:changshengh5/pages/competition/SPClassMatchDetailPage.dart';
import 'package:changshengh5/pages/competition/SPClassMatchListSettingPage.dart';
import 'package:changshengh5/untils/SPClassCommonMethods.dart';
import 'package:changshengh5/untils/SPClassDateUtils.dart';
import 'package:changshengh5/untils/SPClassNavigatorUtils.dart';
import 'package:changshengh5/untils/colors.dart';
import 'package:changshengh5/widgets/SPClassBallFooter.dart';
import 'package:changshengh5/widgets/SPClassBallHeader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

import 'SPClassMatchBasketballView.dart';
import 'SPClassMatchFootballView.dart';
import 'SPClassMatchLolView.dart';
import 'SPClassPageMatchGroupItem.dart';


class SPClassMatchDateList extends StatefulWidget{
  String ?status;
  String ?spProMatchType;
  bool ?isHot;
  SPClassMatchDateListState ?spProState;
  SPClassMatchDateList({this.status,this.spProMatchType,this.isHot});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return spProState=SPClassMatchDateListState();
  }

}

class SPClassMatchDateListState extends State<SPClassMatchDateList> {
  List<String> dates =[];
  List<SPClassGuessMatchInfo> spProShowData =[];
  List<SPClassLeagueName> spProLeagueList=[];
  EasyRefreshController ?controller;
  ScrollController ?spProScrollControllerDate;
  ScrollController ?spProListScrollController;
  int page=1;
  int spProDateIndex=0;
  var leagueMap={};
  var spProIsLottery ="";
  var spProIsHot ="";
  bool showLeagueGroupType=false;
  bool spProIsLoading=false;
  List<Widget> listView=[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller=EasyRefreshController();
    spProListScrollController=ScrollController();
    if(widget.isHot==true){
      spProIsHot = '1';
    }
    if(SPClassMatchListSettingPageState.spProMatchShowType==0||widget.status=="my_collected"){
      showLeagueGroupType=false;
    }else{
      showLeagueGroupType=true;
    }
    if(widget.status=="not_started"){
      dates =SPClassDateUtils.spFunAfterDays(7, SPClassDateUtils.dateFormatByDate(DateTime.now(), 'yyyy-MM-dd'));
    }else{
      dates =SPClassDateUtils.spFunBeforDays(7, SPClassDateUtils.dateFormatByDate(DateTime.now(), 'yyyy-MM-dd'));
    }

    spProDateIndex=dates.indexOf(SPClassDateUtils.dateFormatByDate(DateTime.now(), 'yyyy-MM-dd'));
    if(widget.spProMatchType=="lol"){
      spProIsHot="";
    }
    if(spProDateIndex>3){
      spProScrollControllerDate=ScrollController(initialScrollOffset:width(77)*(spProDateIndex+1) );
    }
    this.leagueMap[dates[spProDateIndex]]="";

    SPClassApplicaion.spProEventBus.on<String>().listen((event) {

      if(event=="match:pankou"){
        // getSeqNum();
        if(SPClassMatchListSettingPageState.spProMatchShowType==0||widget.status=="my_collected"){
          showLeagueGroupType=false;
        }else{
          showLeagueGroupType=true;
        }
        if(mounted){
          setState(() {});
        }
        controller?.callRefresh();
      }
      if(event=="score:hidden"){
        if(SPClassMatchListSettingPageState.spProMatchShowType==0||widget.status=="my_collected"){
          showLeagueGroupType=false;
        }else{
          showLeagueGroupType=true;
        }
        controller?.callRefresh();
        if(mounted){
          setState(() {});
        }
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            (widget.status=="in_progress"||widget.status=="all"||widget.status=="my_collected")? SizedBox(): Container(
              color: Color(0xFFF1F1F1),
              child:  ListView.builder(
                  controller: spProScrollControllerDate,
                  scrollDirection:Axis.horizontal ,
                  itemCount: dates.length,
                  itemBuilder: (c,index){
                    return GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      child: Container(
                        color: Colors.white,
                        width: MediaQuery.of(context).size.width/5,
                        height: height(37),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text("周"+
                                "${SPClassDateUtils.spFunFormatWeekday(dates[index])}",style: TextStyle(fontSize: sp(12),color:index==spProDateIndex? MyColors.main1:Color(0xFF8F8F8F)),),
                            Text(SPClassDateUtils.spFunDateFormatByString(dates[index],"MM-dd"),style: TextStyle(fontSize: sp(12),color: index==spProDateIndex?MyColors.main1:Color(0xFF8F8F8F)),)

                          ],
                        ),
                      ),
                      onTap: (){
                          setState(() {
                            spProDateIndex=index;
                          });
                          controller?.callRefresh();

                      },
                    );
                  }),
              height: height(42),
            ),
            showLeagueGroupType?
            Expanded(
              child: EasyRefresh.custom(
                firstRefresh: true,
                controller:controller ,
                header:SPClassBallHeader(
                    textColor: Color(0xFF666666)
                ),
                footer: SPClassBallFooter(
                    textColor: Color(0xFF666666)
                ),
                onRefresh: spFunOnRefreshLeague,
                emptyWidget: spProLeagueList.isEmpty ? SPClassNoDataView(): null,
                slivers: <Widget>[
                  SliverToBoxAdapter(
                    child: ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        itemCount: spProLeagueList.length,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (c,index){
                      var leagueIem =spProLeagueList[index];
                      return SPClassPageMatchGroupItem(expand: index<3,spProLeagueInfo: leagueIem,spProDate: dates[spProDateIndex],spProMatchType: widget.spProMatchType!,spProStatus: widget.status!,spProRefreshStatus: "1",) ;
                    }),
                  )
                ],
              ),
            ) :

            Expanded(
              child: EasyRefresh.custom(
                firstRefresh: true,
                controller:controller ,
                scrollController: spProListScrollController,
                header:SPClassBallHeader(
                    textColor: Color(0xFF666666)
                ),
                footer: SPClassBallFooter(
                    textColor: Color(0xFF666666)
                ),
                onRefresh: spFunOnReFresh,
                onLoad: spFunOnLoad,
                emptyWidget: spProShowData.length == 0 ? SPClassNoDataView(): null,
                slivers: <Widget>[
                  SliverList(
                    delegate: SliverChildListDelegate([
                      SizedBox(height: width(4),)
                    ]),
                  ),
                  SliverList  (
                    delegate: SliverChildBuilderDelegate(
                          (context, index) {
                        var spProMatchItem =spProShowData[index];

                        if(listView.length-1<index){
                          var view=GestureDetector(
                            key: new GlobalKey(),
                            behavior: HitTestBehavior.opaque,
                            child:(spProMatchItem.spProMatchType=="足球" ? SPClassMatchFootballView(spProMatchItem):
                            spProMatchItem.spProMatchType=="篮球" ?
                            SPClassMatchBasketballView(spProMatchItem):SPClassMatchLolView(spProMatchItem)),
                            onTap: (){
                              SPClassApiManager.spFunGetInstance().spFunMatchClick(queryParameters: {"match_id":spProMatchItem.spProGuessMatchId});
                              SPClassNavigatorUtils.spFunPushRoute(context,  SPClassMatchDetailPage(spProMatchItem,spProMatchType:"guess_match_id",spProInitIndex: 1,));

                            },
                          );
                          listView.add(view);

                        }
                        return listView[index] ;
                      },
                      childCount: spProShowData.length,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> spFunOnReFresh({bool show:true}) async {
    page=1;

    if(show){
      await Future.delayed(Duration(milliseconds: 300));
    }

    await  SPClassApiManager.spFunGetInstance().spFunGuessMatchList<SPClassGuessMatchInfo>(queryParams: spFunGetMatchListParams(page),spProCallBack: SPClassHttpCallBack(
        spProOnSuccess: (list){
          controller?.finishRefresh(noMore: false,success: true);
          controller?.resetLoadState();
          spProShowData=list.spProDataList;
          listView.clear();
          setState(() {
            });
        },
        onError: (result){
          controller?.finishRefresh(success: false);
        },spProOnProgress: (v){}
    ));
  }


   spFunOnRefreshPassive()  {
     var guessIds="";
     listView.forEach((item){
       if(((item.key) as GlobalKey).currentContext!=null){
         if(((item as GestureDetector).child) is SPClassMatchFootballView){
           var itemView =(((item as GestureDetector).child) as SPClassMatchFootballView);
           guessIds= guessIds+(itemView.spProMatchItem!.spProGuessMatchId!+";");
         }
       }
     });
     SPClassApiManager.spFunGetInstance().spFunGuessMatchList<SPClassGuessMatchInfo>(queryParams:
       { "fetch_type":"guess_match",
         "guess_match_id":guessIds
       },
       spProCallBack: SPClassHttpCallBack(
         spProOnSuccess: (list){
           if(list.spProDataList.length>0){
             listView.forEach((item){

               if(((item.key) as GlobalKey).currentContext!=null){
                 if(((item as GestureDetector).child) is SPClassMatchFootballView){
                   var itemView =(((item as GestureDetector).child) as SPClassMatchFootballView);
                   itemView.state!.spFunOnfresh(list.spProDataList);
                 }
               }

             });
           }

         },
         onError: (result){
         },spProOnProgress: (v){},
     ));

  }

  void onReFreshByFilter(String leagueVale,String spProIsLottery){
    this.leagueMap[dates[spProDateIndex]]=leagueVale;
    this.spProIsLottery=spProIsLottery;
    this.spProIsHot="";
    controller?.callRefresh();
  }

  Future<void> spFunOnLoad() async{
    await SPClassApiManager.spFunGetInstance().spFunGuessMatchList<SPClassGuessMatchInfo>(queryParams:  spFunGetMatchListParams(page+1),spProCallBack: SPClassHttpCallBack(
        spProOnSuccess: (list){
          if(list.spProDataList.length==0){
            controller?.finishLoad(noMore: true);
          }else{
            page++;
          }
          setState(() {
            spProShowData.addAll(list.spProDataList);
          });
        },
        onError: (result){
          controller?.finishLoad(success: false);
        },
        spProOnProgress: (v){}
    ));
  }


  Future<void>  spFunOnRefreshLeague() async{
    var params=spFunGetMatchListParams(0);
    params.remove("league_name") ;
    params.remove("is_first_level") ;
    params["is_lottery"]=spProIsLottery;
    await SPClassApiManager.spFunGetInstance().spFunLeagueListByStatus<SPClassLeagueFilter>(params:params,spProCallBack:SPClassHttpCallBack(
        spProOnSuccess: (result){
          controller?.finishLoad(success: true);
          controller?.resetRefreshState();
          spProLeagueList.clear();
          if(this.spFunLeagueName!=null&&this.spFunLeagueName.isNotEmpty){
            this.spFunLeagueName.split(";").forEach((element) {

              result.spProLeagueList.forEach((item) {
                 if(item.spProLeagueName==element){
                   spProLeagueList.add(item);
                 }
              });
            });
          }else{
            spProLeagueList =  result.spProLeagueList;
          }
          setState(() {});
        },
        onError: (value){
          controller?.finishLoad(success: false);
        },spProOnProgress: (v){}
    ) );




  }


  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  Map<String,dynamic> spFunGetMatchListParams(int page) {

    return   {"page":page.toString(), "match_date":dates[spProDateIndex], "fetch_type":widget.status,"match_type":widget.spProMatchType,"league_name":this.leagueMap[dates[spProDateIndex]],"is_lottery":spProIsLottery,"is_first_level":spProIsHot,};

  }
 bool get spFunIsMatchHot  =>spProIsHot=="1";
 String get spFunLeagueName  =>this.leagueMap[dates[spProDateIndex]];
}