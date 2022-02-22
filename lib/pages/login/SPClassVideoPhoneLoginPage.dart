import 'dart:async';
import 'dart:ui';
import 'package:changshengh5/api/SPClassApiManager.dart';
import 'package:changshengh5/api/SPClassHttpCallBack.dart';
import 'package:changshengh5/app/SPClassApplicaion.dart';
import 'package:changshengh5/model/SPClassBaseModelEntity.dart';
import 'package:changshengh5/model/SPClassUserLoginInfo.dart';
import 'package:changshengh5/untils/SPClassCommonMethods.dart';
import 'package:changshengh5/untils/SPClassImageUtil.dart';
import 'package:changshengh5/untils/SPClassNavigatorUtils.dart';
import 'package:changshengh5/untils/SPClassToastUtils.dart';
import 'package:changshengh5/untils/colors.dart';
import 'package:changshengh5/widgets/SPClassToolBar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/services.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';

class SPClassVideoPhoneLoginPage extends StatefulWidget {
  VideoPlayerController? spProVideoPlayerController;
  int? spProPhoneType; //0== 绑定手机号 1==找回密码
  String? spProBindSid;
  SPClassVideoPhoneLoginPage(
      {this.spProVideoPlayerController,
      this.spProPhoneType,
      this.spProBindSid});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SPClassVideoPhoneLoginPageState();
  }
}

