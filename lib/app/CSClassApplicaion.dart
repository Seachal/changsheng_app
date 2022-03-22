
import 'dart:convert';

import 'package:changshengh5/api/CSClassApiManager.dart';
import 'package:changshengh5/api/CSClassHttpCallBack.dart';
import 'package:changshengh5/api/CSClassNetConfig.dart';
import 'package:changshengh5/model/CSClassConfRewardEntity.dart';
import 'package:changshengh5/model/CSClassLogInfoEntity.dart';
import 'package:changshengh5/model/CSClassShowPListEntity.dart';
import 'package:changshengh5/model/CSClassUserInfo.dart';
import 'package:changshengh5/model/CSClassUserLoginInfo.dart';
import 'package:changshengh5/pages/dialogs/CSClassNewRegisterDialog.dart';
import 'package:changshengh5/pages/login/CSClassVideoLoginPage.dart';
import 'package:changshengh5/utils/CSClassDateUtils.dart';
import 'package:changshengh5/utils/CSClassNavigatorUtils.dart';
import 'package:changshengh5/utils/CSClassSharedPreferencesKeys.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:event_bus/event_bus.dart';
import 'package:package_info/package_info.dart';
import 'package:jpush_flutter/jpush_flutter.dart';

class CSClassApplicaion
{
  static var csProAppName="常胜体育";
  static String csProChannelId="11";
  static  String csProAndroidAppId="100";
  static const String csProIOSAppId="108";
  static String csProImei="";
  static String csProDeviceName="";
  static String csProSydid="";
  static String csProMacAddress="";
  static String csProWifiName="";
  static String pushToken="";
  static PackageInfo ?csProPackageInfo;
  static bool csProDEBUG = false;
  static CSClassUserInfo ?csProUserInfo;
  static Map<String,dynamic> ?csProJsMap;
  static CSClassUserLoginInfo ?csProUserLoginInfo;
  static CSClassLogInfoEntity ?csProLogOpenInfo;
  static List<String> csProShowMenuList =["shop","home",/*"pk",*/"match","expert","info","pay","match_scheme","match_analyse","match_odds","bcw_data",/*"game"*/];
  static bool csProEncrypt = false;//是否启用加密
  static bool csProLOG_OPEN = false;
  static JPush ?csProJPush;
  static EventBus csProEventBus = EventBus();
  static CSClassShowPListEntity ?csProShowPListEntity;//;
  static CSClassConfRewardEntity ?csProConfReward;



  //判断用户信息是否存在
  static bool csMethodIsExistUserInfo()
  {
    return (csProUserInfo!=null);
  }

  //初始化状态
  static Future<void> csMethodInitUserState() async {
    return   await  SharedPreferences.getInstance().then((sp){
      var loginInfoJson=sp.getString(CSClassSharedPreferencesKeys.KEY_LOGIN_INFO);
      if(loginInfoJson!=null){
        csProUserLoginInfo=new CSClassUserLoginInfo(json: json.decode(loginInfoJson));
      }
      var userInfoJson=sp.getString(CSClassSharedPreferencesKeys.KEY_USER_INFO);
      if(userInfoJson!=null){
        csProUserInfo=CSClassUserInfo(json: json.decode(userInfoJson));
      }
      return null;
    });

  }

  //保存并更新用户信息
  static void csMethodSaveUserState({bool isFire:true}){
    SharedPreferences.getInstance().then((sp){
      if(csProUserLoginInfo!=null){
        sp.setString(CSClassSharedPreferencesKeys.KEY_LOGIN_INFO, jsonEncode(csProUserLoginInfo?.toJson()));
        csProEventBus.fire("loginInfo");
      }
      if(csProUserInfo!=null){
        sp.setString(CSClassSharedPreferencesKeys.KEY_USER_INFO, jsonEncode(csProUserInfo?.toJson()));
        if(isFire){csProEventBus.fire("userInfo");}
      }
    });
  }

