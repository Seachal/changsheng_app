import 'dart:io';

import 'package:changshengh5/api/SPClassApiManager.dart';
import 'package:changshengh5/app/SPClassApplicaion.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

double width(num width){
  return ScreenUtil().setWidth(width);
}
double height(num width){
  return ScreenUtil().setHeight(width);
}
double sp(num sp){
  return ScreenUtil().setSp(sp);
}

 SPClassApiManager get Api=>SPClassApiManager.spFunGetInstance();
///APP使用
// String get AppId => ((Platform.isAndroid) ? SPClassApplicaion.spProAndroidAppId:SPClassApplicaion.spProIOSAppId);
//
// String get ChannelId => (Platform.isAndroid ? SPClassApplicaion.spProChannelId:"10");

String get AppId => SPClassApplicaion.spProAndroidAppId;

String get ChannelId => SPClassApplicaion.spProChannelId;