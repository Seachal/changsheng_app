import 'dart:convert';

import 'dart:io';
import 'package:changshengh5/pages/SPClassSplashPage.dart';
import 'package:changshengh5/pages/competition/SPClassMatchListSettingPage.dart';
import 'package:changshengh5/pages/dialogs/SPClassPrivacyDialogDialog.dart';
import 'package:changshengh5/utils/LocalStorage.dart';
import 'package:changshengh5/utils/SPClassCommonMethods.dart';
import 'package:changshengh5/utils/SPClassIphoneDevices.dart';
import 'package:changshengh5/utils/SPClassLogUtils.dart';
import 'package:changshengh5/utils/SPClassNavigatorUtils.dart';
import 'package:changshengh5/utils/SPClassSharedPreferencesKeys.dart';
import 'package:changshengh5/utils/SPClassUtil.dart';
import 'package:changshengh5/utils/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity/connectivity.dart';
import 'package:package_info/package_info.dart';
import 'package:jpush_flutter/jpush_flutter.dart';

import 'api/SPClassApiManager.dart';
import 'api/SPClassHttpCallBack.dart';
import 'api/SPClassNetConfig.dart';
import 'app/SPClassApplicaion.dart';
import 'generated/json/base/json_convert_content.dart';
import 'main/SPClassAppPage.dart';
import 'model/SPClassBaseModelEntity.dart';
import 'model/SPClassConfRewardEntity.dart';
import 'model/SPClassLogInfoEntity.dart';
import 'package:fluwx/fluwx.dart' as fluwx;
import 'package:crypto/crypto.dart';
//import 'package:jverify/jverify.dart';

