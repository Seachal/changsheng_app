import 'dart:io';

import 'package:changshengh5/api/CSClassApiManager.dart';
import 'package:changshengh5/app/CSClassApplicaion.dart';
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

 CSClassApiManager get Api=>CSClassApiManager.csMethodGetInstance();

String get AppId => ((Platform.isAndroid) ? CSClassApplicaion.csProAndroidAppId:CSClassApplicaion.csProIOSAppId);
//
String get ChannelId => (Platform.isAndroid ? CSClassApplicaion.csProChannelId:"10");
