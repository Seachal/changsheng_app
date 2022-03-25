import 'dart:io';

import 'package:changshengh5/app/CSClassApplicaion.dart';
import 'package:changshengh5/pages/competition/scheme/CSClassExpertApplyPage.dart';
import 'package:changshengh5/pages/shop/MyOrder.dart';
import 'package:changshengh5/pages/user/publicScheme/CSClassMyAddSchemePage.dart';
import 'package:changshengh5/pages/user/scheme/bug/CSClassMyBuySchemePage.dart';
import 'package:changshengh5/pages/user/scheme/follow/CSClassMyFollowSchemePage.dart';
import 'package:changshengh5/pages/user/setting/CSClassSettingPage.dart';
import 'package:changshengh5/pages/user/systemMsg/CSClassSystemMsgPageState.dart';
import 'package:changshengh5/utils/CSClassCommonMethods.dart';
import 'package:changshengh5/utils/CSClassImageUtil.dart';
import 'package:changshengh5/utils/CSClassNavigatorUtils.dart';
import 'package:changshengh5/utils/CSClassStringUtils.dart';
import 'package:changshengh5/utils/CSClassToastUtils.dart';
import 'package:changshengh5/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'FollowExpertPage.dart';
import 'CSClassContactPage.dart';
import 'CSClassFeedbackPage.dart';
import 'CSClassNewUserWalFarePage.dart';
import 'CSClassRechargeDiamondPage.dart';
import 'about/CSClassAboutUsPage.dart';
import 'info/CSClassUserInfoPage.dart';


class CSClassUserPage extends StatefulWidget {
  @override
  CSClassUserPageState createState() => CSClassUserPageState();
}

