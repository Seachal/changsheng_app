

import 'package:changshengh5/app/SPClassApplicaion.dart';

import 'SPClassSharedPreferencesKeys.dart';
import 'SPClassStringUtils.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:device_information/device_information.dart';


class SPClassUtil{

  // 申请权限
  static Future spFunRequestPermission() async {
    // await PermissionHandler().requestPermissions(
    //     [PermissionGroup.storage, PermissionGroup.phone]);
    // PermissionStatus permission = await PermissionHandler()
    //     .checkPermissionStatus(PermissionGroup.storage);
    await [
      Permission.phone,
      Permission.storage,
    ].request();

    // var imei = await ImeiPlugin.getImei(shouldShowRequestPermissionRationale: false);
    var imei = await DeviceInformation.deviceIMEINumber;
    if(!SPClassStringUtils.spFunIsEmpty(imei)){
      SPClassApplicaion.spProImei = imei;
      SharedPreferences.getInstance().then((sp)=>sp.setString(SPClassSharedPreferencesKeys.KEY_IMEI, imei));
    }
  }
}