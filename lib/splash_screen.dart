import 'dart:convert';

import 'dart:io';
import 'package:changshengh5/pages/CSClassSplashPage.dart';
import 'package:changshengh5/pages/competition/CSClassMatchListSettingPage.dart';
import 'package:changshengh5/pages/dialogs/CSClassPrivacyDialogDialog.dart';
import 'package:changshengh5/utils/LocalStorage.dart';
import 'package:changshengh5/utils/CSClassCommonMethods.dart';
import 'package:changshengh5/utils/CSClassIphoneDevices.dart';
import 'package:changshengh5/utils/CSClassLogUtils.dart';
import 'package:changshengh5/utils/CSClassNavigatorUtils.dart';
import 'package:changshengh5/utils/CSClassSharedPreferencesKeys.dart';
import 'package:changshengh5/utils/CSClassUtil.dart';
import 'package:changshengh5/utils/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity/connectivity.dart';
import 'package:package_info/package_info.dart';
import 'package:jpush_flutter/jpush_flutter.dart';

import 'api/CSClassApiManager.dart';
import 'api/CSClassHttpCallBack.dart';
import 'api/CSClassNetConfig.dart';
import 'app/CSClassApplicaion.dart';
import 'generated/json/base/json_convert_content.dart';
import 'main/CSClassAppPage.dart';
import 'model/CSClassBaseModelEntity.dart';
import 'model/CSClassConfRewardEntity.dart';
import 'model/CSClassLogInfoEntity.dart';
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
      child: CSClassSplashPage(() {}),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (LocalStorage.get(Commons.IS_AGREE_PRIVICY) != null) {
      init();
      Future.delayed(Duration(seconds: 3)).then((value) async {
        CSClassNavigatorUtils.pushAndRemoveAll(context, CSClassAppPage());
        CSClassUtil.csMethodRequestPermission();
      });
    } else {
      Future.delayed(Duration(seconds: 3)).then((value) {
        showDialog(
            context: context,
            builder: (context) {
              return CSClassPrivacyDialogDialog(() async {
                await init();
                Future.delayed(Duration(milliseconds: 100)).then((value) {
                  CSClassNavigatorUtils.pushAndRemoveAll(
                      context, CSClassAppPage());
                  CSClassUtil.csMethodRequestPermission();
                });
              });
            });
      });
    }
    csMethodInitUserData();
  }

  Future<void> init() async {
    try {
      if (Platform.isAndroid) {
        FlutterToolUtil.channelId.then((channel) {
          CSClassApplicaion.csProChannelId = channel;
          if (CSClassApplicaion.csProChannelId == "2") {
            CSClassApplicaion.csProAndroidAppId = "105";
          }
        });
      } else {
//        CSClassApplicaion.csProShowMenuList = [
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
      CSClassLogUtils.csMethodPrintLog(e.toString());
    } finally {
      csMethodInitOneLogin();
      csMethodInitConnectivity();
      csMethodInitPush();
      csMethodInitWx();
    }
  }

  Future<void> csMethodInitUserData() async {
    await SharedPreferences.getInstance().then((sp) {
      CSClassApplicaion.csProDEBUG =
          sp.getBool("test") ?? CSClassApplicaion.csProDEBUG;
      CSClassMatchListSettingPageState.SHOW_PANKOU =
          sp.getBool(CSClassSharedPreferencesKeys.KEY_MATCH_PAN_KOU) ??
              CSClassMatchListSettingPageState.SHOW_PANKOU;
      var logInfoJson = sp.getString(CSClassSharedPreferencesKeys.KEY_LOG_JSON);
      if (logInfoJson != null) {
        var jsonData = json.decode(logInfoJson);
        CSClassApplicaion.csProLogOpenInfo =
            // CSClassLogInfoEntity.fromJson(jsonData);
        JsonConvert.fromJsonAsT<CSClassLogInfoEntity>(jsonData);
      }
    });
    await CSClassApplicaion.csMethodInitUserState();
    if (Platform.isAndroid) {
      csMethodInitAndroid();
    }
    if (Platform.isIOS) {
      csMethodGetSydidCache();
    }
    return;
  }

  void csMethodInitOneLogin() {
    // 初始化一键登录
//    jverify.setup(appKey: 'c79807ca5d4fd2a554e7ad1d',channel: "devloper-default");
  }

  /// 监听网络状态
  Future<Null> csMethodInitConnectivity() async {
    //平台消息可能会失败，因此我们使用Try/Catch PlatformException。
    // try {
    //   _connectivity.checkConnectivity().then((result){
    //     csMethodSetWifiName(result);
    //   });
    //   _connectivity.getWifiBSSID().then((reslut){
    //     if(reslut!=null&&reslut.isNotEmpty){
    //       CSClassApplicaion.csProMacAddress=reslut;
    //     }
    //   });
    // }  catch (e) {
    // }
    //
    // _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
    //   csMethodSetWifiName(result);
    // });
  }

  void csMethodSetWifiName(ConnectivityResult result) {
    // switch(result){
    //   case ConnectivityResult.mobile:
    //   case ConnectivityResult.none:
    //     CSClassApplicaion.csProWifiName="";
    //     break;
    //   case ConnectivityResult.wifi:
    //     _connectivity.getWifiName().then((wifiName){
    //       if(wifiName!=null){
    //         CSClassApplicaion.csProWifiName=wifiName;
    //       }
    //       CSClassLogUtils.csMethodPrintLog("connectionStatus: ${CSClassApplicaion.csProWifiName.toString()}");
    //     });
    //     break;
    // }
    //
    // _connectivity.getWifiBSSID().then((reslut){
    //   if(reslut!=null&&reslut.isNotEmpty){
    //     CSClassApplicaion.csProMacAddress=reslut;
    //   }
    // });
  }

  Future<void> csMethodInitPush() async {

    // 推送
    if (Platform.isIOS) {
      CSClassApplicaion.csProJPush = JPush();
      CSClassApplicaion.csProJPush?.setup(
        appKey:'c79807ca5d4fd2a554e7ad1d',
        channel: "theChannel",
        production: true,
        debug: true,
      );
      CSClassApplicaion.csProJPush?.applyPushAuthority(
          const NotificationSettingsIOS(sound: true, alert: true, badge: true));
    } else {
      CSClassApplicaion.csProJPush = JPush();
      CSClassApplicaion.csProJPush?.setup(
        appKey: 'c79807ca5d4fd2a554e7ad1d',
        channel: "theChannel",
        production: true,
        debug: true,
      );
    }
  }

  csMethodInitWx() async {
    fluwx.registerWxApi(
      appId: ChannelId == "2" ? "wx3968d1915829705d" : "wx3968d1915829705d",
      universalLink: "https://api.gz583.com/hongsheng/",
    );
  }

  Future csMethodInitAndroid() async {
    csMethodGetSydidCache();
    csMethodInitData();
  }

  void csMethodGetSydidCache() async {
    if (Platform.isAndroid) {
      String documentsPath = await FlutterToolUtil.getExternalStorage();
      String appIdPath = CSClassApplicaion.csProAndroidAppId == "100"
          ? '/wbs/wbs.txt'
          : ("/wbs/" + CSClassApplicaion.csProAndroidAppId + "/wbs.txt");
      File file = new File(documentsPath + appIdPath);
      bool exists = await file.exists();
      if (exists) {
        String wbs = await file.readAsString();
        String encryptedString = AesUtils.decryptAes(wbs);
        CSClassApplicaion.csProSydid = encryptedString;
      } else {
        if (CSClassApplicaion.csProLogOpenInfo != null) {
          CSClassApplicaion.csProSydid =
              CSClassApplicaion.csProLogOpenInfo!.sydid!;
        }
      }
    }

    if (Platform.isIOS) {
      CSClassApplicaion.csProSydid = await FlutterToolUtil.getKeyChainSyDid;
    }
    csMethodInitData();
  }

  void csMethodInitData() async {
    CSClassApplicaion.csProPackageInfo = await PackageInfo.fromPlatform();
    if (Platform.isAndroid) {
      CSClassNetConfig.androidInfo =
          await CSClassNetConfig.csProDeviceInfo.androidInfo;
      try {
        CSClassApplicaion.csProImei = await SharedPreferences.getInstance()
            .then((sp) => sp.getString(CSClassSharedPreferencesKeys.KEY_IMEI)!);
        if (CSClassApplicaion.csProImei == null ||
            CSClassApplicaion.csProImei.contains("Denied")) {
          CSClassApplicaion.csProImei = "";
        }
        CSClassApplicaion.csProDeviceName = CSClassNetConfig.androidInfo!.model;
      } catch (e) {}
    } else if (Platform.isIOS) {
      CSClassNetConfig.csProIosDeviceInfo =
          await CSClassNetConfig.csProDeviceInfo.iosInfo;
      CSClassApplicaion.csProDeviceName = CSClassIphoneDevices()
          .csMethodDevicesString(
              CSClassNetConfig.csProIosDeviceInfo!.utsname.machine);
    }
    csMethodDoLogOpen();

    if (csMethodIsLogin()) {
      csMethodDoLogin(CSClassApplicaion.csProUserLoginInfo!.csProAutoLoginStr!);
    }

    csMethodDomainJs(null);
  }

  void csMethodDoLogOpen() {
    if (CSClassApplicaion.csProLogOpenInfo == null) {
      csMethodInitMenuList();
    }

    CSClassApiManager.csMethodGetInstance()
        .csMethodConfReward<CSClassConfRewardEntity>(
            csProCallBack: CSClassHttpCallBack(
                csProOnSuccess: (value) {
                  CSClassApplicaion.csProConfReward = value;
                },
                onError: (e) {},
                csProOnProgress: (v) {}));
    CSClassApiManager.csMethodGetInstance().csMethodLogOpen<CSClassBaseModelEntity>(
        needSydid: "1",
        csProCallBack: CSClassHttpCallBack(
            csProOnSuccess: (result) async {
              var logOpen= JsonConvert.fromJsonAsT<CSClassLogInfoEntity>(result.data);
              // var logOpen = CSClassLogInfoEntity.fromJson(result.data);
              print('显示的内容：${logOpen.csProMenuList}');
              CSClassApplicaion.csProLogOpenInfo = logOpen;
              var md5Code = md5.convert(utf8.encode(AppId)).toString();
              if (Platform.isAndroid) {
                if (result.data["app_sign"] == md5Code) {
                  if(logOpen.csProMenuList!.isNotEmpty){
                    CSClassApplicaion.csProShowMenuList = logOpen.csProMenuList!;
                    SharedPreferences.getInstance().then((sp) => sp.setString(
                        CSClassSharedPreferencesKeys.KEY_LOG_JSON,
                        jsonEncode(result.data)));
                  }
                } else {
                  csMethodInitMenuList();
                }
              }else{
                //ios
                if(result.data['app_sign']!=md5.convert(utf8.encode(CSClassApplicaion.csProIOSAppId)).toString()){
                  CSClassApplicaion.csProShowMenuList =["home","shop","pk","match","expert","info","match_analyse","bcw_data",];
                }else{
                  if(logOpen.csProMenuList!.isNotEmpty){
                    CSClassApplicaion.csProShowMenuList = logOpen.csProMenuList!;
                    SharedPreferences.getInstance().then((sp) => sp.setString(
                        CSClassSharedPreferencesKeys.KEY_LOG_JSON,
                        jsonEncode(result.data)));
                  }

                }
              }

              if (CSClassApplicaion.csProSydid == logOpen.sydid!) {
                return;
              }
              CSClassApplicaion.csProSydid = logOpen.sydid!;
              if (Platform.isAndroid) {
                try {
                  String encryptedString = AesUtils.encryptAes(logOpen.sydid!);
                  if (Platform.isAndroid) {
                    String documentsPath =
                        await FlutterToolUtil.getExternalStorage();
                    String appIdPath =
                        CSClassApplicaion.csProAndroidAppId == "100"
                            ? '/wbs/wbs.txt'
                            : ("/wbs/" +
                                CSClassApplicaion.csProAndroidAppId +
                                "/wbs.txt");
                    File file = new File(documentsPath + appIdPath);
                    if (!file.existsSync()) {
                      file.createSync(recursive: true);
                    }
                    csMethodWriteToFile(file, encryptedString);
                  }
                } on PlatformException {}
              }
              if (Platform.isIOS) {
                FlutterToolUtil.saveKeyChainSyDiy(CSClassApplicaion.csProSydid);
              }
            },
            onError: (e) {},
            csProOnProgress: (v) {}));
  }

  void csMethodInitMenuList() {
    var channels = ["1", "2", "7", "5", "6", "4", "13", '9'];
    if (channels.contains(CSClassApplicaion.csProChannelId)) {
      CSClassApplicaion.csProShowMenuList = ["circle", "match"];
    }
  }

  void csMethodWriteToFile(File file, String notes) async {
    await file.writeAsString(notes);
  }

  void csMethodDomainJs(String? autoString) async {
    CSClassApiManager.csMethodGetInstance().csMethodDomainJs(
        csProCallBack: CSClassHttpCallBack(
            csProOnSuccess: (result) {
              CSClassApplicaion.csProJsMap = result.data;
            },
            onError: (e) {},
            csProOnProgress: (v) {}));
  }

  void csMethodDoLogin(String autoString) {
    CSClassApiManager.csMethodGetInstance().csMethodUserAuoLogin(
        csProAutoLoginStr: autoString,
        csProCallBack: CSClassHttpCallBack(
            csProOnSuccess: (result) {
              CSClassApplicaion.csProUserLoginInfo = result;
              CSClassApplicaion.csMethodSaveUserState();
            },
            onError: (error) {
              if (error.code == "401") {
                CSClassApplicaion.csMethodClearUserState();
              }
            },
            csProOnProgress: (v) {}));
  }
}
