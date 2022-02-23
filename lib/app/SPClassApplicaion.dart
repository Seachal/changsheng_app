
import 'dart:convert';

import 'package:changshengh5/api/SPClassApiManager.dart';
import 'package:changshengh5/api/SPClassHttpCallBack.dart';
import 'package:changshengh5/api/SPClassNetConfig.dart';
import 'package:changshengh5/model/SPClassConfRewardEntity.dart';
import 'package:changshengh5/model/SPClassLogInfoEntity.dart';
import 'package:changshengh5/model/SPClassShowPListEntity.dart';
import 'package:changshengh5/model/SPClassUserInfo.dart';
import 'package:changshengh5/model/SPClassUserLoginInfo.dart';
import 'package:changshengh5/pages/dialogs/SPClassNewRegisterDialog.dart';
import 'package:changshengh5/pages/login/SPClassVideoLoginPage.dart';
import 'package:changshengh5/untils/SPClassDateUtils.dart';
import 'package:changshengh5/untils/SPClassNavigatorUtils.dart';
import 'package:changshengh5/untils/SPClassSharedPreferencesKeys.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:event_bus/event_bus.dart';
import 'package:package_info/package_info.dart';
import 'package:jpush_flutter/jpush_flutter.dart';

class SPClassApplicaion
{
  static var spProAppName="常胜体育";
  static String spProChannelId="11";
  static  String spProAndroidAppId="100";
  static const String spProIOSAppId="106";
  static String spProImei="";
  static String spProDeviceName="";
  static String spProSydid="";
  static String spProMacAddress="";
  static String spProWifiName="";
  static String pushToken="";
  static PackageInfo ?spProPackageInfo;
  static bool spProDEBUG = false;
  static SPClassUserInfo ?spProUserInfo;
  static Map<String,dynamic> ?spProJsMap;
  static SPClassUserLoginInfo ?spProUserLoginInfo;
  static SPClassLogInfoEntity ?spProLogOpenInfo;
  static List<String> spProShowMenuList =["home","pk","match","expert","info","pay","match_scheme","match_analyse","match_odds","bcw_data","game"];
  static bool spProEncrypt = false;//是否启用加密
  static JPush ?spProJPush;
  static EventBus spProEventBus = EventBus();
  static SPClassShowPListEntity ?spProShowPListEntity;//;
  static SPClassConfRewardEntity ?spProConfReward;



  //判断用户信息是否存在
  static bool spFunIsExistUserInfo()
  {
    return (spProUserInfo!=null);
  }

  //初始化状态
  static Future<void> spFunInitUserState() async {
    return   await  SharedPreferences.getInstance().then((sp){
      var loginInfoJson=sp.getString(SPClassSharedPreferencesKeys.KEY_LOGIN_INFO);
      if(loginInfoJson!=null){
        spProUserLoginInfo=new SPClassUserLoginInfo(json: json.decode(loginInfoJson));
      }
      var userInfoJson=sp.getString(SPClassSharedPreferencesKeys.KEY_USER_INFO);
      if(userInfoJson!=null){
        spProUserInfo=SPClassUserInfo(json: json.decode(userInfoJson));
      }
      return null;
    });

  }

  //保存并更新用户信息
  static void spFunSaveUserState({bool isFire:true}){
    SharedPreferences.getInstance().then((sp){
      if(spProUserLoginInfo!=null){
        sp.setString(SPClassSharedPreferencesKeys.KEY_LOGIN_INFO, jsonEncode(spProUserLoginInfo?.toJson()));
        spProEventBus.fire("loginInfo");
      }
      if(spProUserInfo!=null){
        sp.setString(SPClassSharedPreferencesKeys.KEY_USER_INFO, jsonEncode(spProUserInfo?.toJson()));
        if(isFire){spProEventBus.fire("userInfo");}
      }
    });
  }

