import 'dart:async';
import 'dart:io';

import 'package:changshengh5/api/CSClassApiManager.dart';
import 'package:changshengh5/api/CSClassHttpCallBack.dart';
import 'package:changshengh5/app/CSClassApplicaion.dart';
import 'package:changshengh5/app/CSClassGlobalNotification.dart';
import 'package:changshengh5/model/CSClassBaseModelEntity.dart';
import 'package:changshengh5/model/CSClassUserLoginInfo.dart';
import 'package:changshengh5/pages/common/CSClassDialogUtils.dart';
import 'package:changshengh5/pages/dialogs/agreement_page.dart';
import 'package:changshengh5/utils/CSClassCommonMethods.dart';
import 'package:changshengh5/utils/CSClassImageUtil.dart';
import 'package:changshengh5/utils/CSClassNavigatorUtils.dart';
import 'package:changshengh5/utils/CSClassToastUtils.dart';
import 'package:changshengh5/utils/colors.dart';
import 'package:changshengh5/widgets/CSClassToolBar.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import 'package:jverify/jverify.dart';
import 'package:fluwx/fluwx.dart' as fluwx;


import 'PasswordLogin.dart';
import 'CSClassVideoPhoneLoginPage.dart';

class CSClassVideoLoginPage extends StatefulWidget {
  CSClassVideoLoginPageState createState() => CSClassVideoLoginPageState();
}

