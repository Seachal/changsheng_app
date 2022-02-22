import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:changshengh5/api/SPClassNetConfig.dart';
import 'package:changshengh5/app/SPClassApplicaion.dart';
import 'package:changshengh5/untils/SPClassCommonMethods.dart';
import 'package:changshengh5/untils/SPClassImageUtil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SPClassSplashPage extends StatefulWidget {
  VoidCallback callback;

  SPClassSplashPage(this.callback);
  SPClassSplashPageState createState() => SPClassSplashPageState();
}

class SPClassSplashPageState extends State<SPClassSplashPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    ScreenUtil.init(BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width,
        maxHeight: MediaQuery.of(context).size.height),
        context: context, designSize: Size(360, 640));
    return Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: <Widget>[
          Expanded(
            child: Container(
                alignment: Alignment.center,
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width,
                  imageUrl:
                      "${SPClassNetConfig.spFunGetImageUrl()}img/startup.png?time=${DateTime.now().millisecondsSinceEpoch.toString()}",
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  errorWidget: (context, url, error) =>
                      Image.asset(
                    SPClassImageUtil.spFunGetImagePath("bg_splash"),
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width,
                  ),
                )),
          ),
          Container(
            height: width(80),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      SPClassImageUtil.spFunGetImagePath("ic_app_logo"),
                      width: width(40),
                    ),
                    SizedBox(
                      width: width(3),
                    ),
                    Text(
                      "${SPClassApplicaion.spProAppName}",
                      style: TextStyle(
                          fontSize: sp(18), fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                SizedBox(
                  height: height(5),
                ),
                Text(
                  "Copyright © 2018-2020 " +
                      "${SPClassApplicaion.spProAppName} " +
                      "All Rights Reserved",
                  style: TextStyle(fontSize: sp(9), color: Color(0xFF999999)),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
