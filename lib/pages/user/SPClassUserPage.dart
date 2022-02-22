import 'dart:io';

import 'package:changshengh5/app/SPClassApplicaion.dart';
import 'package:changshengh5/pages/competition/scheme/SPClassExpertApplyPage.dart';
import 'package:changshengh5/pages/user/scheme/bug/SPClassMyBuySchemePage.dart';
import 'package:changshengh5/pages/user/scheme/follow/SPClassMyFollowSchemePage.dart';
import 'package:changshengh5/pages/user/setting/SPClassSettingPage.dart';
import 'package:changshengh5/pages/user/systemMsg/SPClassSystemMsgPageState.dart';
import 'package:changshengh5/untils/SPClassCommonMethods.dart';
import 'package:changshengh5/untils/SPClassImageUtil.dart';
import 'package:changshengh5/untils/SPClassNavigatorUtils.dart';
import 'package:changshengh5/untils/SPClassStringUtils.dart';
import 'package:changshengh5/untils/SPClassToastUtils.dart';
import 'package:changshengh5/untils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'FollowExpertPage.dart';
import 'SPClassContactPage.dart';
import 'SPClassFeedbackPage.dart';
import 'SPClassNewUserWalFarePage.dart';
import 'SPClassRechargeDiamondPage.dart';
import 'about/SPClassAboutUsPage.dart';
import 'info/SPClassUserInfoPage.dart';


class SPClassUserPage extends StatefulWidget {
  @override
  SPClassUserPageState createState() => SPClassUserPageState();
}

