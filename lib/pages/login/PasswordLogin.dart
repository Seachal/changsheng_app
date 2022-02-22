import 'package:changshengh5/api/SPClassApiManager.dart';
import 'package:changshengh5/api/SPClassHttpCallBack.dart';
import 'package:changshengh5/app/SPClassApplicaion.dart';
import 'package:changshengh5/app/SPClassGlobalNotification.dart';
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

import 'SPClassVideoPhoneLoginPage.dart';


class PasswordLogin extends StatefulWidget {

  @override
  _PasswordLoginState createState() => _PasswordLoginState();
}

class _PasswordLoginState extends State<PasswordLogin> {
  String spProPhoneNum = "";
  String spProPhonePwd = "";
  bool isAgree = false; //是否同意协议
  bool spProIsShowPassWord = false;
  late VideoPlayerController _videoPlayerController;
  late TextEditingController _textEditingController;

  @override
  void initState() {
    _textEditingController = TextEditingController(text: spProPhoneNum);

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
                SPClassImageUtil
                    .spFunGetImagePath(
                    'login_bg'),
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
                                            SPClassImageUtil.spFunGetImagePath("phone"),
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
                                                  spProPhoneNum = value;
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
                                            SPClassImageUtil.spFunGetImagePath("password"),
                                            width: width(24),
                                          ),
                                          SizedBox(
                                            width: width(8),
                                          ),
                                          Expanded(
                                              child: TextField(
                                                obscureText:
                                                !spProIsShowPassWord,
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
                                                    onPressed: () =>
                                                        setState(() {
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
                                    ),
                                    /// 登录按钮
                                    GestureDetector(
                                        child: Container(
                                          margin:
                                          EdgeInsets.only(top: height(25)),
                                          decoration: BoxDecoration(
                                              color: spProPhoneNum.length == 11&&spProPhonePwd.isNotEmpty
                                                  ?MyColors.main1:Colors.transparent,
                                              border:Border.all(color: spProPhoneNum.length == 11&&spProPhonePwd.isNotEmpty
                                                  ?MyColors.main1:MyColors.grey_66,width: 0.5),
                                              borderRadius:
                                              BorderRadius.circular(400)),
                                          height: width(46),
                                          alignment: Alignment.center,
                                          child: Text(
                                            "登录",
                                            style: TextStyle(
                                                color:spProPhoneNum.length == 11&&spProPhonePwd.isNotEmpty
                                                    ?MyColors.white:MyColors.grey_66,
                                                fontSize: sp(16)),
                                          ),
                                        ),
                                        onTap: () {
                                          if (spProPhoneNum.length != 11) {
                                            SPClassToastUtils.spFunShowToast(
                                                msg: "请输入正确11位手机号码!");
                                            return;
                                          }

                                          if (spProPhonePwd.isEmpty) {
                                            SPClassToastUtils.spFunShowToast(
                                                msg: "请输入密码");
                                            return;
                                          }
                                          if(!isAgree){
                                            SPClassToastUtils.spFunShowToast(
                                                msg: "请阅读并勾选 用户协议 和 隐私政策 ");
                                            return;
                                          }
                                          SPClassApiManager().spFunUserLogin(
                                              queryParameters: {
                                                "username": spProPhoneNum
                                              },
                                              spProBodyParameters: {
                                                "pwd": spProPhonePwd
                                              },
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
                                                        .fire("login:gamelist");
                                                    SPClassNavigatorUtils.spFunPopAll(context);
                                                  },onError: (v){},spProOnProgress: (v){}
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
                                          SPClassNavigatorUtils
                                              .spFunPushRoute(
                                              context,
                                              SPClassVideoPhoneLoginPage(
                                                spProVideoPlayerController:
                                                _videoPlayerController,
                                                spProPhoneType: 1,
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
                                                SPClassImageUtil
                                                    .spFunGetImagePath(
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
                                                      SPClassApplicaion.spProAppName,
                                                  children: <TextSpan>[
                                                    TextSpan(
                                                        text: "《用户协议》",
                                                        recognizer:
                                                        new TapGestureRecognizer()
                                                          ..onTap = () {
                                                            SPClassNavigatorUtils.spFunPushRoute(context,  AgreementPage(title:"用户协议",url:"../../assets/html/useragreement.html"));
                                                            // SPClassNavigatorUtils
                                                            //     .spFunPushRoute(
                                                            //     context,
                                                            //     SPClassWebPage(
                                                            //       "",
                                                            //       "用户协议",
                                                            //       spProLocalFile: "assets/html/useragreement.html",
                                                            //     ));
                                                          }),
                                                    TextSpan(text: "和"),
                                                    TextSpan(
                                                        text: "《隐私政策》",
                                                        recognizer:
                                                        new TapGestureRecognizer()
                                                          ..onTap = () {
                                                            SPClassNavigatorUtils.spFunPushRoute(context,  AgreementPage(title:"隐私协议",url:"../../assets/html/privacy_score.html"));

                                                            // SPClassNavigatorUtils
                                                            //     .spFunPushRoute(
                                                            //     context,
                                                            //     SPClassWebPage(
                                                            //         "",
                                                            //         "隐私协议",
                                                            //         spProLocalFile:
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
