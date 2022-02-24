import 'package:changshengh5/pages/anylise/SPClassSearchExpertPage.dart';
import 'package:changshengh5/pages/home/FollowPage.dart';
import 'package:changshengh5/utils/SPClassCommonMethods.dart';
import 'package:changshengh5/utils/SPClassImageUtil.dart';
import 'package:changshengh5/utils/SPClassNavigatorUtils.dart';
import 'package:changshengh5/utils/colors.dart';
import 'package:flutter/material.dart';

import 'SPClassExpertLeaderboardPage.dart';


class SPClassExpertHomePage extends StatefulWidget{
  SPClassExpertHomePageState ?spProState;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return  spProState=SPClassExpertHomePageState();
  }

}

class SPClassExpertHomePageState extends State<SPClassExpertHomePage> with TickerProviderStateMixin ,AutomaticKeepAliveClientMixin{
  var titles=["关注","榜单","专家"];
  var spProTabTitle=["关注专家的方案","榜单"];
  List<Widget> views=[];
  static int index=1;
  PageController ?spProPageController;
  TabController ?spProTabMatchController;   //顶部导航栏
  List spProTabMatchTitles = ['关注', '足球', '篮球',];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    spProTabMatchController =
        TabController(length: spProTabMatchTitles.length,initialIndex: 1, vsync: this);
    spProPageController=PageController(initialPage: index);
    spProTabMatchController?.addListener(() {
      setState(() {
      });
    });
    //views=[/*FollowHomePage(),*/SPClassExpertLeaderboardPage()/*,ExpertListPage()*/];
    views=[FollowPage(),SPClassExpertLeaderboardPage(matchType: 'is_zq_expert',),SPClassExpertLeaderboardPage(matchType: 'is_lq_expert',)];
    /*if(index==1){
      ApiManager.getInstance().logAppEvent(spProEventName: "view_expert_ranking",);
    }*/
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    super.build(context);
    return Scaffold(
      backgroundColor: Color(0xFFF2F2F2),
      appBar: PreferredSize(
          child: AppBar(
            elevation: 0,
          ),
          preferredSize: Size.fromHeight(0)),
      body: Column(
        children: <Widget>[
          Container(
            color: MyColors.main1,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    color: MyColors.main1,
                    height: width(48),
                    padding:EdgeInsets.symmetric(horizontal: width(20)),
                    child: Container(
                      height: width(27),
                      child: TabBar(
                          indicatorColor: Colors.transparent,
                          labelColor: MyColors.main1,
                          labelPadding: EdgeInsets.zero,
                          unselectedLabelColor: Colors.white,
                          unselectedLabelStyle: TextStyle(fontSize: sp(17),),
                          isScrollable: false,
                          // indicatorSize:TabBarIndicatorSize.label,
                          labelStyle: TextStyle(fontSize: sp(17),
                            fontWeight: FontWeight.w500,),
                          controller: spProTabMatchController,
                          tabs: spProTabMatchTitles.map((key) {
                            return Container(
                              width: width(65),
                              height: width(27),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color:spProTabMatchController?.index==spProTabMatchTitles.indexOf(key)?Colors.white: MyColors.main1,
                                borderRadius: BorderRadius.circular(width(150)),
                              ),
                              child: Text(key),
                            );
                          }).toList()),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: width(20)),
                  child: GestureDetector(
                    child: Image.asset(
                      SPClassImageUtil.spFunGetImagePath("ic_search"),
                      width: width(16),
                      fit: BoxFit.fitWidth,
                      color: Colors.white,
                    ),
                    onTap: (){
                      SPClassNavigatorUtils.spFunPushRoute(context, SPClassSearchExpertPage());
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: spProTabMatchController,
              children: views,
            ),
          )
        ],
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

 /* void tapTopItem(index){
    spProPageController.jumpToPage(index);
    setState(() {
      ExpertHomePageState.index=index;
    });
    if(index==1){
      ApiManager.getInstance().logAppEvent(spProEventName: "view_expert_ranking",);
    }
    if(index==2){
      ApiManager.getInstance().logAppEvent(spProEventName: "view_expert_list",);
    }
  }*/

}