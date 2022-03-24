
import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:changshengh5/app/CSClassApplicaion.dart';
import 'package:changshengh5/utils/CSClassCommonMethods.dart';

class CSClassNetConfig {

  static final DeviceInfoPlugin csProDeviceInfo=DeviceInfoPlugin();
  static AndroidDeviceInfo ?androidInfo;
  static  IosDeviceInfo ?csProIosDeviceInfo;

  static var  BASE_URL_DEBUG = 'http://api-test.demo.gz583.com/';
  static var  BASE_URL_RELEASE = 'http://api.win2048.com/';
  static var  BASE_URL_IOS_RELEASE = 'http://api.win2048.com/';
  static var  SHARE_URL_DEBUG = 'http://demo.gz583.com/';
  static var  SHARE_URL_RELEASE = 'http://www.gz583.com/';
  static var  SHARE_URL_IOS_RELEASE = 'http://www.gz583.cn/';
  static var  IMAGE_URL_DEBUG = 'http://cdn.demo.gz583.com/';
  static var  IMAGE_URL_RELEASE = 'http://cdn.win2048.com/';

  static csMethodGetBasicUrl() {
    return  CSClassApplicaion.csProDEBUG? CSClassNetConfig.BASE_URL_DEBUG:Platform.isIOS ? BASE_URL_IOS_RELEASE: CSClassNetConfig.BASE_URL_RELEASE;
  }
  static csMethodGetBasicUrlByValue(bool isDemo) {
    return  isDemo?CSClassNetConfig.BASE_URL_DEBUG: Platform.isIOS ? BASE_URL_IOS_RELEASE: CSClassNetConfig.BASE_URL_RELEASE;
  }
  static csMethodGetImageUrl() {
    return  CSClassApplicaion.csProDEBUG? CSClassNetConfig.IMAGE_URL_DEBUG:IMAGE_URL_RELEASE;
  }
  static csMethodGetBaseShareUrl() {
    return  CSClassApplicaion.csProDEBUG? CSClassNetConfig.SHARE_URL_DEBUG:Platform.isIOS ? SHARE_URL_IOS_RELEASE:CSClassNetConfig.SHARE_URL_RELEASE;
  }

  static csMethodGetShareUrl() {
    return  "${csMethodGetBaseShareUrl()}"+
        "share.html?invite_code="+
        "${CSClassApplicaion.csProUserInfo?.csProInviteCode}"+
        "&app_id="+
        "${AppId.toString()}"+
        "&channel_id="+
        "${ChannelId.toString()}";
  }
}