
import 'dart:convert';
import 'dart:io';
import 'package:changshengh5/pages/SPClassSplashPage.dart';
import 'package:changshengh5/pages/competition/SPClassMatchListSettingPage.dart';
import 'package:changshengh5/pages/dialogs/SPClassPrivacyDialogDialog.dart';
import 'package:changshengh5/untils/LocalStorage.dart';
import 'package:changshengh5/untils/SPClassNavigatorUtils.dart';
import 'package:changshengh5/untils/SPClassSharedPreferencesKeys.dart';
import 'package:changshengh5/untils/common.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/SPClassApplicaion.dart';
import 'main/SPClassAppPage.dart';
import 'model/SPClassLogInfoEntity.dart';


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // final Connectivity _connectivity = Connectivity();

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
      // init();
      Future.delayed(Duration(seconds: 3)).then((value) async{

        SPClassNavigatorUtils.pushAndRemoveAll(context, SPClassAppPage());

      });
    }else{
      Future.delayed(Duration(seconds: 3)).then((value) {
        showDialog(context: context,builder: (context){
          return SPClassPrivacyDialogDialog( ()async{
            // await init();
            Future.delayed(Duration(milliseconds: 100)).then((value) {
              SPClassNavigatorUtils.pushAndRemoveAll(context, SPClassAppPage());
              // SPClassUtil.spFunRequestPermission();
            });
          });
        });
      });
    }
    spFunInitUserData();

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
    return null;
  }


}
