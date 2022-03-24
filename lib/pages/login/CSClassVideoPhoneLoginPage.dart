import 'dart:async';
import 'dart:ui';
import 'package:changshengh5/api/CSClassApiManager.dart';
import 'package:changshengh5/api/CSClassHttpCallBack.dart';
import 'package:changshengh5/app/CSClassApplicaion.dart';
import 'package:changshengh5/model/CSClassBaseModelEntity.dart';
import 'package:changshengh5/model/CSClassUserLoginInfo.dart';
import 'package:changshengh5/utils/CSClassCommonMethods.dart';
import 'package:changshengh5/utils/CSClassImageUtil.dart';
import 'package:changshengh5/utils/CSClassNavigatorUtils.dart';
import 'package:changshengh5/utils/CSClassToastUtils.dart';
import 'package:changshengh5/utils/colors.dart';
import 'package:changshengh5/widgets/CSClassToolBar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/services.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';

class CSClassVideoPhoneLoginPage extends StatefulWidget {
  VideoPlayerController? csProVideoPlayerController;
  int? csProPhoneType; //0== 绑定手机号 1==找回密码
  String? csProBindSid;
  int csProLoginType; //0 wx 1  apple
  CSClassVideoPhoneLoginPage(
      {this.csProVideoPlayerController,
      this.csProPhoneType,
      this.csProBindSid,
        this.csProLoginType=0
      });

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CSClassVideoPhoneLoginPageState();
  }
}

