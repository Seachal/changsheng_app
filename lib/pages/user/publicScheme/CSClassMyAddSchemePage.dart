import 'package:changshengh5/utils/CSClassCommonMethods.dart';
import 'package:changshengh5/utils/CSClassNavigatorUtils.dart';
import 'package:changshengh5/utils/colors.dart';
import 'package:changshengh5/widgets/CSClassToolBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'CSClassMyAddSchemeListPage.dart';
import 'CSClassPublicSchemePage.dart';
import 'CSClassSchemeIncomeReportPage.dart';


class CSClassMyAddSchemePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CSClassMyAddSchemePageState();
  }

}

class CSClassMyAddSchemePageState extends State<CSClassMyAddSchemePage> with TickerProviderStateMixin {
  var csProTabTitle=["我的发布","我的收益"];
  TabController ?csProTabController;
  List<Widget> views=[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    csProTabController=TabController(length: csProTabTitle.length,vsync: this);
    views=[CSClassMyAddSchemeListPage(),CSClassSchemeIncomeReportPage(),];

  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: CSClassToolBar(
        context,
        title:"发布中心",
        actions: <Widget>[
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            child: Row(
              children: <Widget>[

                // CSClassEncryptImage.asset(CSClassImageUtil.csMethodGetImagePath("ic_shceme_public"),width: width(14),),
                SizedBox(width: width(3),),
                Text("去发布",style: TextStyle(color: Colors.white,fontSize: sp(13)),),
                SizedBox(width:width(15) ,),
              ],
            ),
            onTap: (){
              CSClassNavigatorUtils.csMethodPushRoute(context, CSClassPublicSchemePage());

            },
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              height: width(6),
              color: Color(0xFFF2F2F2),
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(bottom: BorderSide(width: 0.4,color: Colors.grey[300]!),top: BorderSide(width: 0.4,color: Colors.grey[300]!))
              ),
              child: TabBar(
                  labelColor: MyColors.main1,
                  unselectedLabelColor: Color(0xFF666666),
                  isScrollable: false,
                  indicatorColor: MyColors.main1,
                  indicatorPadding: EdgeInsets.symmetric(horizontal: width(60)),
                  labelStyle: TextStyle(fontSize: sp(15),fontWeight: FontWeight.bold),
                  unselectedLabelStyle: TextStyle(fontSize: sp(15),fontWeight: FontWeight.w400),
                  controller: csProTabController,
                  indicatorSize: TabBarIndicatorSize.label,
                  tabs:csProTabTitle.map((csProTabTitle){
                    return Stack(
                      children: <Widget>[
                        Container(
                          alignment: Alignment.center,
                          height: width(38),
                          child:Text(csProTabTitle,style: TextStyle(letterSpacing: 0,wordSpacing: 0,fontSize: sp(15)),),
                        ),
                       // csProTabTitle=="我的收益"? Positioned(
                       //    top: 0,
                       //    right: width(20),
                       //    child:   GestureDetector(
                       //      behavior: HitTestBehavior.opaque,
                       //      child: Container(
                       //        padding: EdgeInsets.all(3),
                       //        child: CSClassEncryptImage.asset(CSClassImageUtil.csMethodGetImagePath("ic_rulu_tip"),width: width(12),),
                       //      ),
                       //      onTap: (){
                       //        showDialog(context: context,child: CSClassAddSchemeRuleTipDialog(callback: (){
                       //        },));
                       //      },
                       //    ),
                       //
                       //  ):SizedBox()
                      ],
                    );
                  }).toList()
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: csProTabController,
                children:views,
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


}