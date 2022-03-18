import 'dart:async';

import 'package:changshengh5/api/SPClassApiManager.dart';
import 'package:changshengh5/api/SPClassHttpCallBack.dart';
import 'package:changshengh5/app/SPClassApplicaion.dart';
import 'package:changshengh5/model/SPClassSchemeListEntity.dart';
import 'package:changshengh5/pages/common/SPClassNoDataView.dart';
import 'package:changshengh5/pages/home/SPClassSchemeItemView.dart';
import 'package:changshengh5/utils/SPClassCommonMethods.dart';
import 'package:changshengh5/utils/SPClassImageUtil.dart';
import 'package:changshengh5/widgets/SPClassBallFooter.dart';
import 'package:changshengh5/widgets/SPClassBallHeader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';


class SPClassMyAddSchemeListPage extends StatefulWidget{

  SPClassMyAddSchemeListPage();
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SPClassMyAddSchemeListPageState();
  }

}

class SPClassMyAddSchemeListPageState extends State<SPClassMyAddSchemeListPage>  {
  List<SPClassSchemeListSchemeList> spProSchemeList= [];//全部
  EasyRefreshController ?spProRefreshController;
  int page=1;
  var spProNowDate;

  StreamSubscription<String> ? spProSubEvent;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    spFunOnRefresh();
    spProRefreshController=EasyRefreshController();

    spProSubEvent = SPClassApplicaion.spProEventBus.on<String>().listen((event) {
      if(event=="refresh:myscheme"){
        spFunOnRefresh();
      }
    });


  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      color: Colors.white,
      child: EasyRefresh.custom(
        controller:spProRefreshController ,
        header: SPClassBallHeader(
            textColor: Color(0xFF666666)
        ),
        footer: SPClassBallFooter(
            textColor: Color(0xFF666666)
        ),
        emptyWidget:spProSchemeList.isEmpty?  SPClassNoDataView():null,
        onRefresh: spFunOnRefresh,
        onLoad: spFunOnMore,
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Container(
              color: Colors.white,
              child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: spProSchemeList.length,
                  itemBuilder: (c,index){
                    var schemeItem=spProSchemeList[index];
                    return Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        SPClassSchemeItemView(schemeItem,spProShowRate: false,),
                        Positioned(
                          right:  width(13) ,
                          top:width(10),
                          child: Image.asset(
                            (schemeItem.spProVerifyStatus=="0")? SPClassImageUtil.spFunGetImagePath("ic_verify_ing"):
                            (schemeItem.spProVerifyStatus=="-1")? SPClassImageUtil.spFunGetImagePath("ic_verify_bad"): "",
                            width: width(46),
                          ),
                        ),
                        Positioned(
                          top: 10,
                          right:  width(13) ,
                          child: Image.asset(
                            (schemeItem.spProIsWin=="1")? SPClassImageUtil.spFunGetImagePath("ic_result_red"):
                            (schemeItem.spProIsWin=="0")? SPClassImageUtil.spFunGetImagePath("ic_result_hei"):
                            (schemeItem.spProIsWin=="2")? SPClassImageUtil.spFunGetImagePath("ic_result_zou"):"",
                            width: width(46),
                          ),
                        ),
                      ],
                    );
                  }),
            ),
          ),

        ],
      ),
    );
  }

  Future<void>  spFunOnRefresh() async {
    page=1;
    return  SPClassApiManager.spFunGetInstance().spFunSchemeList(queryParameters: {"fetch_type":"mine","page":page.toString(),},spProCallBack: SPClassHttpCallBack<SPClassSchemeListEntity>(
        spProOnSuccess: (list){
          spProRefreshController?.finishRefresh(noMore: false,success: true);
          spProRefreshController?.resetLoadState();
          if(mounted){
            setState(() {
              spProSchemeList=list.spProSchemeList!;
            });
          }
        },
        onError: (value){
          spProRefreshController?.finishRefresh(success: false);
        },spProOnProgress: (v){}
    ));
  }

  Future<void>  spFunOnMore() async {
    await  SPClassApiManager.spFunGetInstance().spFunSchemeList(queryParameters: {"fetch_type":"mine","page":(page+1).toString(),},spProCallBack: SPClassHttpCallBack<SPClassSchemeListEntity>(
        spProOnSuccess: (list){
          if(list.spProSchemeList!.isEmpty){
            spProRefreshController?.finishLoad(noMore: true);
          }else{
            page++;
            spProRefreshController?.finishLoad(noMore: false);

          }

          if(mounted){
            setState(() {
              spProSchemeList.addAll(list.spProSchemeList!);
            });
          }
        },
        onError: (value){
          spProRefreshController?.finishLoad(success: false);

        },spProOnProgress: (v){}
    ));

  }



  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    spProSubEvent?.cancel();
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;



}