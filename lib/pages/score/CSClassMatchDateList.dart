
import 'dart:convert';

import 'package:changshengh5/api/CSClassApiManager.dart';
import 'package:changshengh5/api/CSClassHttpCallBack.dart';
import 'package:changshengh5/app/CSClassApplicaion.dart';
import 'package:changshengh5/model/CSClassGuessMatchInfo.dart';
import 'package:changshengh5/model/CSClassLeagueFilter.dart';
import 'package:changshengh5/pages/common/CSClassNoDataView.dart';
import 'package:changshengh5/pages/competition/CSClassMatchDetailPage.dart';
import 'package:changshengh5/pages/competition/CSClassMatchListSettingPage.dart';
import 'package:changshengh5/utils/CSClassCommonMethods.dart';
import 'package:changshengh5/utils/CSClassDateUtils.dart';
import 'package:changshengh5/utils/CSClassNavigatorUtils.dart';
import 'package:changshengh5/utils/colors.dart';
import 'package:changshengh5/widgets/CSClassBallFooter.dart';
import 'package:changshengh5/widgets/CSClassBallHeader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

import 'CSClassMatchBasketballView.dart';
import 'CSClassMatchFootballView.dart';
import 'CSClassMatchLolView.dart';
import 'CSClassPageMatchGroupItem.dart';


class CSClassMatchDateList extends StatefulWidget{
  String ?status;
  String ?csProMatchType;
  bool ?isHot;
  CSClassMatchDateListState ?csProState;
  CSClassMatchDateList({this.status,this.csProMatchType,this.isHot});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return csProState=CSClassMatchDateListState();
  }

}

