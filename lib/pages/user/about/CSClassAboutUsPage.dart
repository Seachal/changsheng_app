

import 'dart:async';

import 'package:changshengh5/app/CSClassApplicaion.dart';
import 'package:changshengh5/pages/dialogs/agreement_page.dart';
import 'package:changshengh5/utils/CSClassCommonMethods.dart';
import 'package:changshengh5/utils/CSClassImageUtil.dart';
import 'package:changshengh5/utils/CSClassNavigatorUtils.dart';
import 'package:changshengh5/widgets/CSClassToolBar.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';

import 'CSClassTestPage.dart';



class CSClassAboutUsPage extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CSClassAboutUsPageState();
  }

}

class CSClassAboutUsPageState extends State<CSClassAboutUsPage>{

  int csProDebugIndex=0;
  DateTime ?csProPressTime;
  PackageInfo ?csProPackageInfo;
  Timer ?timer;
  @override
   initState()  {
    // TODO: implement initState
    super.initState();
       PackageInfo.fromPlatform().then((result){
         csProPackageInfo=result;
         if(mounted){
           setState(() {
           });
         }
     });

  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: CSClassToolBar(
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
                  child: Image.asset(CSClassImageUtil.csMethodGetImagePath("ic_app_logo"),
                    width: width(93),
                  ),
                ),
                onTap: (){
                  if(csProPressTime==null){
                    csProPressTime=DateTime.now();
                    csProDebugIndex=1;
                    return;
                  }
                  csProDebugIndex++;
                  if(timer!=null){
                    timer?.cancel();
                  }
                  timer= Timer(Duration(seconds: 2), (){
                    csProPressTime=null;
                  });
                  if(csProDebugIndex==5){
                    csProDebugIndex=0;
                    csProPressTime=null;
                    CSClassNavigatorUtils.csMethodPushRoute(context,CSClassTestPage());
                  }
                },
              ),
              SizedBox(height: 10,),
              Text("${CSClassApplicaion.csProAppName}",style: TextStyle(fontSize: 18,color: Color(0xFF333333),fontWeight: FontWeight.bold),),
              Text("Copyright © 2018-2019 "+
                  CSClassApplicaion.csProAppName,style: TextStyle(fontSize: 13,color: Color(0xFFBDBDBD)),),
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
                      Image.asset(CSClassImageUtil.csMethodGetImagePath("ic_btn_right"),
                        width: width(11),
                      ),
                      SizedBox(width: width(10),)
                    ],
                  ),
                ),
                onTap: ()  {
                  // CSClassNavigatorUtils.csMethodPushRoute(context,  CSClassWebPage("","隐私协议", csProLocalFile: "assets/html/privacy_score.html"));
                  CSClassNavigatorUtils.csMethodPushRoute(context,  AgreementPage(title:"隐私协议",));

                },
              ),
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: GestureDetector(
                  child: Container(
                    padding: EdgeInsets.only(bottom: 10),
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.bottomCenter,
                    child:Text("version "+
                        csProPackageInfo!.version+
                        " build "+
                        csProPackageInfo!.buildNumber +
                        (CSClassApplicaion.csProDEBUG?
                         "调试模式":""),style: TextStyle(fontSize: 13,color: Color(0xFFBDBDBD)),),
                  ),
                  onLongPressStart:(value){

                  },
                  onLongPressEnd: (value){

                  },
                ),
              )

            ],

        ),
      ),
    );
  }

}