class SPClassUserPageState extends State<SPClassUserPage>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  var spProMyTitles = ["已购方案", "关注专家","关注方案", '专家入驻'];
  var spProMyTitleImages = ["bug","follow_expert", "follow",'expert_apply'];
  var spProOtherTitles = [
    // "邀请好友", web没有分享
    "新人福利",
    /*"抽奖",*/
    "系统消息",
    "联系客服",
    "关于我们",
    "意见反馈",
    "设置"
  ];
  var spProOtherImages = [
    // "invite", web没有分享
    "new",
/*"turntable",*/
    "sys",
    "contact",
    "about",
    "feedback",
    "setting"
  ];
  var spProUserSubscription;
  int spProSeqNum = 0;
  AnimationController ?spProScaleAnimation;
  bool spProIsSignIn = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SPClassApplicaion.spFunGetUserInfo(isFire: false);
    spProUserSubscription =
        SPClassApplicaion.spProEventBus.on<String>().listen((event) {
      if (event == "userInfo") {
        // getSeqNum();
        if (SPClassApplicaion.spProUserLoginInfo!.spProExpertVerifyStatus == "1") {
          spProMyTitles.remove("专家入驻");
          spProMyTitles.remove("我的发布");
          spProMyTitleImages.remove("expert_apply");
          spProMyTitles.add("我的发布");
          spProMyTitleImages.add("send");
        } else {
          spProMyTitles.remove("我的发布");
          spProMyTitles.remove("专家入驻");
          spProMyTitleImages.remove("expert_apply");
          spProMyTitles.add("专家入驻");
          spProMyTitleImages.add("expert_apply");
        }
        if (mounted) {
          setState(() {});
        }
      }
    });

    if (!SPClassApplicaion.spProShowMenuList.contains("home")) {
      spProMyTitles.remove("已购方案");
      spProMyTitles.remove("关注方案");
      spProMyTitleImages.remove("bug");
      spProMyTitleImages.remove("follow");
      //spProOtherTitles.remove("邀请好友");
      spProOtherTitles.remove("新人福利");
      //spProOtherImages.remove("invite");
      spProOtherImages.remove("new");
    }

    if (!SPClassApplicaion.spProShowMenuList.contains("expert")) {
      spProMyTitles.remove("关注专家");
      spProMyTitles.remove("专家入驻");
      spProMyTitleImages.remove("follow_expert");
      spProMyTitleImages.remove("expert_apply");
    }

    if (SPClassApplicaion.spProUserLoginInfo!.spProExpertVerifyStatus == "1") {
      spProMyTitles.remove("专家入驻");
      spProMyTitleImages.remove("expert_apply");
      spProMyTitles.add("我的发布");
      spProMyTitleImages.add("expert_apply");
    }
    //
    // if (Platform.isIOS) {
    //   spProMyTitles.remove("已购方案");
    //   spProMyTitleImages.remove("bug");
    //   spProOtherTitles.remove("邀请好友");
    //   spProOtherTitles.remove("新人福利");
    //   spProOtherImages.remove("invite");
    //   spProOtherImages.remove("new");
    //   spProOtherTitles.remove("抽奖");
    //   spProOtherImages.remove("turntable");
    // }

    spProScaleAnimation = AnimationController(
        duration: const Duration(milliseconds: 600),
        reverseDuration: const Duration(milliseconds: 600),
        vsync: this,
        lowerBound: 1.0,
        upperBound: 1.1);
    spProScaleAnimation!.repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Color(0xFFF7F7F7)
            ),
            Positioned(
              left: 0,
              right: 0,
              top: 0,
              child: Image.asset(
                SPClassImageUtil.spFunGetImagePath("zhuanjiabg"),
                width: MediaQuery.of(context).size.width,
                height: width(180),
                fit: BoxFit.fill,
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              left: 0,
              bottom: 0,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    AppBar(
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      title: Text("个人中心",
                          style:
                              TextStyle(fontSize: sp(19), color: Colors.white)),
                      centerTitle: true,
                    ),
                    GestureDetector(
                      child: Row(
                        children: <Widget>[
                          SizedBox(
                            width: width(15),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.white, width: width(2)),
                                borderRadius:
                                    BorderRadius.circular(width(27.5))),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(width(25.5)),
                              child:
                                  (!SPClassApplicaion.spFunIsExistUserInfo() ||
                                          SPClassApplicaion.spProUserInfo!
                                              .spProAvatarUrl.isEmpty)
                                      ? Image.asset(
                                          SPClassImageUtil.spFunGetImagePath(
                                              "ic_default_avater"),
                                          width: width(46),
                                          height: width(46),
                                        )
                                      : Image.network(
                                          SPClassApplicaion
                                              .spProUserInfo!.spProAvatarUrl,
                                          fit: BoxFit.cover,
                                          width: width(46),
                                          height: width(46),
                                        ),
                            ),
                          ),
                          SizedBox(
                            width: width(8),
                          ),
                          Flexible(
                            flex: 1,
                            fit: FlexFit.tight,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: SPClassApplicaion.spFunIsExistUserInfo()
                                  ? <Widget>[
                                      Text(
                                        SPClassApplicaion
                                            .spProUserInfo!.spProNickName,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: sp(17)),
                                      ),
                                      Text(
                                        "UID:" +
                                            SPClassApplicaion.spProUserLoginInfo!.spProUserId.toString(),
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: sp(13)),
                                      ),
                                    ]
                                  : <Widget>[
                                      Text(
                                        "登录 / 注册",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            fontSize: 18),
                                      ),
                                      Text(
                                        "登录后可以获得更多奖励哦",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            fontSize: 14),
                                      ),
                                    ],
                            ),
                          ),

                          SizedBox(
                            width: width(15),
                          ),
                        ],
                      ),
                      onTap: () {
                        if (spFunIsLogin(context: context)) {
                          SPClassNavigatorUtils.spFunPushRoute(
                              context, SPClassUserInfoPage());
                        }
                      },
                    ),
                    Visibility(
                      child: Container(
                        color: Colors.white,
                        padding: EdgeInsets.symmetric(horizontal: width(16),vertical: width(23)),
                        margin: EdgeInsets.only(top: width(24)),
                        child: Row(
                          children: <Widget>[
                            Text('当前钻石:',
                              style:  TextStyle(color:MyColors.grey_33,fontSize: sp(14),),
                            ),
                            SizedBox(width: width(5),),
                            Text(SPClassApplicaion
                                .spFunIsExistUserInfo()
                                ? SPClassStringUtils
                                .spFunSqlitZero(
                                SPClassApplicaion
                                    .spProUserInfo!
                                    .spProDiamond)
                                : "-",
                              style: TextStyle(color:MyColors.main1,height: 0.8,fontSize: sp(36),fontWeight: FontWeight.w500,),
                            ),
                            Image.asset(
                              SPClassImageUtil.spFunGetImagePath("zhuanshi"),
                              width: width(24),
                            ),
                            Expanded(
                              child: SizedBox(),
                            ),
                            GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              onTap: (){
                                if (spFunIsLogin(context: context)) {
                                  SPClassNavigatorUtils.spFunPushRoute(
                                      context,
                                      SPClassRechargeDiamondPage());
                                }
                              },
                              child: Container(
                                width: width(83),
                                height: width(34),
                                alignment: Alignment.center,
                                child: Text('立即充值', style: TextStyle(color:Colors.white,fontWeight: FontWeight.w500,fontSize: sp(14))),
                                decoration: BoxDecoration(
                                  color: MyColors.main1,
                                  borderRadius: BorderRadius.circular(150),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      visible: (SPClassApplicaion.spProShowMenuList
                          .contains("pay") ||
                          double.tryParse(SPClassApplicaion
                              .spProUserInfo!.spProDiamond)! >
                              0),
                    ),
                    spProMyTitles.length > 0
                        ? Container(
                        color: Colors.white,
                        margin: EdgeInsets.only(top: width(8)),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border(bottom: BorderSide(
                                      color: Color(0xFFF7F7F7),
                                      width: 1,
                                    ))
                                  ),
                                  padding: EdgeInsets.only(
                                      left: width(16), right: width(16),top: width(16),bottom: width(13)),
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        "常用功能",
                                        style: TextStyle(color: MyColors.grey_66,fontWeight: FontWeight.bold,
                                         fontSize: sp(17),),
                                      ),
                                    ],
                                  ),
                                ),
                                GridView.count(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  crossAxisCount: 4,
                                  padding: EdgeInsets.zero,
                                  childAspectRatio: width(85) / width(97),
                                  children: spProMyTitles.map((item) {
                                    var index = spProMyTitles.indexOf(item);
                                    return GestureDetector(
                                      child: spProMyTitleImages.length>index?Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Image.asset(
                                              SPClassImageUtil.spFunGetImagePath(
                                                  "ic_user_" +
                                                      "${spProMyTitleImages[index]}"),
                                              width: width(36)),
                                          Text(
                                            item,
                                            style: TextStyle(
                                                color: Color(0xFF333333),
                                                fontSize: sp(13)),
                                          )
                                        ],
                                      ):SizedBox(),
                                      onTap: () => spFunOnTap(item),
                                    );
                                  }).toList(),
                                )
                              ],
                            ),
                          )
                        : SizedBox(),
                    Container(
                          color: Colors.white,
                      margin: EdgeInsets.only(top: width(12)),
                      child: Column(
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                                border: Border(bottom: BorderSide(
                                  color: Color(0xFFF7F7F7),
                                  width: 1,
                                ))
                            ),
                            padding: EdgeInsets.only(
                                left: width(16), right: width(16),top: width(16),bottom: width(13)),
                            child: Row(
                              children: <Widget>[
                                Text(
                                  "其他功能",
                                  style:  TextStyle(color: MyColors.grey_66,fontWeight: FontWeight.bold,
                              fontSize: sp(17),),
                                ),
                              ],
                            ),
                          ),
                          GridView.count(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            crossAxisCount: 4,
                            padding: EdgeInsets.zero,
                            childAspectRatio: 1.2,
                            children: spProOtherTitles.map((item) {
                              var index = spProOtherTitles.indexOf(item);
                              return GestureDetector(
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: <Widget>[
                                    spProOtherImages.length>index?
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: <Widget>[
                                        Image.asset(
                                            SPClassImageUtil.spFunGetImagePath(
                                                "ic_user_" +
                                                    "${spProOtherImages[index]}"),
                                            width: width(31)),
                                        Text(
                                          item,
                                          style: TextStyle(
                                              color: Color(0xFF333333),
                                              fontSize: sp(12)),
                                        )
                                      ],
                                    ):SizedBox(),
                                    item == "新人福利"
                                        ? Positioned(
                                      top: width(10),
                                      right: width(18),
                                      child: ScaleTransition(
                                        alignment: Alignment.bottomLeft,
                                        scale: spProScaleAnimation!,
                                        child: Image.asset(
                                          SPClassImageUtil
                                              .spFunGetImagePath(
                                              "ic_anim_invite"),
                                          fit: BoxFit.fitHeight,
                                          height: width(20),
                                        ),
                                      ),
                                    )
                                        : SizedBox(),
                                    item == "系统消息"
                                        ? Positioned(
                                      top: width(20),
                                      right: width(20),
                                      child: (spFunIsLogin() &&
                                          double.tryParse(SPClassApplicaion
                                              .spProUserLoginInfo!
                                              .spProUnreadMsgNum!)! >
                                              0)
                                          ? Container(
                                        height: width(8),
                                        width: width(8),
                                        decoration: BoxDecoration(
                                            color: Colors.red,
                                            shape: BoxShape.circle),
                                      )
                                          : SizedBox(),
                                    )
                                        : SizedBox()
                                  ],
                                ),
                                onTap: () => spFunOnTap(item),
                              );
                            }).toList(),
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
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  void spFunOnTap(String value) {
    if (!spFunIsLogin(context: context)) {
      return;
    }
    if (value == "已购方案") {
      SPClassNavigatorUtils.spFunPushRoute(context, SPClassMyBuySchemePage());
    }
    if (value == "关注方案") {
      SPClassNavigatorUtils.spFunPushRoute(
          context, SPClassMyFollowSchemePage());
    }
    if (value == "关注专家") {
      SPClassNavigatorUtils.spFunPushRoute(
          context, FollowExpertPage());
    }
    if (value == "专家入驻") {
      if (SPClassApplicaion.spProUserLoginInfo!.spProExpertVerifyStatus == "0") {
        SPClassToastUtils.spFunShowToast(msg: "您的申请正在审核中，请留意系统消息");
        return;
      }
      SPClassNavigatorUtils.spFunPushRoute(context, SPClassExpertApplyPage());
    }
    // if (value == "邀请好友") {
    //   if (spFunIsLogin(context: context)) {
    //     SPClassApiManager.spFunGetInstance().spFunShare(
    //         context: context,
    //         spProCallBack: SPClassHttpCallBack(spProOnSuccess: (result) {
    //           showModalBottomSheet<void>(
    //               context: context,
    //               builder: (BuildContext context) {
    //                 return SPClassShareView(
    //                   title: result.title,
    //                   spProDesContent: result.content,
    //                   spProPageUrl: result.spProPageUrl ??
    //                       SPClassNetConfig.spFunGetShareUrl(),
    //                   spProIconUrl: result.spProIconUrl,
    //                 );
    //               });
    //         }));
    //   }
    // }
    ///
    if (value == "新人福利") {
      SPClassNavigatorUtils.spFunPushRoute(
          context, SPClassNewUserWalFarePage());
    }
    // if (value == "抽奖") {
    //   showCupertinoModalPopup(
    //       context: context, builder: (c) => SPClassDialogTurntable(() {}));
    // }

    if (value == "系统消息") {
      SPClassNavigatorUtils.spFunPushRoute(context, SPClassSystemMsgPage());
    }
    //
    // if (value == "优惠券") {
    //   SPClassNavigatorUtils.spFunPushRoute(context, SPClassCouponPage());
    // }
    //
    if (value == "联系客服") {
      SPClassNavigatorUtils.spFunPushRoute(context, SPClassContactPage());
    }
    if (value == "关于我们") {
      SPClassNavigatorUtils.spFunPushRoute(context, SPClassAboutUsPage());
    }
    if (value == "意见反馈") {
      SPClassNavigatorUtils.spFunPushRoute(context, SPClassFeedbackPage());
    }
    if (value == "设置") {
      SPClassNavigatorUtils.spFunPushRoute(context, SPClassSettingPage());
    }
    // if (value == "我的发布") {
    //   SPClassNavigatorUtils.spFunPushRoute(context, SPClassMyAddSchemePage());
    // }
  }
}
