
import 'dart:async';

import 'package:changshengh5/api/CSClassApiManager.dart';
import 'package:changshengh5/api/CSClassHttpCallBack.dart';
import 'package:changshengh5/app/CSClassApplicaion.dart';
import 'package:changshengh5/utils/CSClassCommonMethods.dart';
import 'package:changshengh5/utils/CSClassImageUtil.dart';
import 'package:changshengh5/utils/CSClassNavigatorUtils.dart';
import 'package:changshengh5/utils/CSClassToastUtils.dart';
import 'package:changshengh5/utils/colors.dart';
import 'package:changshengh5/widgets/CSClassToolBar.dart';
import 'package:flutter/material.dart';


class CSClassChangePwdPage extends StatefulWidget
{
  CSClassChangePwdPageState createState()=> CSClassChangePwdPageState();
}

class CSClassChangePwdPageState extends State<CSClassChangePwdPage>
{
  String csProPwdOrg = '';
  String csProPwd = '';
  String csProPwd2 = '';
  bool csProIsShowPassWord = false;
  int csProCurrentSecond = 0;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  Scaffold(
        resizeToAvoidBottomInset: false,
        appBar:CSClassToolBar(
          context,
          title: "修改密码",
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Color(0xFFF1F1F1),
          child: SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: <Widget>[
                  SizedBox(height: width(12)),
                  csMethodBuildRegisterTextForm(),
                  SizedBox(height: width(23)),
                  csMethodBuildRegisterButton(),
                ],
              ),
            ),
          ),
        ));
  }

  // 创建登录界面的Item
  Widget csMethodBuildRegisterTextForm() {
    return Container(
        width: MediaQuery.of(context).size.width ,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

           CSClassApplicaion.csProUserLoginInfo?.csProHasPwd=="1"? Container(
             color: Colors.white,
             padding: EdgeInsets.only(left: width(18)),
             child: Row(
               crossAxisAlignment: CrossAxisAlignment.center,
               children: <Widget>[
                 Image.asset(
                   CSClassImageUtil.csMethodGetImagePath('password_1'),
                   fit: BoxFit.contain,
                   width: width(24),
                 ),
                 SizedBox(width: width(4)),
                 Expanded(
                   child: TextField(
                     obscureText: false,
                     style: TextStyle(fontSize: 16, color: Color(0xFF333333),textBaseline: TextBaseline.alphabetic),
                     decoration: InputDecoration(
                       hintText: "请输入原密码",
                       hintStyle: TextStyle(fontSize: 16, color: Color(0xFF999999),textBaseline: TextBaseline.alphabetic),

                     ),
                     onChanged: (value) {
                       setState(() {
                         csProPwdOrg = value;
                       });
                     },
                   ),
                 ),
               ],
             ),
           ):SizedBox(),
            Container(
              color:Colors.white,
              padding: EdgeInsets.only(left: width(18)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    CSClassImageUtil.csMethodGetImagePath('password_1'),
                    fit: BoxFit.contain,
                    width: width(24),
                  ),
                  SizedBox(width: width(4)),
                  Expanded(
                    child: TextField(
                      obscureText: !csProIsShowPassWord,
                      style: TextStyle(fontSize: 16, color: Color(0xFF333333),textBaseline: TextBaseline.alphabetic),
                      decoration: InputDecoration(
                        hintText: "请输入新密码",
                        hintStyle: TextStyle(fontSize: 16, color: Color(0xFF999999),textBaseline: TextBaseline.alphabetic),

                      ),
                      onChanged: (value) {
                        setState(() {
                          csProPwd = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
           Container(
             color: Colors.white,
             padding: EdgeInsets.only(left: width(18)),
             child:  Row(
               crossAxisAlignment: CrossAxisAlignment.center,
               children: <Widget>[
                 Image.asset(
                   CSClassImageUtil.csMethodGetImagePath('password_1'),
                   fit: BoxFit.contain,
                   width: width(24),
                   height: width(24),
                 ),
                 SizedBox(width: width(4)),
                 Expanded(
                   child: TextField(
                     obscureText: !csProIsShowPassWord,
                     style: TextStyle(fontSize: 16, color: Color(0xFF333333),textBaseline: TextBaseline.alphabetic),
                     decoration: InputDecoration(
                       hintText: "请确认密码",
                       border: InputBorder.none,
                       hintStyle: TextStyle(fontSize: 16, color: Color(0xFF999999),textBaseline: TextBaseline.alphabetic),

                     ),
                     onChanged: (value) {
                       setState(() {
                         csProPwd2 = value;
                       });
                     },
                   ),
                 ),
               ],
             ),
           ),
          ],
        ));
  }

  // 创建登录界面的button
  Widget csMethodBuildRegisterButton() {

   return  GestureDetector(
      child:  Container(
        margin: EdgeInsets.only(top: height(10)),
        height: height(53),
        alignment: Alignment.center,
        child:Container(
          alignment: Alignment.center,
          height: width(46),
          width: width(276),
          decoration: BoxDecoration(
            color: MyColors.main1,
            borderRadius: BorderRadius.circular(150),
          ),
          child:Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[

              Text("确定",style: TextStyle(fontSize: sp(15),color: Colors.white),)
            ],
          ),
        ) ,
      ),
      onTap: () async {
        if(CSClassApplicaion.csProUserLoginInfo?.csProHasPwd=="1"){
          if(csMethodCheckTextOrg()){return;}
        }
        if(csMethodCheckTextPwd()){return;}
        if(csMethodCheckPwdRepeat()){return;}
        csMethodDoRegister();
      },
    );

  }

// 点击控制密码是否显示
  void csMethodShowPassWord() {
    setState(() {
      csProIsShowPassWord = !csProIsShowPassWord;
    });
  }


  bool csMethodCheckTextOrg() {
    if (csProPwdOrg.isEmpty) {CSClassToastUtils.csMethodShowToast(msg: "原密码不能为空");return true;}
    return false;
  }

  bool csMethodCheckTextPwd() {
    if (csProPwd.isEmpty||csProPwd2.isEmpty) {CSClassToastUtils.csMethodShowToast(msg: "新密码不能为空");return true;}
    return false;
  }


  bool csMethodCheckPwdRepeat() {
    if (csProPwd!=csProPwd2) {CSClassToastUtils.csMethodShowToast(msg: "两次密码不一致");return true;}
    return false;
  }

  Future csMethodDoRegister() async {


    CSClassApiManager.csMethodGetInstance().csMethodUserChangePwd(context:context ,queryParameters:{"old_pwd":csProPwdOrg,"change_method":"old_pwd"},csProBodyParameters:{"pwd":csProPwd},
    csProCallBack: CSClassHttpCallBack(
      csProOnSuccess: (result){
        CSClassToastUtils.csMethodShowToast(msg: "修改成功,请重新登录");
        CSClassApplicaion.csMethodClearUserState();
        CSClassApplicaion.csProEventBus.fire("login:out");
        CSClassNavigatorUtils.csMethodPopAll(context);
      },onError: (e){},csProOnProgress: (v){}
    )
    );

  }
}