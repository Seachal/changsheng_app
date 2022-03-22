import 'package:changshengh5/api/CSClassApiManager.dart';
import 'package:changshengh5/api/CSClassHttpCallBack.dart';
import 'package:changshengh5/model/CSClassExpertListEntity.dart';
import 'package:changshengh5/utils/CSClassCommonMethods.dart';
import 'package:changshengh5/utils/CSClassImageUtil.dart';
import 'package:changshengh5/utils/CSClassMatchDataUtils.dart';
import 'package:changshengh5/utils/CSClassNavigatorUtils.dart';
import 'package:changshengh5/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:math' as math;

import 'anylise/CSClassExpertDetailPage.dart';



class CSClassHomeRangkingList extends StatefulWidget{
  String ?order_key;
  String ?csProMatchType ;
  CSClassHomeRangkingListState ?csProState;
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return csProState=CSClassHomeRangkingListState();
  }

  CSClassHomeRangkingList(this.order_key,this.csProMatchType);

}


class CSClassHomeRangkingListState extends State<CSClassHomeRangkingList> with AutomaticKeepAliveClientMixin<CSClassHomeRangkingList>,TickerProviderStateMixin<CSClassHomeRangkingList>{
  List<CSClassExpertListExpertList> csProExpertList=[];
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
 @override
  void initState() {
    // TODO: implement initState
    super.initState();

   onFunOnRefresh();
 }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    super.build(context);

    return Container(
      alignment: Alignment.center,
      height: height(100),
      child: GridView.count(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        //水平子Widget之间间距
        crossAxisSpacing:width(5),
        //垂直子Widget之间间距
        mainAxisSpacing:0,
        //GridView内边距
        padding: EdgeInsets.only(left: width(15),right: width(15)),
        //一行的Widget数量
        crossAxisCount: 5,
        //子Widget宽高比例
        childAspectRatio: (width(340)/5)/width(100),
        children:buildViews() ,
      ),
    );
  }

  buildViews() {
    List<Widget> views=[];
    views.addAll(csProExpertList.map((expertItem){
      return Container(
        margin: EdgeInsets.only(top: width(8),bottom: width(4)),
        decoration: BoxDecoration(
           color: Colors.white,
           borderRadius: BorderRadius.circular(4),
            boxShadow:[
              BoxShadow(
                offset: Offset(0,0),
                color: Color(0xFFCED4D9),
                blurRadius:width(1,),),
            ],
        ),
        alignment: Alignment.center,
        child: GestureDetector(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Stack(
                overflow: Overflow.visible,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(width: 0.4,color: Colors.grey[300]!),
                        borderRadius: BorderRadius.circular(200)),
                    child:  ClipRRect(
                      borderRadius: BorderRadius.circular(200),
                      child:( expertItem.csProAvatarUrl==null||expertItem.csProAvatarUrl!.isEmpty)? Image.asset(
                        CSClassImageUtil.csMethodGetImagePath("ic_default_avater"),
                        width: width(46),
                        height: width(46),
                      ):Image.network(
                        expertItem.csProAvatarUrl!,
                        width: width(46),
                        height: width(46),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: -width(8),
                    child: Container(
                      alignment: Alignment.center,
                      width: width(46),
                      height: width(16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(300),
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Color(0xFFFF8C66),Color(0xFFF75231)]
                        ),
                      ),
                      child: Text((widget.order_key=="hot" )?//推荐
                      "近"+
                          expertItem.csProLast10Result!.length.toString()+
                          "中"+
                          "${expertItem.csProLast10CorrectNum}":
                      (widget.order_key=="max_red_num" )?//连红
                      "${expertItem.csProMaxRedNum}"+
                          "连红":
                      (widget.order_key=="correct_rate" )?//胜率
                      // (CSClassMatchDataUtils.csMethodCalcBestCorrectRate(expertItem.csProLast10Result!)*100).toStringAsFixed(0)+
                      (double.tryParse(expertItem.csProCorrectRate!)!*100).toStringAsFixed(0)+
                          "%": (double.tryParse(expertItem.csProRecentProfitSum!)!*100).toStringAsFixed(0)+
                          "%"
                        ,style: TextStyle(fontSize: sp(9),color: Colors.white,fontWeight: FontWeight.w500),maxLines: 1,),
                    ),
                  )
                ],
              ),
              SizedBox(height:width(8),),
              Text("${expertItem.csProNickName}",style: TextStyle(fontSize: sp(11),color: MyColors.grey_99),maxLines: 1,overflow: TextOverflow.ellipsis,textAlign: TextAlign.center,)
            ],
          ),
          onTap: (){
            CSClassApiManager.csMethodGetInstance().csMethodLogAppEvent(csProEventName: "view_hot_expert",targetId:expertItem.csProUserId);
            CSClassApiManager.csMethodGetInstance().csMethodExpertInfo(queryParameters: {"expert_uid":expertItem.csProUserId},
                context:context,csProCallBack: CSClassHttpCallBack(
                    csProOnSuccess: (info){
                      CSClassNavigatorUtils.csMethodPushRoute(context,  CSClassExpertDetailPage(info,csProIsStatics: false,));
                    },onError: (e){},csProOnProgress: (v){}
                ));
          },
        ),
      );
    }).toList())  ;

    return views;
  }

  void onFunOnRefresh() {
    Map<String,dynamic> params;
   if(widget.order_key=="hot"){
     params= {"fetch_type":widget.order_key,"${widget.csProMatchType}":"1"};

   }else{
     params= {"order_key":widget.order_key,"ranking_type":"近10场","${widget.csProMatchType}":"1"};
   }
    CSClassApiManager.csMethodGetInstance().csMethodExpertList(queryParameters:params,csProCallBack: CSClassHttpCallBack<CSClassExpertListEntity>(
        csProOnSuccess: (list){
          if(list.csProExpertList!=null&&list.csProExpertList!.length>0){
            if(mounted){
              setState(() {
                csProExpertList=list.csProExpertList!.take(5).toList();
              });
            }
          }
        },onError: (v){},csProOnProgress: (v){}
    ));

  }





}