class SPClassVideoPhoneLoginPageState extends State<SPClassVideoPhoneLoginPage>
    with WidgetsBindingObserver {
  bool spProIsKeyBoardShow = false;
  String spProPhoneNum = "";
  String spProVerCode = "";
  int spProCurrentSecond = 0;
  Timer? spProTimer;
  bool spProIsShowPassWord = false;
  String spProPhonePwd = "";

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
    if (spProTimer != null) {
      spProTimer!.cancel();
    }
    WidgetsBinding.instance!.removeObserver(this);
  }

  @override
  void didChangeMetrics() {
    // TODO: implement didChangeMetrics
    super.didChangeMetrics();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      setState(() {
        spProIsKeyBoardShow = (MediaQuery.of(context).viewInsets.bottom > 0);
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
                child: widget.spProVideoPlayerController!.value.isInitialized
                    ? Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.width /
                            widget
                                .spProVideoPlayerController!.value.aspectRatio,
                        child: VideoPlayer(widget.spProVideoPlayerController!),
                      )
                    : SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height)),
            Container(
              child: Image.asset(
                SPClassImageUtil.spFunGetImagePath('login_bg'),
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
              ),
            ),
            Container(
              child: Column(
                children: <Widget>[
                  SPClassToolBar(
                    context,
                    spProBgColor: Colors.transparent,
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
                              widget.spProPhoneType == 0 ? "绑定手机" : "找回密码",
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
                                        SPClassImageUtil.spFunGetImagePath(
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
                                          spProPhoneNum = value;
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
                                              SPClassImageUtil
                                                  .spFunGetImagePath("code"),
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
                                                    spProVerCode = value;
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
                                        spFunDoSendCode();
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
                                          spProCurrentSecond > 0
                                              ? "已发送" +
                                                  spProCurrentSecond
                                                      .toString() +
                                                  "s"
                                              : "获取验证码",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                widget.spProPhoneType == 1
                                    ? Container(
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
                                              SPClassImageUtil
                                                  .spFunGetImagePath(
                                                      "password"),
                                              width: width(24),
                                            ),
                                            SizedBox(
                                              width: width(8),
                                            ),
                                            Expanded(
                                                child: TextField(
                                              obscureText: !spProIsShowPassWord,
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
                                                    !spProIsShowPassWord
                                                        ? SPClassImageUtil
                                                            .spFunGetImagePath(
                                                                'ic_login_uneye')
                                                        : SPClassImageUtil
                                                            .spFunGetImagePath(
                                                                'ic_eye_pwd'),
                                                    fit: BoxFit.contain,
                                                    color: Colors.white,
                                                    width: width(18),
                                                    height: width(18),
                                                  ),
                                                  onPressed: () => setState(() {
                                                    spProIsShowPassWord =
                                                        !spProIsShowPassWord;
                                                  }),
                                                ),
                                              ),
                                              onChanged: (value) {
                                                setState(() {
                                                  spProPhonePwd = value;
                                                });
                                              },
                                            ))
                                          ],
                                        ),
                                      )
                                    : SizedBox(),

                                /// 登录按钮
                                GestureDetector(
                                    child: Container(
                                      margin: EdgeInsets.only(top: height(25)),
                                      decoration: BoxDecoration(
                                          color: spProPhoneNum.length == 11
                                              ? MyColors.main1
                                              : Colors.transparent,
                                          border: Border.all(
                                              color: spProPhoneNum.length == 11
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
                                            color: spProPhoneNum.length == 11
                                                ? MyColors.white
                                                : MyColors.grey_66,
                                            fontSize: sp(16)),
                                      ),
                                    ),
                                    onTap: () {
                                      if (spProPhoneNum.length != 11) {
                                        SPClassToastUtils.spFunShowToast(
                                            msg: "请输入正确11位手机号码!");
                                        return;
                                      }

                                      if (spProVerCode.isEmpty) {
                                        SPClassToastUtils.spFunShowToast(
                                            msg: "请输入验证码");
                                        return;
                                      }

                                      if (spProPhonePwd.isEmpty &&
                                          widget.spProPhoneType == 1) {
                                        SPClassToastUtils.spFunShowToast(
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
    switch (widget.spProPhoneType) {
      case 0:
        SPClassApiManager.spFunGetInstance().spFunUserRegister(
            context: context,
            queryParameters: {
              "phone_number": spProPhoneNum,
              "phone_code": spProVerCode,
              "bind_sid": widget.spProBindSid,
              "bind_type": "WX"
            },
            spProBodyParameters: {"pwd": spProPhonePwd},
            spProCallBack: SPClassHttpCallBack<SPClassUserLoginInfo>(
                spProOnSuccess: (loginInfo) {
              SPClassApplicaion.spProUserLoginInfo = loginInfo;
              SPClassApplicaion.spFunSaveUserState();
              SPClassApplicaion.spFunInitUserState();
              SPClassApplicaion.spFunGetUserInfo();
              SPClassToastUtils.spFunShowToast(msg: "登录成功");
              // SPClassApplicaion.spFunSavePushToken();
              SPClassNavigatorUtils.spFunPopAll(context);
            },onError: (v){},spProOnProgress: (v){}
            )
        );
        break;
      case 1:
        SPClassApiManager.spFunGetInstance().spFunUserChangePwd(
            context: context,
            queryParameters: {
              "phone_number": spProPhoneNum,
              "phone_code": spProVerCode,
              "change_method": "phone_code"
            },
            spProBodyParameters: {"pwd": spProPhonePwd},
            spProCallBack: SPClassHttpCallBack<SPClassBaseModelEntity>(
                spProOnSuccess: (result) {
              SPClassApiManager().spFunUserLogin(
                  queryParameters: {"username": spProPhoneNum},
                  spProBodyParameters: {"pwd": spProPhonePwd},
                  context: context,
                  spProCallBack: SPClassHttpCallBack<SPClassUserLoginInfo>(
                      spProOnSuccess: (loginInfo) {
                    SPClassApplicaion.spProUserLoginInfo = loginInfo;
                    SPClassApplicaion.spFunSaveUserState();
                    SPClassApplicaion.spFunInitUserState();
                    SPClassApplicaion.spFunGetUserInfo();
                    // SPClassApplicaion.spFunSavePushToken();
                    SPClassToastUtils.spFunShowToast(
                        msg: "登录成功", gravity: ToastGravity.CENTER);
                    SPClassNavigatorUtils.spFunPopAll(context);
                  },onError: (v){},spProOnProgress: (v){}
                  ));
            },onError: (v){},spProOnProgress: (v){}
            ));
        break;
    }
  }

  void spFunDoSendCode() async {
    if (spProPhoneNum.length != 11) {
      SPClassToastUtils.spFunShowToast(msg: "请输入11位正确手机号");
      return;
    } else if (spProCurrentSecond > 0) {
      return;
    }

    SPClassApiManager.spFunGetInstance().spFunSendCode(
        context: context,
        spProPhoneNumber: spProPhoneNum,
        spProCodeType: widget.spProPhoneType == 0 ? "bind" : "change_pwd",
        spProCallBack: SPClassHttpCallBack<SPClassBaseModelEntity>(
            spProOnSuccess: (result) {
          SPClassToastUtils.spFunShowToast(msg: "发送成功");
          setState(() {
            spProCurrentSecond = 60;
          });
          spProTimer = Timer.periodic(Duration(seconds: 1), (second) {
            setState(() {
              if (spProCurrentSecond > 0) {
                setState(() {
                  spProCurrentSecond = spProCurrentSecond - 1;
                });
              } else {
                second.cancel();
              }
            });
          });
        }));
  }
}
