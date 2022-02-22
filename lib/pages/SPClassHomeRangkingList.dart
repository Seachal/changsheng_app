import 'package:changshengh5/api/SPClassApiManager.dart';
import 'package:changshengh5/api/SPClassHttpCallBack.dart';
import 'package:changshengh5/model/SPClassExpertListEntity.dart';
import 'package:changshengh5/untils/SPClassCommonMethods.dart';
import 'package:changshengh5/untils/SPClassImageUtil.dart';
import 'package:changshengh5/untils/SPClassMatchDataUtils.dart';
import 'package:changshengh5/untils/SPClassNavigatorUtils.dart';
import 'package:changshengh5/untils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:math' as math;

import 'anylise/SPClassExpertDetailPage.dart';



class SPClassHomeRangkingList extends StatefulWidget{
  String ?order_key;
  String ?spProMatchType ;
  SPClassHomeRangkingListState ?spProState;
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return spProState=SPClassHomeRangkingListState();
  }

  SPClassHomeRangkingList(this.order_key,this.spProMatchType);

}


class SPClassHomeRangkingListState extends State<SPClassHomeRangkingList> with AutomaticKeepAliveClientMixin<SPClassHomeRangkingList>,TickerProviderStateMixin<SPClassHomeRangkingList>{
  List<SPClassExpertListExpertList> spProExpertList=[];
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
    views.addAll(spProExpertList.map((expertItem){
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
                      child:( expertItem.spProAvatarUrl==null||expertItem.spProAvatarUrl!.isEmpty)? Image.asset(
                        SPClassImageUtil.spFunGetImagePath("ic_default_avater"),
                        width: width(46),
                        height: width(46),
                      ):Image.network(
                        expertItem.spProAvatarUrl!,
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
                          expertItem.spProLast10Result!.length.toString()+
                          "中"+
                          "${expertItem.spProLast10CorrectNum}":
                      (widget.order_key=="max_red_num" )?//连红
                      "${expertItem.spProMaxRedNum}"+
                          "连红":
                      (widget.order_key=="recent_correct_rate" )?//胜率
                      (SPClassMatchDataUtils.spFunCalcBestCorrectRate(expertItem.spProLast10Result!)*100).toStringAsFixed(0)+
                          "%": (double.tryParse(expertItem.spProRecentProfitSum!)!*100).toStringAsFixed(0)+
                          "%"
                        ,style: TextStyle(fontSize: sp(12),color: Colors.white,fontWeight: FontWeight.w500),maxLines: 1,),
                    ),
                  )
                ],
              ),
              SizedBox(height:width(8),),
              Text("${expertItem.spProNickName}",style: TextStyle(fontSize: sp(11),color: MyColors.grey_99),maxLines: 1,overflow: TextOverflow.ellipsis,textAlign: TextAlign.center,)
            ],
          ),
          onTap: (){
            SPClassApiManager.spFunGetInstance().spFunLogAppEvent(spProEventName: "view_hot_expert",targetId:expertItem.spProUserId);
            SPClassApiManager.spFunGetInstance().spFunExpertInfo(queryParameters: {"expert_uid":expertItem.spProUserId},
                context:context,spProCallBack: SPClassHttpCallBack(
                    spProOnSuccess: (info){
                      SPClassNavigatorUtils.spFunPushRoute(context,  SPClassExpertDetailPage(info,spProIsStatics: false,));
                    },onError: (e){},spProOnProgress: (v){}
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
     params= {"fetch_type":widget.order_key,"${widget.spProMatchType}":"1"};

   }else{
     params= {"order_key":widget.order_key,"ranking_type":"近7天","${widget.spProMatchType}":"1"};
   }
    SPClassApiManager.spFunGetInstance().spFunExpertList(queryParameters:params,spProCallBack: SPClassHttpCallBack<SPClassExpertListEntity>(
        spProOnSuccess: (list){
          if(list.spProExpertList!=null&&list.spProExpertList!.length>0){
            if(mounted){
              setState(() {
                spProExpertList=list.spProExpertList!.take(5).toList();
              });
            }
          }
        },onError: (v){},spProOnProgress: (v){}
    ));

  }





}