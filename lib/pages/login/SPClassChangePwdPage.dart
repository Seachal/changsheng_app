
import 'dart:async';

import 'package:changshengh5/api/SPClassApiManager.dart';
import 'package:changshengh5/api/SPClassHttpCallBack.dart';
import 'package:changshengh5/app/SPClassApplicaion.dart';
import 'package:changshengh5/untils/SPClassCommonMethods.dart';
import 'package:changshengh5/untils/SPClassImageUtil.dart';
import 'package:changshengh5/untils/SPClassNavigatorUtils.dart';
import 'package:changshengh5/untils/SPClassToastUtils.dart';
import 'package:changshengh5/untils/colors.dart';
import 'package:changshengh5/widgets/SPClassToolBar.dart';
import 'package:flutter/material.dart';


class SPClassChangePwdPage extends StatefulWidget
{
  SPClassChangePwdPageState createState()=> SPClassChangePwdPageState();
}

class SPClassChangePwdPageState extends State<SPClassChangePwdPage>
{
  String spProPwdOrg = '';
  String spProPwd = '';
  String spProPwd2 = '';
  bool spProIsShowPassWord = false;
  int spProCurrentSecond = 0;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  Scaffold(
        resizeToAvoidBottomInset: false,
        appBar:SPClassToolBar(
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
                  spFunBuildRegisterTextForm(),
                  SizedBox(height: width(23)),
                  spFunBuildRegisterButton(),
                ],
              ),
            ),
          ),
        ));
  }

  // 创建登录界面的Item
  Widget spFunBuildRegisterTextForm() {
    return Container(
        width: MediaQuery.of(context).size.width ,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

           SPClassApplicaion.spProUserLoginInfo?.spProHasPwd=="1"? Container(
             color: Colors.white,
             padding: EdgeInsets.only(left: width(18)),
             child: Row(
               crossAxisAlignment: CrossAxisAlignment.center,
               children: <Widget>[
                 Image.asset(
                   SPClassImageUtil.spFunGetImagePath('password_1'),
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
                         spProPwdOrg = value;
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
                    SPClassImageUtil.spFunGetImagePath('password_1'),
                    fit: BoxFit.contain,
                    width: width(24),
                  ),
                  SizedBox(width: width(4)),
                  Expanded(
                    child: TextField(
                      obscureText: !spProIsShowPassWord,
                      style: TextStyle(fontSize: 16, color: Color(0xFF333333),textBaseline: TextBaseline.alphabetic),
                      decoration: InputDecoration(
                        hintText: "请输入新密码",
                        hintStyle: TextStyle(fontSize: 16, color: Color(0xFF999999),textBaseline: TextBaseline.alphabetic),

                      ),
                      onChanged: (value) {
                        setState(() {
                          spProPwd = value;
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
                   SPClassImageUtil.spFunGetImagePath('password_1'),
                   fit: BoxFit.contain,
                   width: width(24),
                   height: width(24),
                 ),
                 SizedBox(width: width(4)),
                 Expanded(
                   child: TextField(
                     obscureText: !spProIsShowPassWord,
                     style: TextStyle(fontSize: 16, color: Color(0xFF333333),textBaseline: TextBaseline.alphabetic),
                     decoration: InputDecoration(
                       hintText: "请确认密码",
                       border: InputBorder.none,
                       hintStyle: TextStyle(fontSize: 16, color: Color(0xFF999999),textBaseline: TextBaseline.alphabetic),

                     ),
                     onChanged: (value) {
                       setState(() {
                         spProPwd2 = value;
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
  Widget spFunBuildRegisterButton() {

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
        if(SPClassApplicaion.spProUserLoginInfo?.spProHasPwd=="1"){
          if(spFunCheckTextOrg()){return;}
        }
        if(spFunCheckTextPwd()){return;}
        if(spFunCheckPwdRepeat()){return;}
        spFunDoRegister();
      },
    );

  }

// 点击控制密码是否显示
  void spFunShowPassWord() {
    setState(() {
      spProIsShowPassWord = !spProIsShowPassWord;
    });
  }


  bool spFunCheckTextOrg() {
    if (spProPwdOrg.isEmpty) {SPClassToastUtils.spFunShowToast(msg: "原密码不能为空");return true;}
    return false;
  }

  bool spFunCheckTextPwd() {
    if (spProPwd.isEmpty||spProPwd2.isEmpty) {SPClassToastUtils.spFunShowToast(msg: "新密码不能为空");return true;}
    return false;
  }


  bool spFunCheckPwdRepeat() {
    if (spProPwd!=spProPwd2) {SPClassToastUtils.spFunShowToast(msg: "两次密码不一致");return true;}
    return false;
  }

  Future spFunDoRegister() async {


    SPClassApiManager.spFunGetInstance().spFunUserChangePwd(context:context ,queryParameters:{"old_pwd":spProPwdOrg,"change_method":"old_pwd"},spProBodyParameters:{"pwd":spProPwd},
    spProCallBack: SPClassHttpCallBack(
      spProOnSuccess: (result){
        SPClassToastUtils.spFunShowToast(msg: "修改成功,请重新登录");
        SPClassApplicaion.spFunClearUserState();
        SPClassApplicaion.spProEventBus.fire("login:out");
        SPClassNavigatorUtils.spFunPopAll(context);
      },onError: (e){},spProOnProgress: (v){}
    )
    );

  }
}