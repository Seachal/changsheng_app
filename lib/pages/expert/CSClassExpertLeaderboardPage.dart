import 'package:changshengh5/api/CSClassApiManager.dart';
import 'package:changshengh5/api/CSClassHttpCallBack.dart';
import 'package:changshengh5/app/CSClassApplicaion.dart';
import 'package:changshengh5/model/CSClassExpertListEntity.dart';
import 'package:changshengh5/pages/anylise/CSClassExpertDetailPage.dart';
import 'package:changshengh5/pages/common/CSClassNoDataView.dart';
import 'package:changshengh5/utils/CSClassCommonMethods.dart';
import 'package:changshengh5/utils/CSClassImageUtil.dart';
import 'package:changshengh5/utils/CSClassNavigatorUtils.dart';
import 'package:changshengh5/utils/CSClassToastUtils.dart';
import 'package:changshengh5/utils/colors.dart';
import 'package:changshengh5/widgets/CSClassBallFooter.dart';
import 'package:changshengh5/widgets/CSClassBallHeader.dart';
import 'package:changshengh5/widgets/CSClassExpandIcon.dart';
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart" hide ExpandIcon;
import "package:flutter_easyrefresh/easy_refresh.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";

import 'dart:math' as math;

class CSClassExpertLeaderboardPage extends StatefulWidget{
  final String ?matchType;

  const CSClassExpertLeaderboardPage({Key ?key, this.matchType}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CSClassExpertLeaderboardPageState();
  }

}

class CSClassExpertLeaderboardPageState extends State<CSClassExpertLeaderboardPage> with TickerProviderStateMixin ,AutomaticKeepAliveClientMixin{
   var csProTimeKey="近30天";
   var csProTimeKeys=[
     ["近期", "近30天"],
     [ "近期", "全周期"],
     ["近期","近30天"],
   ];
   String matchType = 'is_zq_expert';

   var csProBoardKey="胜率榜";
   var csProBoardTitles=["胜率榜", "连红榜","回报率"];
   var csProBoardTopTitles=["胜率", "最高连红","回报率"];
   var csProOrderKeys=["correct_rate", "max_red_num","profit_sum"];
   int page=1;

