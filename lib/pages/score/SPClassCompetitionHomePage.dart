
import 'package:changshengh5/app/SPClassApplicaion.dart';
import 'package:changshengh5/pages/competition/SPClassMatchListSettingPage.dart';
import 'package:changshengh5/pages/competition/filter/SPClassFilterHomePage.dart';
import 'package:changshengh5/untils/SPClassCommonMethods.dart';
import 'package:changshengh5/untils/SPClassImageUtil.dart';
import 'package:changshengh5/untils/SPClassNavigatorUtils.dart';
import 'package:changshengh5/untils/colors.dart';
import 'package:changshengh5/widgets/SPClassSwitchTabBar.dart';
import 'package:flutter/material.dart';

import 'SPClassTabMatchInfoPage.dart';



class SPClassCompetitionHomePage extends StatefulWidget
{

  SPClassCompetitionHomePageState ?spProState;
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return  spProState=SPClassCompetitionHomePageState();
  }


}

class SPClassCompetitionHomePageState extends State<SPClassCompetitionHomePage> with AutomaticKeepAliveClientMixin{
  static int spProIndex = 0;
  List<SPClassTabMatchInfoPage> spProPages=[];
  var titles=["足球","篮球"];
  var spProMatchTypes=["足球","篮球"];
  SPClassSwitchTabBarState ?spProSwitchTabBarController;
  PageController ?controller;
  var spProHiddenFilter= false;
  @override
    void initState() {
    // TODO: implement initState
    super.initState();
    // if(SPClassApplicaion.spProShowMenuList.contains("es")){
    //   titles.add("电竞");
    //   spProMatchTypes.add("lol");
    // }
    
    spProPages=spProMatchTypes.map((item)=>SPClassTabMatchInfoPage(item),).toList();
    // 标记
    // spFunSetTabIndex( SPClassHomePageState.spProHomeMatchType);
    controller =PageController(initialPage: spProIndex);
    SPClassApplicaion.spProEventBus.on<String>().listen((event) {
      if(event.startsWith("scheme:refresh")){
        // 标记
        // spFunSetTabIndex( SPClassHomePageState.spProHomeMatchType);
      }
      if(event==("score:hidden")){
        setState(() {
          spProHiddenFilter=true;
        });
      }
      if(event==("score:show")){
        setState(() {
          spProHiddenFilter=false;
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
              SPClassImageUtil.spFunGetImagePath('ic_match_setting'),
              width: width(19),
              color: Colors.white,
            ),
            onPressed: (){
              if(spFunIsLogin(context: context)){
                SPClassNavigatorUtils.spFunPushRoute(context,SPClassMatchListSettingPage());
              }
            },
          ),
          title:  SPClassSwitchTabBar(
            spProTabTitles:titles,
            index:spProIndex,
            fontSize: sp(17),
            width: width(67*titles.length),
            height: width(29),
            spProGetState: (state){
              spProSwitchTabBarController=state;
            },
            spProTabChanged: (index){
              spProIndex=index;
              controller!.jumpToPage(index);
              // 标记
              // SPClassHomePageState.spProHomeMatchType=titles[spProIndex];
            },
          ),
          actions: <Widget>
          [
            spProHiddenFilter?  SizedBox():IconButton(
              padding: EdgeInsets.zero,
              icon: Image.asset(
                SPClassImageUtil.spFunGetImagePath('ic_filter'),
                width: width(19),
                color: Colors.white,
              ),
              onPressed: (){
                SPClassNavigatorUtils.spFunPushRoute(context,SPClassFilterHomePage(
                  spProPages[spProIndex].spProState!.spFunGetLeagueName,
                  spProIsHot: spProPages[spProIndex].spProState!.spFunIsMatchHot,
                  param:spProPages[spProIndex].spProState!.spFunGetParams,
                  callback: (value,value2){
                    spFunCurrentPage.spProState!.spFunReFreshByFilter(value,value2);
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
        children:spProPages ,
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
  SPClassTabMatchInfoPage get spFunCurrentPage=> spProPages[spProIndex];

  void spFunSetTabIndex(String spProHomeMatchType) {
    if(spProHomeMatchType=="足球"){spProIndex=0;}
     else if(spProHomeMatchType=="篮球"){spProIndex=1;}
     else if(spProHomeMatchType=="lol"){spProIndex=2;}
     if(spProSwitchTabBarController!=null){
       spProSwitchTabBarController!.spFunStartAnmat(spProIndex);
     }
    if(controller!=null){
      controller!.jumpToPage(spProIndex);
    }
    }
  }

