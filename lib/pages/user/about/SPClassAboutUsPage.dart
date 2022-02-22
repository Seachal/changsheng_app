

import 'dart:async';

import 'package:changshengh5/app/SPClassApplicaion.dart';
import 'package:changshengh5/pages/dialogs/agreement_page.dart';
import 'package:changshengh5/untils/SPClassCommonMethods.dart';
import 'package:changshengh5/untils/SPClassImageUtil.dart';
import 'package:changshengh5/untils/SPClassNavigatorUtils.dart';
import 'package:changshengh5/widgets/SPClassToolBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'SPClassTestPage.dart';


class SPClassAboutUsPage extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SPClassAboutUsPageState();
  }

}

class SPClassAboutUsPageState extends State<SPClassAboutUsPage>{

  int spProDebugIndex=0;
  DateTime ?spProPressTime;
  //标记 app专用
  // PackageInfo spProPackageInfo;
  Timer ?timer;
  @override
   initState()  {
    // TODO: implement initState
    super.initState();
    //标记 app专用
     //   PackageInfo.fromPlatform().then((result){
     //     spProPackageInfo=result;
     //     if(mounted){
     //       setState(() {
     //       });
     //     }
     // });

  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: SPClassToolBar(
        context,title: "关于我们",),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Color(0xFFF1F1F1),
        child: Column(
            children: <Widget>[
              SizedBox(height: height(53),),
              GestureDetector(
                child: Container(
                  alignment: Alignment.bottomCenter,
                  width: MediaQuery.of(context).size.width,
                  child: Image.asset(SPClassImageUtil.spFunGetImagePath("ic_app_logo"),
                    width: width(93),
                  ),
                ),
                onTap: (){
                  // if(spProPressTime==null){
                  //   spProPressTime=DateTime.now();
                  //   spProDebugIndex=1;
                  //   return;
                  // }
                  // spProDebugIndex++;
                  // if(timer!=null){
                  //   timer?.cancel();
                  // }
                  // timer= Timer(Duration(seconds: 2), (){
                  //   spProPressTime=null;
                  // });
                  // if(spProDebugIndex==5){
                  //   spProDebugIndex=0;
                  //   spProPressTime=null;
                  //   SPClassNavigatorUtils.spFunPushRoute(context,SPClassTestPage());
                  // }
                },
              ),
              SizedBox(height: 10,),
              Text("${SPClassApplicaion.spProAppName}",style: TextStyle(fontSize: 18,color: Color(0xFF333333),fontWeight: FontWeight.bold),),
              Text("Copyright © 2018-2019 "+
                  SPClassApplicaion.spProAppName,style: TextStyle(fontSize: 13,color: Color(0xFFBDBDBD)),),
              SizedBox(height: 20,),
              GestureDetector(
                behavior:HitTestBehavior.opaque ,
                child:Container(
                  padding: EdgeInsets.only(right: 13,left: 13),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(top: BorderSide(width: 0.4,color: Colors.grey[300]!),bottom: BorderSide(width: 0.4,color: Colors.grey[300]!))
                  ),
                  height: height(53),
                  child:  Row(
                    children: <Widget>[
                      Flexible(
                        flex: 1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text("隐私协议",style: TextStyle(fontSize:sp(14),color: Color(0xFF666666)),),

                          ],
                        ),
                      ),
                      Image.asset(SPClassImageUtil.spFunGetImagePath("ic_btn_right"),
                        width: width(11),
                      ),
                      SizedBox(width: width(10),)
                    ],
                  ),
                ),
                onTap: ()  {
                  // SPClassNavigatorUtils.spFunPushRoute(context,  SPClassWebPage("","隐私协议", spProLocalFile: "assets/html/privacy_score.html"));
                  SPClassNavigatorUtils.spFunPushRoute(context,  AgreementPage(title:"隐私协议",url:"../../assets/html/privacy_score.html"));

                },
              ),
//              标记 APP专用
              // Flexible(
              //   flex: 1,
              //   fit: FlexFit.tight,
              //   child: GestureDetector(
              //     child: Container(
              //       padding: EdgeInsets.only(bottom: 10),
              //       width: MediaQuery.of(context).size.width,
              //       alignment: Alignment.bottomCenter,
              //       child:Text("version "+
              //           spProPackageInfo.version+
              //           " build "+
              //           spProPackageInfo.buildNumber +
              //           (SPClassApplicaion.spProDEBUG?
              //            "调试模式":""),style: TextStyle(fontSize: 13,color: Color(0xFFBDBDBD)),),
              //     ),
              //     onLongPressStart:(value){
              //
              //     },
              //     onLongPressEnd: (value){
              //
              //     },
              //   ),
              // )

            ],

        ),
      ),
    );
  }

}