class CSClassMatchDateListState extends State<CSClassMatchDateList> {
  List<String> dates =[];
  List<CSClassGuessMatchInfo> csProShowData =[];
  List<CSClassLeagueName> csProLeagueList=[];
  EasyRefreshController ?controller;
  ScrollController ?csProScrollControllerDate;
  ScrollController ?csProListScrollController;
  int page=1;
  int csProDateIndex=0;
  var leagueMap={};
  var csProIsLottery ="";
  var csProIsHot ="";
  bool showLeagueGroupType=false;
  bool csProIsLoading=false;
  List<Widget> listView=[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller=EasyRefreshController();
    csProListScrollController=ScrollController();
    if(widget.isHot==true){
      csProIsHot = '1';
    }
    if(CSClassMatchListSettingPageState.csProMatchShowType==0||widget.status=="my_collected"){
      showLeagueGroupType=false;
    }else{
      showLeagueGroupType=true;
    }
    if(widget.status=="not_started"){
      dates =CSClassDateUtils.csMethodAfterDays(7, CSClassDateUtils.dateFormatByDate(DateTime.now(), 'yyyy-MM-dd'));
    }else{
      dates =CSClassDateUtils.csMethodBeforDays(7, CSClassDateUtils.dateFormatByDate(DateTime.now(), 'yyyy-MM-dd'));
    }

    csProDateIndex=dates.indexOf(CSClassDateUtils.dateFormatByDate(DateTime.now(), 'yyyy-MM-dd'));
    if(widget.csProMatchType=="lol"){
      csProIsHot="";
    }
    if(csProDateIndex>3){
      csProScrollControllerDate=ScrollController(initialScrollOffset:width(77)*(csProDateIndex+1) );
    }
    this.leagueMap[dates[csProDateIndex]]="";

    CSClassApplicaion.csProEventBus.on<String>().listen((event) {

      if(event=="match:pankou"){
        // getSeqNum();
        if(CSClassMatchListSettingPageState.csProMatchShowType==0||widget.status=="my_collected"){
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
        if(CSClassMatchListSettingPageState.csProMatchShowType==0||widget.status=="my_collected"){
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
                  controller: csProScrollControllerDate,
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
                                "${CSClassDateUtils.csMethodFormatWeekday(dates[index])}",style: TextStyle(fontSize: sp(12),color:index==csProDateIndex? MyColors.main1:Color(0xFF8F8F8F)),),
                            Text(CSClassDateUtils.csMethodDateFormatByString(dates[index],"MM-dd"),style: TextStyle(fontSize: sp(12),color: index==csProDateIndex?MyColors.main1:Color(0xFF8F8F8F)),)

                          ],
                        ),
                      ),
                      onTap: (){
                          setState(() {
                            csProDateIndex=index;
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
                header:CSClassBallHeader(
                    textColor: Color(0xFF666666)
                ),
                footer: CSClassBallFooter(
                    textColor: Color(0xFF666666)
                ),
                onRefresh: csMethodOnRefreshLeague,
                emptyWidget: csProLeagueList.isEmpty ? CSClassNoDataView(): null,
                slivers: <Widget>[
                  SliverToBoxAdapter(
                    child: ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        itemCount: csProLeagueList.length,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (c,index){
                      var leagueIem =csProLeagueList[index];
                      return CSClassPageMatchGroupItem(expand: index<3,csProLeagueInfo: leagueIem,csProDate: dates[csProDateIndex],csProMatchType: widget.csProMatchType!,csProStatus: widget.status!,csProRefreshStatus: "1",) ;
                    }),
                  )
                ],
              ),
            ) :

            Expanded(
              child: EasyRefresh.custom(
                firstRefresh: true,
                controller:controller ,
                scrollController: csProListScrollController,
                header:CSClassBallHeader(
                    textColor: Color(0xFF666666)
                ),
                footer: CSClassBallFooter(
                    textColor: Color(0xFF666666)
                ),
                onRefresh: csMethodOnReFresh,
                onLoad: csMethodOnLoad,
                emptyWidget: csProShowData.length == 0 ? CSClassNoDataView(): null,
                slivers: <Widget>[
                  SliverList(
                    delegate: SliverChildListDelegate([
                      SizedBox(height: width(4),)
                    ]),
                  ),
                  SliverList  (
                    delegate: SliverChildBuilderDelegate(
                          (context, index) {
                        var csProMatchItem =csProShowData[index];

                        if(listView.length-1<index){
                          var view=GestureDetector(
                            key: new GlobalKey(),
                            behavior: HitTestBehavior.opaque,
                            child:(csProMatchItem.csProMatchType=="足球" ? CSClassMatchFootballView(csProMatchItem):
                            csProMatchItem.csProMatchType=="篮球" ?
                            CSClassMatchBasketballView(csProMatchItem):CSClassMatchLolView(csProMatchItem)),
                            onTap: (){
                              CSClassApiManager.csMethodGetInstance().csMethodMatchClick(queryParameters: {"match_id":csProMatchItem.csProGuessMatchId});
                              CSClassNavigatorUtils.csMethodPushRoute(context,  CSClassMatchDetailPage(csProMatchItem,csProMatchType:"guess_match_id",csProInitIndex: 1,));

                            },
                          );
                          listView.add(view);

                        }
                        return listView[index] ;
                      },
                      childCount: csProShowData.length,
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

  Future<void> csMethodOnReFresh({bool show:true}) async {
    page=1;

    if(show){
      await Future.delayed(Duration(milliseconds: 300));
    }

    await  CSClassApiManager.csMethodGetInstance().csMethodGuessMatchList<CSClassGuessMatchInfo>(queryParams: csMethodGetMatchListParams(page),csProCallBack: CSClassHttpCallBack(
        csProOnSuccess: (list){
          controller?.finishRefresh(noMore: false,success: true);
          controller?.resetLoadState();
          csProShowData=list.csProDataList;
          listView.clear();
          setState(() {
            });
        },
        onError: (result){
          controller?.finishRefresh(success: false);
        },csProOnProgress: (v){}
    ));
  }


   csMethodOnRefreshPassive()  {
     var guessIds="";
     listView.forEach((item){
       if(((item.key) as GlobalKey).currentContext!=null){
         if(((item as GestureDetector).child) is CSClassMatchFootballView){
           var itemView =(((item as GestureDetector).child) as CSClassMatchFootballView);
           guessIds= guessIds+(itemView.csProMatchItem!.csProGuessMatchId!+";");
         }
       }
     });
     CSClassApiManager.csMethodGetInstance().csMethodGuessMatchList<CSClassGuessMatchInfo>(queryParams:
       { "fetch_type":"guess_match",
         "guess_match_id":guessIds
       },
       csProCallBack: CSClassHttpCallBack(
         csProOnSuccess: (list){
           if(list.csProDataList.length>0){
             listView.forEach((item){

               if(((item.key) as GlobalKey).currentContext!=null){
                 if(((item as GestureDetector).child) is CSClassMatchFootballView){
                   var itemView =(((item as GestureDetector).child) as CSClassMatchFootballView);
                   itemView.state!.csMethodOnfresh(list.csProDataList);
                 }
               }

             });
           }

         },
         onError: (result){
         },csProOnProgress: (v){},
     ));

  }

  void onReFreshByFilter(String leagueVale,String csProIsLottery){
    this.leagueMap[dates[csProDateIndex]]=leagueVale;
    this.csProIsLottery=csProIsLottery;
    this.csProIsHot="";
    controller?.callRefresh();
  }

  Future<void> csMethodOnLoad() async{
    await CSClassApiManager.csMethodGetInstance().csMethodGuessMatchList<CSClassGuessMatchInfo>(queryParams:  csMethodGetMatchListParams(page+1),csProCallBack: CSClassHttpCallBack(
        csProOnSuccess: (list){
          if(list.csProDataList.length==0){
            controller?.finishLoad(noMore: true);
          }else{
            page++;
          }
          setState(() {
            csProShowData.addAll(list.csProDataList);
          });
        },
        onError: (result){
          controller?.finishLoad(success: false);
        },
        csProOnProgress: (v){}
    ));
  }


  Future<void>  csMethodOnRefreshLeague() async{
    var params=csMethodGetMatchListParams(0);
    params.remove("league_name") ;
    params.remove("is_first_level") ;
    params["is_lottery"]=csProIsLottery;
    await CSClassApiManager.csMethodGetInstance().csMethodLeagueListByStatus<CSClassLeagueFilter>(params:params,csProCallBack:CSClassHttpCallBack(
        csProOnSuccess: (result){
          controller?.finishLoad(success: true);
          controller?.resetRefreshState();
          csProLeagueList.clear();
          if(this.csMethodLeagueName!=null&&this.csMethodLeagueName.isNotEmpty){
            this.csMethodLeagueName.split(";").forEach((element) {

              result.csProLeagueList.forEach((item) {
                 if(item.csProLeagueName==element){
                   csProLeagueList.add(item);
                 }
              });
            });
          }else{
            csProLeagueList =  result.csProLeagueList;
          }
          setState(() {});
        },
        onError: (value){
          controller?.finishLoad(success: false);
        },csProOnProgress: (v){}
    ) );




  }


  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  Map<String,dynamic> csMethodGetMatchListParams(int page) {

    return   {"page":page.toString(), "match_date":dates[csProDateIndex], "fetch_type":widget.status,"match_type":widget.csProMatchType,"league_name":this.leagueMap[dates[csProDateIndex]],"is_lottery":csProIsLottery,"is_first_level":csProIsHot,};

  }
 bool get csMethodIsMatchHot  =>csProIsHot=="1";
 String get csMethodLeagueName  =>this.leagueMap[dates[csProDateIndex]];
}