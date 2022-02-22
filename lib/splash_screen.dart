
import 'dart:convert';
import 'dart:io';
import 'package:changshengh5/pages/SPClassSplashPage.dart';
import 'package:changshengh5/pages/competition/SPClassMatchListSettingPage.dart';
import 'package:changshengh5/pages/dialogs/SPClassPrivacyDialogDialog.dart';
import 'package:changshengh5/untils/LocalStorage.dart';
import 'package:changshengh5/untils/SPClassCommonMethods.dart';
import 'package:changshengh5/untils/SPClassLogUtils.dart';
import 'package:changshengh5/untils/SPClassNavigatorUtils.dart';
import 'package:changshengh5/untils/SPClassSharedPreferencesKeys.dart';
import 'package:changshengh5/untils/SPClassUtil.dart';
import 'package:changshengh5/untils/common.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity/connectivity.dart';

import 'app/SPClassApplicaion.dart';
import 'main/SPClassAppPage.dart';
import 'model/SPClassLogInfoEntity.dart';
import 'package:fluwx/fluwx.dart' as fluwx;


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final Connectivity _connectivity = Connectivity();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Colors.white,
      child: SPClassSplashPage((){}),
    );
  }

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(LocalStorage.get(Commons.IS_AGREE_PRIVICY)!=null){
      init();
      Future.delayed(Duration(seconds: 3)).then((value) async{

        SPClassNavigatorUtils.pushAndRemoveAll(context, SPClassAppPage());
        SPClassUtil.spFunRequestPermission();

      });
    }else{
      Future.delayed(Duration(seconds: 3)).then((value) {
        showDialog(context: context,builder: (context){
          return SPClassPrivacyDialogDialog( ()async{
            await init();
            Future.delayed(Duration(milliseconds: 100)).then((value) {
              SPClassNavigatorUtils.pushAndRemoveAll(context, SPClassAppPage());
              SPClassUtil.spFunRequestPermission();
            });
          });
        });
      });
    }
    spFunInitUserData();

}

  Future<void> init() async{
    try{
      if(Platform.isAndroid){
        //标记
        // FlutterToolplugin.channelId.then((channel){
        //   SPClassApplicaion.spProChannelId=channel;
        //   if(SPClassApplicaion.spProChannelId=="2"){
        //     SPClassApplicaion.spProAndroidAppId="105";
        //   }
        // });
      }else{
        SPClassApplicaion.spProShowMenuList=
        ["home","match","expert","info","match_scheme","match_analyse","game"];
      }
    }catch(e){
      SPClassLogUtils.spFunPrintLog(e.toString());
    }finally{
      spFunInitOneLogin();
      spFunInitConnectivity();
      spFunInitPush();
      spFunInitWx();
      // spFunInitUserData();
    }
  }



  Future<void> spFunInitUserData() async {
    await  SharedPreferences.getInstance().then((sp) {
      SPClassApplicaion.spProDEBUG=sp.getBool("test")??SPClassApplicaion.spProDEBUG;
      SPClassMatchListSettingPageState.SHOW_PANKOU=sp.getBool(SPClassSharedPreferencesKeys.KEY_MATCH_PAN_KOU)??SPClassMatchListSettingPageState.SHOW_PANKOU;
      var logInfoJson=sp.getString(SPClassSharedPreferencesKeys.KEY_LOG_JSON);
      if(logInfoJson!=null){
        var jsonData=json.decode(logInfoJson);
        SPClassApplicaion.spProLogOpenInfo= SPClassLogInfoEntity.fromJson(jsonData);
      }
    } );
    await SPClassApplicaion.spFunInitUserState();
    ///有欠缺
    ///
    return;
  }

  void spFunInitOneLogin() {
    // 标记
    // if(SPClassApplicaion.spProChannelId=="2"){
    //   FlutterPhoneLogin.init(appId: "5abdca70b4e6e", appSecret: "14e354d0d7cb3c89ffb5590be87b04ee");
    // }else{
    //   FlutterPhoneLogin.init(appId: "59dda2adae0c1", appSecret: "8c62e662895f9583dfa2aed777df8c08");
    // }
  }

  /// 监听网络状态
  Future<Null> spFunInitConnectivity() async {
    //平台消息可能会失败，因此我们使用Try/Catch PlatformException。
    // try {
    //   _connectivity.checkConnectivity().then((result){
    //     spFunSetWifiName(result);
    //   });
    //   _connectivity.getWifiBSSID().then((reslut){
    //     if(reslut!=null&&reslut.isNotEmpty){
    //       SPClassApplicaion.spProMacAddress=reslut;
    //     }
    //   });
    // }  catch (e) {
    // }
    //
    // _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
    //   spFunSetWifiName(result);
    // });

  }

  void spFunSetWifiName(ConnectivityResult result){
    // switch(result){
    //   case ConnectivityResult.mobile:
    //   case ConnectivityResult.none:
    //     SPClassApplicaion.spProWifiName="";
    //     break;
    //   case ConnectivityResult.wifi:
    //     _connectivity.getWifiName().then((wifiName){
    //       if(wifiName!=null){
    //         SPClassApplicaion.spProWifiName=wifiName;
    //       }
    //       SPClassLogUtils.spFunPrintLog("connectionStatus: ${SPClassApplicaion.spProWifiName.toString()}");
    //     });
    //     break;
    // }
    //
    // _connectivity.getWifiBSSID().then((reslut){
    //   if(reslut!=null&&reslut.isNotEmpty){
    //     SPClassApplicaion.spProMacAddress=reslut;
    //   }
    // });
  }

  Future<void> spFunInitPush() async {
//     if(Platform.isIOS){
//       SPClassApplicaion.spProJPush = new JPush();
//       SPClassApplicaion.spProJPush .setup(
//         appKey:SPClassApplicaion.spProChannelId=="2"? "13a7f0f109637413b2cc9c6d":"883e94b7fc3b1e8eae037188",
//         channel: "theChannel",
//         production: true,
//         debug: true,
// //        production: false,
// //        debug: SPClassApplicaion.spProDEBUG,
//       );
//       SPClassApplicaion.spProJPush.applyPushAuthority(new NotificationSettingsIOS(
//           sound: true,
//           alert: true,
//           badge: true));
//     }else{
//       var androidInfo=  await SPClassNetConfig.spProDeviceInfo.androidInfo;
//       if(androidInfo.manufacturer.toLowerCase().contains("huawei")){
//         FlutterPluginHuaweiPush.pushToken.then((pushToken){
//           print("token=====$pushToken");
//           if(pushToken!=null&&pushToken.isNotEmpty){
//             SPClassApplicaion.pushToken=pushToken;
//           }
//         });
//       }else{
//         SPClassApplicaion.spProJPush = new JPush();
//         SPClassApplicaion.spProJPush .setup(
//           appKey:SPClassApplicaion.spProChannelId=="2"? "13a7f0f109637413b2cc9c6d":"883e94b7fc3b1e8eae037188",
//           channel: "theChannel",
//           production: true,
//           debug: true,
// //        production: false,
// //        debug: SPClassApplicaion.spProDEBUG,
//         );
//       }
//     }
  }

  spFunInitWx() async {
    fluwx.registerWxApi(
      appId: ChannelId == "2" ? "wx3968d1915829705d" : "wx55c3416a14860147",
      universalLink: "https://api.gz583.com/hongsheng/",
    );
  }




}
