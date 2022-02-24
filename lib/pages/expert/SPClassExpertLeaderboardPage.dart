import 'package:changshengh5/api/SPClassApiManager.dart';
import 'package:changshengh5/api/SPClassHttpCallBack.dart';
import 'package:changshengh5/app/SPClassApplicaion.dart';
import 'package:changshengh5/model/SPClassExpertListEntity.dart';
import 'package:changshengh5/pages/anylise/SPClassExpertDetailPage.dart';
import 'package:changshengh5/pages/common/SPClassNoDataView.dart';
import 'package:changshengh5/utils/SPClassCommonMethods.dart';
import 'package:changshengh5/utils/SPClassImageUtil.dart';
import 'package:changshengh5/utils/SPClassNavigatorUtils.dart';
import 'package:changshengh5/utils/SPClassToastUtils.dart';
import 'package:changshengh5/utils/colors.dart';
import 'package:changshengh5/widgets/SPClassBallFooter.dart';
import 'package:changshengh5/widgets/SPClassBallHeader.dart';
import 'package:changshengh5/widgets/SPClassExpandIcon.dart';
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart" hide ExpandIcon;
import "package:flutter_easyrefresh/easy_refresh.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";

import 'dart:math' as math;

class SPClassExpertLeaderboardPage extends StatefulWidget{
  final String ?matchType;

  const SPClassExpertLeaderboardPage({Key ?key, this.matchType}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SPClassExpertLeaderboardPageState();
  }

}

class SPClassExpertLeaderboardPageState extends State<SPClassExpertLeaderboardPage> with TickerProviderStateMixin ,AutomaticKeepAliveClientMixin{
   var spProTimeKey="近30天";
   var spProTimeKeys=[
     ["近期", "近30天"],
     [ "近期", "全周期"],
     ["近期","近30天"],
   ];
   String matchType = 'is_zq_expert';

   var spProBoardKey="胜率榜";
   var spProBoardTitles=["胜率榜", "连红榜","回报率"];
   var spProBoardTopTitles=["胜率", "最高连红","回报率"];
   var spProOrderKeys=["correct_rate", "max_red_num","profit_sum"];
   int page=1;

