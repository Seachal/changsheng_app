import 'dart:io';

import 'package:changshengh5/api/SPClassApiManager.dart';
import 'package:changshengh5/api/SPClassHttpCallBack.dart';
import 'package:changshengh5/app/SPClassApplicaion.dart';
import 'package:changshengh5/model/SPClassCoinLogInfo.dart';
import 'package:changshengh5/pages/common/SPClassLoadingPage.dart';
import 'package:changshengh5/pages/common/SPClassNoDataView.dart';
import 'package:changshengh5/utils/SPClassCommonMethods.dart';
import 'package:changshengh5/utils/SPClassDateUtils.dart';
import 'package:changshengh5/utils/SPClassImageUtil.dart';
import 'package:changshengh5/utils/SPClassStringUtils.dart';
import 'package:changshengh5/utils/colors.dart';
import 'package:changshengh5/widgets/SPClassBallFooter.dart';
import 'package:changshengh5/widgets/SPClassBallHeader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


import 'SPClassRechargeDiamondPage.dart';


class SPClassDiamondHistoryPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SPClassDiamondHistoryPageState();
  }
}

class SPClassDiamondHistoryPageState extends State<SPClassDiamondHistoryPage> {
  EasyRefreshController ?spProFreshController;
  List<SPClassCoinLogInfo> spProDiamondLogs =[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    spProFreshController =EasyRefreshController();

  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("余额明细"),
      ),
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              height: width(6),
              color: Color(0xFFF2F2F2),
            ),
            Container(
              height: width(40),
              padding: EdgeInsets.symmetric(horizontal: width(15)),
              child: Row(
                children: <Widget>[
                  Text('当前余额',style: TextStyle(),),
                  Expanded(child: SizedBox(),),
                  Text(SPClassStringUtils.spFunSqlitZero(SPClassApplicaion.spProUserInfo!.spProDiamond),style: TextStyle(height: 0.9,color: MyColors.main1,fontSize: sp(23)),),
                  Image.asset(
                    SPClassImageUtil.spFunGetImagePath("zhuanshi"),
                    width: width(17),
                  ),
                ],
              ),
            ),
            Container(
              height: width(40),
              padding: EdgeInsets.only(left: width(13)),
              decoration: BoxDecoration(
                  color: Color(0xFFF3F3F3),
                border: Border(top: BorderSide(width: 0.4,color: Colors.grey[300]!,),bottom: BorderSide(width: 0.4,color: Colors.grey[300]!,))
              ),
              alignment: Alignment.centerLeft,
              child: Text("钻石明细",style: TextStyle(color: Color(0xFF333333),fontSize: sp(13)),),
            ),
            Expanded(
              child:EasyRefresh.custom(
                firstRefresh: true,
                firstRefreshWidget:SPClassLoadingPage(),
                header:SPClassBallHeader(
                    textColor: Color(0xFF666666)
                ),
                footer: SPClassBallFooter(
                    textColor: Color(0xFF666666)
                ),
                onRefresh: spFunGetList,
                onLoad: spFunListMore,
                emptyWidget: spProDiamondLogs.length==0? SPClassNoDataView():null,
                controller:spProFreshController ,
                slivers: <Widget>[
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, i) {
                        return Container(
                          padding: EdgeInsets.only(left: width(21),right:width(21),top: height(13),bottom: height(13) ),
                          decoration: BoxDecoration(
                              border: Border(bottom: BorderSide(width: 0.4,color: Colors.grey[300]!))
                          ),
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Flexible(
                                flex: 1,
                                fit: FlexFit.tight,
                                child:Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(spProDiamondLogs[i].spProChangeDesc!,style:TextStyle(fontSize: sp(14),color: Color(0xFF333333)),maxLines: 1,overflow: TextOverflow.ellipsis,),
                                    SizedBox(height: width(2),),
                                    Text(SPClassDateUtils.spFunDateFormatByString(spProDiamondLogs[i].spProChangeTime!, "yyyy年MM月dd日 HH:mm:ss"),style:TextStyle(fontSize: sp(11),color: Color(0xFFB7B7B7)),)
                                  ],
                                ),
                              ),
                              SizedBox(width: width(50),),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(double.parse(spProDiamondLogs[i].spProChangeCoin!)>0?
                                  "+"+ SPClassStringUtils.spFunSqlitZero(spProDiamondLogs[i].spProChangeCoin!):
                                  SPClassStringUtils.spFunSqlitZero(spProDiamondLogs[i].spProChangeCoin!),style:TextStyle(fontFamily: 'RobotoRegular',fontSize: sp(20),color:double.parse(spProDiamondLogs[i].spProChangeCoin!)>0?  Color(0xFFE3494B):Color(0xFF58A55C)),),
                                  (spProDiamondLogs[i].subtitle==null||spProDiamondLogs[i].subtitle!.isEmpty)?SizedBox(): Container(
                                    alignment: Alignment.center,
                                    height: height(15),
                                    padding: EdgeInsets.only(left: 5,right: 5),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(width(3)),
                                        border: Border.all(color:Color(0xFF888888),width: 0.4 )
                                    ),
                                    child:Text(spProDiamondLogs[i].subtitle!,style: TextStyle(fontSize: sp(10),color: Color(0xFF888888)),),
                                  ),
                                ],
                              )
                            ],


                          ),
                        );
                      },
                      childCount: spProDiamondLogs.length
                  )
                  )
                ],
              ),
            )
          ],
        ),
      ),
      // bottomNavigationBar: Container(
      //   decoration: BoxDecoration(
      //       boxShadow:[BoxShadow(
      //         offset: Offset(1,1),
      //         color: Color(0x1a000000),
      //         blurRadius:width(6,),
      //       )]
      //   ),
      //   height:height(53),
      //   child:GestureDetector(
      //     child:  Container(
      //       color: Colors.white,
      //       height: height(53),
      //       alignment: Alignment.center,
      //       child:Container(
      //         alignment: Alignment.center,
      //         height: height(40),
      //         width: width(253),
      //         decoration: BoxDecoration(
      //           borderRadius: BorderRadius.circular(width(5)),
      //           gradient: LinearGradient(
      //               colors: [Color(0xFFF1585A),Color(0xFFF77273)]
      //           ),
      //         ),
      //         child:Text("充值",style: TextStyle(fontSize: sp(15),color: Colors.white),),
      //       ) ,
      //     ),
      //     onTap: (){
      //
      //     SPClassNavigatorUtils.spFunPushRoute(context,  SPClassRechargeDiamondPage());
      //
      //     },
      //   ),
      // ),
    );
  }

  Future<void>  spFunGetList() async {

    return SPClassApiManager.spFunGetInstance().spFunGetCoinLog<SPClassCoinLogInfo>(queryParameters: {"coin_type":"diamond"},
    spProCallBack:SPClassHttpCallBack(
      spProOnSuccess: (result){
        spProDiamondLogs=result.spProDataList;
        spProFreshController!.resetLoadState();
        setState(() {
        });
      },onError: (e){},spProOnProgress: (v){}
    ));


  }

  Future<void> spFunListMore() async {


    return SPClassApiManager.spFunGetInstance().spFunGetCoinLog<SPClassCoinLogInfo>(
        queryParameters:
       {"coin_type":"diamond","ref_coin_log_id":spProDiamondLogs[spProDiamondLogs.length-1].spProCoinLogId},
        spProCallBack:SPClassHttpCallBack(
            spProOnSuccess: (result){
              if(result.spProDataList.length>0){
                spProFreshController!.finishLoad();
              }else{
                spProFreshController!.finishLoad(noMore: true);
              }
              spProDiamondLogs.addAll(result.spProDataList);
              setState(() {
              });
            },onError: (e){},spProOnProgress: (v){}
        ));


  }
}
