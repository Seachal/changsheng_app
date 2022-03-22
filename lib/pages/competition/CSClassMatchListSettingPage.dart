


import 'dart:convert';

import 'package:changshengh5/api/CSClassApiManager.dart';
import 'package:changshengh5/api/CSClassHttpCallBack.dart';
import 'package:changshengh5/app/CSClassApplicaion.dart';
import 'package:changshengh5/app/CSClassGlobalNotification.dart';
import 'package:changshengh5/pages/dialogs/CSClassBottomLeaguePage.dart';
import 'package:changshengh5/utils/CSClassCommonMethods.dart';
import 'package:changshengh5/utils/CSClassImageUtil.dart';
import 'package:changshengh5/utils/CSClassSharedPreferencesKeys.dart';
import 'package:changshengh5/widgets/CSClassToolBar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CSClassMatchListSettingPage extends StatefulWidget{
  final int index; //0 足球  1篮球
  const CSClassMatchListSettingPage({Key? key, this.index=0}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CSClassMatchListSettingPageState();
  }

}

class CSClassMatchListSettingPageState extends State<CSClassMatchListSettingPage>{
  static bool  csProShowRedCard=true;
  static bool SHOW_PANKOU=false;
  static int csProMatchShowType =0;
  List<String> csProScorePrompts=[];
  List<String> csProRedPrompts=[];
  List<String> csProHalfPrompts=[];
  List<String> csProOverPrompts=[];
  var csProPromptScoreTitle=["热门的比赛","全部赛事","关注的比赛",];
  var csProPromptScopeKeys=["hot","all","collected",];
  var csProPromptScoreIndex=0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var csProPromptScope=CSClassApplicaion.csProUserLoginInfo!.csProUserSetting!.csProPromptScope;
    if(csProPromptScope!.isNotEmpty){
      csProPromptScoreIndex=csProPromptScopeKeys.indexOf(csProPromptScope);
    }
    csProScorePrompts=userLoginInfo!.csProUserSetting!.csProScorePrompt!.split(";");
    csProRedPrompts=userLoginInfo!.csProUserSetting!.csProRedCardPrompt!.split(";");
    csProHalfPrompts=userLoginInfo!.csProUserSetting!.csProHalfPrompt!.split(";");
    csProOverPrompts=userLoginInfo!.csProUserSetting!.csProOverPrompt!.split(";");
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: CSClassToolBar(
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
                    Text(csProMatchShowType==0 ? "按时间排序":"按联赛排序",style: TextStyle(color: Color(0xFFA7A7A7),fontSize: sp(12),fontWeight: FontWeight.w500),),
                    SizedBox(width: width(5),),
                    Image.asset(CSClassImageUtil.csMethodGetImagePath("ic_btn_right"),
                      width: width(11),
                    ),

                  ],
                ),
              ),
              onTap: () async {

                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext c) {
                    return CSClassBottomLeaguePage(<String>["按时间排序","按联赛排序"],"请选择",(index){
                      setState(() {
                        csProMatchShowType=index;
                      });
                      CSClassApplicaion.csProEventBus.fire("match:pankou");
                    },initialIndex: csProMatchShowType,);
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
                    Text(csProPromptScoreTitle[csProPromptScoreIndex],style: TextStyle(color: Color(0xFFA7A7A7),fontSize: sp(12),fontWeight: FontWeight.w500),),
                    SizedBox(width: width(5),),
                    Image.asset(CSClassImageUtil.csMethodGetImagePath("ic_btn_right"),
                      width: width(11),
                    ),

                  ],
                ),
              ),
              onTap: () async {
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return CSClassBottomLeaguePage(csProPromptScoreTitle,"请选择",(index){

                      csProPromptScoreIndex=index;

                      setState(() {
                      });

                      csMethodUpdateSetting(csProPromptScopeKeys[index],"prompt_scope");

                    },initialIndex: csProPromptScoreIndex);
                  },
                );
              },
            ),


            Visibility(
              child: SizedBox(height: height(10),),
              visible: widget.index==0,
            ),

            Visibility(
              child: Column(
                children:[
                  {
                    "title":"进球提示",
                    "list":csProScorePrompts,
                    "key":"score_prompt",
                  },
                  {
                    "title":"红牌提示",
                    "list":csProRedPrompts,
                    "key":"red_card_prompt",
                  },
                  {
                    "title":"半场提示",
                    "list":csProHalfPrompts,
                    "key":"half_prompt",
                  },
                  {
                    "title":"全场提示",
                    "list":csProOverPrompts,
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
                                  Image.asset(CSClassImageUtil.csMethodGetImagePath(list!.contains("audio")? "ic_select":"ic_seleect_un"), width: width(15)),
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
                                csMethodUpdateSetting(promptValue,item["key"].toString());

                              },
                            ),
                            SizedBox(width: width(10),),
                            GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              child: Row(
                                children: <Widget>[
                                  Image.asset(CSClassImageUtil.csMethodGetImagePath(list.contains("vibrate")?  "ic_select":"ic_seleect_un"), width: width(15)),
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
                                csMethodUpdateSetting(promptValue,item["key"].toString());
                              },
                            ),
                            SizedBox(width: width(10),),
                            GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              child: Row(
                                children: <Widget>[
                                  Image.asset(CSClassImageUtil.csMethodGetImagePath(list.contains("alert")?  "ic_select":"ic_seleect_un"), width: width(15)),
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
                                csMethodUpdateSetting(promptValue,item["key"].toString());
                              },
                            ),
                          ],
                        ),),


                      ],
                    ),
                  );
                }).toList(),
              ),
              visible: widget.index==0,
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
                          color:csProShowRedCard ? Theme.of(context).primaryColor:Color(0xFFEAE8EB),
                        ),
                        child: Row(
                          mainAxisAlignment:csProShowRedCard ? MainAxisAlignment.start:MainAxisAlignment.end ,
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
                          csProShowRedCard=!csProShowRedCard;
                        });
                        SharedPreferences.getInstance().then((sp)=>sp.setBool(CSClassSharedPreferencesKeys.KEY_MATCH_RED_CAR, csProShowRedCard));

                        CSClassApplicaion.csProEventBus.fire("match:pankou");
                      },
                    ),

                  ],
                ),
              ),
              visible: widget.index==0,
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
                        SharedPreferences.getInstance().then((sp)=>sp.setBool(CSClassSharedPreferencesKeys.KEY_MATCH_PAN_KOU, SHOW_PANKOU));

                        CSClassApplicaion.csProEventBus.fire("match:pankou");
                      },
                    ),

                  ],
                ),
              ),
              visible: widget.index==0,
            ),

          ],
        ),
      ),
    );
  }

  void csMethodUpdateSetting(String promptValue, String key) {
    print(promptValue);
    CSClassApiManager.csMethodGetInstance().csMethodUpdateSetting(
        queryParameters: { "setting_key":key,"setting_val":promptValue},
        csProCallBack: CSClassHttpCallBack(
            csProOnSuccess: (value){
              if(key=="score_prompt"){
                CSClassApplicaion.csProUserLoginInfo!.csProUserSetting!.csProScorePrompt= promptValue;
              }else if(key=="red_card_prompt"){
                CSClassApplicaion.csProUserLoginInfo!.csProUserSetting!.csProRedCardPrompt= promptValue;
              }else if(key=="half_prompt"){
                CSClassApplicaion.csProUserLoginInfo!.csProUserSetting!.csProHalfPrompt= promptValue;
              }else if(key=="over_prompt"){
                CSClassApplicaion.csProUserLoginInfo!.csProUserSetting!.csProOverPrompt= promptValue;
              }else if(key=="prompt_scope"){
                CSClassApplicaion.csProUserLoginInfo!.csProUserSetting!.csProPromptScope= promptValue;
              }
            },onError: (e){},csProOnProgress: (v){}
        )
    );
    CSClassGlobalNotification.csMethodGetInstance()!.csMethodDoMethod(
        {
          "method":"user/update_setting",
          "param":{key:promptValue,},
        }
    );
  }



}