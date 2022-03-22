import 'package:changshengh5/utils/CSClassCommonMethods.dart';
import 'package:changshengh5/utils/colors.dart';
import 'package:flutter/material.dart';

import 'FollowPage.dart';
import 'HomeDetailPage.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with TickerProviderStateMixin<HomePage> {
  List csProTabMatchTitles = ['关注', '足球', '篮球', /*'AI分析'*/];
  late TabController csProTabMatchController; //顶部导航栏
  int csProTabMatchIndex = 1; //顶部栏的下标

  @override
  void initState() {
    csProTabMatchController = TabController(
        length: csProTabMatchTitles.length, initialIndex: 1, vsync: this);
    csProTabMatchController.addListener(() {
      setState(() {

      });
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: AppBar(
          elevation: 0,
        ),
        preferredSize: Size.fromHeight(0),
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Container(
              color: MyColors.main1,
              height: width(48),
              padding: EdgeInsets.only(
                // top: height(14),
                // bottom: height(8),
                  left: width(18),
                  right: width(18)),
              child: Container(
                height: width(30),
                child: TabBar(
                    labelColor: MyColors.main1,
                    labelPadding: EdgeInsets.zero,
                    indicatorColor: Colors.transparent,
                    indicatorPadding: EdgeInsets.zero,
                    unselectedLabelColor: Colors.white,
                    unselectedLabelStyle: TextStyle(fontSize: sp(17),),
                    isScrollable: false,
                    // labelStyle: GoogleFonts.notoSansSC(
                    //   fontSize: sp(17),
                    //   fontWeight: FontWeight.w500,
                    // ),
                    labelStyle: TextStyle(
                      fontSize: sp(17),
                      fontWeight: FontWeight.w500,
                    ),
                    controller: csProTabMatchController,
                    tabs: csProTabMatchTitles.map((key) {
                      return Container(
                        width: width(65),
                        height: width(27),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color:csProTabMatchController.index==csProTabMatchTitles.indexOf(key)?Colors.white: MyColors.main1,
                          borderRadius: BorderRadius.circular(width(150)),
                        ),
                        child: Text(key),
                      );
                      // return Tab(
                      //   text: key,
                      // );
                    }).toList()),
              ),
            ),
            Expanded(
              child: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                controller: csProTabMatchController,
                children: <Widget>[
                  FollowPage(),
                  HomeDetailPage(type: 0,),
                  HomeDetailPage(type: 1,),
                  // AIAnalysis(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
