import 'package:changshengh5/api/SPClassApiManager.dart';
import 'package:changshengh5/app/SPClassApplicaion.dart';
import 'package:changshengh5/untils/SPClassCommonMethods.dart';
import 'package:changshengh5/untils/SPClassImageUtil.dart';
import 'package:changshengh5/untils/colors.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../SPClassHomeRangkingList.dart';

class SPClassTabHotExpert extends StatefulWidget {
 String ?spProMatchType ;
 SPClassTabHotExpertState ?spProState;

 SPClassTabHotExpert(this.spProMatchType);
 @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return spProState=SPClassTabHotExpertState();
  }

}


class SPClassTabHotExpertState extends State<SPClassTabHotExpert> with TickerProviderStateMixin{
  // var spProTabExpertTitles=["胜率","连红"];
  var spProTabExpertTitles=['推荐','胜率','连红','回报'];
  List<SPClassHomeRangkingList> spProExpertViews=[];
  late TabController spProTabExpertController;
  var spProTabExpertKey=["hot","recent_correct_rate",'max_red_num','recent_profit'];

  get spProBodyParameters => null;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    spProTabExpertController=TabController(length: spProTabExpertTitles.length,vsync: this);
    spProExpertViews=spProTabExpertKey.map((key){ return SPClassHomeRangkingList(key,widget.spProMatchType); }).toList();

  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  Container(
      color: Colors.white,
      margin: EdgeInsets.only(top: width(18),/*left: width(10),right: width(10),*/bottom:  width(8)),
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
                    controller: spProTabExpertController,
                    tabs:spProTabExpertTitles.map((key){
                      return  Tab(text: key,);
                    }).toList() ,
                  ),
                ),
                Expanded(child: SizedBox(),),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    child: Image.asset(SPClassImageUtil.spFunGetImagePath("youjiantou",),
                      width: width(23),
                      height: width(23),
                    ),
                  ),
                  onTap: (){
                    SPClassApplicaion.spProEventBus.fire("tab:expert");
                  },
                )
              ],
            ),
          ),
          Container(
            height: width(100),
            child: TabBarView(
              controller: spProTabExpertController,
              children: spProExpertViews,
            ),
          ),
        ],

      ),
    );
  }

 onRefresh(){
    spProExpertViews[spProTabExpertController.index].spProState?.onFunOnRefresh();
 }

 void spFunGetBcwUrl(String value){
    if(spFunIsLogin(context: context)){
      var params=SPClassApiManager.spFunGetInstance().spFunGetCommonParams();
      params.putIfAbsent("model_type", ()=>value);
//       SPClassNavigatorUtils.spFunPushRoute(context, WebViewPage( SPClassNetConfig.spFunGetBasicUrl()+"user/bcw/login?"+Transformer.urlEncodeMap(params),""));
    }
 }



}