   var spProShowBroadDown=false;
   var spProShowTimerDown=false;
   EasyRefreshController ?controller;
   List<SPClassExpertListExpertList> spProExpertList=[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    matchType= widget.matchType??'is_zq_expert';
    controller=EasyRefreshController();
    // SPClassApplicaion.spProEventBus.on<String>().listen((event) {
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
                  children: spProBoardTitles.map((e) {
                    return GestureDetector(
                      onTap: (){
                        spProTimeKey="近期";

                        spProExpertList.clear();
                        setState(() {
                          spProBoardKey=e;
                        });
                        controller?.callRefresh();
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: width(40),
                        decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(color: spProBoardKey==e?MyColors.main1:Colors.transparent,width: 2))
                        ),
                        child: Text(e,style: TextStyle(color:spProBoardKey==e?MyColors.main1:MyColors.grey_66 ),),
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
                                       children: spProTimeKeys[spProBoardTitles.indexOf(spProBoardKey)].map((e) {
                                         return GestureDetector(
                                           behavior: HitTestBehavior.translucent,
                                           onTap: (){
                                             spProExpertList.clear();
                                             setState(() {
                                               spProTimeKey=e;
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
                       Text(spProTimeKey,style: TextStyle(color: MyColors.grey_66,fontSize: sp(13)),),
                       SPClassExpandIcon(
                         padding: EdgeInsets.zero,
                         isExpanded: spProShowBroadDown,
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
            header: SPClassBallHeader(
                textColor: Color(0xFF666666)
            ),
            footer: SPClassBallFooter(
                textColor: Color(0xFF666666)
            ),
            emptyWidget: spProExpertList.isEmpty? SPClassNoDataView():null,
            slivers: <Widget>[
              SliverList(
                delegate: SliverChildBuilderDelegate(
                      (context, index) {
                    var item=spProExpertList[index];
                    return GestureDetector(
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border(bottom: BorderSide(width: 0.4,color: Colors.grey[300]!))
                        ),
                        height: height(53),
                        child: Row(
                          children: <Widget>[
                            Container(
                              width: width(50),
                              height: height(53),
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
                                        child:( item.spProAvatarUrl==null||item.spProAvatarUrl!.isEmpty)? Image.asset(
                                          SPClassImageUtil.spFunGetImagePath("ic_default_avater"),
                                          width: width(46),
                                          height: width(46),
                                        ):Image.network(
                                          item.spProAvatarUrl!,
                                          width: width(46),
                                          height: width(46),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: width(8),),
                                    Expanded(
                                      child:Text(item.spProNickName!,style: TextStyle(fontSize: sp(17),color: Color(0xFF333333)),maxLines: 1,overflow: TextOverflow.ellipsis,),
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
                                if(spFunIsLogin(context: context)){
                                  SPClassApiManager.spFunGetInstance().spFunFollowExpert(isFollow: !item.spProIsFollowing!,spProExpertUid: item.spProUserId,context: context,spProCallBack: SPClassHttpCallBack(
                                      spProOnSuccess: (result){
                                        if(!item.spProIsFollowing!){
                                          SPClassToastUtils.spFunShowToast(msg: "关注成功");
                                          item.spProIsFollowing=true;
                                        }else{
                                          item.spProIsFollowing=false;
                                        }
                                        setState(() {});
                                      },onError: (e){},spProOnProgress: (v){}
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
                                  border: Border.all(color:item.spProIsFollowing!?MyColors.grey_cc: MyColors.main1,width: 0.5),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(item.spProIsFollowing!? Icons.check:Icons.add,color: item.spProIsFollowing!?MyColors.grey_cc:MyColors.main1,size: width(15),),
                                    Text(item.spProIsFollowing!? "已关注":"关注",style: TextStyle(color:item.spProIsFollowing!?MyColors.grey_cc: MyColors.main1,fontSize: sp(12)),)
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      onTap: (){
                        SPClassApiManager.spFunGetInstance().spFunExpertInfo(queryParameters: {"expert_uid":item.spProUserId},
                            context:context,spProCallBack: SPClassHttpCallBack(
                                spProOnSuccess: (info){
                                  SPClassNavigatorUtils.spFunPushRoute(context,  SPClassExpertDetailPage(info));
                                },onError: (e){},spProOnProgress: (v){}
                            ));
                      },

                    );
                  },
                  childCount: spProExpertList.length,
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
     var spProRankingType=spProTimeKey.toString();
     if(spProBoardKey=="胜率榜"||spProBoardKey=="回报率"){
        if(spProTimeKey=="近期"){
          spProRankingType="近10场";
        }
     }
     if(spProTimeKey=="近期"&&spProBoardKey=="连红榜"){
       params={
         "fetch_type":"current_red_num",
          "page":"1",
         "$matchType":"1"
       };
     }else{
       params= {"order_key":spProOrderKeys[spProBoardTitles.indexOf(spProBoardKey)],"page":"1","ranking_type":spProRankingType,"$matchType":"1"};
     }



     await Future.delayed(Duration(seconds: 1));
     await  SPClassApiManager.spFunGetInstance().spFunExpertList(queryParameters: params,spProCallBack: SPClassHttpCallBack<SPClassExpertListEntity>(
         spProOnSuccess: (list){
           controller?.finishLoad(success: true);
           controller?.resetRefreshState();

           if(mounted){
             setState(() {
               spProExpertList=list.spProExpertList!;
             });
           }
         },
         onError: (value){
           controller?.finishLoad(success: false);
         },spProOnProgress: (v){}
     ));
   }

   Future<void>  onLoading() async{
     var params;
       params= {"order_key":spProOrderKeys[spProBoardTitles.indexOf(spProBoardKey)],"page":(page+1).toString(),"ranking_type":spProTimeKey,"$matchType":"1"};

     await SPClassApiManager.spFunGetInstance().spFunExpertList(queryParameters:params,spProCallBack: SPClassHttpCallBack<SPClassExpertListEntity>(
         spProOnSuccess: (list){
           if(list.spProExpertList!.isEmpty){
             controller?.finishLoad(noMore: true);
           }else{
             controller?.finishLoad(success: true);
             page++;
           }

           if(mounted){
             setState(() {
               spProExpertList.addAll(list.spProExpertList!);
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
       SPClassImageUtil.spFunGetImagePath(ranking==1? "ic_leaderbord_one":(ranking==2? "ic_leaderbord_two":"ic_leaderbord_three")),
       width: width(31),
     );

   }

  void initList(SPClassExpertListEntity list) {
     if(list.spProExpertList!=null&&list.spProExpertList!.isNotEmpty){
       list.spProExpertList?.forEach((item) {
          item.spProCorrectRate=(double.parse(item.spProLast10CorrectNum!)/item.spProLast10Result!.length).toStringAsFixed(2);
          item.spProCorrectSchemeNum=item.spProLast10Result!.replaceAll("0", "").replaceAll("2", "").length.toString();
          item.spProDrawSchemeNum=item.spProLast10Result!.replaceAll("0", "").replaceAll("1", "").length.toString();
          item.spProWrongSchemeNum=item.spProLast10Result!.replaceAll("1", "").replaceAll("2", "").length.toString();
       });

     }
  }

  String getboardTitleValue(SPClassExpertListExpertList item) {

     if(spProOrderKeys[spProBoardTitles.indexOf(spProBoardKey)]=="correct_rate"){

       try{
         return "${(double.tryParse(item.spProCorrectRate!)!*100).toStringAsFixed(0)}%";
       }catch(e){
         return "";
       }
     }

     if(spProOrderKeys[spProBoardTitles.indexOf(spProBoardKey)]=="max_red_num"){
        if(spProTimeKey=="近期"){
          return '${item.spProCurrentRedNum}连红';
        }
       return '${item.spProMaxRedNum}连红';
     }

     if(spProOrderKeys[spProBoardTitles.indexOf(spProBoardKey)]=="profit_sum"){

       try{
         return "${(double.tryParse(item.spProProfitSum!)!*100).toStringAsFixed(0)}%";
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