import 'utils/AesUtils.dart';
import 'utils/FlutterToolUtil.dart';


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final Connectivity _connectivity = Connectivity();
//  标记
//  final Jverify jverify =  Jverify();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Colors.white,
      child: SPClassSplashPage(() {}),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (LocalStorage.get(Commons.IS_AGREE_PRIVICY) != null) {
      init();
      Future.delayed(Duration(seconds: 3)).then((value) async {
        SPClassNavigatorUtils.pushAndRemoveAll(context, SPClassAppPage());
        SPClassUtil.spFunRequestPermission();
      });
    } else {
      Future.delayed(Duration(seconds: 3)).then((value) {
        showDialog(
            context: context,
            builder: (context) {
              return SPClassPrivacyDialogDialog(() async {
                await init();
                Future.delayed(Duration(milliseconds: 100)).then((value) {
                  SPClassNavigatorUtils.pushAndRemoveAll(
                      context, SPClassAppPage());
                  SPClassUtil.spFunRequestPermission();
                });
              });
            });
      });
    }
    spFunInitUserData();
  }

  Future<void> init() async {
    try {
      if (Platform.isAndroid) {
        FlutterToolUtil.channelId.then((channel) {
          SPClassApplicaion.spProChannelId = channel;
          if (SPClassApplicaion.spProChannelId == "2") {
            SPClassApplicaion.spProAndroidAppId = "105";
          }
        });
      } else {
//        SPClassApplicaion.spProShowMenuList = [
//          "home",
//          "match",
//          "expert",
//          "info",
//          "match_scheme",
//          "match_analyse",
//          "game"
//        ];
      }
    } catch (e) {
      SPClassLogUtils.spFunPrintLog(e.toString());
    } finally {
      spFunInitOneLogin();
      spFunInitConnectivity();
      spFunInitPush();
      spFunInitWx();
    }
  }

  Future<void> spFunInitUserData() async {
    await SharedPreferences.getInstance().then((sp) {
      SPClassApplicaion.spProDEBUG =
          sp.getBool("test") ?? SPClassApplicaion.spProDEBUG;
      SPClassMatchListSettingPageState.SHOW_PANKOU =
          sp.getBool(SPClassSharedPreferencesKeys.KEY_MATCH_PAN_KOU) ??
              SPClassMatchListSettingPageState.SHOW_PANKOU;
      var logInfoJson = sp.getString(SPClassSharedPreferencesKeys.KEY_LOG_JSON);
      if (logInfoJson != null) {
        var jsonData = json.decode(logInfoJson);
        SPClassApplicaion.spProLogOpenInfo =
            // SPClassLogInfoEntity.fromJson(jsonData);
        JsonConvert.fromJsonAsT<SPClassLogInfoEntity>(jsonData);
      }
    });
    await SPClassApplicaion.spFunInitUserState();
    if (Platform.isAndroid) {
      spFunInitAndroid();
    }
    if (Platform.isIOS) {
      spFunGetSydidCache();
    }
    return;
  }

  void spFunInitOneLogin() {
    // 初始化一键登录
//    jverify.setup(appKey: 'c79807ca5d4fd2a554e7ad1d',channel: "devloper-default");
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

  void spFunSetWifiName(ConnectivityResult result) {
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

    // 推送
    if (Platform.isIOS) {
      SPClassApplicaion.spProJPush = JPush();
      SPClassApplicaion.spProJPush?.setup(
        appKey:'c79807ca5d4fd2a554e7ad1d',
        channel: "theChannel",
        production: true,
        debug: true,
      );
      SPClassApplicaion.spProJPush?.applyPushAuthority(
          const NotificationSettingsIOS(sound: true, alert: true, badge: true));
    } else {
      SPClassApplicaion.spProJPush = JPush();
      SPClassApplicaion.spProJPush?.setup(
        appKey: 'c79807ca5d4fd2a554e7ad1d',
        channel: "theChannel",
        production: true,
        debug: true,
      );
    }
  }

  spFunInitWx() async {
    fluwx.registerWxApi(
      appId: ChannelId == "2" ? "wx3968d1915829705d" : "wx3968d1915829705d",
      universalLink: "https://api.gz583.com/hongsheng/",
    );
  }

  Future spFunInitAndroid() async {
    spFunGetSydidCache();
    spFunInitData();
  }

  void spFunGetSydidCache() async {
    if (Platform.isAndroid) {
      String documentsPath = await FlutterToolUtil.getExternalStorage();
      String appIdPath = SPClassApplicaion.spProAndroidAppId == "100"
          ? '/wbs/wbs.txt'
          : ("/wbs/" + SPClassApplicaion.spProAndroidAppId + "/wbs.txt");
      File file = new File(documentsPath + appIdPath);
      bool exists = await file.exists();
      if (exists) {
        String wbs = await file.readAsString();
        String encryptedString = AesUtils.decryptAes(wbs);
        SPClassApplicaion.spProSydid = encryptedString;
      } else {
        if (SPClassApplicaion.spProLogOpenInfo != null) {
          SPClassApplicaion.spProSydid =
              SPClassApplicaion.spProLogOpenInfo!.sydid!;
        }
      }
    }

    if (Platform.isIOS) {
      SPClassApplicaion.spProSydid = await FlutterToolUtil.getKeyChainSyDid;
    }
    spFunInitData();
  }

  void spFunInitData() async {
    SPClassApplicaion.spProPackageInfo = await PackageInfo.fromPlatform();
    if (Platform.isAndroid) {
      SPClassNetConfig.androidInfo =
          await SPClassNetConfig.spProDeviceInfo.androidInfo;
      try {
        SPClassApplicaion.spProImei = await SharedPreferences.getInstance()
            .then((sp) => sp.getString(SPClassSharedPreferencesKeys.KEY_IMEI)!);
        if (SPClassApplicaion.spProImei == null ||
            SPClassApplicaion.spProImei.contains("Denied")) {
          SPClassApplicaion.spProImei = "";
        }
        SPClassApplicaion.spProDeviceName = SPClassNetConfig.androidInfo!.model;
      } catch (e) {}
    } else if (Platform.isIOS) {
      SPClassNetConfig.spProIosDeviceInfo =
          await SPClassNetConfig.spProDeviceInfo.iosInfo;
      SPClassApplicaion.spProDeviceName = SPClassIphoneDevices()
          .spFunDevicesString(
              SPClassNetConfig.spProIosDeviceInfo!.utsname.machine);
    }
    spFunDoLogOpen();

    if (spFunIsLogin()) {
      spFunDoLogin(SPClassApplicaion.spProUserLoginInfo!.spProAutoLoginStr!);
    }

    spFunDomainJs(null);
  }

  void spFunDoLogOpen() {
    if (SPClassApplicaion.spProLogOpenInfo == null) {
      spFunInitMenuList();
    }

    SPClassApiManager.spFunGetInstance()
        .spFunConfReward<SPClassConfRewardEntity>(
            spProCallBack: SPClassHttpCallBack(
                spProOnSuccess: (value) {
                  SPClassApplicaion.spProConfReward = value;
                },
                onError: (e) {},
                spProOnProgress: (v) {}));
    SPClassApiManager.spFunGetInstance().spFunLogOpen<SPClassBaseModelEntity>(
        needSydid: "1",
        spProCallBack: SPClassHttpCallBack(
            spProOnSuccess: (result) async {
              var logOpen= JsonConvert.fromJsonAsT<SPClassLogInfoEntity>(result.data);
              // var logOpen = SPClassLogInfoEntity.fromJson(result.data);
              print('显示的内容：${logOpen.spProMenuList}');
              SPClassApplicaion.spProLogOpenInfo = logOpen;
              var md5Code = md5.convert(utf8.encode(AppId)).toString();
              if (Platform.isAndroid) {
                if (result.data["app_sign"] == md5Code) {
                  if(logOpen.spProMenuList!.isNotEmpty){
                    SPClassApplicaion.spProShowMenuList = logOpen.spProMenuList!;
                    SharedPreferences.getInstance().then((sp) => sp.setString(
                        SPClassSharedPreferencesKeys.KEY_LOG_JSON,
                        jsonEncode(result.data)));
                  }
                } else {
                  spFunInitMenuList();
                }
              }else{
                //ios
                if(result.data['app_sign']!=md5.convert(utf8.encode(SPClassApplicaion.spProIOSAppId)).toString()){
                  SPClassApplicaion.spProShowMenuList =["home","shop","pk","match","expert","info","match_analyse","bcw_data",];
                }else{
                  if(logOpen.spProMenuList!.isNotEmpty){
                    SPClassApplicaion.spProShowMenuList = logOpen.spProMenuList!;
                    SharedPreferences.getInstance().then((sp) => sp.setString(
                        SPClassSharedPreferencesKeys.KEY_LOG_JSON,
                        jsonEncode(result.data)));
                  }

                }
              }

              if (SPClassApplicaion.spProSydid == logOpen.sydid!) {
                return;
              }
              SPClassApplicaion.spProSydid = logOpen.sydid!;
              if (Platform.isAndroid) {
                try {
                  String encryptedString = AesUtils.encryptAes(logOpen.sydid!);
                  if (Platform.isAndroid) {
                    String documentsPath =
                        await FlutterToolUtil.getExternalStorage();
                    String appIdPath =
                        SPClassApplicaion.spProAndroidAppId == "100"
                            ? '/wbs/wbs.txt'
                            : ("/wbs/" +
                                SPClassApplicaion.spProAndroidAppId +
                                "/wbs.txt");
                    File file = new File(documentsPath + appIdPath);
                    if (!file.existsSync()) {
                      file.createSync(recursive: true);
                    }
                    spFunWriteToFile(file, encryptedString);
                  }
                } on PlatformException {}
              }
              if (Platform.isIOS) {
                FlutterToolUtil.saveKeyChainSyDiy(SPClassApplicaion.spProSydid);
              }
            },
            onError: (e) {},
            spProOnProgress: (v) {}));
  }

  void spFunInitMenuList() {
    var channels = ["1", "2", "7", "5", "6", "4", "13", '9'];
    if (channels.contains(SPClassApplicaion.spProChannelId)) {
      SPClassApplicaion.spProShowMenuList = ["circle", "match"];
    }
  }

  void spFunWriteToFile(File file, String notes) async {
    await file.writeAsString(notes);
  }

  void spFunDomainJs(String? autoString) async {
    SPClassApiManager.spFunGetInstance().spFunDomainJs(
        spProCallBack: SPClassHttpCallBack(
            spProOnSuccess: (result) {
              SPClassApplicaion.spProJsMap = result.data;
            },
            onError: (e) {},
            spProOnProgress: (v) {}));
  }

  void spFunDoLogin(String autoString) {
    SPClassApiManager.spFunGetInstance().spFunUserAuoLogin(
        spProAutoLoginStr: autoString,
        spProCallBack: SPClassHttpCallBack(
            spProOnSuccess: (result) {
              SPClassApplicaion.spProUserLoginInfo = result;
              SPClassApplicaion.spFunSaveUserState();
            },
            onError: (error) {
              if (error.code == "401") {
                SPClassApplicaion.spFunClearUserState();
              }
            },
            spProOnProgress: (v) {}));
  }
}