class CSClassVideoLoginPageState extends State<CSClassVideoLoginPage>
    with WidgetsBindingObserver {
  int csProLoginType = 0; //0--验证码登录 1--密码登录 2==一键登录
  late VideoPlayerController _videoPlayerController;
  bool csProIsKeyBoardShow = false;
  bool csProIsShowPassWord = false;
  String csProPhoneNum = "";
  String csProVerCode = "";
  String csProPhonePwd = "";
  String csProWxCode ="";
  bool isAgree = false; //是否同意协议
  var csProWxListen;
  static bool csProOneLogin = false;
  int csProCurrentSecond = 0;
  Timer ?csProTimer;
 final Jverify jverify =  Jverify();

  late TextEditingController _textEditingController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _textEditingController = TextEditingController(text: csProPhoneNum);
    _videoPlayerController =
        VideoPlayerController.asset('assets/video/video_login.m4v')
          ..initialize().then((_) {
            // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
            setState(() {});
          });
    _videoPlayerController.setLooping(true);
    _videoPlayerController.play();
    WidgetsBinding.instance!.addObserver(this);
    // initPlatformState();
    csProWxListen = fluwx.weChatResponseEventHandler
        .distinct((a, b) => a == b)
        .listen((res) {
      if (res is fluwx.WeChatAuthResponse) {
        if (csProWxCode == null || (csProWxCode != res.code)) {
          csProWxCode = res.code!;
          csMethodDoLoginWx(res.code!);
        }
      }
    });
    initOneLogin();
    // FlutterPhoneLogin.preLogin((result) {
    //   if (result) {
    //     csProOneLogin = true;
    //     csProLoginType = 2;
    //   } else {
    //     csProOneLogin = false;
    //     csProLoginType = 0;
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
    if (csProTimer != null) {
      csProTimer?.cancel();
    }

    ///备注APP使用
    if (csProWxListen != null) {
      csProWxListen.cancel();
    }
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
                CSClassImageUtil.csMethodGetImagePath('login_bg'),
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
              ),
            ),
            // BackdropFilter(
            //   filter: new ImageFilter.blur(
            //       sigmaX: csProIsKeyBoardShow ? 25 : 0,
            //       sigmaY: csProIsKeyBoardShow ? 25 : 0),
            //   child: new Container(
            //     width: ScreenUtil.screenWidth,
            //     height: ScreenUtil.screenHeight,
            //     color: Colors.black45,
            //   ),
            // ),
            Container(
              child: Column(
                children: <Widget>[
                  CSClassToolBar(
                    context,
                    csProBgColor: Colors.transparent,
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
                              (csProLoginType == 0 || csProLoginType == 2)
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
                                            CSClassImageUtil.csMethodGetImagePath(
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
                                              csProPhoneNum = value;
                                            },
                                          ))
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: width(16),
                                    ),
                                    csProLoginType == 1
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
                                                        CSClassImageUtil
                                                            .csMethodGetImagePath(
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
                                                            //     csProCurrentSecond > 0
                                                            //         ? "已发送" +
                                                            //         csProCurrentSecond
                                                            //             .toString() +
                                                            //         "s"
                                                            //         : "发送验证码",
                                                            //     style: TextStyle(
                                                            //         color:
                                                            //         Colors.white),
                                                            //   ),
                                                            //   onPressed: () =>
                                                            //   {csMethodDoSendCode()},
                                                            // ),
                                                          ),
                                                          onChanged: (value) {
                                                            setState(() {
                                                              csProVerCode =
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
                                                  csMethodDoSendCode();
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
                                                    csProCurrentSecond > 0
                                                        ? "已发送" +
                                                            csProCurrentSecond
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
                                                  csProPhoneNum.length == 11 &&
                                                          (csProVerCode
                                                                  .isNotEmpty ||
                                                              csProPhonePwd
                                                                  .isNotEmpty)
                                                      ? MyColors.main1
                                                      : Colors.transparent,
                                              border: Border.all(
                                                  color: csProPhoneNum.length ==
                                                              11 &&
                                                          (csProVerCode
                                                                  .isNotEmpty ||
                                                              csProPhonePwd
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
                                                color: csProPhoneNum.length ==
                                                            11 &&
                                                        (csProVerCode
                                                                .isNotEmpty ||
                                                            csProPhonePwd
                                                                .isNotEmpty)
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
                                          if (csProLoginType == 0 &&
                                              csProVerCode.isEmpty) {
                                            CSClassToastUtils.csMethodShowToast(
                                                msg: "请输入验证码");
                                            return;
                                          }
                                          if (csProLoginType == 1 &&
                                              csProPhonePwd.isEmpty) {
                                            CSClassToastUtils.csMethodShowToast(
                                                msg: "请输入密码");
                                            return;
                                          }
                                          if (!isAgree) {
                                            CSClassToastUtils.csMethodShowToast(
                                                msg: "请阅读并勾选 用户协议 和 隐私政策 ");
                                            return;
                                          }
                                          if (csProLoginType == 0) {
                                            if (csProVerCode.length == 0) {
                                              CSClassToastUtils.csMethodShowToast(
                                                  msg: "请输入验证码");
                                              return;
                                            }
                                            CSClassApiManager.csMethodGetInstance()
                                                .csMethodLoginByCode(
                                                    csProPhoneNumber:
                                                        csProPhoneNum,
                                                    csProPhoneCode:
                                                        csProVerCode,
                                                    csProInviteCode: "",
                                                    context: context,
                                                    csProCallBack:
                                                        CSClassHttpCallBack<
                                                                CSClassUserLoginInfo>(
                                                            csProOnSuccess:
                                                                (loginInfo) {
                                                      CSClassApplicaion
                                                              .csProUserLoginInfo =
                                                          loginInfo;
                                                      CSClassApplicaion
                                                          .csMethodSaveUserState();
                                                      CSClassApplicaion
                                                          .csMethodInitUserState();
                                                      CSClassApplicaion
                                                          .csMethodGetUserInfo();
                                                      CSClassGlobalNotification
                                                              .csMethodGetInstance()
                                                          ?.csMethodInitWebSocket();
                                                      // CSClassApplicaion
                                                      //     .csMethodSavePushToken();
                                                      CSClassApplicaion
                                                          .csProEventBus
                                                          .fire(
                                                              "login:gamelist");
                                                      Navigator.of(context)
                                                          .pop();
                                                    },onError: (v){},csProOnProgress: (v){},
                                                    ));
                                          }
                                        }
                                        ),

                                    csProOneLogin
                                        ? GestureDetector(
                                            child: Container(
                                              margin: EdgeInsets.only(
                                                  top: width(12)),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          400),
                                                  color: MyColors.main1),
                                              height: width(46),
                                              alignment: Alignment.center,
                                              child: Text(
                                                "本机号码一键登录",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: sp(16)),
                                              ),
                                            ),
                                            onTap: () {
                                             csMethodDoOneLogin();
                                            })
                                        : Container(),

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
                                                CSClassImageUtil
                                                    .csMethodGetImagePath(isAgree
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
                                                      CSClassApplicaion
                                                          .csProAppName,
                                                  children: <TextSpan>[
                                                    TextSpan(
                                                        text: "《用户协议》",
                                                        recognizer:
                                                            new TapGestureRecognizer()
                                                              ..onTap = () {
                                                                CSClassNavigatorUtils.csMethodPushRoute(context,  AgreementPage(title:"用户协议",));
                                                                // CSClassNavigatorUtils
                                                                //     .csMethodPushRoute(
                                                                //         context,
                                                                //         CSClassWebPage(
                                                                //           "",
                                                                //           "用户协议",
                                                                //           csProLocalFile:
                                                                //               "assets/html/useragreement.html",
                                                                //         ));
                                                              }),
                                                    TextSpan(text: "和"),
                                                    TextSpan(
                                                        text: "《隐私政策》",
                                                        recognizer:
                                                            new TapGestureRecognizer()
                                                              ..onTap = () {
                                                                CSClassNavigatorUtils.csMethodPushRoute(context,  AgreementPage(title:"隐私协议",));
                                                                // CSClassNavigatorUtils.csMethodPushRoute(
                                                                //     context,
                                                                //     CSClassWebPage(
                                                                //         "",
                                                                //         "隐私协议",
                                                                //         csProLocalFile:
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
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Image.asset(
                                      CSClassImageUtil.csMethodGetImagePath(
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
                                      CSClassImageUtil.csMethodGetImagePath(
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
                                    GestureDetector(
                                      child: Column(
                                        children: <Widget>[
                                          Container(
//                                            padding: EdgeInsets.all(width(10)),
//                                            decoration: ShapeDecoration(
//                                                color: Colors.black45,
//                                                shape: CircleBorder()),
                                            alignment: Alignment.center,
                                            child: Image.asset(
                                              CSClassImageUtil
                                                  .csMethodGetImagePath(
                                                      'cs_wx_login'),
                                              fit: BoxFit.contain,
                                              color: Colors.white,
                                              width: width(40),
                                            ),
                                          ),
                                          SizedBox(
                                            height: height(5),
                                          ),
                                          Text(
                                            "微信",
                                            style: TextStyle(
                                                fontSize: sp(12),
                                                color: Colors.white),
                                          ),
                                        ],
                                      ),
                                      onTap: () {
                                        if (!isAgree) {
                                          CSClassToastUtils.csMethodShowToast(
                                              msg: "请阅读并勾选 用户协议 和 隐私政策 ");
                                          return;
                                        }
                                        fluwx.sendWeChatAuth(
                                            scope: "snsapi_userinfo",
                                            state: "wechat_sdk_demo_test");
                                      },
                                    ),
//                                     SizedBox(
//                                       width: width(20),
//                                     ),
//                                     GestureDetector(
//                                       child: Column(
//                                         children: <Widget>[
//                                           Container(
// //                                            padding: EdgeInsets.all(width(10)),
// //                                            decoration: ShapeDecoration(
// //                                                color: Colors.black45,
// //                                                shape: CircleBorder()),
//                                             alignment: Alignment.center,
//                                             child: Image.asset(
//                                               CSClassImageUtil
//                                                   .csMethodGetImagePath(
//                                                   'cs_apple_login'),
//                                               fit: BoxFit.contain,
//                                               color: Colors.white,
//                                               width: width(40),
//                                             ),
//                                           ),
//                                           SizedBox(
//                                             height: height(5),
//                                           ),
//                                           Text(
//                                             "苹果",
//                                             style: TextStyle(
//                                                 fontSize: sp(12),
//                                                 color: Colors.white),
//                                           ),
//                                         ],
//                                       ),
//                                       onTap: () {
//                                         if (!isAgree) {
//                                           CSClassToastUtils.csMethodShowToast(
//                                               msg: "请阅读并勾选 用户协议 和 隐私政策 ");
//                                           return;
//                                         }
//                                         SignInApple.clickAppleSignIn();
//                                       },
//                                     ),
                                    SizedBox(
                                      width: width(20),
                                    ),
                                    GestureDetector(
                                      child: Column(
                                        children: <Widget>[
                                          Container(
//                                            padding: EdgeInsets.all(width(10)),
//                                            decoration: ShapeDecoration(
//                                                color: Colors.black45,
//                                                shape: CircleBorder()),
                                            alignment: Alignment.center,
                                            child: Image.asset(
                                              csProLoginType == 1
                                                  ? CSClassImageUtil
                                                      .csMethodGetImagePath(
                                                          'cs_code_login')
                                                  : CSClassImageUtil
                                                      .csMethodGetImagePath(
                                                          'cs_pwd_login'),
                                              fit: BoxFit.contain,
                                              color: Colors.white,
                                              width: width(40),
                                            ),
                                          ),
                                          SizedBox(
                                            height: height(5),
                                          ),
                                          Text(
                                            csProLoginType == 0
                                                ? "密码登录"
                                                : "验证码登录",
                                            style: TextStyle(
                                                fontSize: sp(12),
                                                color: Colors.white),
                                          ),
                                        ],
                                      ),
                                      onTap: () {
                                        CSClassNavigatorUtils.csMethodPushRoute(
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

  void csMethodDoLoginWx(String code) {
    CSClassApiManager.csMethodGetInstance().csMethodUserLoginByWx(
        context: context,
        csProWxCode: code,
        csProCallBack: CSClassHttpCallBack<CSClassUserLoginInfo>(
            csProOnSuccess: (loginInfo) {
          if (loginInfo.csProNeedBind!) {
            CSClassNavigatorUtils.csMethodPushRoute(
                context,
                CSClassVideoPhoneLoginPage(
                  csProVideoPlayerController: _videoPlayerController,
                  csProPhoneType: 0,
                  csProBindSid: loginInfo.csProBindSid,
                  csProLoginType: 0,
                ));
          } else {
            CSClassApplicaion.csProUserLoginInfo = loginInfo;
            CSClassApplicaion.csMethodSaveUserState();
            CSClassApplicaion.csMethodInitUserState();
            CSClassApplicaion.csMethodGetUserInfo();
            CSClassToastUtils.csMethodShowToast(msg: "登录成功");
            CSClassGlobalNotification.csMethodGetInstance()!.csMethodInitWebSocket();
            CSClassApplicaion.csMethodSavePushToken();
            Navigator.of(context).pop();
          }
        },onError: (e){},csProOnProgress: (v){}
        ));
  }

  // Future<void> initPlatformState() async {
  //   SignInApple.handleAppleSignInCallBack(onCompleteWithSignIn: (AppleIdUser user) async {
  //
  //     print('苹果登陆成功：_name:${user.familyName} ==_mail: ${user.mail} == _userIdentify:${user.userIdentifier} ==_authorizationCode: ${user.authorizationCode} ');
  //
  //     CSClassApiManager.csMethodGetInstance().csMethodUserLoginByApple(context: context,csProAppleId: user.userIdentifier,csProCallBack: CSClassHttpCallBack<CSClassUserLoginInfo>(
  //         csProOnSuccess: (loginInfo){
  //           if (loginInfo.csProNeedBind!) {
  //             CSClassNavigatorUtils.csMethodPushRoute(context, CSClassVideoPhoneLoginPage(csProVideoPlayerController:_videoPlayerController,csProPhoneType: 0,csProBindSid: loginInfo.csProBindSid,csProLoginType: 1,));
  //           } else {
  //             CSClassApplicaion.csProUserLoginInfo = loginInfo;
  //             CSClassApplicaion.csMethodSaveUserState();
  //             CSClassApplicaion.csMethodInitUserState();
  //             CSClassApplicaion.csMethodGetUserInfo();
  //             CSClassToastUtils.csMethodShowToast(msg: "登录成功");
  //             CSClassGlobalNotification.csMethodGetInstance()!.csMethodInitWebSocket();
  //             CSClassApplicaion.csMethodSavePushToken();
  //             Navigator.of(context).pop();
  //           }
  //         },onError: (e){},csProOnProgress: (v){}
  //     ));
  //
  //   }, onCompleteWithError: (AppleSignInErrorCode code) async {
  //     var errorMsg = "unknown";
  //     switch (code) {
  //       case AppleSignInErrorCode.canceled:
  //         errorMsg = "user canceled request";
  //         break;
  //       case AppleSignInErrorCode.failed:
  //         errorMsg = "request fail";
  //         break;
  //       case AppleSignInErrorCode.invalidResponse:
  //         errorMsg = "request invalid response";
  //         break;
  //       case AppleSignInErrorCode.notHandled:
  //         errorMsg = "request not handled";
  //         break;
  //       case AppleSignInErrorCode.unknown:
  //         errorMsg = "request fail unknown";
  //         break;
  //     }
  //     print(errorMsg);
  //   });
  // }


  void initOneLogin(){
    String _token='';
    String _result='';

   jverify.isInitSuccess().then((map) {
     print('初始化：$map');
     bool result = map['result'];
     setState(() {
       if (result) {
         jverify.checkVerifyEnable().then((map) {
           bool result = map['result'];
           if (result) {
             csProOneLogin =true;
             // jverify.getToken().then((map) {
             //   int code = map['code'];
             //   _token = map['message'];
             //   String operator = map['operator'];
             //   setState(() {
             //     _result = "[$code] message = $_token, operator = $operator";
             //   });
             // });
           } else {
             // setState(() {
             //   _hideLoading();
             //   _result = "[2016],msg = 当前网络环境不支持认证";
             // });
           }
         });
       } else {
         _result = "sdk 初始换失败";
       }
     });
   });
  }

 void csMethodDoOneLogin() {
   JVUIConfig uiConfig = JVUIConfig();
   // uiConfig.privacyState = false; //设置默认勾选
   uiConfig.privacyCheckboxSize = 12;
   uiConfig.privacyTextSize = 12;
   uiConfig.privacyOffsetX = 30; // 距离底部距离
   CSClassDialogUtils.csMethodShowLoadingDialog(context,
           barrierDismissible: true, content: "登录中");
   jverify.setCustomAuthorizationView(true, uiConfig,
       landscapeConfig: uiConfig, );
   jverify.addLoginAuthCallBackListener((event) {
     print(
         "通过添加监听，获取到 loginAuthSyncApi 接口返回数据，code=${event.code},message = ${event.message},operator = ${event.operator}");
     Navigator.of(context).pop();
     CSClassApiManager.csMethodGetInstance().csMethodOneClickLogin(
         context: context,
         queryParameters: {
           "token": event.message,
           "op_token": '',
           "operator": event.operator
         },
         csProCallBack: CSClassHttpCallBack<CSClassUserLoginInfo>(
             csProOnSuccess: (userLogin) {
               CSClassApplicaion.csProUserLoginInfo = userLogin;
               CSClassApplicaion.csMethodSaveUserState();
               CSClassApplicaion.csMethodInitUserState();
               CSClassApplicaion.csMethodGetUserInfo();
               CSClassToastUtils.csMethodShowToast(msg: "登录成功");
               CSClassApplicaion.csMethodSavePushToken();
               CSClassGlobalNotification.csMethodGetInstance()?.csMethodInitWebSocket();
               Navigator.of(context).pop();
             },onError: (e){},csProOnProgress: (v){}
         ));
   });
   jverify.loginAuthSyncApi(autoDismiss: true);
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
        csProCodeType: "login",
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
        ),

    );
  }
}
