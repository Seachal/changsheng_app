

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'SPClassCommonMethods.dart';

class Commons {

  /// 项目名
  /// TODO 修改为你的项目名
  static const String PROJECT_NAME = "baseFlutter";

  /// 版本号
  static const String VERSION = "version";

  ///用户信息
  static const TOKEN = "token";
  static const DEBUG = true;
  static const IS_AGREE_PRIVICY = 'isAgreePrivicy';  //是否同意协议


  static Widget getAppBar({String ?title,Widget ?appBarRight,Widget ?appBarLeft,Widget ?appBarBottom,}) {
    return Container(
      height: kToolbarHeight,
      width: double.infinity,
      color: Colors.transparent,
      child: Stack(
        alignment: FractionalOffset(0, 0.5),
        children: <Widget>[
          Align(
            alignment: FractionalOffset(0.5, 0.5),
            child: Text(
              title??'',
              style: TextStyle(
                fontSize: sp(19),
                color: Colors.white,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          Positioned(
            //左边返回导航 的位置，可以根据需求变更
            left: 15,
            child: Offstage(
              offstage: false/*!_isBackIconShow*/,
              child: appBarLeft??Container() ,
            ),
          ),
          Positioned(
            right: 0,
            child: appBarRight??Container(),
          ),
          Positioned(
            bottom: 0,
            child: appBarBottom??Container(),
          ),
        ],
      ),
    );
  }


}

