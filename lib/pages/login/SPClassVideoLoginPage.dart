import 'dart:async';
import 'dart:io';

import 'package:changshengh5/api/SPClassApiManager.dart';
import 'package:changshengh5/api/SPClassHttpCallBack.dart';
import 'package:changshengh5/app/SPClassApplicaion.dart';
import 'package:changshengh5/app/SPClassGlobalNotification.dart';
import 'package:changshengh5/model/SPClassBaseModelEntity.dart';
import 'package:changshengh5/model/SPClassUserLoginInfo.dart';
import 'package:changshengh5/pages/dialogs/agreement_page.dart';
import 'package:changshengh5/untils/SPClassCommonMethods.dart';
import 'package:changshengh5/untils/SPClassImageUtil.dart';
import 'package:changshengh5/untils/SPClassNavigatorUtils.dart';
import 'package:changshengh5/untils/SPClassToastUtils.dart';
import 'package:changshengh5/untils/colors.dart';
import 'package:changshengh5/widgets/SPClassToolBar.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';

import 'PasswordLogin.dart';

class SPClassVideoLoginPage extends StatefulWidget {
  SPClassVideoLoginPageState createState() => SPClassVideoLoginPageState();
}

class SPClassVideoLoginPageState extends State<SPClassVideoLoginPage>
    with WidgetsBindingObserver {
  int spProLoginType = 0; //0--验证码登录 1--密码登录 2==一键登录
  late VideoPlayerController _videoPlayerController;
  bool spProIsKeyBoardShow = false;
  bool spProIsShowPassWord = false;
  String spProPhoneNum = "";
  String spProVerCode = "";
  String spProPhonePwd = "";
  // String spProWxCode;
  bool isAgree = false; //是否同意协议
  var spProWxListen;
  static bool spProOneLogin = false;
  int spProCurrentSecond = 0;
  Timer ?spProTimer;

  late TextEditingController _textEditingController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _textEditingController = TextEditingController(text: spProPhoneNum);
    _videoPlayerController =
        VideoPlayerController.asset('assets/video/video_login.m4v')
          ..initialize().then((_) {
            // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
            setState(() {});
          });
    _videoPlayerController.setLooping(true);
    _videoPlayerController.play();
    WidgetsBinding.instance!.addObserver(this);

    ///备注APP使用
    // spProWxListen = fluwx.weChatResponseEventHandler
    //     .distinct((a, b) => a == b)
    //     .listen((res) {
    //   if (res is fluwx.WeChatAuthResponse) {
    //     if (spProWxCode == null || (spProWxCode != res.code)) {
    //       spProWxCode = res.code;
    //       spFunDoLoginWx(res.code);
    //     }
    //   }
    // });
    // FlutterPhoneLogin.preLogin((result) {
    //   if (result) {
    //     spProOneLogin = true;
    //     spProLoginType = 2;
    //   } else {
    //     spProOneLogin = false;
    //     spProLoginType = 0;
    //   }
    //   setState(() {});
    // });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _videoPlayerController.dispose();
    WidgetsBinding.instance!.removeObserver(this);
    if (spProTimer != null) {
      spProTimer?.cancel();
    }

    ///备注APP使用
    // if (spProWxListen != null) {
    //   spProWxListen.cancel();
    // }
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
                child: _videoPlayerController.value.isInitialized
                    ? Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.width /
                            _videoPlayerController.value.aspectRatio,
                        child: VideoPlayer(_videoPlayerController),
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
            // BackdropFilter(
            //   filter: new ImageFilter.blur(
            //       sigmaX: spProIsKeyBoardShow ? 25 : 0,
            //       sigmaY: spProIsKeyBoardShow ? 25 : 0),
            //   child: new Container(
            //     width: ScreenUtil.screenWidth,
            //     height: ScreenUtil.screenHeight,
            //     color: Colors.black45,
            //   ),
            // ),
            Container(
              child: Column(
                children: <Widget>[
                  SPClassToolBar(
                    context,
                    spProBgColor: Colors.transparent,
                    iconColor: 0xFFFFFFFF,
                    actions: <Widget>[],
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
                              (spProLoginType == 0 || spProLoginType == 2)
                                  ? "手机号登录"
                                  : "密码登录",
                              style: TextStyle(
                                  fontSize: sp(20), color: Colors.white),
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "认证服务由运营商提供",
                              style: TextStyle(
                                  fontSize: sp(12), color: Color(0xFF999999)),
                            ),
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    Container(
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.white,
                                                  width: 0.5))),
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
                                            controller: _textEditingController,
                                            textAlign: TextAlign.left,
                                            maxLines: 1,
                                            style: TextStyle(
                                              color: Colors.white,
                                              textBaseline:
                                                  TextBaseline.alphabetic,
                                              fontSize: sp(18),
                                            ),
                                            decoration: InputDecoration(
                                              hintText: "请输入手机号",
                                              hintStyle: TextStyle(
                                                  color: Color(0xFFC6C6C6),
                                                  fontSize: sp(14)),
                                              border: InputBorder.none,
                                            ),
                                            inputFormatters: <
                                                TextInputFormatter>[
                                              FilteringTextInputFormatter
                                                  .digitsOnly, //只输入数字
                                              LengthLimitingTextInputFormatter(
                                                  11), //限制长度
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
                                    spProLoginType == 1
                                        ? SizedBox()
                                        : Row(
                                            children: <Widget>[
                                              Expanded(
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      border: Border(
                                                          bottom: BorderSide(
                                                              color:
                                                                  Colors.white,
                                                              width: 0.5))),
                                                  child: Row(
                                                    children: <Widget>[
                                                      Image.asset(
                                                        SPClassImageUtil
                                                            .spFunGetImagePath(
                                                                "code"),
                                                        width: width(24),
                                                      ),
                                                      SizedBox(
                                                        width: width(8),
                                                      ),
                                                      Expanded(
                                                        child: TextField(
                                                          textAlign:
                                                              TextAlign.left,
                                                          maxLines: 1,
                                                          style: TextStyle(
                                                              fontSize: sp(18),
                                                              color:
                                                                  Colors.white,
                                                              textBaseline:
                                                                  TextBaseline
                                                                      .alphabetic),
                                                          decoration:
                                                              InputDecoration(
                                                            hintText: "请输入验证码",
                                                            hintStyle: TextStyle(
                                                                color: Color(
                                                                    0xFFC6C6C6),
                                                                fontSize:
                                                                    sp(14)),
                                                            border: InputBorder
                                                                .none,
                                                            // suffixIcon: FlatButton(
                                                            //   padding: EdgeInsets.only(
                                                            //       right: width(24)),
                                                            //   child: Text(
                                                            //     spProCurrentSecond > 0
                                                            //         ? "已发送" +
                                                            //         spProCurrentSecond
                                                            //             .toString() +
                                                            //         "s"
                                                            //         : "发送验证码",
                                                            //     style: TextStyle(
                                                            //         color:
                                                            //         Colors.white),
                                                            //   ),
                                                            //   onPressed: () =>
                                                            //   {spFunDoSendCode()},
                                                            // ),
                                                          ),
                                                          onChanged: (value) {
                                                            setState(() {
                                                              spProVerCode =
                                                                  value;
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
                                                  margin: EdgeInsets.only(
                                                      left: width(31)),
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: width(15),
                                                      vertical: width(6)),
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: Colors.white,
                                                          width: 0.5),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              150)),
                                                  child: Text(
                                                    spProCurrentSecond > 0
                                                        ? "已发送" +
                                                            spProCurrentSecond
                                                                .toString() +
                                                            "s"
                                                        : "获取验证码",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),

                                    /// 登录按钮
                                    GestureDetector(
                                        child: Container(
                                          margin:
                                              EdgeInsets.only(top: height(25)),
                                          decoration: BoxDecoration(
                                              color:
                                                  spProPhoneNum.length == 11 &&
                                                          (spProVerCode
                                                                  .isNotEmpty ||
                                                              spProPhonePwd
                                                                  .isNotEmpty)
                                                      ? MyColors.main1
                                                      : Colors.transparent,
                                              border: Border.all(
                                                  color: spProPhoneNum.length ==
                                                              11 &&
                                                          (spProVerCode
                                                                  .isNotEmpty ||
                                                              spProPhonePwd
                                                                  .isNotEmpty)
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
                                                color: spProPhoneNum.length ==
                                                            11 &&
                                                        (spProVerCode
                                                                .isNotEmpty ||
                                                            spProPhonePwd
                                                                .isNotEmpty)
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
                                          if (spProLoginType == 0 &&
                                              spProVerCode.isEmpty) {
                                            SPClassToastUtils.spFunShowToast(
                                                msg: "请输入验证码");
                                            return;
                                          }
                                          if (spProLoginType == 1 &&
                                              spProPhonePwd.isEmpty) {
                                            SPClassToastUtils.spFunShowToast(
                                                msg: "请输入密码");
                                            return;
                                          }
                                          if (!isAgree) {
                                            SPClassToastUtils.spFunShowToast(
                                                msg: "请阅读并勾选 用户协议 和 隐私政策 ");
                                            return;
                                          }
                                          if (spProLoginType == 0) {
                                            if (spProVerCode.length == 0) {
                                              SPClassToastUtils.spFunShowToast(
                                                  msg: "请输入验证码");
                                              return;
                                            }
                                            SPClassApiManager.spFunGetInstance()
                                                .spFunLoginByCode(
                                                    spProPhoneNumber:
                                                        spProPhoneNum,
                                                    spProPhoneCode:
                                                        spProVerCode,
                                                    spProInviteCode: "",
                                                    context: context,
                                                    spProCallBack:
                                                        SPClassHttpCallBack<
                                                                SPClassUserLoginInfo>(
                                                            spProOnSuccess:
                                                                (loginInfo) {
                                                      SPClassApplicaion
                                                              .spProUserLoginInfo =
                                                          loginInfo;
                                                      SPClassApplicaion
                                                          .spFunSaveUserState();
                                                      SPClassApplicaion
                                                          .spFunInitUserState();
                                                      SPClassApplicaion
                                                          .spFunGetUserInfo();
                                                      SPClassGlobalNotification
                                                              .spFunGetInstance()
                                                          ?.spFunInitWebSocket();
                                                      // SPClassApplicaion
                                                      //     .spFunSavePushToken();
                                                      SPClassApplicaion
                                                          .spProEventBus
                                                          .fire(
                                                              "login:gamelist");
                                                      Navigator.of(context)
                                                          .pop();
                                                    },onError: (v){},spProOnProgress: (v){},
                                                    ));
                                          } else if (spProLoginType == 1) {
                                            // SPClassApiManager().spFunUserLogin(
                                            //     queryParameters: {
                                            //       "username": spProPhoneNum
                                            //     },
                                            //     spProBodyParameters: {
                                            //       "pwd": spProPhonePwd
                                            //     },
                                            //     context: context,
                                            //     spProCallBack:
                                            //         SPClassHttpCallBack<
                                            //                 SPClassUserLoginInfo>(
                                            //             spProOnSuccess:
                                            //                 (loginInfo) {
                                            //       SPClassApplicaion
                                            //               .spProUserLoginInfo =
                                            //           loginInfo;
                                            //       SPClassApplicaion
                                            //           .spFunSaveUserState();
                                            //       SPClassApplicaion
                                            //           .spFunInitUserState();
                                            //       SPClassApplicaion
                                            //           .spFunGetUserInfo();
                                            //       SPClassGlobalNotification
                                            //               .spFunGetInstance()
                                            //           .spFunInitWebSocket();
                                            //       SPClassApplicaion
                                            //           .spFunSavePushToken();
                                            //       SPClassApplicaion
                                            //           .spProEventBus
                                            //           .fire("login:gamelist");
                                            //       Navigator.of(context).pop();
                                            //     }));
                                          }
                                        }
                                        ),

                                    ///一键登录 APP使用
                                    // spProOneLogin
                                    //     ? GestureDetector(
                                    //         child: Container(
                                    //           margin: EdgeInsets.only(
                                    //               top: width(12)),
                                    //           decoration: BoxDecoration(
                                    //               borderRadius:
                                    //                   BorderRadius.circular(
                                    //                       400),
                                    //               color: MyColors.main1),
                                    //           height: width(46),
                                    //           alignment: Alignment.center,
                                    //           child: Text(
                                    //             "本机号码一键登录",
                                    //             style: TextStyle(
                                    //                 color: Colors.white,
                                    //                 fontSize: sp(16)),
                                    //           ),
                                    //         ),
                                    //         onTap: () {
                                    //           spFunDoOneLogin();
                                    //         })
                                    //     : Container(),

                                    ///协议
                                    Container(
                                      margin: EdgeInsets.only(
                                          bottom: width(20), top: width(16)),
                                      alignment: Alignment.center,
                                      child: Row(
                                        children: <Widget>[
                                          GestureDetector(
                                            behavior:
                                                HitTestBehavior.translucent,
                                            onTap: () {
                                              setState(() {
                                                isAgree = !isAgree;
                                              });
                                            },
                                            child: Container(
                                              padding: EdgeInsets.only(
                                                  right: width(8),
                                                  top: width(2),
                                                  bottom: width(2)),
                                              child: Image.asset(
                                                SPClassImageUtil
                                                    .spFunGetImagePath(isAgree
                                                        ? 'select'
                                                        : 'select_un'),
                                                fit: BoxFit.contain,
                                                width: width(13),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: RichText(
                                              textAlign: TextAlign.start,
                                              text: TextSpan(
                                                  style: TextStyle(
                                                      fontSize: sp(12),
                                                      color: Color.fromRGBO(
                                                          255, 255, 255, 0.8)),
                                                  text: "登录即代表同意" +
                                                      SPClassApplicaion
                                                          .spProAppName,
                                                  children: <TextSpan>[
                                                    TextSpan(
                                                        text: "《用户协议》",
                                                        recognizer:
                                                            new TapGestureRecognizer()
                                                              ..onTap = () {
                                                                SPClassNavigatorUtils.spFunPushRoute(context,  AgreementPage(title:"用户协议",url:"../../assets/html/useragreement.html"));
                                                                // SPClassNavigatorUtils
                                                                //     .spFunPushRoute(
                                                                //         context,
                                                                //         SPClassWebPage(
                                                                //           "",
                                                                //           "用户协议",
                                                                //           spProLocalFile:
                                                                //               "assets/html/useragreement.html",
                                                                //         ));
                                                              }),
                                                    TextSpan(text: "和"),
                                                    TextSpan(
                                                        text: "《隐私政策》",
                                                        recognizer:
                                                            new TapGestureRecognizer()
                                                              ..onTap = () {
                                                                SPClassNavigatorUtils.spFunPushRoute(context,  AgreementPage(title:"隐私协议",url:"../../assets/html/privacy_score.html"));
                                                                // SPClassNavigatorUtils.spFunPushRoute(
                                                                //     context,
                                                                //     SPClassWebPage(
                                                                //         "",
                                                                //         "隐私协议",
                                                                //         spProLocalFile:
                                                                //             "assets/html/privacy_score.html"));
                                                              }),
                                                  ]),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: width(61),
                                ),
                                ///APP使用
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Image.asset(
                                      SPClassImageUtil.spFunGetImagePath(
                                          'dot_left'),
                                      fit: BoxFit.cover,
                                      width: width(46),
                                    ),
                                    SizedBox(
                                      width: width(6),
                                    ),
                                    Text(
                                      "其它登录方式",
                                      style: TextStyle(
                                          fontSize: sp(12),
                                          color: Colors.white),
                                    ),
                                    SizedBox(
                                      width: width(6),
                                    ),
                                    Image.asset(
                                      SPClassImageUtil.spFunGetImagePath(
                                          'dot_right'),
                                      fit: BoxFit.contain,
                                      width: width(46),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: width(15),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    // GestureDetector(
                                    //   child: Column(
                                    //     children: <Widget>[
                                    //       Container(
                                    //         padding: EdgeInsets.all(width(10)),
                                    //         decoration: ShapeDecoration(
                                    //             color: Colors.black45,
                                    //             shape: CircleBorder()),
                                    //         alignment: Alignment.center,
                                    //         child: Image.asset(
                                    //           SPClassImageUtil
                                    //               .spFunGetImagePath(
                                    //                   'ic_wx_login'),
                                    //           fit: BoxFit.contain,
                                    //           color: Colors.white,
                                    //           width: height(30),
                                    //         ),
                                    //       ),
                                    //       SizedBox(
                                    //         height: height(5),
                                    //       ),
                                    //       Text(
                                    //         "微信",
                                    //         style: TextStyle(
                                    //             fontSize: sp(12),
                                    //             color: Colors.white),
                                    //       ),
                                    //     ],
                                    //   ),
                                    //   onTap: () {
                                    //     if (!isAgree) {
                                    //       SPClassToastUtils.spFunShowToast(
                                    //           msg: "请阅读并勾选 用户协议 和 隐私政策 ");
                                    //       return;
                                    //     }
                                    //     fluwx.sendWeChatAuth(
                                    //         scope: "snsapi_userinfo",
                                    //         state: "wechat_sdk_demo_test");
                                    //   },
                                    // ),
                                    // SizedBox(
                                    //   width: width(20),
                                    // ),
                                    GestureDetector(
                                      child: Column(
                                        children: <Widget>[
                                          Container(
                                            padding: EdgeInsets.all(width(10)),
                                            decoration: ShapeDecoration(
                                                color: Colors.black45,
                                                shape: CircleBorder()),
                                            alignment: Alignment.center,
                                            child: Image.asset(
                                              spProLoginType == 1
                                                  ? SPClassImageUtil
                                                      .spFunGetImagePath(
                                                          'ic_code_login')
                                                  : SPClassImageUtil
                                                      .spFunGetImagePath(
                                                          'ic_pwd_login'),
                                              fit: BoxFit.contain,
                                              color: Colors.white,
                                              width: height(30),
                                            ),
                                          ),
                                          SizedBox(
                                            height: height(5),
                                          ),
                                          Text(
                                            spProLoginType == 0
                                                ? "密码登录"
                                                : "验证码登录",
                                            style: TextStyle(
                                                fontSize: sp(12),
                                                color: Colors.white),
                                          ),
                                        ],
                                      ),
                                      onTap: () {
                                        SPClassNavigatorUtils.spFunPushRoute(
                                            context, PasswordLogin());
                                      },
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: height(30),
                                ),
                              ],
                            ),
                          ),
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

  ///APP使用
  // void spFunDoLoginWx(String code) {
  //   SPClassApiManager.spFunGetInstance().spFunUserLoginByWx(
  //       context: context,
  //       spProWxCode: code,
  //       spProCallBack: SPClassHttpCallBack<SPClassUserLoginInfo>(
  //           spProOnSuccess: (loginInfo) {
  //         if (loginInfo.spProNeedBind) {
  //           SPClassNavigatorUtils.spFunPushRoute(
  //               context,
  //               SPClassVideoPhoneLoginPage(
  //                 spProVideoPlayerController: _videoPlayerController,
  //                 spProPhoneType: 0,
  //                 spProBindSid: loginInfo.spProBindSid,
  //               ));
  //         } else {
  //           SPClassApplicaion.spProUserLoginInfo = loginInfo;
  //           SPClassApplicaion.spFunSaveUserState();
  //           SPClassApplicaion.spFunInitUserState();
  //           SPClassApplicaion.spFunGetUserInfo();
  //           SPClassToastUtils.spFunShowToast(msg: "登录成功");
  //           SPClassGlobalNotification.spFunGetInstance().spFunInitWebSocket();
  //           SPClassApplicaion.spFunSavePushToken();
  //           Navigator.of(context).pop();
  //         }
  //       }));
  // }
  //
  // void spFunDoOneLogin() {
  //   SPClassDialogUtils.spFunShowLoadingDialog(context,
  //       barrierDismissible: true, content: "登录中");
  //   FlutterPhoneLogin.loginWithModel(success: (map) {
  //     Navigator.of(context).pop();
  //     SPClassApiManager.spFunGetInstance().spFunOneClickLogin(
  //         context: context,
  //         queryParameters: {
  //           "token": map["token"],
  //           "op_token": map["operatorToken"],
  //           "operator": map["operatorType"]
  //         },
  //         spProCallBack: SPClassHttpCallBack<SPClassUserLoginInfo>(
  //             spProOnSuccess: (userLogin) {
  //           SPClassApplicaion.spProUserLoginInfo = userLogin;
  //           SPClassApplicaion.spFunSaveUserState();
  //           SPClassApplicaion.spFunInitUserState();
  //           SPClassApplicaion.spFunGetUserInfo();
  //           SPClassToastUtils.spFunShowToast(msg: "登录成功");
  //           SPClassApplicaion.spFunSavePushToken();
  //           SPClassGlobalNotification.spFunGetInstance().spFunInitWebSocket();
  //           Navigator.of(context).pop();
  //         }));
  //   }, fail: (code) {
  //     Navigator.of(context).pop();
  //     if (Platform.isIOS) {
  //       if (code != 170204 && code != 170301) {
  //         SPClassToastUtils.spFunShowToast(
  //             msg: "一键登录失败:code" + code.toString());
  //         setState(() {
  //           spProOneLogin = false;
  //         });
  //       }
  //     } else {
  //       if (code != 0 && code != 1) {
  //         SPClassToastUtils.spFunShowToast(
  //             msg: "一键登录失败:code" + code.toString());
  //         setState(() {
  //           spProOneLogin = false;
  //         });
  //       }
  //     }
  //   });
  // }

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
        spProCodeType: "login",
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
        },onError: (v){},spProOnProgress: (v){}
        ),

    );
  }
}
