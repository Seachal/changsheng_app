
import 'dart:convert';
import 'package:changshengh5/pages/shop/ShopPage.dart';
import 'package:changshengh5/pages/user/setting/CSClassVersionCheckDialog.dart';
import 'package:dio/dio.dart';

import 'package:changshengh5/api/CSClassApiManager.dart';
import 'package:changshengh5/api/CSClassHttpCallBack.dart';
import 'package:changshengh5/api/CSClassNetConfig.dart';
import 'package:changshengh5/app/CSClassApplicaion.dart';
import 'package:changshengh5/app/CSClassGlobalNotification.dart';
import 'package:changshengh5/model/CSClassGuessMatchInfo.dart';
import 'package:changshengh5/pages/anylise/CSClassExpertDetailPage.dart';
import 'package:changshengh5/pages/common/CSClassShareView.dart';
import 'package:changshengh5/pages/competition/CSClassMatchDetailPage.dart';
import 'package:changshengh5/pages/competition/scheme/CSClassExpertApplyPage.dart';
import 'package:changshengh5/pages/competition/scheme/CSClassSchemeDetailPage.dart';
import 'package:changshengh5/pages/expert/CSClassExpertHomePage.dart';
import 'package:changshengh5/pages/home/HomePage.dart';
import 'package:changshengh5/pages/news/CSClassWebPageState.dart';
import 'package:changshengh5/pages/score/CSClassCompetitionHomePage.dart';
import 'package:changshengh5/pages/user/CSClassContactPage.dart';
import 'package:changshengh5/pages/user/CSClassUserPage.dart';
import 'package:changshengh5/utils/CSClassCommonMethods.dart';
import 'package:changshengh5/utils/CSClassImageUtil.dart';
import 'package:changshengh5/utils/CSClassNavigatorUtils.dart';
import 'package:changshengh5/utils/CSClassToastUtils.dart';
import 'package:changshengh5/widgets/Qnav/CSClassQNavBar.dart';
import 'package:changshengh5/widgets/Qnav/CSClassQNavButton.dart';
import 'package:flutter/material.dart';

class CSClassAppPage extends StatefulWidget
{
  @override

  CSClassAppPageState createState()=>CSClassAppPageState();

}

class CSClassAppPageState extends State<CSClassAppPage>
{
  List<Widget> csProPageList =  [];
  List<CSClassQNavTab> tabs= [];
  int csProIndex = 0;

  var csProExpertIndex=-1;
  late PageController controller;

