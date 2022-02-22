
import 'package:changshengh5/api/SPClassApiManager.dart';
import 'package:changshengh5/api/SPClassHttpCallBack.dart';
import 'package:changshengh5/app/SPClassApplicaion.dart';
import 'package:changshengh5/model/SPClassExpertListEntity.dart';
import 'package:changshengh5/untils/SPClassCommonMethods.dart';
import 'package:changshengh5/untils/SPClassImageUtil.dart';
import 'package:changshengh5/untils/SPClassMatchDataUtils.dart';
import 'package:changshengh5/untils/SPClassNavigatorUtils.dart';
import 'package:changshengh5/untils/SPClassToastUtils.dart';
import 'package:changshengh5/untils/colors.dart';
import 'package:flutter/material.dart';

import 'SPClassExpertDetailPage.dart';


class SPClassSearchExpertPage extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SPClassSearchExpertPageState();
  }

}

class SPClassSearchExpertPageState extends State<SPClassSearchExpertPage>{
  var spProSearchKey="";
  List<SPClassExpertListExpertList> spProExpertList=[];
  TextEditingController ?controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller=TextEditingController();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        titleSpacing:0,
        title: Container(
          alignment: Alignment.center,
          child: Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(left: width(13)) ,
            padding: EdgeInsets.only(left: width(13),right: width(13),),
            height: height(32),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(height(16)),
                color: Colors.white
            ),
            child:Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  color: Colors.white,
                  child: Image.asset(
                    SPClassImageUtil.spFunGetImagePath("ic_search"),
                    width: width(16),
                    color: Color(0xFFDDDDDD),
                  ),
                ),
                SizedBox(width: 7,),
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: EdgeInsets.only(top: height(5)),
                    alignment: Alignment.center,
                    child: TextField(
                      cursorWidth: 1,
                      autofocus: true,
                      controller: controller,
                      cursorColor: Color(0xFF666666),
                      textInputAction: TextInputAction.search,
                      style: TextStyle(fontSize: sp(15),color:Color(0xFF333333),textBaseline: TextBaseline.alphabetic,),
                      decoration: InputDecoration(
                          hintText: "搜索专家",
                          hintStyle:  TextStyle(fontSize: sp(13),color:Color(0xFFDDDDDD)),
                          contentPadding: EdgeInsets.only(bottom: sp(15)),
                          border: InputBorder.none
                      ),
                      onEditingComplete: (){
                        spFunOnSearchExpert(showToast: true);
                      },
                      onChanged: (value){
                        if(mounted){
                          setState(() {
                            spProSearchKey=value;
                          });
                        }
                        spFunOnSearchExpert(showToast: false,spProIsLoading: false);
                      },
                    ),
                  ),
                ),
                spProSearchKey.length>0? GestureDetector(
                  child:Container(
                    height: width(16),
                    width: width(16),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(width(8)),
                        color: Color(0xFFDDDDDD)
                    ),
                    alignment: Alignment.center,
                    child: Icon(Icons.close,color: Colors.white,size: width(12)),
                  ),
                  onTap: (){
                    controller?.clear();

                    if(mounted){
                      setState(() {
                        spProSearchKey="";
                      });
                    }
                  },
                ):SizedBox()
              ],
            ),
          ),
        ),
        actions: <Widget>[
         GestureDetector(
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(left: width(13),right: width(13),),
              child: Text("取消",style: TextStyle(fontSize: sp(16),color: Colors.white)),
            ),
            onTap: (){
              Navigator.of(context).pop();
            },
          )
        ],
      ),
      body: ListView.builder(
          itemCount: spProExpertList.length,
          itemBuilder:(c,index){
            var item=spProExpertList[index];
            return GestureDetector(
              child: Container(
                padding: EdgeInsets.only(left: width(14),right: width(14),top: width(12),bottom: width(12)),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(bottom: BorderSide(width: 0.4,color: Colors.grey[300]!))
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: BorderRadius.circular(200),
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
                        Positioned(
                          right: 0,
                          top: 0,
                          child:(item.spProNewSchemeNum!="null"&&int.tryParse(item.spProNewSchemeNum!)!>0)? Container(
                            alignment: Alignment.center,
                            width: width(12),
                            height: width(12),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(width(6)),
                              color: Color(0xFFE3494B),
                            ),
                            child:Text(item.spProNewSchemeNum!,style: TextStyle(fontSize: sp(8),color: Colors.white),),
                          ):Container(),
                        )
                      ],
                    ),
                    SizedBox(width: width(8),),
                    Expanded(
                      child: Text("${item.spProNickName}",style: TextStyle(fontSize: sp(17),color: Color(0xFF333333)),),
                    ),
                    // Text("胜率${(double.tryParse(item.spProCorrectRate) *100).toStringAsFixed(0)}%",
                    Text("胜率${(SPClassMatchDataUtils.spFunCalcBestCorrectRate(item.spProLast10Result!) * 100).toStringAsFixed(0)}%",
                      style: TextStyle(
                          letterSpacing: 0,
                          wordSpacing: 0,
                          fontSize: sp(17),
                          fontWeight: FontWeight.w500,
                          color: Color(0xFFE3494B),),
                    ),
                    SizedBox(width:width(15),),
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
                        padding: EdgeInsets.symmetric(horizontal: width(8),vertical: width(4)),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color:item.spProIsFollowing!?MyColors.grey_cc: MyColors.main1,width: 0.5),
                        ),
                        child: Row(
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
      }),
    );
  }

  spFunOnSearchExpert({bool? showToast,bool  spProIsLoading:true}){
    if(spProSearchKey.isEmpty){
      return;
    }
    SPClassApiManager.spFunGetInstance().spFunExpertList(queryParameters: {"search_key":spProSearchKey},spProIsLoading: spProIsLoading,context: context,spProCallBack: SPClassHttpCallBack<SPClassExpertListEntity>(
        spProOnSuccess: (list){

          if(list.spProExpertList!=null){
            if(mounted){
              setState(() {
               spProExpertList=list.spProExpertList!;
              });
            }
          }
          if(spProExpertList.isEmpty&&showToast!){
            SPClassToastUtils.spFunShowToast(msg: "暂无相关数据");
          }

        }
    ));
  }



}