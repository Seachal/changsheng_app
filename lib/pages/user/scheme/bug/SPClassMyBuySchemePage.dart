import 'package:changshengh5/utils/SPClassCommonMethods.dart';
import 'package:changshengh5/utils/colors.dart';
import 'package:changshengh5/widgets/SPClassToolBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'SPClassBuySchemeListPage.dart';


class SPClassMyBuySchemePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SPClassMyBuySchemePageState();
  }

}

class SPClassMyBuySchemePageState extends State<SPClassMyBuySchemePage> with TickerProviderStateMixin{
  var spProTabTitle=["未结束","已结束"];
  TabController ?spProTabController;
  List<Widget> ?views;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    spProTabController=TabController(length: spProTabTitle.length,vsync: this);
    views=[SPClassBuySchemeListPage("0"),SPClassBuySchemeListPage("1")];

  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: SPClassToolBar(
        context,
        title:"已购的方案",
        spProBgColor: MyColors.main1,
        iconColor: 0xffffffff,
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(bottom: BorderSide(width: 0.4,color: Colors.grey[300]!),top: BorderSide(width: 0.4,color: Colors.grey[300]!))
              ),
              child: TabBar(
                  labelColor: MyColors.main1,
                  unselectedLabelColor: Color(0xFF333333),
                  isScrollable: false,
                  indicatorColor: MyColors.main1,
                  labelStyle: TextStyle(fontSize: sp(14),fontWeight: FontWeight.bold),
                  unselectedLabelStyle: TextStyle(fontSize: sp(14),fontWeight: FontWeight.w400),
                  controller: spProTabController,
                  indicatorSize: TabBarIndicatorSize.label,
                  tabs:spProTabTitle.map((spProTabTitle){
                    return Container(
                      alignment: Alignment.center,
                      height: height(35),
                      child:Text(spProTabTitle,style: TextStyle(letterSpacing: 0,wordSpacing: 0,fontSize: sp(15)),),
                    );
                  }).toList()
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: spProTabController,
                children:views!,
              ),
            )
          ],
        ),
      ),
    );
  }

}