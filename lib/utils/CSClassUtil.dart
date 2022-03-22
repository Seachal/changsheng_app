

import 'package:changshengh5/app/CSClassApplicaion.dart';

import 'CSClassSharedPreferencesKeys.dart';
import 'CSClassStringUtils.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:device_information/device_information.dart';


class CSClassUtil{

  // 申请权限
  static Future csMethodRequestPermission() async {
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
    if(!CSClassStringUtils.csMethodIsEmpty(imei)){
      CSClassApplicaion.csProImei = imei;
      SharedPreferences.getInstance().then((sp)=>sp.setString(CSClassSharedPreferencesKeys.KEY_IMEI, imei));
    }
  }
}