   var csProShowBroadDown=false;
   var csProShowTimerDown=false;
   EasyRefreshController ?controller;
   List<CSClassExpertListExpertList> csProExpertList=[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    matchType= widget.matchType??'is_zq_expert';
    controller=EasyRefreshController();
    // CSClassApplicaion.csProEventBus.on<String>().listen((event) {
    //   if(event.startsWith("scheme:refresh")){
    //
    //     onRefresh();
    //
    //   }
    // });
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    super.build(context);
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            height: width(width(6)),
            color: Color(0xFFF2F2F2),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
                bottom: BorderSide(width: 0.4,color: Colors.grey[300]!)
            ),
           ),
            height: width(40),
            child: Row(
             children: <Widget>[
              Expanded(
                child:  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: csProBoardTitles.map((e) {
                    return GestureDetector(
                      onTap: (){
                        csProTimeKey="近期";

                        csProExpertList.clear();
                        setState(() {
                          csProBoardKey=e;
                        });
                        controller?.callRefresh();
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: width(40),
                        decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(color: csProBoardKey==e?MyColors.main1:Colors.transparent,width: 2))
                        ),
                        child: Text(e,style: TextStyle(color:csProBoardKey==e?MyColors.main1:MyColors.grey_66 ),),
                      ),
                    );
                  }).toList(),
                ),
              ),
               GestureDetector(
                 onTap: (){
                   showCupertinoDialog(context: context,barrierLabel:'', builder: (context){
                     return GestureDetector(
                       onTap: (){
                         Navigator.pop(context);
                       },
                       child: Material(
                         color: Colors.transparent,
                         child: Column(
                           crossAxisAlignment: CrossAxisAlignment.end,
                           children: <Widget>[
                             Container(
                               child: Stack(
                                 children: <Widget>[
                                   Container(
                                     decoration: BoxDecoration(
                                         color: Color(0xFF475766),
                                         borderRadius: BorderRadius.circular(8)
                                     ),
                                     child: Column(
                                       children: csProTimeKeys[csProBoardTitles.indexOf(csProBoardKey)].map((e) {
                                         return GestureDetector(
                                           behavior: HitTestBehavior.translucent,
                                           onTap: (){
                                             csProExpertList.clear();
                                             setState(() {
                                               csProTimeKey=e;
                                             });
                                             controller?.callRefresh();
                                             Navigator.of(context).pop();
                                           },
                                           child: Container(
                                             decoration: BoxDecoration(
                                                 border: Border(bottom: BorderSide(width: 0.4,color: Color(0xFFF2F2F2)))
                                             ),
                                             padding: EdgeInsets.symmetric(horizontal: width(17),vertical: width(13)),
                                             child: Text(e,style: TextStyle(color: Colors.white,fontSize: sp(15)),),
                                           ),
                                         );
                                       }).toList(),
                                     ),
                                   ),
                                   Positioned(
                                     top:-width(5),
                                     right:width(15),
                                     child: Transform(
                                       alignment: Alignment.center,
                                       transform: Matrix4.rotationZ((math.pi)/4),
                                       child: Container(
                                         height: width(16),
                                         width: width(16),
                                         color: const Color(0xFF475766),
                                       ),
                                     ),
                                   )
                                 ],
                                 overflow: Overflow.visible,
                               ),
                               margin: EdgeInsets.only(right: width(15),top: MediaQuery.of(context).padding.top+width(100)),
                             ),
                           ],
                         ),
                       ),
                     );
                   });
                 },
                 child: Container(
                   padding: EdgeInsets.symmetric(horizontal: width(23),vertical: width(10)),
                   child: Row(
                     children: <Widget>[
                       Text(csProTimeKey,style: TextStyle(color: MyColors.grey_66,fontSize: sp(13)),),
                       CSClassExpandIcon(
                         padding: EdgeInsets.zero,
                         isExpanded: csProShowBroadDown,
                         color: Colors.grey[300],
                       ),
                     ],
                   ),
                 ),
               )
             ],
        ),
      ),
          Expanded(
          child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow:[
                BoxShadow(
                  offset: Offset(2,5),
                  color: Color(0x0C000000),
                  blurRadius:width(6,),),
                BoxShadow(
                  offset: Offset(-5,1),
                  color: Color(0x0C000000),
                  blurRadius:width(6,),
                )
              ],
              borderRadius: BorderRadius.circular(width(7))
          ),
          child: EasyRefresh.custom(
            controller: controller,
            onRefresh: onRefresh,
            firstRefresh: true,
            header: CSClassBallHeader(
                textColor: Color(0xFF666666)
            ),
            footer: CSClassBallFooter(
                textColor: Color(0xFF666666)
            ),
            emptyWidget: csProExpertList.isEmpty? CSClassNoDataView():null,
            slivers: <Widget>[
              SliverList(
                delegate: SliverChildBuilderDelegate(
                      (context, index) {
                    var item=csProExpertList[index];
                    return GestureDetector(
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border(bottom: BorderSide(width: 0.4,color: Colors.grey[300]!))
                        ),
                        height: height(46),
                        child: Row(
                          children: <Widget>[
                            Container(
                              width: width(46),
                              height: height(46),
                              alignment: Alignment.center,
                              child: (index<3&&index>=0) ?
                              buildMedal(index+1):Text((index+1).toString(),style: TextStyle(fontSize: sp(17),color: MyColors.grey_33),),
                            ),
                            Expanded(
                              child: Container(
                                width: width(110),
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(width: 1,color: Colors.grey[200]!),
                                          borderRadius: BorderRadius.circular(150)),
                                      child:  ClipOval(
                                        child:( item.csProAvatarUrl==null||item.csProAvatarUrl!.isEmpty)? Image.asset(
                                          CSClassImageUtil.csMethodGetImagePath("cs_default_avater"),
                                          width: width(40),
                                          height: width(40),
                                        ):Image.network(
                                          item.csProAvatarUrl!,
                                          width: width(40),
                                          height: width(40),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: width(6),),
                                    Expanded(
                                      child:Text(item.csProNickName!,style: TextStyle(fontSize: sp(14),color: Color(0xFF333333)),maxLines: 1,overflow: TextOverflow.ellipsis,),
                                    ),
                                  ],
                                ),

                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: width(15)),
                              alignment: Alignment.center,
                              child: Text(getboardTitleValue(item),style: TextStyle(fontSize: sp(17),color: Color(0xFFE3494B),fontWeight: FontWeight.w500),maxLines: 1,),
                            ),
                            GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              onTap: (){
                                if(csMethodIsLogin(context: context)){
                                  CSClassApiManager.csMethodGetInstance().csMethodFollowExpert(isFollow: !item.csProIsFollowing!,csProExpertUid: item.csProUserId,context: context,csProCallBack: CSClassHttpCallBack(
                                      csProOnSuccess: (result){
                                        if(!item.csProIsFollowing!){
                                          CSClassToastUtils.csMethodShowToast(msg: "关注成功");
                                          item.csProIsFollowing=true;
                                        }else{
                                          item.csProIsFollowing=false;
                                        }
                                        setState(() {});
                                      },onError: (e){},csProOnProgress: (v){}
                                  ));
                                }
                              },
                              child: Container(
                                margin: EdgeInsets.only(right: width(15)),
                                width: width(61),
                                height: width(27),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14),
                                  border: Border.all(color:item.csProIsFollowing!?MyColors.grey_cc: MyColors.main1,width: 0.5),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(item.csProIsFollowing!? Icons.check:Icons.add,color: item.csProIsFollowing!?MyColors.grey_cc:MyColors.main1,size: width(15),),
                                    Text(item.csProIsFollowing!? "已关注":"关注",style: TextStyle(color:item.csProIsFollowing!?MyColors.grey_cc: MyColors.main1,fontSize: sp(12)),)
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      onTap: (){
                        CSClassApiManager.csMethodGetInstance().csMethodExpertInfo(queryParameters: {"expert_uid":item.csProUserId},
                            context:context,csProCallBack: CSClassHttpCallBack(
                                csProOnSuccess: (info){
                                  CSClassNavigatorUtils.csMethodPushRoute(context,  CSClassExpertDetailPage(info));
                                },onError: (e){},csProOnProgress: (v){}
                            ));
                      },

                    );
                  },
                  childCount: csProExpertList.length,
                ),
              ),
            ],
          ),

        ),
      )
         ],
      ),
    ) ;
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

   Future<void>  onRefresh() async{

     page=1;
     var params;
     var csProRankingType=csProTimeKey.toString();
     if(csProBoardKey=="胜率榜"||csProBoardKey=="回报率"){
        if(csProTimeKey=="近期"){
          csProRankingType="近10场";
        }
     }
     if(csProTimeKey=="近期"&&csProBoardKey=="连红榜"){
       params={
         "fetch_type":"current_red_num",
          "page":"1",
         "$matchType":"1"
       };
     }else{
       params= {"order_key":csProOrderKeys[csProBoardTitles.indexOf(csProBoardKey)],"page":"1","ranking_type":csProRankingType,"$matchType":"1"};
     }



     await Future.delayed(Duration(seconds: 1));
     await  CSClassApiManager.csMethodGetInstance().csMethodExpertList(queryParameters: params,csProCallBack: CSClassHttpCallBack<CSClassExpertListEntity>(
         csProOnSuccess: (list){
           controller?.finishLoad(success: true);
           controller?.resetRefreshState();

           if(mounted){
             setState(() {
               csProExpertList=list.csProExpertList!;
             });
           }
         },
         onError: (value){
           controller?.finishLoad(success: false);
         },csProOnProgress: (v){}
     ));
   }

   Future<void>  onLoading() async{
     var params;
       params= {"order_key":csProOrderKeys[csProBoardTitles.indexOf(csProBoardKey)],"page":(page+1).toString(),"ranking_type":csProTimeKey,"$matchType":"1"};

     await CSClassApiManager.csMethodGetInstance().csMethodExpertList(queryParameters:params,csProCallBack: CSClassHttpCallBack<CSClassExpertListEntity>(
         csProOnSuccess: (list){
           if(list.csProExpertList!.isEmpty){
             controller?.finishLoad(noMore: true);
           }else{
             controller?.finishLoad(success: true);
             page++;
           }

           if(mounted){
             setState(() {
               csProExpertList.addAll(list.csProExpertList!);
             });
           }
         },
         onError: (value){
           controller?.finishLoad(success: false);
         }
     ));
   }

   buildMedal(int ranking) {
     return Image.asset(
       CSClassImageUtil.csMethodGetImagePath(ranking==1? "cs_leaderbord_one":(ranking==2? "cs_leaderbord_two":"cs_leaderbord_three")),
       width: width(30),
     );

   }

  void initList(CSClassExpertListEntity list) {
     if(list.csProExpertList!=null&&list.csProExpertList!.isNotEmpty){
       list.csProExpertList?.forEach((item) {
          item.csProCorrectRate=(double.parse(item.csProLast10CorrectNum!)/item.csProLast10Result!.length).toStringAsFixed(2);
          item.csProCorrectSchemeNum=item.csProLast10Result!.replaceAll("0", "").replaceAll("2", "").length.toString();
          item.csProDrawSchemeNum=item.csProLast10Result!.replaceAll("0", "").replaceAll("1", "").length.toString();
          item.csProWrongSchemeNum=item.csProLast10Result!.replaceAll("1", "").replaceAll("2", "").length.toString();
       });

     }
  }

  String getboardTitleValue(CSClassExpertListExpertList item) {

     if(csProOrderKeys[csProBoardTitles.indexOf(csProBoardKey)]=="correct_rate"){

       try{
         return "${(double.tryParse(item.csProCorrectRate!)!*100).toStringAsFixed(0)}%";
       }catch(e){
         return "";
       }
     }

     if(csProOrderKeys[csProBoardTitles.indexOf(csProBoardKey)]=="max_red_num"){
        if(csProTimeKey=="近期"){
          return '${item.csProCurrentRedNum}连红';
        }
       return '${item.csProMaxRedNum}连红';
     }

     if(csProOrderKeys[csProBoardTitles.indexOf(csProBoardKey)]=="profit_sum"){

       try{
         return "${(double.tryParse(item.csProProfitSum!)!*100).toStringAsFixed(0)}%";
       }catch(e){
         return "";
       }
     }

     return "";
  }


}

class CustomContainer extends Container {
  final Widget ?child;
  final double ?width;
  final double ?height;
  final Decoration ?decoration;
  final Function ?onTap;  // 添加点击事件

  CustomContainer({
    Key? key,
    this.child,
    this.width,
    this.height,
    this.decoration,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget widget = Container(
      width: this.width,
      height: this.height,
      decoration: decoration,
      child: InkWell( // 添加点击事件
        child: child,
        onTap: onTap!(),
        // 去除水波纹效果
        splashColor:Colors.transparent,
        highlightColor: Colors.transparent,
      ),
    );
    return widget;
  }
}