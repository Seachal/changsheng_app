import 'package:changshengh5/app/SPClassApplicaion.dart';
import 'package:changshengh5/pages/login/SPClassVideoLoginPage.dart';
import 'package:changshengh5/pages/user/SPClassMyFollowExpertPage.dart';
import 'package:changshengh5/pages/user/scheme/follow/SPClassFollowSchemeListPage.dart';
import 'package:changshengh5/untils/SPClassCommonMethods.dart';
import 'package:changshengh5/untils/SPClassNavigatorUtils.dart';
import 'package:changshengh5/untils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class FollowPage extends StatefulWidget {
  _FollowPageState ?spProState;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return spProState = _FollowPageState();
  }
}

@override
// TODO: implement wantKeepAlive
bool get wantKeepAlive => true;

class _FollowPageState extends State<FollowPage> with  TickerProviderStateMixin<FollowPage>{
  late TabController _controller;
  List topTitle = ['关注专家','关注方案'];

  @override
  void initState() {
    _controller = TabController(
        length: topTitle.length,
        vsync: this,
    );
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return spFunIsLogin()?
    Column(
      children: <Widget>[
        Container(
          height: width(width(6)),
          color: Color(0xFFF2F2F2),
        ),
        Container(
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                  bottom: BorderSide(
                      width: 0.4, color: Colors.grey[300]!))),
          child: TabBar(
            labelColor: MyColors.main1,
            labelPadding: EdgeInsets.zero,
            unselectedLabelColor: Color(0xFF666666),
            indicatorColor: MyColors.main1,
            isScrollable: false,
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorPadding: EdgeInsets.symmetric(horizontal: width(80)),
            labelStyle:TextStyle(fontSize: sp(15),
                fontWeight: FontWeight.bold),
            unselectedLabelStyle:
            TextStyle(fontSize: sp(15)),
            controller: _controller,
            tabs: topTitle.map((tab) {
              return Tab(
                text: tab,
              );
            }).toList(),
          ),
        ),
        Expanded(
          child:
          TabBarView(
            controller: _controller,
            children: <Widget>[
              SPClassMyFollowExpertPage(),
              SPClassFollowSchemeListPage('0'),
            ],
          ),
        )
      ],
    ):
    Center(child:
      GestureDetector(
        onTap: (){
          SPClassNavigatorUtils.spFunPushRoute(context, SPClassVideoLoginPage());
        },
        child: Text('请登录',style: TextStyle(color: Colors.blue,fontSize: sp(16),decoration: TextDecoration.underline),),
      ),
    );
  }
}
