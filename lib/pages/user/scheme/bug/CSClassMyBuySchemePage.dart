import 'package:changshengh5/utils/CSClassCommonMethods.dart';
import 'package:changshengh5/utils/colors.dart';
import 'package:changshengh5/widgets/CSClassToolBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'CSClassBuySchemeListPage.dart';


class CSClassMyBuySchemePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CSClassMyBuySchemePageState();
  }

}

class CSClassMyBuySchemePageState extends State<CSClassMyBuySchemePage> with TickerProviderStateMixin{
  var csProTabTitle=["未结束","已结束"];
  TabController ?csProTabController;
  List<Widget> ?views;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    csProTabController=TabController(length: csProTabTitle.length,vsync: this);
    views=[CSClassBuySchemeListPage("0"),CSClassBuySchemeListPage("1")];

  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: CSClassToolBar(
        context,
        title:"已购的方案",
        csProBgColor: MyColors.main1,
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
                  controller: csProTabController,
                  indicatorSize: TabBarIndicatorSize.label,
                  tabs:csProTabTitle.map((csProTabTitle){
                    return Container(
                      alignment: Alignment.center,
                      height: height(35),
                      child:Text(csProTabTitle,style: TextStyle(letterSpacing: 0,wordSpacing: 0,fontSize: sp(15)),),
                    );
                  }).toList()
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: csProTabController,
                children:views!,
              ),
            )
          ],
        ),
      ),
    );
  }

}