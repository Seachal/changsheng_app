
import 'package:changshengh5/app/CSClassApplicaion.dart';
import 'package:changshengh5/pages/competition/CSClassMatchListSettingPage.dart';
import 'package:changshengh5/pages/competition/filter/CSClassFilterHomePage.dart';
import 'package:changshengh5/utils/CSClassCommonMethods.dart';
import 'package:changshengh5/utils/CSClassImageUtil.dart';
import 'package:changshengh5/utils/CSClassNavigatorUtils.dart';
import 'package:changshengh5/utils/colors.dart';
import 'package:changshengh5/widgets/CSClassSwitchTabBar.dart';
import 'package:flutter/material.dart';

import 'CSClassTabMatchInfoPage.dart';



class CSClassCompetitionHomePage extends StatefulWidget
{

  CSClassCompetitionHomePageState ?csProState;
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return  csProState=CSClassCompetitionHomePageState();
  }


}

class CSClassCompetitionHomePageState extends State<CSClassCompetitionHomePage> with AutomaticKeepAliveClientMixin{
  static int csProIndex = 0;
  List<CSClassTabMatchInfoPage> csProPages=[];
  var titles=["足球","篮球"];
  var csProMatchTypes=["足球","篮球"];
  CSClassSwitchTabBarState ?csProSwitchTabBarController;
  PageController ?controller;
  var csProHiddenFilter= false;
  @override
    void initState() {
    // TODO: implement initState
    super.initState();
    if(CSClassApplicaion.csProShowMenuList.contains("es")){
      titles.add("电竞");
      csProMatchTypes.add("lol");
    }
    
    csProPages=csProMatchTypes.map((item)=>CSClassTabMatchInfoPage(item),).toList();
    // 标记
    // csMethodSetTabIndex( CSClassHomePageState.csProHomeMatchType);
    controller =PageController(initialPage: csProIndex);
    CSClassApplicaion.csProEventBus.on<String>().listen((event) {
      if(event.startsWith("scheme:refresh")){
        // 标记
        // csMethodSetTabIndex( CSClassHomePageState.csProHomeMatchType);
      }
      if(event==("score:hidden")){
        setState(() {
          csProHiddenFilter=true;
        });
      }
      if(event==("score:show")){
        setState(() {
          csProHiddenFilter=false;
        });
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    super.build(context);
    return Scaffold(
      appBar:PreferredSize(
        preferredSize: Size.fromHeight(width(48)),
        child: AppBar(
          centerTitle: true,
          backgroundColor: MyColors.main1,
          elevation: 0,
          brightness: Brightness.dark,
          leading: IconButton(
            padding: EdgeInsets.zero,
            icon: Image.asset(
              CSClassImageUtil.csMethodGetImagePath('ic_match_setting'),
              width: width(19),
              color: Colors.white,
            ),
            onPressed: (){
              if(csMethodIsLogin(context: context)){
                CSClassNavigatorUtils.csMethodPushRoute(context,CSClassMatchListSettingPage(index: csProIndex,));
              }
            },
          ),
          title:  CSClassSwitchTabBar(
            csProTabTitles:titles,
            index:csProIndex,
            fontSize: sp(17),
            width: width(67*titles.length),
            height: width(29),
            csProGetState: (state){
              csProSwitchTabBarController=state;
            },
            csProTabChanged: (index){
              csProIndex=index;
              controller!.jumpToPage(index);
              // 标记
              // CSClassHomePageState.csProHomeMatchType=titles[csProIndex];
            },
          ),
          actions: <Widget>
          [
            csProHiddenFilter?  SizedBox():IconButton(
              padding: EdgeInsets.zero,
              icon: Image.asset(
                CSClassImageUtil.csMethodGetImagePath('ic_filter'),
                width: width(19),
                color: Colors.white,
              ),
              onPressed: (){
                CSClassNavigatorUtils.csMethodPushRoute(context,CSClassFilterHomePage(
                  csProPages[csProIndex].csProState!.csMethodGetLeagueName,
                  csProIsHot: csProPages[csProIndex].csProState!.csMethodIsMatchHot,
                  param:csProPages[csProIndex].csProState!.csMethodGetParams,
                  callback: (value,value2){
                    csMethodCurrentPage.csProState!.csMethodReFreshByFilter(value,value2);
                  },));
              },
            )
          ],
        ),
        
      ),
      backgroundColor: Color(0xFFF2F2F2),
      body:PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: controller,
        children:csProPages ,
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
  CSClassTabMatchInfoPage get csMethodCurrentPage=> csProPages[csProIndex];

  void csMethodSetTabIndex(String csProHomeMatchType) {
    if(csProHomeMatchType=="足球"){csProIndex=0;}
     else if(csProHomeMatchType=="篮球"){csProIndex=1;}
     else if(csProHomeMatchType=="lol"){csProIndex=2;}
     if(csProSwitchTabBarController!=null){
       csProSwitchTabBarController!.csMethodStartAnmat(csProIndex);
     }
    if(controller!=null){
      controller!.jumpToPage(csProIndex);
    }
    }
  }

