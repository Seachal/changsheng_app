
import 'dart:io';

import 'package:changshengh5/app/SPClassApplicaion.dart';
import 'package:changshengh5/untils/SPClassCommonMethods.dart';

class SPClassNetConfig {

  /* app

  static final DeviceInfoPlugin spProDeviceInfo=new DeviceInfoPlugin();
  static AndroidDeviceInfo androidInfo;
  static  IosDeviceInfo spProIosDeviceInfo;

   */
  static var  BASE_URL_DEBUG = 'http://api-test.demo.gz583.com/';
  static var  BASE_URL_RELEASE = 'http://api.gz583.com/';
  static var  BASE_URL_IOS_RELEASE = 'http://api.gz583.cn/';
  static var  SHARE_URL_DEBUG = 'http://demo.gz583.com/';
  static var  SHARE_URL_RELEASE = 'http://www.gz583.com/';
  static var  SHARE_URL_IOS_RELEASE = 'http://www.gz583.cn/';
  static var  IMAGE_URL_DEBUG = 'http://cdn.demo.gz583.com/';
  static var  IMAGE_URL_RELEASE = 'http://cdn.gz583.com/';

  static spFunGetBasicUrl() {
    return  SPClassApplicaion.spProDEBUG? SPClassNetConfig.BASE_URL_DEBUG:SPClassNetConfig.BASE_URL_RELEASE;//Platform.isIOS ? BASE_URL_IOS_RELEASE: SPClassNetConfig.BASE_URL_RELEASE;
  }
  static spFunGetBasicUrlByValue(bool isDemo) {
    return  isDemo? SPClassNetConfig.BASE_URL_DEBUG: SPClassNetConfig.BASE_URL_RELEASE; //Platform.isIOS ? BASE_URL_IOS_RELEASE: SPClassNetConfig.BASE_URL_RELEASE;
  }
  static spFunGetImageUrl() {
    return  SPClassApplicaion.spProDEBUG? SPClassNetConfig.IMAGE_URL_DEBUG:IMAGE_URL_RELEASE;
  }
  static spFunGetBaseShareUrl() {
    return  SPClassApplicaion.spProDEBUG? SPClassNetConfig.SHARE_URL_DEBUG:SPClassNetConfig.SHARE_URL_RELEASE;//Platform.isIOS ? SHARE_URL_IOS_RELEASE:SPClassNetConfig.SHARE_URL_RELEASE;
  }

  static spFunGetShareUrl() {
    return  "${spFunGetBaseShareUrl()}"+
        "share.html?invite_code="+
        "${SPClassApplicaion.spProUserInfo?.spProInviteCode}"+
        "&app_id="+
        "${AppId.toString()}"+
        "&channel_id="+
        "${ChannelId.toString()}";
  }
}