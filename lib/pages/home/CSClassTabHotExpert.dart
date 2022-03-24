import 'package:changshengh5/api/CSClassApiManager.dart';
import 'package:changshengh5/app/CSClassApplicaion.dart';
import 'package:changshengh5/utils/CSClassCommonMethods.dart';
import 'package:changshengh5/utils/CSClassImageUtil.dart';
import 'package:changshengh5/utils/colors.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../CSClassHomeRangkingList.dart';

class CSClassTabHotExpert extends StatefulWidget {
 String ?csProMatchType ;
 CSClassTabHotExpertState ?csProState;

 CSClassTabHotExpert(this.csProMatchType);
 @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return csProState=CSClassTabHotExpertState();
  }

}


class CSClassTabHotExpertState extends State<CSClassTabHotExpert> with TickerProviderStateMixin{
  // var csProTabExpertTitles=["胜率","连红"];
  var csProTabExpertTitles=['推荐','胜率','连红','回报'];
  List<CSClassHomeRangkingList> csProExpertViews=[];
  late TabController csProTabExpertController;
  var csProTabExpertKey=["hot",/*"recent_correct_rate"*/'correct_rate','max_red_num','recent_profit'];

  get csProBodyParameters => null;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    csProTabExpertController=TabController(length: csProTabExpertTitles.length,vsync: this);
    csProExpertViews=csProTabExpertKey.map((key){ return CSClassHomeRangkingList(key,widget.csProMatchType); }).toList();

  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  Container(
      color: Colors.white,
      margin: EdgeInsets.only(top: width(16),/*left: width(10),right: width(10),*/),
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: width(16),right: width(16)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  height:width(25),
                  width: width(240),
                  decoration: BoxDecoration(
                      color: Color(0xFFF2F2F2),
                      borderRadius: BorderRadius.circular(100)
                  ),
                  child:TabBar(
                    indicator: BoxDecoration(
                        color: MyColors.main1,
                        borderRadius: BorderRadius.circular(width(18)),
                    ),
                    labelColor: Colors.white,
                    labelPadding: EdgeInsets.zero,
                    unselectedLabelColor: Color(0xFF666666),
                    isScrollable: false,
                    indicatorSize:TabBarIndicatorSize.tab,
                    labelStyle: TextStyle(fontSize: sp(13),fontWeight: FontWeight.bold),
                    unselectedLabelStyle:  TextStyle(fontSize: sp(13)),
                    controller: csProTabExpertController,
                    tabs:csProTabExpertTitles.map((key){
                      return  Tab(text: key,);
                    }).toList() ,
                  ),
                ),
                Expanded(child: SizedBox(),),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    child: Image.asset(CSClassImageUtil.csMethodGetImagePath("youjiantou",),
                      width: width(23),
                      height: width(23),
                    ),
                  ),
                  onTap: (){
                    CSClassApplicaion.csProEventBus.fire("tab:expert");
                  },
                )
              ],
            ),
          ),
          Container(
            height: width(100),
            child: TabBarView(
              controller: csProTabExpertController,
              children: csProExpertViews,
            ),
          ),
        ],

      ),
    );
  }

 onRefresh(){
    csProExpertViews[csProTabExpertController.index].csProState?.onFunOnRefresh();
 }

 void csMethodGetBcwUrl(String value){
    if(csMethodIsLogin(context: context)){
      var params=CSClassApiManager.csMethodGetInstance().csMethodGetCommonParams();
      params.putIfAbsent("model_type", ()=>value);
//       CSClassNavigatorUtils.csMethodPushRoute(context, WebViewPage( CSClassNetConfig.csMethodGetBasicUrl()+"user/bcw/login?"+Transformer.urlEncodeMap(params),""));
    }
 }



}