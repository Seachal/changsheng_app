import 'dart:io';

import 'package:changshengh5/app/CSClassApplicaion.dart';
import 'package:changshengh5/pages/news/CSClassWebPageState.dart';
import 'package:changshengh5/utils/CSClassCommonMethods.dart';
import 'package:changshengh5/utils/CSClassNavigatorUtils.dart';
import 'package:changshengh5/utils/common.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'agreement_page.dart';
class CSClassPrivacyDialogDialog extends StatefulWidget{
  VoidCallback callback;

  CSClassPrivacyDialogDialog(this.callback);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return PrivacyDialogState();
  }

}

class PrivacyDialogState extends State<CSClassPrivacyDialogDialog>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(
      child:Container(
        color: Colors.transparent,
        child: Dialog(
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: width(23)),
                width: width(288),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(width(8))
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("用户使用及隐私保护政策提示",style: TextStyle(fontSize: sp(16),color: Color(0xFF333333),fontWeight: FontWeight.bold),),
                    SizedBox(height: 5,),
                    Container(
                      width: width(219),
                      child: RichText(
                        text: TextSpan(
                            style: TextStyle(fontSize: sp(12.5),color: Color(0xFF333333)),
                            text: "欢迎使用"+
                                CSClassApplicaion.csProAppName+
                                "！"+
                                CSClassApplicaion.csProAppName+
                                "非常重视您的隐私和个人信息保护。在您使用"+
                                CSClassApplicaion.csProAppName+
                                "前，请认真阅读",
                            children: <TextSpan>[
                              TextSpan(
                                  style: TextStyle(color: Color(0xFF4CA3F5)),
                                  text: "《用户协议》",recognizer: new TapGestureRecognizer()..onTap=(){
                                // CSClassNavigatorUtils.csMethodPushRoute(context,  CSClassWebPage("","用户协议", csProLocalFile: "assets/html/useragreement.html"));
                                CSClassNavigatorUtils.csMethodPushRoute(context,  AgreementPage(title:"用户协议",));

                              }),
                              TextSpan(text: "及",),
                              TextSpan(
                                  style: TextStyle(color: Color(0xFF4CA3F5)),
                                  text: "《隐私政策》",recognizer: new TapGestureRecognizer()..onTap=(){
                                // CSClassNavigatorUtils.csMethodPushRoute(context,  CSClassWebPage("","隐私协议", csProLocalFile: "assets/html/privacy_score.html"));
                                CSClassNavigatorUtils.csMethodPushRoute(context,  AgreementPage(title:"隐私协议",));

                              }),
                              TextSpan(text: "，您同意并接受全部条款后方可开始使用"+
                                  CSClassApplicaion.csProAppName+
                                  "。\n        为提供上述服务，我们可能会获取及使用您的设备信息和浏览记录。")
                            ]
                        ),
                      ),
                    ),
                    SizedBox(height: height(10),),
                    // Container(
                    //   height: 0.4,
                    //   color:Colors.grey[300] ,
                    // ),
                    Container(
                      margin: EdgeInsets.only(top: height(10)),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.vertical(bottom: Radius.circular(width(5)))
                      ),
                      child: Column(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: width(30)),
                            decoration: BoxDecoration(
                                // color:Color(0xFF49BAF2),
                                gradient: LinearGradient(
                                  begin:Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: [Color(0xFF49BAF2),Color(0xFF499DF2)]
                                ),
                                borderRadius: BorderRadius.circular(150)
                            ),
                            child: FlatButton(
                              padding: EdgeInsets.zero,
                              child: Container(
                                alignment: Alignment.center,
                                height:width(20),
                                child: Text("同意",style: TextStyle(fontSize: sp(17),color: Colors.white),),
                              ),
                              onPressed: () async {
                                SharedPreferences.getInstance().then((sp)=>sp.setBool(Commons.IS_AGREE_PRIVICY, true));
                                widget.callback();
                              },
                            ),
                          ),
                          FlatButton(
                            padding: EdgeInsets.zero,
                            child: Container(
                              alignment: Alignment.center,
                              height:height(20),
                              child: Text("不同意并退出APP",style: TextStyle(fontSize: sp(17),color: Color(0xFF999999)),),
                            ),
                            onPressed: (){
                              exit(0);
                            },
                          ),
                          SizedBox(
                            height: height(10),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      onWillPop:() async{
        return false;
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

}