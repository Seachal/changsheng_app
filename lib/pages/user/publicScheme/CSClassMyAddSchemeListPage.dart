import 'dart:async';

import 'package:changshengh5/api/CSClassApiManager.dart';
import 'package:changshengh5/api/CSClassHttpCallBack.dart';
import 'package:changshengh5/app/CSClassApplicaion.dart';
import 'package:changshengh5/model/CSClassSchemeListEntity.dart';
import 'package:changshengh5/pages/common/CSClassNoDataView.dart';
import 'package:changshengh5/pages/home/CSClassSchemeItemView.dart';
import 'package:changshengh5/utils/CSClassCommonMethods.dart';
import 'package:changshengh5/utils/CSClassImageUtil.dart';
import 'package:changshengh5/widgets/CSClassBallFooter.dart';
import 'package:changshengh5/widgets/CSClassBallHeader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';


class CSClassMyAddSchemeListPage extends StatefulWidget{

  CSClassMyAddSchemeListPage();
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CSClassMyAddSchemeListPageState();
  }

}

class CSClassMyAddSchemeListPageState extends State<CSClassMyAddSchemeListPage>  {
  List<CSClassSchemeListSchemeList> csProSchemeList= [];//全部
  EasyRefreshController ?csProRefreshController;
  int page=1;
  var csProNowDate;

  StreamSubscription<String> ? csProSubEvent;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    csMethodOnRefresh();
    csProRefreshController=EasyRefreshController();

    csProSubEvent = CSClassApplicaion.csProEventBus.on<String>().listen((event) {
      if(event=="refresh:myscheme"){
        csMethodOnRefresh();
      }
    });


  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      color: Colors.white,
      child: EasyRefresh.custom(
        controller:csProRefreshController ,
        header: CSClassBallHeader(
            textColor: Color(0xFF666666)
        ),
        footer: CSClassBallFooter(
            textColor: Color(0xFF666666)
        ),
        emptyWidget:csProSchemeList.isEmpty?  CSClassNoDataView():null,
        onRefresh: csMethodOnRefresh,
        onLoad: csMethodOnMore,
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Container(
              color: Colors.white,
              child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: csProSchemeList.length,
                  itemBuilder: (c,index){
                    var schemeItem=csProSchemeList[index];
                    return Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        CSClassSchemeItemView(schemeItem,csProShowRate: false,),
                        Positioned(
                          right:  width(13) ,
                          top:width(10),
                          child: Image.asset(
                            (schemeItem.csProVerifyStatus=="0")? CSClassImageUtil.csMethodGetImagePath("ic_verify_ing"):
                            (schemeItem.csProVerifyStatus=="-1")? CSClassImageUtil.csMethodGetImagePath("ic_verify_bad"): "",
                            width: width(46),
                          ),
                        ),
                        Positioned(
                          top: 10,
                          right:  width(13) ,
                          child: Image.asset(
                            (schemeItem.csProIsWin=="1")? CSClassImageUtil.csMethodGetImagePath("ic_result_red"):
                            (schemeItem.csProIsWin=="0")? CSClassImageUtil.csMethodGetImagePath("ic_result_hei"):
                            (schemeItem.csProIsWin=="2")? CSClassImageUtil.csMethodGetImagePath("ic_result_zou"):"",
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

  Future<void>  csMethodOnRefresh() async {
    page=1;
    return  CSClassApiManager.csMethodGetInstance().csMethodSchemeList(queryParameters: {"fetch_type":"mine","page":page.toString(),},csProCallBack: CSClassHttpCallBack<CSClassSchemeListEntity>(
        csProOnSuccess: (list){
          csProRefreshController?.finishRefresh(noMore: false,success: true);
          csProRefreshController?.resetLoadState();
          if(mounted){
            setState(() {
              csProSchemeList=list.csProSchemeList!;
            });
          }
        },
        onError: (value){
          csProRefreshController?.finishRefresh(success: false);
        },csProOnProgress: (v){}
    ));
  }

  Future<void>  csMethodOnMore() async {
    await  CSClassApiManager.csMethodGetInstance().csMethodSchemeList(queryParameters: {"fetch_type":"mine","page":(page+1).toString(),},csProCallBack: CSClassHttpCallBack<CSClassSchemeListEntity>(
        csProOnSuccess: (list){
          if(list.csProSchemeList!.isEmpty){
            csProRefreshController?.finishLoad(noMore: true);
          }else{
            page++;
            csProRefreshController?.finishLoad(noMore: false);

          }

          if(mounted){
            setState(() {
              csProSchemeList.addAll(list.csProSchemeList!);
            });
          }
        },
        onError: (value){
          csProRefreshController?.finishLoad(success: false);

        },csProOnProgress: (v){}
    ));

  }



  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    csProSubEvent?.cancel();
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;



}