class CSClassVideoPhoneLoginPageState extends State<CSClassVideoPhoneLoginPage>
    with WidgetsBindingObserver {
  bool csProIsKeyBoardShow = false;
  String csProPhoneNum = "";
  String csProVerCode = "";
  int csProCurrentSecond = 0;
  Timer? csProTimer;
  bool csProIsShowPassWord = false;
  String csProPhonePwd = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    if (csProTimer != null) {
      csProTimer!.cancel();
    }
    WidgetsBinding.instance!.removeObserver(this);
  }

  @override
  void didChangeMetrics() {
    // TODO: implement didChangeMetrics
    super.didChangeMetrics();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      setState(() {
        csProIsKeyBoardShow = (MediaQuery.of(context).viewInsets.bottom > 0);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        child: Stack(
          children: <Widget>[
            Container(
                child: widget.csProVideoPlayerController!.value.isInitialized
                    ? Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.width /
                            widget
                                .csProVideoPlayerController!.value.aspectRatio,
                        child: VideoPlayer(widget.csProVideoPlayerController!),
                      )
                    : SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height)),
            Container(
              child: Image.asset(
                CSClassImageUtil.csMethodGetImagePath('login_bg'),
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
              ),
            ),
            Container(
              child: Column(
                children: <Widget>[
                  CSClassToolBar(
                    context,
                    csProBgColor: Colors.transparent,
                    iconColor: 0xFFFFFFFF,
                  ),
                  Expanded(
                    child: Container(
                      padding:
                          EdgeInsets.only(left: width(44), right: width(44)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              widget.csProPhoneType == 0 ? "绑定手机" : "找回密码",
                              style: TextStyle(
                                  fontSize: sp(20), color: Colors.white),
                            ),
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  decoration: BoxDecoration(
                                      // color: Color(0x4DDDDDDD),
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Colors.white, width: 0.5))
                                      // borderRadius:
                                      // BorderRadius.circular(400),

                                      ),
                                  height: height(48),
                                  child: Row(
                                    children: <Widget>[
                                      Image.asset(
                                        CSClassImageUtil.csMethodGetImagePath(
                                            "phone"),
                                        width: width(24),
                                      ),
                                      SizedBox(
                                        width: width(8),
                                      ),
                                      Expanded(
                                          child: TextField(
                                        textAlign: TextAlign.left,
                                        maxLines: 1,
                                        style: TextStyle(
                                            fontSize: sp(18),
                                            color: Colors.white,
                                            textBaseline:
                                                TextBaseline.alphabetic),
                                        decoration: InputDecoration(
                                          hintText: "请输入手机号",
                                          hintStyle: TextStyle(
                                              color: Color(0xFFC6C6C6),
                                              fontSize: sp(14)),
                                          border: InputBorder.none,
                                        ),
                                        inputFormatters: <TextInputFormatter>[
                                          FilteringTextInputFormatter.digitsOnly,//只输入数字
                                          LengthLimitingTextInputFormatter(
                                              11) //限制长度
                                        ],
                                        onChanged: (value) {
                                          csProPhoneNum = value;
                                        },
                                      ))
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: width(16),
                                ),
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                            border: Border(
                                                bottom: BorderSide(
                                                    color: Colors.white,
                                                    width: 0.5))),
                                        child: Row(
                                          children: <Widget>[
                                            Image.asset(
                                              CSClassImageUtil
                                                  .csMethodGetImagePath("code"),
                                              width: width(24),
                                            ),
                                            SizedBox(
                                              width: width(8),
                                            ),
                                            Expanded(
                                              child: TextField(
                                                textAlign: TextAlign.left,
                                                maxLines: 1,
                                                style: TextStyle(
                                                    fontSize: sp(18),
                                                    color: Colors.white,
                                                    textBaseline: TextBaseline
                                                        .alphabetic),
                                                decoration: InputDecoration(
                                                  hintText: "请输入验证码",
                                                  hintStyle: TextStyle(
                                                      color: Color(0xFFC6C6C6),
                                                      fontSize: sp(14)),
                                                  border: InputBorder.none,
                                                ),
                                                onChanged: (value) {
                                                  setState(() {
                                                    csProVerCode = value;
                                                  });
                                                },
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        csMethodDoSendCode();
                                      },
                                      child: Container(
                                        margin:
                                            EdgeInsets.only(left: width(31)),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: width(15),
                                            vertical: width(6)),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.white,
                                                width: 0.5),
                                            borderRadius:
                                                BorderRadius.circular(150)),
                                        child: Text(
                                          csProCurrentSecond > 0
                                              ? "已发送" +
                                                  csProCurrentSecond
                                                      .toString() +
                                                  "s"
                                              : "获取验证码",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
//                                widget.csProPhoneType == 1
//                                    ?
                                Container(
                                        decoration: BoxDecoration(
                                            // color: Color(0x4DDDDDDD),
                                            border: Border(
                                                bottom: BorderSide(
                                                    color: Colors.white,
                                                    width: 0.5))
                                            // borderRadius:
                                            // BorderRadius.circular(400),

                                            ),
                                        height: height(48),
                                        child: Row(
                                          children: <Widget>[
                                            Image.asset(
                                              CSClassImageUtil
                                                  .csMethodGetImagePath(
                                                      "password"),
                                              width: width(24),
                                            ),
                                            SizedBox(
                                              width: width(8),
                                            ),
                                            Expanded(
                                                child: TextField(
                                              obscureText: !csProIsShowPassWord,
                                              textAlign: TextAlign.left,
                                              maxLines: 1,
                                              style: TextStyle(
                                                  fontSize: sp(18),
                                                  color: Colors.white,
                                                  textBaseline:
                                                      TextBaseline.alphabetic),
                                              decoration: InputDecoration(
                                                hintText: "请输入密码",
                                                hintStyle: TextStyle(
                                                    color: Color(0xFFC6C6C6),
                                                    fontSize: sp(14)),
                                                border: InputBorder.none,
                                                suffixIcon: IconButton(
                                                  padding: EdgeInsets.only(
                                                      right: width(24)),
                                                  icon: Image.asset(
                                                    !csProIsShowPassWord
                                                        ? CSClassImageUtil
                                                            .csMethodGetImagePath(
                                                                'cs_login_uneye')
                                                        : CSClassImageUtil
                                                            .csMethodGetImagePath(
                                                                'cs_eye_pwd'),
                                                    fit: BoxFit.contain,
                                                    color: Colors.white,
                                                    width: width(18),
                                                    height: width(18),
                                                  ),
                                                  onPressed: () => setState(() {
                                                    csProIsShowPassWord =
                                                        !csProIsShowPassWord;
                                                  }),
                                                ),
                                              ),
                                              onChanged: (value) {
                                                setState(() {
                                                  csProPhonePwd = value;
                                                });
                                              },
                                            ))
                                          ],
                                        ),
                                      ),
//                                    : SizedBox(),

                                /// 登录按钮
                                GestureDetector(
                                    child: Container(
                                      margin: EdgeInsets.only(top: height(25)),
                                      decoration: BoxDecoration(
                                          color: csProPhoneNum.length == 11
                                              ? MyColors.main1
                                              : Colors.transparent,
                                          border: Border.all(
                                              color: csProPhoneNum.length == 11
                                                  ? MyColors.main1
                                                  : MyColors.grey_66,
                                              width: 0.5),
                                          borderRadius:
                                              BorderRadius.circular(400)),
                                      height: width(46),
                                      alignment: Alignment.center,
                                      child: Text(
                                        "登录",
                                        style: TextStyle(
                                            color: csProPhoneNum.length == 11
                                                ? MyColors.white
                                                : MyColors.grey_66,
                                            fontSize: sp(16)),
                                      ),
                                    ),
                                    onTap: () {
                                      if (csProPhoneNum.length != 11) {
                                        CSClassToastUtils.csMethodShowToast(
                                            msg: "请输入正确11位手机号码!");
                                        return;
                                      }

                                      if (csProVerCode.isEmpty) {
                                        CSClassToastUtils.csMethodShowToast(
                                            msg: "请输入验证码");
                                        return;
                                      }

                                      if (csProPhonePwd.isEmpty &&
                                          widget.csProPhoneType == 1) {
                                        CSClassToastUtils.csMethodShowToast(
                                            msg: "请输入密码");
                                        return;
                                      }
                                      login();
                                    }),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void login() {
    switch (widget.csProPhoneType) {
      case 0:
        CSClassApiManager.csMethodGetInstance().csMethodUserRegister(
            context: context,
            queryParameters: {
              "phone_number": csProPhoneNum,
              "phone_code": csProVerCode,
              "bind_sid": widget.csProBindSid,
              "bind_type": widget.csProLoginType==0?"WX":"APPLE"
            },
            csProBodyParameters: {"pwd": csProPhonePwd},
            csProCallBack: CSClassHttpCallBack<CSClassUserLoginInfo>(
                csProOnSuccess: (loginInfo) {
              CSClassApplicaion.csProUserLoginInfo = loginInfo;
              CSClassApplicaion.csMethodSaveUserState();
              CSClassApplicaion.csMethodInitUserState();
              CSClassApplicaion.csMethodGetUserInfo();
              CSClassToastUtils.csMethodShowToast(msg: "登录成功");
              CSClassApplicaion.csMethodSavePushToken();
              CSClassNavigatorUtils.csMethodPopAll(context);
            },onError: (v){},csProOnProgress: (v){}
            )
        );
        break;
      case 1:
        CSClassApiManager.csMethodGetInstance().csMethodUserChangePwd(
            context: context,
            queryParameters: {
              "phone_number": csProPhoneNum,
              "phone_code": csProVerCode,
              "change_method": "phone_code"
            },
            csProBodyParameters: {"pwd": csProPhonePwd},
            csProCallBack: CSClassHttpCallBack<CSClassBaseModelEntity>(
                csProOnSuccess: (result) {
              CSClassApiManager().csMethodUserLogin(
                  queryParameters: {"username": csProPhoneNum},
                  csProBodyParameters: {"pwd": csProPhonePwd},
                  context: context,
                  csProCallBack: CSClassHttpCallBack<CSClassUserLoginInfo>(
                      csProOnSuccess: (loginInfo) {
                    CSClassApplicaion.csProUserLoginInfo = loginInfo;
                    CSClassApplicaion.csMethodSaveUserState();
                    CSClassApplicaion.csMethodInitUserState();
                    CSClassApplicaion.csMethodGetUserInfo();
                    CSClassApplicaion.csMethodSavePushToken();
                    CSClassToastUtils.csMethodShowToast(
                        msg: "登录成功", gravity: ToastGravity.CENTER);
                    CSClassNavigatorUtils.csMethodPopAll(context);
                  },onError: (v){},csProOnProgress: (v){}
                  ));
            },onError: (v){},csProOnProgress: (v){}
            ));
        break;
    }
  }

  void csMethodDoSendCode() async {
    if (csProPhoneNum.length != 11) {
      CSClassToastUtils.csMethodShowToast(msg: "请输入11位正确手机号");
      return;
    } else if (csProCurrentSecond > 0) {
      return;
    }

    CSClassApiManager.csMethodGetInstance().csMethodSendCode(
        context: context,
        csProPhoneNumber: csProPhoneNum,
        csProCodeType: widget.csProPhoneType == 0 ? "bind" : "change_pwd",
        csProCallBack: CSClassHttpCallBack<CSClassBaseModelEntity>(
            csProOnSuccess: (result) {
          CSClassToastUtils.csMethodShowToast(msg: "发送成功");
          setState(() {
            csProCurrentSecond = 60;
          });
          csProTimer = Timer.periodic(Duration(seconds: 1), (second) {
            setState(() {
              if (csProCurrentSecond > 0) {
                setState(() {
                  csProCurrentSecond = csProCurrentSecond - 1;
                });
              } else {
                second.cancel();
              }
            });
          });
        },onError: (v){},csProOnProgress: (v){}
        ));
  }
}
