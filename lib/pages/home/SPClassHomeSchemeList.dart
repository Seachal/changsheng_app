

import 'package:changshengh5/api/SPClassApiManager.dart';
import 'package:changshengh5/api/SPClassHttpCallBack.dart';
import 'package:changshengh5/app/SPClassApplicaion.dart';
import 'package:changshengh5/model/SPClassSchemeListEntity.dart';
import 'package:changshengh5/pages/common/SPClassNoDataView.dart';
import 'package:changshengh5/widgets/SPClassBallFooter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

import 'SPClassSchemeItemView.dart';



class SPClassHomeSchemeList extends StatefulWidget{
  String ?spProFetchType="";
  String ?spProPayWay;
  bool ?spProShowProfit;
  int ?type ;
  SPClassHomeSchemeListState ?spProState;

  SPClassHomeSchemeList({this.spProFetchType,this.spProPayWay,this.spProShowProfit:true,this.type=0});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return spProState=SPClassHomeSchemeListState();
  }

}

class SPClassHomeSchemeListState extends State<SPClassHomeSchemeList> with AutomaticKeepAliveClientMixin<SPClassHomeSchemeList>{
  List<SPClassSchemeListSchemeList> spProSchemeList=[];//全部
  late EasyRefreshController spProRefreshController;
  String spProPayWay="";
  String spProMatchType="足球";
  int page=1;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    spProRefreshController=EasyRefreshController();
    // spProMatchType= SPClassHomePageState.spProHomeMatchType;
    spProMatchType = widget.type==0?'足球':'篮球';
    spFunOnRefresh(widget.spProPayWay!,spProMatchType);

    SPClassApplicaion.spProEventBus.on<String>().listen((event) {
      if(event.startsWith("scheme:refresh")){
        spFunOnRefresh(widget.spProPayWay!,spProMatchType/*SPClassHomePageState.*/);
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    super.build(context);
    return EasyRefresh.custom(
      topBouncing: false,
      controller:spProRefreshController ,
      footer: SPClassBallFooter(
        textColor: Color(0xFF8F8F8F),
      ),
      onLoad: spFunOnMore,
      slivers: <Widget>[
        SliverToBoxAdapter(
          child:spProSchemeList.isEmpty?  SPClassNoDataView():SizedBox(),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
                (context, index) {
              var schemeItem=spProSchemeList[index];
              return SPClassSchemeItemView(schemeItem,spProShowProFit: widget.spProShowProfit!,);
            },
            childCount: spProSchemeList.length,
          ),
        ),
      ],
    );
  }

  Future<void>  spFunOnRefresh(String spProPayWay,String spProMatchType) async {
    page=1;
    this.spProPayWay=spProPayWay;
    this.spProMatchType=spProMatchType;
    return  SPClassApiManager.spFunGetInstance().spFunSchemeList(queryParameters: {"fetch_type":widget.spProFetchType,"page":page.toString(),"playing_way":spProPayWay,"match_type":spProMatchType},spProCallBack: SPClassHttpCallBack(
        spProOnSuccess: (list){
          spProRefreshController.finishRefresh(noMore: false,success: true);
          spProRefreshController.resetLoadState();
          if(mounted){
            setState(() {
              spProSchemeList=list.spProSchemeList!;
            });
          }
        },
        onError: (value){
          spProRefreshController.finishRefresh(success: false);
        },spProOnProgress: (v){},
    ));
  }

  Future<void>  spFunOnMore() async {
    await  SPClassApiManager.spFunGetInstance().spFunSchemeList(queryParameters: {"fetch_type":widget.spProFetchType,"page":(page+1).toString(),"playing_way":spProPayWay,"match_type":spProMatchType},spProCallBack: SPClassHttpCallBack(
        spProOnSuccess: (list){

          if(list.spProSchemeList!.isEmpty){
            spProRefreshController.finishLoad(noMore: true);
          }else{
            page++;

          }
          if(mounted){
            setState(() {
              spProSchemeList.addAll(list.spProSchemeList!);
            });
          }
        },
        onError: (value){
          spProRefreshController.finishLoad(success: false);
        },spProOnProgress: (v){}
    ));

  }


  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

}