  var csProLastPressedAt;
  var csProPopTimer= DateTime.now();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(
      child:  Scaffold(
        body: PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: controller,
          children:csProPageList,
        ) ,
        backgroundColor: Colors.white,
        bottomNavigationBar:SafeArea(
          bottom: true,
          child:
          CSClassQNavBar(csProNavTabs: tabs,csProPageChange: (value)=>csMethodItemTapped(value),csProNavHeight: height(48),csProNavTextSize: width(10),csProSelectIndex: csProIndex,),
        ),
      ),
      onWillPop: () async{
        if(DateTime.now().difference(csProPopTimer).inSeconds>3){
          CSClassToastUtils.csMethodShowToast(msg: "再按一次退出");
        }else{
          return true;
        }
        csProPopTimer=DateTime.now();
        return false;
      },
    );
  }

  void csMethodCheckVersion() {

    CSClassApiManager.csMethodGetInstance().csMethodCheckUpdate(csProCallBack:CSClassHttpCallBack(
        csProOnSuccess: (result){
          if(result.csProNeedUpdate!){
            showDialog<void>(
                context: context,
                builder: (BuildContext cx) {
                  return CSClassVersionCheckDialog(
                    result.csProIsForced??false,
                    result.csProUpdateDesc??'',
                    result.csProAppVersion??'',
                    csProDownloadUrl: result.csProDownloadUrl??'',
                    csProCancelCallBack: (){
                      Navigator.of(context).pop();
                      CSClassApplicaion.csMethodShowUserDialog(context);
                    },
                  );
                });
          }else{
            CSClassApplicaion.csMethodShowUserDialog(context);
          }
        },
      onError: (error){
        CSClassApplicaion.csMethodShowUserDialog(context);
      },csProOnProgress: (v){}
    ) );

  }

  void csMethodGetBcwUrl(String value){
    if(csMethodIsLogin(context: context)){
      var params=CSClassApiManager.csMethodGetInstance().csMethodGetCommonParams();
      params.putIfAbsent("model_type", ()=>value);
      CSClassNavigatorUtils.csMethodPushRoute(context, CSClassWebPage( CSClassNetConfig.csMethodGetBasicUrl()+"user/bcw/login?"+Transformer.urlEncodeMap(params),""));
    }
  }




  csMethodGoRoutPage(String urlPage,String title,String csProMsgId,bool isDemo){
    if(csProMsgId!=null){
      CSClassApiManager.csMethodGetInstance().csMethodPushMsgClick(pushMsgId: csProMsgId,isDemo: isDemo,csProAutoLoginStr: csMethodIsLogin()? CSClassApplicaion.csProUserLoginInfo?.csProAutoLoginStr:"");
    }
    if(urlPage==null||urlPage.trim().isEmpty){
      return;
    }
    if(urlPage.startsWith("hs_sport:")){
      Uri url = Uri.parse(urlPage.replaceAll("hs_sport", "hssport"));
      if(urlPage.contains("scheme?")){
        if(csMethodIsLogin(context: context)){
          CSClassApiManager.csMethodGetInstance().csMethodSchemeDetail(
              queryParameters: {"scheme_id":url.queryParameters["scheme_id"]},
              context: context,csProCallBack:CSClassHttpCallBack(
              csProOnSuccess: (value){
                CSClassNavigatorUtils.csMethodPushRoute(context,  CSClassSchemeDetailPage(value));
              },onError: (e){},csProOnProgress: (v){}
          ));
        }
      }
      if(urlPage.contains("expert?")){
        CSClassApiManager.csMethodGetInstance().csMethodExpertInfo(queryParameters: {"expert_uid":url.queryParameters["expert_uid"]},
            context:context,csProCallBack: CSClassHttpCallBack(
                csProOnSuccess: (info){
                  CSClassNavigatorUtils.csMethodPushRoute(context,  CSClassExpertDetailPage(info));
                }
            ));
      }
      if(urlPage.contains("guess_match?")){
        CSClassApiManager.csMethodGetInstance().csMethodSportMatchData<CSClassGuessMatchInfo>(loading: true,context: context,csProGuessMatchId:url.queryParameters["guess_match_id"],dataKeys: "guess_match",csProCallBack: CSClassHttpCallBack(
            csProOnSuccess: (result) async {
              CSClassNavigatorUtils.csMethodPushRoute(context, CSClassMatchDetailPage(result,csProMatchType:"guess_match_id",csProInitIndex: 1,));
            },onError: (e){},csProOnProgress: (v){}
        ) );
      }
      if(urlPage.contains("invite")){
        if(csMethodIsLogin(context: context)){

          CSClassApiManager.csMethodGetInstance().csMethodShare(context: context,csProCallBack: CSClassHttpCallBack(
              csProOnSuccess: (result){
                showModalBottomSheet<void>(
                    context: context,
                    builder: (BuildContext context) {
                      return CSClassShareView(title: result.title,csProDesContent: result.content,csProPageUrl: result.csProPageUrl??CSClassNetConfig.csMethodGetShareUrl(),csProIconUrl: result.csProIconUrl,);
                    });
              }
          ));

        }
      }
      if(urlPage.contains("contact_cs")){
        CSClassNavigatorUtils.csMethodPushRoute(context,  CSClassContactPage());
      }

      if(urlPage.contains("apply_expert")){
        if(csMethodIsLogin(context: context)) {
          CSClassNavigatorUtils.csMethodPushRoute(context,  CSClassExpertApplyPage());
        }
      }

      if(urlPage.contains("big_data_report")){
        if(csMethodIsLogin(context: context)) {
          csMethodGetBcwUrl("bigDataReport");
        }
      }
      if(urlPage.contains("all_analysis")){
        if(csMethodIsLogin(context: context)) {
          csMethodGetBcwUrl("allAnalysis");
        }
      }

      if(urlPage.contains("odds_wave")){
        if(csMethodIsLogin(context: context)) {
          csMethodGetBcwUrl("oddsWave");
        }
      }
      if(urlPage.contains("dark_horse_analysis")){
        if(csMethodIsLogin(context: context)) {
          csMethodGetBcwUrl("coldJudge");
        }
      }
    }else{
      CSClassNavigatorUtils.csMethodPushRoute(context,CSClassWebPage(urlPage,title));
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller=PageController();
    // CSClassGlobalNotification.csMethodGetInstance(buildContext: context);
    CSClassApplicaion.csMethodSavePushToken();
    if(CSClassApplicaion.csProShowMenuList.contains("home")){
      // csProPageList.add(CSClassHomePage());
      csProPageList.add(HomePage());
      tabs.add(CSClassQNavTab( csProTabText: "推荐",csProTabImage:CSClassImageUtil.csMethodGetImagePath("ic_homepage")));
    }
    if(CSClassApplicaion.csProShowMenuList.contains("shop")){

      csProPageList.add(ShopPage());
      tabs.add(CSClassQNavTab( csProTabText: "商城",csProTabImage:CSClassImageUtil.csMethodGetImagePath("ic_shopPage")));
    }
    if(CSClassApplicaion.csProShowMenuList.contains("match")){
      csProPageList.add(CSClassCompetitionHomePage());
      tabs.add(CSClassQNavTab( csProTabText: "比分",csProTabImage:CSClassImageUtil.csMethodGetImagePath("ic_score")),);
    }

//    if(CSClassApplicaion.csProShowMenuList.contains("circle")){
//      csProPageList.add(Container());
//      // csProPageList.add(CSClassHotHomePage());
//      tabs.add(CSClassQNavTab( csProTabText: "热门",csProTabImage:CSClassImageUtil.csMethodGetImagePath("ic_tab_hot")));
//    }
    if(CSClassApplicaion.csProShowMenuList.contains("expert")){
      csProPageList.add(CSClassExpertHomePage());
        tabs.add(CSClassQNavTab( csProTabText: "专家",csProTabImage:CSClassImageUtil.csMethodGetImagePath("ic_match")));
        csProExpertIndex=csProPageList.length-1;
    }

    if(CSClassApplicaion.csProShowMenuList.contains("game")&&CSClassApplicaion.csProDEBUG == true){
      csProPageList.add(Container());
      // csProPageList.add(CSClassGamePage());
      tabs.add(CSClassQNavTab(csProTabText: '游戏',csProTabImage:CSClassImageUtil.csMethodGetImagePath("ic_game")));
    }
       csProPageList.add(CSClassUserPage());
       tabs.add(CSClassQNavTab(csProTabText: "我的",csProTabImage:CSClassImageUtil.csMethodGetImagePath("ic_tab_user"),badge:csMethodIsLogin()? int.parse(CSClassApplicaion.csProUserLoginInfo!.csProUnreadMsgNum!):0));

      CSClassApplicaion.csProEventBus.on<String>().listen((event) {
      if(event=="tab:expert"){
        CSClassExpertHomePageState.index=1;
        if(csProExpertIndex>-1){
          csMethodItemTapped(csProExpertIndex);
          //(csProPageList[csProExpertIndex] as ExpertHomePage).csProState.tapTopItem(1);
        }
      }
      if(event=="login:out"){
        CSClassGlobalNotification.csMethodGetInstance()?.csMethodCloseConnect();
        CSClassGlobalNotification.csMethodGetInstance()?.csMethodInitWebSocket();
        csMethodItemTapped(0);
      }
      if(event=="tab:home"){
        csMethodItemTapped(0);
      }
      if(event=="userInfo"){
        tabs[tabs.length-1].badge=csMethodIsLogin()? int.parse(CSClassApplicaion.csProUserLoginInfo!.csProUnreadMsgNum!):0;
      }
    });
///
    WidgetsBinding.instance?.addPostFrameCallback((callback) async {
      csMethodCheckVersion();
//      FlutterPluginHuaweiPush.notificationListener((url,msgID,isDemo){
//        csMethodGoRoutPage(url,"",msgID,isDemo);
//      });

      if( CSClassApplicaion.csProJPush!=null){
        CSClassApplicaion.csProJPush?.addEventHandler(
          // 点击通知回调方法。
          onOpenNotification: (Map<String, dynamic> message) async {
            var map= json.decode(message["extras"]["cn.jpush.android.EXTRA"]);
            csMethodGoRoutPage(map["page_url"],message["title"],map["push_msg_id"].toString(),map["is_demo"].toString()=="1");
          },
        );
      }
    });
  }

  void csMethodItemTapped(int index) {

    if((csProPageList[index] is CSClassUserPage)&&!csMethodIsLogin(context: context)){
      setState(() {});
      return;
    }
    setState(() {
      csProIndex = index;
    });

    controller.jumpToPage(index);
    // if(csProPageList[index] is CSClassHomePage){( csProPageList[index] as CSClassHomePage).csProState.csMethodTabReFresh();}
    if(csProPageList[index] is CSClassCompetitionHomePage){( csProPageList[index] as CSClassCompetitionHomePage).csProState?.csMethodCurrentPage.csProState?.csMethodRefreshTab();}

    if((csProPageList[index] is CSClassUserPage)&&csMethodIsLogin()){
      CSClassApplicaion.csMethodGetUserInfo();
    }

  }
}