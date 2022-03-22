import 'package:changshengh5/api/CSClassApiManager.dart';
import 'package:changshengh5/api/CSClassHttpCallBack.dart';
import 'package:changshengh5/app/CSClassApplicaion.dart';
import 'package:changshengh5/app/CSClassGlobalNotification.dart';
import 'package:changshengh5/model/CSClassUserLoginInfo.dart';
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
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:video_player/video_player.dart';

import 'CSClassVideoPhoneLoginPage.dart';


class PasswordLogin extends StatefulWidget {

  @override
  _PasswordLoginState createState() => _PasswordLoginState();
}

class _PasswordLoginState extends State<PasswordLogin> {
  String csProPhoneNum = "";
  String csProPhonePwd = "";
  bool isAgree = false; //是否同意协议
  bool csProIsShowPassWord = false;
  late VideoPlayerController _videoPlayerController;
  late TextEditingController _textEditingController;

  @override
  void initState() {
    _textEditingController = TextEditingController(text: csProPhoneNum);

    _videoPlayerController =
    VideoPlayerController.asset('assets/video/video_login.m4v')
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
    _videoPlayerController.setLooping(true);
    _videoPlayerController.play();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        child: Stack(
          children: <Widget>[
            Container(
                child: _videoPlayerController.value.isInitialized
                    ? Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width/_videoPlayerController.value.aspectRatio,
                  child: VideoPlayer(_videoPlayerController),
                )
                    : SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height)),
            Container(
              child: Image.asset(
                CSClassImageUtil
                    .csMethodGetImagePath(
                    'login_bg'),
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
                              "密码登录",
                              style: TextStyle(
                                  fontSize: sp(20), color: Colors.white),
                            ),
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[

                                Column(
                                  children: <Widget>[
                                    Container(
                                      decoration: BoxDecoration(
                                        // color: Color(0x4DDDDDDD),
                                          border: Border(bottom: BorderSide(color: Colors.white,width: 0.5))
                                        // borderRadius:
                                        // BorderRadius.circular(400),

                                      ),
                                      height: height(48),
                                      child: Row(
                                        children: <Widget>[
                                          // Text(
                                          //   "+86",
                                          //   style: GoogleFonts.roboto(
                                          //       fontSize: sp(18),
                                          //       textStyle: TextStyle(
                                          //           color: Colors.white,
                                          //           textBaseline: TextBaseline
                                          //               .alphabetic)),
                                          // ),
                                          Image.asset(
                                            CSClassImageUtil.csMethodGetImagePath("phone"),
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
                                                    fontSize: sp(18),
                                                    color: Colors.white,
                                                    textBaseline: TextBaseline
                                                        .alphabetic),
                                                decoration: InputDecoration(
                                                  hintText: "请输入手机号",
                                                  hintStyle: TextStyle(
                                                      color: Color(0xFFC6C6C6),
                                                      fontSize: sp(14)),
                                                  border: InputBorder.none,
                                                ),
                                                inputFormatters: <
                                                    TextInputFormatter>[
                                                  // WhitelistingTextInputFormatter
                                                  //     .digitsOnly, //只输入数字
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
                                    Container(
                                      decoration: BoxDecoration(
                                        // color: Color(0x4DDDDDDD),
                                          border: Border(bottom: BorderSide(color: Colors.white,width: 0.5))
                                        // borderRadius:
                                        // BorderRadius.circular(400),

                                      ),
                                      height: height(48),
                                      child: Row(
                                        children: <Widget>[
                                          Image.asset(
                                            CSClassImageUtil.csMethodGetImagePath("password"),
                                            width: width(24),
                                          ),
                                          SizedBox(
                                            width: width(8),
                                          ),
                                          Expanded(
                                              child: TextField(
                                                obscureText:
                                                !csProIsShowPassWord,
                                                textAlign: TextAlign.left,
                                                maxLines: 1,
                                                style: TextStyle(
                                                    fontSize: sp(18),
                                                    color: Colors.white,
                                                    textBaseline: TextBaseline
                                                        .alphabetic),
                                                decoration: InputDecoration(
                                                  hintText: "请输入密码",
                                                  hintStyle: TextStyle(
                                                      color: Color(0xFFC6C6C6),
                                                      fontSize: sp(14)),
                                                  border: InputBorder.none,
                                                  suffixIcon: IconButton(
                                                    padding: EdgeInsets.only(
                                                        right: width(24)),
                                                    icon: Image
                                                        .asset(
                                                      !csProIsShowPassWord
                                                          ? CSClassImageUtil
                                                          .csMethodGetImagePath(
                                                          'ic_login_uneye')
                                                          : CSClassImageUtil
                                                          .csMethodGetImagePath(
                                                          'ic_eye_pwd'),
                                                      fit: BoxFit.contain,
                                                      color: Colors.white,
                                                      width: width(18),
                                                      height: width(18),
                                                    ),
                                                    onPressed: () =>
                                                        setState(() {
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
                                    /// 登录按钮
                                    GestureDetector(
                                        child: Container(
                                          margin:
                                          EdgeInsets.only(top: height(25)),
                                          decoration: BoxDecoration(
                                              color: csProPhoneNum.length == 11&&csProPhonePwd.isNotEmpty
                                                  ?MyColors.main1:Colors.transparent,
                                              border:Border.all(color: csProPhoneNum.length == 11&&csProPhonePwd.isNotEmpty
                                                  ?MyColors.main1:MyColors.grey_66,width: 0.5),
                                              borderRadius:
                                              BorderRadius.circular(400)),
                                          height: width(46),
                                          alignment: Alignment.center,
                                          child: Text(
                                            "登录",
                                            style: TextStyle(
                                                color:csProPhoneNum.length == 11&&csProPhonePwd.isNotEmpty
                                                    ?MyColors.white:MyColors.grey_66,
                                                fontSize: sp(16)),
                                          ),
                                        ),
                                        onTap: () {
                                          if (csProPhoneNum.length != 11) {
                                            CSClassToastUtils.csMethodShowToast(
                                                msg: "请输入正确11位手机号码!");
                                            return;
                                          }

                                          if (csProPhonePwd.isEmpty) {
                                            CSClassToastUtils.csMethodShowToast(
                                                msg: "请输入密码");
                                            return;
                                          }
                                          if(!isAgree){
                                            CSClassToastUtils.csMethodShowToast(
                                                msg: "请阅读并勾选 用户协议 和 隐私政策 ");
                                            return;
                                          }
                                          CSClassApiManager().csMethodUserLogin(
                                              queryParameters: {
                                                "username": csProPhoneNum
                                              },
                                              csProBodyParameters: {
                                                "pwd": csProPhonePwd
                                              },
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
                                                    CSClassApplicaion
                                                        .csMethodSavePushToken();
                                                    CSClassApplicaion
                                                        .csProEventBus
                                                        .fire("login:gamelist");
                                                    CSClassNavigatorUtils.csMethodPopAll(context);
                                                  },onError: (v){},csProOnProgress: (v){}
                                                  )
                                          );}),
                                    Container(
                                      margin: EdgeInsets.only(
                                          top: width(16)),
                                      alignment: Alignment.center,
                                      child: GestureDetector(
                                        child: Text(
                                          "忘记密码",
                                          style: TextStyle(
                                            fontSize: sp(14),
                                            color: Colors.white,
                                            decoration:
                                            TextDecoration.underline,
                                          ),
                                        ),
                                        onTap: () {
                                          CSClassNavigatorUtils
                                              .csMethodPushRoute(
                                              context,
                                              CSClassVideoPhoneLoginPage(
                                                csProVideoPlayerController:
                                                _videoPlayerController,
                                                csProPhoneType: 1,
                                              ));
                                        },
                                      ),
                                    ),

                                    ///协议
                                    Container(
                                      margin: EdgeInsets.only(bottom: width(20),top: width(48)),
                                      alignment: Alignment.center,
                                      child: Row(
                                        children: <Widget>[
                                          GestureDetector(
                                            behavior: HitTestBehavior.translucent,
                                            onTap: (){
                                              setState(() {
                                                isAgree = !isAgree;
                                              });
                                            },
                                            child: Container(
                                              padding: EdgeInsets.only(right: width(8),top: width(2),bottom: width(2)),
                                              child:  Image.asset(
                                                CSClassImageUtil
                                                    .csMethodGetImagePath(
                                                    isAgree?'select':'select_un'),
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
                                                      color: Color.fromRGBO(255, 255, 255, 0.8)
                                                  ),
                                                  text: "登录即代表同意" +
                                                      CSClassApplicaion.csProAppName,
                                                  children: <TextSpan>[
                                                    TextSpan(
                                                        text: "《用户协议》",
                                                        recognizer:
                                                        new TapGestureRecognizer()
                                                          ..onTap = () {
                                                            CSClassNavigatorUtils.csMethodPushRoute(context,  AgreementPage(title:"用户协议",));
                                                            // CSClassNavigatorUtils
                                                            //     .csMethodPushRoute(
                                                            //     context,
                                                            //     CSClassWebPage(
                                                            //       "",
                                                            //       "用户协议",
                                                            //       csProLocalFile: "assets/html/useragreement.html",
                                                            //     ));
                                                          }),
                                                    TextSpan(text: "和"),
                                                    TextSpan(
                                                        text: "《隐私政策》",
                                                        recognizer:
                                                        new TapGestureRecognizer()
                                                          ..onTap = () {
                                                            CSClassNavigatorUtils.csMethodPushRoute(context,  AgreementPage(title:"隐私协议",));

                                                            // CSClassNavigatorUtils
                                                            //     .csMethodPushRoute(
                                                            //     context,
                                                            //     CSClassWebPage(
                                                            //         "",
                                                            //         "隐私协议",
                                                            //         csProLocalFile:
                                                            //         "assets/html/privacy_score.html"));
                                                          }),
                                                  ]),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
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

  @override
  void dispose() {
    _videoPlayerController.dispose();
    // TODO: implement dispose
    super.dispose();
  }
}
