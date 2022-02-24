


import 'dart:convert';

import 'package:changshengh5/api/SPClassApiManager.dart';
import 'package:changshengh5/api/SPClassHttpCallBack.dart';
import 'package:changshengh5/app/SPClassApplicaion.dart';
import 'package:changshengh5/app/SPClassGlobalNotification.dart';
import 'package:changshengh5/pages/dialogs/SPClassBottomLeaguePage.dart';
import 'package:changshengh5/utils/SPClassCommonMethods.dart';
import 'package:changshengh5/utils/SPClassImageUtil.dart';
import 'package:changshengh5/utils/SPClassSharedPreferencesKeys.dart';
import 'package:changshengh5/widgets/SPClassToolBar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SPClassMatchListSettingPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SPClassMatchListSettingPageState();
  }

}

class SPClassMatchListSettingPageState extends State<SPClassMatchListSettingPage>{
  static bool  spProShowRedCard=true;
  static bool SHOW_PANKOU=false;
  static int spProMatchShowType =0;
  List<String> spProScorePrompts=[];
  List<String> spProRedPrompts=[];
  List<String> spProHalfPrompts=[];
  List<String> spProOverPrompts=[];
  var spProPromptScoreTitle=["热门的比赛","全部赛事","关注的比赛",];
  var spProPromptScopeKeys=["hot","all","collected",];
  var spProPromptScoreIndex=0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var spProPromptScope=SPClassApplicaion.spProUserLoginInfo!.spProUserSetting!.spProPromptScope;
    if(spProPromptScope.isNotEmpty){
      spProPromptScoreIndex=spProPromptScopeKeys.indexOf(spProPromptScope);
    }
    spProScorePrompts=userLoginInfo!.spProUserSetting!.spProScorePrompt.split(";");
    spProRedPrompts=userLoginInfo!.spProUserSetting!.spProRedCardPrompt.split(";");
    spProHalfPrompts=userLoginInfo!.spProUserSetting!.spProHalfPrompt.split(";");
    spProOverPrompts=userLoginInfo!.spProUserSetting!.spProOverPrompt.split(";");
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: SPClassToolBar(
        context,
        title: "设置",
      ),
      body: Container(
        color: Color(0xFFF1F1F1),
        child: Column(
          children: <Widget>[
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              child: Container(
                margin: EdgeInsets.only(top: height(10)),
                padding: EdgeInsets.only(top: height(10),bottom: height(10),left: width(24),right: width(24)),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(bottom: BorderSide(color: Colors.grey[300]!,width: 0.4))
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text("赛事排序",style: TextStyle(color: Color(0xFF333333),fontSize: sp(13),fontWeight: FontWeight.w500),),
                    Expanded(child: SizedBox(),),
                    Text(spProMatchShowType==0 ? "按时间排序":"按联赛排序",style: TextStyle(color: Color(0xFFA7A7A7),fontSize: sp(12),fontWeight: FontWeight.w500),),
                    SizedBox(width: width(5),),
                    Image.asset(SPClassImageUtil.spFunGetImagePath("ic_btn_right"),
                      width: width(11),
                    ),

                  ],
                ),
              ),
              onTap: () async {

                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext c) {
                    return SPClassBottomLeaguePage(<String>["按时间排序","按联赛排序"],"请选择",(index){
                      setState(() {
                        spProMatchShowType=index;
                      });
                      SPClassApplicaion.spProEventBus.fire("match:pankou");
                    },initialIndex: spProMatchShowType,);
                  },
                );
              },
            ),

            GestureDetector(
              behavior: HitTestBehavior.opaque,
              child: Container(
                padding: EdgeInsets.only(top: height(10),bottom: height(10),left: width(24),right: width(24)),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(bottom: BorderSide(color: Colors.grey[300]!,width: 0.4))
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text("提示范围",style: TextStyle(color: Color(0xFF333333),fontSize: sp(13),fontWeight: FontWeight.w500),),
                    Expanded(child: SizedBox(),),
                    Text(spProPromptScoreTitle[spProPromptScoreIndex],style: TextStyle(color: Color(0xFFA7A7A7),fontSize: sp(12),fontWeight: FontWeight.w500),),
                    SizedBox(width: width(5),),
                    Image.asset(SPClassImageUtil.spFunGetImagePath("ic_btn_right"),
                      width: width(11),
                    ),

                  ],
                ),
              ),
              onTap: () async {
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return SPClassBottomLeaguePage(spProPromptScoreTitle,"请选择",(index){

                      spProPromptScoreIndex=index;

                      setState(() {
                      });

                      spFunUpdateSetting(spProPromptScopeKeys[index],"prompt_scope");

                    },initialIndex: spProPromptScoreIndex);
                  },
                );
              },
            ),


            Visibility(
              child: SizedBox(height: height(10),),
              visible: true//SPClassHomePageState.spProHomeMatchType=="足球",
            ),

            Visibility(
              child: Column(
                children:[
                  {
                    "title":"进球提示",
                    "list":spProScorePrompts,
                    "key":"score_prompt",
                  },
                  {
                    "title":"红牌提示",
                    "list":spProRedPrompts,
                    "key":"red_card_prompt",
                  },
                  {
                    "title":"半场提示",
                    "list":spProHalfPrompts,
                    "key":"half_prompt",
                  },
                  {
                    "title":"全场提示",
                    "list":spProOverPrompts,
                    "key":"over_prompt",
                  }
                ].map((item) {
                  List<String>? list= item["list"] as List<String>? ;
                  return Container(
                    padding: EdgeInsets.only(top: height(10),bottom: height(10),left: width(24),right: width(24)),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border(bottom: BorderSide(color: Colors.grey[300]!,width: 0.4))
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(item["title"].toString(),style: TextStyle(color: Color(0xFF333333),fontSize: sp(13),fontWeight: FontWeight.w500),),
                        Expanded(child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              child: Row(
                                children: <Widget>[
                                  Image.asset(SPClassImageUtil.spFunGetImagePath(list!.contains("audio")? "ic_select":"ic_seleect_un"), width: width(15)),
                                  SizedBox(width: width(5),),
                                  Text("声音",style: TextStyle(fontSize: sp(13),color: Colors.black),)
                                ],
                              ),
                              onTap: (){
                                if(list.contains("audio")){
                                  list.remove("audio");
                                }else{
                                  list.add("audio");
                                }
                                setState(() {});
                                var promptValue= JsonEncoder().convert(list).replaceAll("[", "").replaceAll("]", "").replaceAll(",", ";").replaceAll("\"", "");
                                spFunUpdateSetting(promptValue,item["key"].toString());

                              },
                            ),
                            SizedBox(width: width(10),),
                            GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              child: Row(
                                children: <Widget>[
                                  Image.asset(SPClassImageUtil.spFunGetImagePath(list.contains("vibrate")?  "ic_select":"ic_seleect_un"), width: width(15)),
                                  SizedBox(width: width(5),),
                                  Text("震动",style: TextStyle(fontSize: sp(13),color: Colors.black),)

                                ],
                              ),
                              onTap: (){
                                if(list.contains("vibrate")){
                                  list.remove("vibrate");
                                }else{
                                  list.add("vibrate");
                                }
                                setState(() {});
                                var promptValue= JsonEncoder().convert(list).replaceAll("[", "").replaceAll("]", "").replaceAll(",", ";").replaceAll("\"", "");
                                spFunUpdateSetting(promptValue,item["key"].toString());
                              },
                            ),
                            SizedBox(width: width(10),),
                            GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              child: Row(
                                children: <Widget>[
                                  Image.asset(SPClassImageUtil.spFunGetImagePath(list.contains("alert")?  "ic_select":"ic_seleect_un"), width: width(15)),
                                  SizedBox(width: width(5),),
                                  Text("弹窗",style: TextStyle(fontSize: sp(13),color: Colors.black),)

                                ],
                              ),
                              onTap: (){
                                if(list.contains("alert")){
                                  list.remove("alert");
                                }else{
                                  list.add("alert");
                                }
                                setState(() {});
                                var promptValue= JsonEncoder().convert(list).replaceAll("[", "").replaceAll("]", "").replaceAll(",", ";").replaceAll("\"", "");
                                spFunUpdateSetting(promptValue,item["key"].toString());
                              },
                            ),
                          ],
                        ),),


                      ],
                    ),
                  );
                }).toList(),
              ),
              visible: true//SPClassHomePageState.spProHomeMatchType=="足球",
            ),


            Visibility(
              child: Container(
                padding: EdgeInsets.only(top: height(10),bottom: height(10),left: width(24),right: width(24)),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(bottom: BorderSide(color: Colors.grey[300]!,width: 0.4))
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text("红黄牌显示",style: TextStyle(color: Color(0xFF333333),fontSize: sp(13),fontWeight: FontWeight.w500),),
                    Expanded(child: SizedBox(),),
                    GestureDetector(
                      child: Container(
                        width: width(50),
                        height: width(27),
                        decoration: BoxDecoration(
                          borderRadius:BorderRadius.circular(300),
                          color:spProShowRedCard ? Theme.of(context).primaryColor:Color(0xFFEAE8EB),
                        ),
                        child: Row(
                          mainAxisAlignment:spProShowRedCard ? MainAxisAlignment.start:MainAxisAlignment.end ,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(left: 2,right: 2),
                              width: width(23),
                              height: width(23),
                              decoration: ShapeDecoration(
                                  shadows: [
                                    BoxShadow(
                                        offset: Offset(1,1),
                                        color: Colors.black.withOpacity(0.2)
                                    ),
                                  ],
                                  shape: CircleBorder(),
                                  color: Colors.white
                              ),
                            )
                          ],
                        ),
                      ),
                      onTap: (){
                        setState(() {
                          spProShowRedCard=!spProShowRedCard;
                        });
                        SharedPreferences.getInstance().then((sp)=>sp.setBool(SPClassSharedPreferencesKeys.KEY_MATCH_RED_CAR, spProShowRedCard));

                        SPClassApplicaion.spProEventBus.fire("match:pankou");
                      },
                    ),

                  ],
                ),
              ),
              visible: true//SPClassHomePageState.spProHomeMatchType=="足球",
            ),
            Visibility(
              child:    Container(
                margin: EdgeInsets.only(top: height(10)),
                padding: EdgeInsets.only(top: height(10),bottom: height(10),left: width(24),right: width(24)),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(bottom: BorderSide(color: Colors.grey[300]!,width: 0.4))
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text("指数显示",style: TextStyle(color: Color(0xFF333333),fontSize: sp(13),fontWeight: FontWeight.w500),),
                    Expanded(child: SizedBox(),),
                    GestureDetector(
                      child: Container(
                        width: width(50),
                        height: width(27),
                        decoration: BoxDecoration(
                          borderRadius:BorderRadius.circular(300),
                          color:SHOW_PANKOU ? Theme.of(context).primaryColor:Color(0xFFEAE8EB),
                        ),
                        child: Row(
                          mainAxisAlignment:SHOW_PANKOU ? MainAxisAlignment.start:MainAxisAlignment.end ,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(left: 2,right: 2),
                              width: width(23),
                              height: width(23),
                              decoration: ShapeDecoration(
                                  shadows: [
                                    BoxShadow(
                                        offset: Offset(1,1),
                                        color: Colors.black.withOpacity(0.2)
                                    ),
                                  ],
                                  shape: CircleBorder(),
                                  color: Colors.white
                              ),
                            )
                          ],
                        ),
                      ),
                      onTap: (){
                        setState(() {
                          SHOW_PANKOU=!SHOW_PANKOU;
                        });
                        SharedPreferences.getInstance().then((sp)=>sp.setBool(SPClassSharedPreferencesKeys.KEY_MATCH_PAN_KOU, SHOW_PANKOU));

                        SPClassApplicaion.spProEventBus.fire("match:pankou");
                      },
                    ),

                  ],
                ),
              ),
              visible: true//SPClassHomePageState.spProHomeMatchType=="足球"&&Platform.isAndroid,
            ),

          ],
        ),
      ),
    );
  }

  void spFunUpdateSetting(String promptValue, String key) {
    print(promptValue);
    SPClassApiManager.spFunGetInstance().spFunUpdateSetting(
        queryParameters: { "setting_key":key,"setting_val":promptValue},
        spProCallBack: SPClassHttpCallBack(
            spProOnSuccess: (value){
              if(key=="score_prompt"){
                SPClassApplicaion.spProUserLoginInfo!.spProUserSetting!.spProScorePrompt= promptValue;
              }else if(key=="red_card_prompt"){
                SPClassApplicaion.spProUserLoginInfo!.spProUserSetting!.spProRedCardPrompt= promptValue;
              }else if(key=="half_prompt"){
                SPClassApplicaion.spProUserLoginInfo!.spProUserSetting!.spProHalfPrompt= promptValue;
              }else if(key=="over_prompt"){
                SPClassApplicaion.spProUserLoginInfo!.spProUserSetting!.spProOverPrompt= promptValue;
              }else if(key=="prompt_scope"){
                SPClassApplicaion.spProUserLoginInfo!.spProUserSetting!.spProPromptScope= promptValue;
              }
            },onError: (e){},spProOnProgress: (v){}
        )
    );
    SPClassGlobalNotification.spFunGetInstance()!.spFunDoMethod(
        {
          "method":"user/update_setting",
          "param":{key:promptValue,},
        }
    );
  }



}