  //清空登录状态
  static void csMethodClearUserState(){
    CSClassApplicaion.csProUserLoginInfo=null;
    CSClassApplicaion.csProUserInfo=null;
    SharedPreferences.getInstance().then((sp){
      sp.remove(CSClassSharedPreferencesKeys.KEY_USER_INFO);
      sp.remove(CSClassSharedPreferencesKeys.KEY_LOGIN_INFO);
    });
    if(CSClassApplicaion.csProJPush!=null){
      CSClassApplicaion.csProJPush?.deleteAlias();
    }
  }

  static Future<void> csMethodSavePushToken() async {
    var pakegeInfo= await PackageInfo.fromPlatform();
    if(pushToken.isNotEmpty&&CSClassNetConfig.androidInfo!.manufacturer.toLowerCase().contains("huawei")){
      CSClassApiManager.csMethodGetInstance().csMethodSavePushToken(packName: pakegeInfo.packageName,pushToken:pushToken,tokenType: "huawei");
    }
    if(CSClassApplicaion.csProJPush!=null){
      if(CSClassApplicaion.csProSydid.isNotEmpty){
        print('极光Alias：${CSClassApplicaion.csProSydid}');
        CSClassApplicaion.csProJPush?.setAlias(CSClassApplicaion.csProSydid);
      }
      var registrationId= await CSClassApplicaion.csProJPush?.getRegistrationID();
      if(registrationId!=null&&registrationId.isNotEmpty){
        CSClassApiManager.csMethodGetInstance().csMethodSavePushToken(packName: pakegeInfo.packageName,pushToken:registrationId,tokenType: "jiguang",);
      }
    }
  }


  //获取最新用户信息
  static void csMethodGetUserInfo({BuildContext? context,bool isFire:true}) {
    if(!csMethodIsLogin()){return;}
    CSClassApiManager.csMethodGetInstance().csMethodUserInfo(context: context,csProCallBack: CSClassHttpCallBack(
        csProOnSuccess: (value){
          csProUserInfo=value;
          csMethodSaveUserState(isFire: isFire);
        },onError: (e){},csProOnProgress: (v){}
    ));
  }

  static Future<void> csMethodShowUserDialog(BuildContext context ) async {
    if(!CSClassApplicaion.csProShowMenuList.contains("pay")){
      return;
    }
    var dialogShowTime;
    if(csMethodIsLogin()){
      dialogShowTime = await  SharedPreferences.getInstance().then((sp){
        return sp.getString("dialog_turn${CSClassApplicaion.csProUserLoginInfo?.csProUserId.toString()}");
      }); //
    }

    if( !csMethodIsLogin()||(dialogShowTime==null||dialogShowTime!=CSClassDateUtils.dateFormatByDate(DateTime.now(), "yyyy-MM-dd")))
    {
      if(csMethodIsLogin()){
        SharedPreferences.getInstance().then((sp){
          sp.setString("dialog_turn${CSClassApplicaion.csProUserLoginInfo?.csProUserId.toString()}", CSClassDateUtils.dateFormatByDate(DateTime.now(), "yyyy-MM-dd"));
        });
      }
//      转盘
//      showCupertinoModalPopup(context: context, builder: (c)=> CSClassDialogTurntable((){
//        csMethodShowNewUser(context);
//
//      }));
    }else{
      csMethodShowNewUser(context);
    }


  }

  static bool csMethodIsShowIosUI(){
    return false;
  }

}


bool csMethodIsLogin({BuildContext ?context}) {
  if (CSClassApplicaion.csProUserLoginInfo != null) {
    return true;
  } else {
    if (context != null) {
      CSClassNavigatorUtils.csMethodPushRoute(context, CSClassVideoLoginPage());
    }
    return false;
  }
}

Future<void> csMethodShowNewUser(BuildContext context) async {
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
          return CSClassNewRegisterDialog(callback: (){
          },);
        });
    return;
  }
}


CSClassUserLoginInfo? get userLoginInfo=>CSClassApplicaion.csProUserLoginInfo;