class CSClassUserPageState extends State<CSClassUserPage>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  var csProMyTitles = ["已购方案", "关注专家","关注方案", '专家入驻'];
  var csProMyTitleImages = ["bug","follow_expert", "follow",'expert_apply'];
  var csProOtherTitles = [
    "我的订单",
    // "邀请好友", web没有分享
    "新人福利",
    /*"抽奖",*/
    "系统消息",
    "联系客服",
    "关于我们",
    "意见反馈",
    "设置"
  ];
  var csProOtherImages = [
    "order",
    // "invite", web没有分享
    "new",
/*"turntable",*/
    "sys",
    "contact",
    "about",
    "feedback",
    "setting"
  ];
  var csProUserSubscription;
  int csProSeqNum = 0;
  AnimationController ?csProScaleAnimation;
  bool csProIsSignIn = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    CSClassApplicaion.csMethodGetUserInfo(isFire: false);
    csProUserSubscription =
        CSClassApplicaion.csProEventBus.on<String>().listen((event) {
      if (event == "userInfo") {
        // getSeqNum();
        if (CSClassApplicaion.csProUserLoginInfo!.csProExpertVerifyStatus == "1") {
          csProMyTitles.remove("专家入驻");
          csProMyTitles.remove("我的发布");
          csProMyTitleImages.remove("expert_apply");
          csProMyTitles.add("我的发布");
          csProMyTitleImages.add("send");
        } else {
          csProMyTitles.remove("我的发布");
          csProMyTitles.remove("专家入驻");
          csProMyTitleImages.remove("expert_apply");
          csProMyTitles.add("专家入驻");
          csProMyTitleImages.add("expert_apply");
        }
        if (mounted) {
          setState(() {});
        }
      }
    });

    if (!CSClassApplicaion.csProShowMenuList.contains("home")) {
      csProMyTitles.remove("已购方案");
      csProMyTitles.remove("关注方案");
      csProMyTitleImages.remove("bug");
      csProMyTitleImages.remove("follow");
      //csProOtherTitles.remove("邀请好友");
      csProOtherTitles.remove("新人福利");
      //csProOtherImages.remove("invite");
      csProOtherImages.remove("new");
    }

    if (!CSClassApplicaion.csProShowMenuList.contains("expert")) {
      csProMyTitles.remove("关注专家");
      csProMyTitles.remove("专家入驻");
      csProMyTitleImages.remove("follow_expert");
      csProMyTitleImages.remove("expert_apply");
    }

    if (!CSClassApplicaion.csProShowMenuList.contains("shop")) {
      csProOtherImages.remove("order");
      csProOtherTitles.remove("我的订单");
    }
    if (!CSClassApplicaion.csProShowMenuList.contains("pay")) {
      csProOtherImages.remove("new");
      csProOtherTitles.remove("新人福利");
      csProMyTitles.remove("已购方案");
      csProMyTitleImages.remove("bug");
    }



      if (CSClassApplicaion.csProUserLoginInfo!.csProExpertVerifyStatus == "1") {
      csProMyTitles.remove("专家入驻");
      csProMyTitleImages.remove("expert_apply");
      csProMyTitles.add("我的发布");
      csProMyTitleImages.add("expert_apply");
    }
    //
    // if (Platform.isIOS) {
    //   csProMyTitles.remove("已购方案");
    //   csProMyTitleImages.remove("bug");
    //   csProOtherTitles.remove("邀请好友");
    //   csProOtherTitles.remove("新人福利");
    //   csProOtherImages.remove("invite");
    //   csProOtherImages.remove("new");
    //   csProOtherTitles.remove("抽奖");
    //   csProOtherImages.remove("turntable");
    // }

    csProScaleAnimation = AnimationController(
        duration: const Duration(milliseconds: 600),
        reverseDuration: const Duration(milliseconds: 600),
        vsync: this,
        lowerBound: 1.0,
        upperBound: 1.1);
    csProScaleAnimation!.repeat(reverse: true);
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
                CSClassImageUtil.csMethodGetImagePath("zhuanjiabg"),
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
                                  (!CSClassApplicaion.csMethodIsExistUserInfo() ||
                                          CSClassApplicaion.csProUserInfo!
                                              .csProAvatarUrl.isEmpty)
                                      ? Image.asset(
                                          CSClassImageUtil.csMethodGetImagePath(
                                              "cs_default_avater"),
                                          width: width(46),
                                          height: width(46),
                                        )
                                      : Image.network(
                                          CSClassApplicaion
                                              .csProUserInfo!.csProAvatarUrl,
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
                              children: CSClassApplicaion.csMethodIsExistUserInfo()
                                  ? <Widget>[
                                      Text(
                                        CSClassApplicaion
                                            .csProUserInfo!.csProNickName,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: sp(17)),
                                      ),
                                      Text(
                                        "UID:" +
                                            CSClassApplicaion.csProUserLoginInfo!.csProUserId.toString(),
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
                        if (csMethodIsLogin(context: context)) {
                          CSClassNavigatorUtils.csMethodPushRoute(
                              context, CSClassUserInfoPage());
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
                            Text(CSClassApplicaion
                                .csMethodIsExistUserInfo()
                                ? CSClassStringUtils
                                .csMethodSqlitZero(
                                CSClassApplicaion
                                    .csProUserInfo!
                                    .csProDiamond)
                                : "-",
                              style: TextStyle(color:MyColors.main1,height: 0.8,fontSize: sp(36),fontWeight: FontWeight.w500,),
                            ),
                            Image.asset(
                              CSClassImageUtil.csMethodGetImagePath("zhuanshi"),
                              width: width(24),
                            ),
                            Expanded(
                              child: SizedBox(),
                            ),
                            GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              onTap: (){
                                if (csMethodIsLogin(context: context)) {
                                  CSClassNavigatorUtils.csMethodPushRoute(
                                      context,
                                      CSClassRechargeDiamondPage());
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
                      visible: (CSClassApplicaion.csProShowMenuList
                          .contains("pay") ||
                          double.tryParse(CSClassApplicaion
                              .csProUserInfo!.csProDiamond)! >
                              0),
                    ),
                    csProMyTitles.length > 0
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
                                  children: csProMyTitles.map((item) {
                                    var index = csProMyTitles.indexOf(item);
                                    return GestureDetector(
                                      child: csProMyTitleImages.length>index?Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Image.asset(
                                              CSClassImageUtil.csMethodGetImagePath(
                                                  "cs_user_" +
                                                      "${csProMyTitleImages[index]}"),
                                              width: width(36)),
                                          Text(
                                            item,
                                            style: TextStyle(
                                                color: Color(0xFF333333),
                                                fontSize: sp(13)),
                                          )
                                        ],
                                      ):SizedBox(),
                                      onTap: () => csMethodOnTap(item),
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
                            children: csProOtherTitles.map((item) {
                              var index = csProOtherTitles.indexOf(item);
                              return GestureDetector(
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: <Widget>[
                                    csProOtherImages.length>index?
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: <Widget>[
                                        Image.asset(
                                            CSClassImageUtil.csMethodGetImagePath(
                                                "cs_user_" +
                                                    "${csProOtherImages[index]}"),
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
                                        scale: csProScaleAnimation!,
                                        child: Image.asset(
                                          CSClassImageUtil
                                              .csMethodGetImagePath(
                                              "cs_anim_invite"),
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
                                      child: (csMethodIsLogin() &&
                                          double.tryParse(CSClassApplicaion
                                              .csProUserLoginInfo!
                                              .csProUnreadMsgNum!)! >
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
                                onTap: () => csMethodOnTap(item),
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

  void csMethodOnTap(String value) {
    if (!csMethodIsLogin(context: context)) {
      return;
    }
    if (value == "已购方案") {
      CSClassNavigatorUtils.csMethodPushRoute(context, CSClassMyBuySchemePage());
    }
    if (value == "我的订单") {
      CSClassNavigatorUtils.csMethodPushRoute(context, MyOrder());
    }
    if (value == "关注方案") {
      CSClassNavigatorUtils.csMethodPushRoute(
          context, CSClassMyFollowSchemePage());
    }
    if (value == "关注专家") {
      CSClassNavigatorUtils.csMethodPushRoute(
          context, FollowExpertPage());
    }
    if (value == "专家入驻") {
      if (CSClassApplicaion.csProUserLoginInfo!.csProExpertVerifyStatus == "0") {
        CSClassToastUtils.csMethodShowToast(msg: "您的申请正在审核中，请留意系统消息");
        return;
      }
      CSClassNavigatorUtils.csMethodPushRoute(context, CSClassExpertApplyPage());
    }
    // if (value == "邀请好友") {
    //   if (csMethodIsLogin(context: context)) {
    //     CSClassApiManager.csMethodGetInstance().csMethodShare(
    //         context: context,
    //         csProCallBack: CSClassHttpCallBack(csProOnSuccess: (result) {
    //           showModalBottomSheet<void>(
    //               context: context,
    //               builder: (BuildContext context) {
    //                 return CSClassShareView(
    //                   title: result.title,
    //                   csProDesContent: result.content,
    //                   csProPageUrl: result.csProPageUrl ??
    //                       CSClassNetConfig.csMethodGetShareUrl(),
    //                   csProIconUrl: result.csProIconUrl,
    //                 );
    //               });
    //         }));
    //   }
    // }
    ///
    if (value == "新人福利") {
      CSClassNavigatorUtils.csMethodPushRoute(
          context, CSClassNewUserWalFarePage());
    }
    // if (value == "抽奖") {
    //   showCupertinoModalPopup(
    //       context: context, builder: (c) => CSClassDialogTurntable(() {}));
    // }

    if (value == "系统消息") {
      CSClassNavigatorUtils.csMethodPushRoute(context, CSClassSystemMsgPage());
    }
    //
    // if (value == "优惠券") {
    //   CSClassNavigatorUtils.csMethodPushRoute(context, CSClassCouponPage());
    // }
    //
    if (value == "联系客服") {
      CSClassNavigatorUtils.csMethodPushRoute(context, CSClassContactPage());
    }
    if (value == "关于我们") {
      CSClassNavigatorUtils.csMethodPushRoute(context, CSClassAboutUsPage());
    }
    if (value == "意见反馈") {
      CSClassNavigatorUtils.csMethodPushRoute(context, CSClassFeedbackPage());
    }
    if (value == "设置") {
      CSClassNavigatorUtils.csMethodPushRoute(context, CSClassSettingPage());
    }
     if (value == "我的发布") {
       CSClassNavigatorUtils.csMethodPushRoute(context, CSClassMyAddSchemePage());
     }
  }
}
