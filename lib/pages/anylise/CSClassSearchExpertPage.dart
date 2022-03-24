
import 'package:changshengh5/api/CSClassApiManager.dart';
import 'package:changshengh5/api/CSClassHttpCallBack.dart';
import 'package:changshengh5/app/CSClassApplicaion.dart';
import 'package:changshengh5/model/CSClassExpertListEntity.dart';
import 'package:changshengh5/utils/CSClassCommonMethods.dart';
import 'package:changshengh5/utils/CSClassImageUtil.dart';
import 'package:changshengh5/utils/CSClassMatchDataUtils.dart';
import 'package:changshengh5/utils/CSClassNavigatorUtils.dart';
import 'package:changshengh5/utils/CSClassToastUtils.dart';
import 'package:changshengh5/utils/colors.dart';
import 'package:flutter/material.dart';

import 'CSClassExpertDetailPage.dart';


class CSClassSearchExpertPage extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CSClassSearchExpertPageState();
  }

}

class CSClassSearchExpertPageState extends State<CSClassSearchExpertPage>{
  var csProSearchKey="";
  List<CSClassExpertListExpertList> csProExpertList=[];
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
                    CSClassImageUtil.csMethodGetImagePath("cs_search"),
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
                        csMethodOnSearchExpert(showToast: true);
                      },
                      onChanged: (value){
                        if(mounted){
                          setState(() {
                            csProSearchKey=value;
                          });
                        }
                        csMethodOnSearchExpert(showToast: false,csProIsLoading: false);
                      },
                    ),
                  ),
                ),
                csProSearchKey.length>0? GestureDetector(
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
                        csProSearchKey="";
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
          itemCount: csProExpertList.length,
          itemBuilder:(c,index){
            var item=csProExpertList[index];
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
                          child:( item.csProAvatarUrl==null||item.csProAvatarUrl!.isEmpty)? Image.asset(
                            CSClassImageUtil.csMethodGetImagePath("cs_default_avater"),
                            width: width(46),
                            height: width(46),
                          ):Image.network(
                            item.csProAvatarUrl!,
                            width: width(46),
                            height: width(46),
                            fit: BoxFit.fill,
                          ),
                        ),
                        Positioned(
                          right: 0,
                          top: 0,
                          child:(item.csProNewSchemeNum!="null"&&int.tryParse(item.csProNewSchemeNum!)!>0)? Container(
                            alignment: Alignment.center,
                            width: width(12),
                            height: width(12),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(width(6)),
                              color: Color(0xFFE3494B),
                            ),
                            child:Text(item.csProNewSchemeNum!,style: TextStyle(fontSize: sp(8),color: Colors.white),),
                          ):Container(),
                        )
                      ],
                    ),
                    SizedBox(width: width(8),),
                    Expanded(
                      child: Text("${item.csProNickName}",style: TextStyle(fontSize: sp(17),color: Color(0xFF333333)),),
                    ),
                    // Text("胜率${(double.tryParse(item.csProCorrectRate) *100).toStringAsFixed(0)}%",
                    Text("胜率${(CSClassMatchDataUtils.csMethodCalcBestCorrectRate(item.csProLast10Result!) * 100).toStringAsFixed(0)}%",
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
                        padding: EdgeInsets.symmetric(horizontal: width(8),vertical: width(4)),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color:item.csProIsFollowing!?MyColors.grey_cc: MyColors.main1,width: 0.5),
                        ),
                        child: Row(
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
      }),
    );
  }

  csMethodOnSearchExpert({bool? showToast,bool  csProIsLoading:true}){
    if(csProSearchKey.isEmpty){
      return;
    }
    CSClassApiManager.csMethodGetInstance().csMethodExpertList(queryParameters: {"search_key":csProSearchKey},csProIsLoading: csProIsLoading,context: context,csProCallBack: CSClassHttpCallBack<CSClassExpertListEntity>(
        csProOnSuccess: (list){

          if(list.csProExpertList!=null){
            if(mounted){
              setState(() {
               csProExpertList=list.csProExpertList!;
              });
            }
          }
          if(csProExpertList.isEmpty&&showToast!){
            CSClassToastUtils.csMethodShowToast(msg: "暂无相关数据");
          }

        },onError: (v){},csProOnProgress: (v){}
    ));
  }



}