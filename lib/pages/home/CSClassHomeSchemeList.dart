

import 'package:changshengh5/api/CSClassApiManager.dart';
import 'package:changshengh5/api/CSClassHttpCallBack.dart';
import 'package:changshengh5/app/CSClassApplicaion.dart';
import 'package:changshengh5/model/CSClassSchemeListEntity.dart';
import 'package:changshengh5/pages/common/CSClassNoDataView.dart';
import 'package:changshengh5/widgets/CSClassBallFooter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

import 'CSClassSchemeItemView.dart';



class CSClassHomeSchemeList extends StatefulWidget{
  String ?csProFetchType="";
  String ?csProPayWay;
  bool ?csProShowProfit;
  int ?type ;
  CSClassHomeSchemeListState ?csProState;

  CSClassHomeSchemeList({this.csProFetchType,this.csProPayWay,this.csProShowProfit:true,this.type=0});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return csProState=CSClassHomeSchemeListState();
  }

}

class CSClassHomeSchemeListState extends State<CSClassHomeSchemeList> with AutomaticKeepAliveClientMixin<CSClassHomeSchemeList>{
  List<CSClassSchemeListSchemeList> csProSchemeList=[];//全部
  late EasyRefreshController csProRefreshController;
  String csProPayWay="";
  String csProMatchType="足球";
  int page=1;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    csProRefreshController=EasyRefreshController();
    // csProMatchType= CSClassHomePageState.csProHomeMatchType;
    csProMatchType = widget.type==0?'足球':'篮球';
    csMethodOnRefresh(widget.csProPayWay!,csProMatchType);

    CSClassApplicaion.csProEventBus.on<String>().listen((event) {
      if(event.startsWith("scheme:refresh")){
        csMethodOnRefresh(widget.csProPayWay!,csProMatchType/*CSClassHomePageState.*/);
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    super.build(context);
    return EasyRefresh.custom(
      topBouncing: false,
      controller:csProRefreshController ,
      footer: CSClassBallFooter(
        textColor: Color(0xFF8F8F8F),
      ),
      onLoad: csMethodOnMore,
      slivers: <Widget>[
        SliverToBoxAdapter(
          child:csProSchemeList.isEmpty?  CSClassNoDataView():SizedBox(),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
                (context, index) {
              var schemeItem=csProSchemeList[index];
              return CSClassSchemeItemView(schemeItem,csProShowProFit: widget.csProShowProfit!,);
            },
            childCount: csProSchemeList.length,
          ),
        ),
      ],
    );
  }

  Future<void>  csMethodOnRefresh(String csProPayWay,String csProMatchType) async {
    page=1;
    this.csProPayWay=csProPayWay;
    this.csProMatchType=csProMatchType;
    return  CSClassApiManager.csMethodGetInstance().csMethodSchemeList(queryParameters: {"fetch_type":widget.csProFetchType,"page":page.toString(),"playing_way":csProPayWay,"match_type":csProMatchType},csProCallBack: CSClassHttpCallBack(
        csProOnSuccess: (list){
          csProRefreshController.finishRefresh(noMore: false,success: true);
          csProRefreshController.resetLoadState();
          if(mounted){
            setState(() {
              csProSchemeList=list.csProSchemeList!;
            });
          }
        },
        onError: (value){
          csProRefreshController.finishRefresh(success: false);
        },csProOnProgress: (v){},
    ));
  }

  Future<void>  csMethodOnMore() async {
    await  CSClassApiManager.csMethodGetInstance().csMethodSchemeList(queryParameters: {"fetch_type":widget.csProFetchType,"page":(page+1).toString(),"playing_way":csProPayWay,"match_type":csProMatchType},csProCallBack: CSClassHttpCallBack(
        csProOnSuccess: (list){

          if(list.csProSchemeList!.isEmpty){
            csProRefreshController.finishLoad(noMore: true);
          }else{
            page++;

          }
          if(mounted){
            setState(() {
              csProSchemeList.addAll(list.csProSchemeList!);
            });
          }
        },
        onError: (value){
          csProRefreshController.finishLoad(success: false);
        },csProOnProgress: (v){}
    ));

  }


  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

}