  //清空登录状态
  static void spFunClearUserState(){
    SPClassApplicaion.spProUserLoginInfo=null;
    SPClassApplicaion.spProUserInfo=null;
    SharedPreferences.getInstance().then((sp){
      sp.remove(SPClassSharedPreferencesKeys.KEY_USER_INFO);
      sp.remove(SPClassSharedPreferencesKeys.KEY_LOGIN_INFO);
    });
    // if(SPClassApplicaion.spProJPush!=null){
    //    Application.mJpush.deleteAlias();
    // }
  }

  static Future<void> spFunSavePushToken() async {
    var pakegeInfo= await PackageInfo.fromPlatform();
    if(pushToken.isNotEmpty&&SPClassNetConfig.androidInfo!.manufacturer.toLowerCase().contains("huawei")){
      SPClassApiManager.spFunGetInstance().spFunSavePushToken(packName: pakegeInfo.packageName,pushToken:pushToken,tokenType: "huawei");
    }
    if(SPClassApplicaion.spProJPush!=null){
      if(SPClassApplicaion.spProSydid.isNotEmpty){
        print('极光Alias：${SPClassApplicaion.spProSydid}');
        SPClassApplicaion.spProJPush?.setAlias(SPClassApplicaion.spProSydid);
      }
      var registrationId= await SPClassApplicaion.spProJPush?.getRegistrationID();
      if(registrationId!=null&&registrationId.isNotEmpty){
        SPClassApiManager.spFunGetInstance().spFunSavePushToken(packName: pakegeInfo.packageName,pushToken:registrationId,tokenType: "jiguang",);
      }
    }
  }


  //获取最新用户信息
  static void spFunGetUserInfo({BuildContext? context,bool isFire:true}) {
    if(!spFunIsLogin()){return;}
    SPClassApiManager.spFunGetInstance().spFunUserInfo(context: context,spProCallBack: SPClassHttpCallBack(
        spProOnSuccess: (value){
          spProUserInfo=value;
          spFunSaveUserState(isFire: isFire);
        },onError: (e){},spProOnProgress: (v){}
    ));
  }

  static Future<void> spFunShowUserDialog(BuildContext context ) async {
    if(!SPClassApplicaion.spProShowMenuList.contains("pay")){
      return;
    }
    var dialogShowTime;
    if(spFunIsLogin()){
      dialogShowTime = await  SharedPreferences.getInstance().then((sp){
        return sp.getString("dialog_turn${SPClassApplicaion.spProUserLoginInfo?.spProUserId.toString()}");
      }); //
    }

    if( !spFunIsLogin()||(dialogShowTime==null||dialogShowTime!=SPClassDateUtils.dateFormatByDate(DateTime.now(), "yyyy-MM-dd")))
    {
      if(spFunIsLogin()){
        SharedPreferences.getInstance().then((sp){
          sp.setString("dialog_turn${SPClassApplicaion.spProUserLoginInfo?.spProUserId.toString()}", SPClassDateUtils.dateFormatByDate(DateTime.now(), "yyyy-MM-dd"));
        });
      }
//      转盘
//      showCupertinoModalPopup(context: context, builder: (c)=> SPClassDialogTurntable((){
//        spFunShowNewUser(context);
//
//      }));
    }else{
      spFunShowNewUser(context);
    }


  }

  static bool spFunIsShowIosUI(){
    return false;
  }

}


bool spFunIsLogin({BuildContext ?context}) {
  if (SPClassApplicaion.spProUserLoginInfo != null) {
    return true;
  } else {
    if (context != null) {
      SPClassNavigatorUtils.spFunPushRoute(context, SPClassVideoLoginPage());
    }
    return false;
  }
}

Future<void> spFunShowNewUser(BuildContext context) async {
  var dialogShowTime;
  dialogShowTime = await  SharedPreferences.getInstance().then((sp){
    return sp.getString("dialog_register");
  }); //
  if(dialogShowTime==null)
  {

    SharedPreferences.getInstance().then((sp){
      sp.setString("dialog_register","show");
    });
    showDialog<void>(context: context,
        builder: (BuildContext context) {
          return SPClassNewRegisterDialog(callback: (){
          },);
        });
    return;
  }
}


SPClassUserLoginInfo? get userLoginInfo=>SPClassApplicaion.spProUserLoginInfo;
