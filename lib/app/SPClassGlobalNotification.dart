
import 'dart:async';
import 'dart:convert';

import 'package:changshengh5/api/SPClassApiManager.dart';
import 'package:changshengh5/api/SPClassHttpCallBack.dart';
import 'package:changshengh5/model/SPClassMatchNotice.dart';
import 'package:changshengh5/untils/SPClassLogUtils.dart';
import 'package:changshengh5/untils/SPClassPathUtils.dart';
import 'package:changshengh5/widgets/SPClassMatchToast.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'package:connectivity/connectivity.dart';
import 'package:audioplayers/audioplayers.dart';


import 'SPClassApplicaion.dart';

class SPClassGlobalNotification {
  static SPClassGlobalNotification ?_instance;
  String ip="";
  String port="";
  IOWebSocketChannel ?spProSocketChannel;
  bool done=false;
  BuildContext ?context;
  SPClassGlobalNotification._(){
    spFunInitWebSocket();
  }
  static SPClassGlobalNotification? spFunGetInstance({BuildContext? buildContext}) {
    _instance ??= SPClassGlobalNotification._();
    if(buildContext!=null){
      _instance?.context=buildContext;
    }
    return _instance;
  }

  void spFunInitWebSocket() {

    if(ip.isEmpty||port.isEmpty){
      SPClassApiManager.spFunGetInstance().spFunSportAppConf(spProCallBack: SPClassHttpCallBack(
          spProOnSuccess: (result){
            print('Socket数据：${result.data}');
            // ip=result.data["app_server"]["ip"]?.toString();
            ip="39.108.251.200";
            port=result.data["app_server"]["port"].toString();
            spFunConnectWebSocket();
          },onError: (v){},spProOnProgress: (v){},
      ));
    }else{
      spFunConnectWebSocket();

    }

     Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if(done){
        spFunConnectWebSocket();
      }
    });

    Timer.periodic(Duration(seconds: 10), (timer){
      if(done){
        spFunConnectWebSocket();
      }
    });
  }

  Future<void> spFunConnectWebSocket() async {
     if(ip.isEmpty||port.isEmpty){
       return;
     }
    try{
      if(spProSocketChannel!=null){
        spProSocketChannel?.sink.close();
      }
      var wsHost= "ws://"+ip+":"+port;
      spProSocketChannel = IOWebSocketChannel.connect(wsHost);
      spProSocketChannel?.stream.listen((message) async {
        done=false;
        //标记
        // var result=json.decode(await SPClassEncryptUtils.spFunDecryptByAes(message));
        var result=json.decode(message);

        if(result["method"]=="connectSuccess"){
         spFunUserLogin();
        }else if(result["method"]=="eventNotice") {
          var notice = SPClassMatchNotice(json: result["param"]);
          // if(SPClassHomePageState.spProHomeMatchType=="足球"){
            spFunShowMatchNotice(notice);
          // }
          SPClassApplicaion.spProEventBus.fire("score:refresh");
        }
        SPClassLogUtils.spFunPrintLog("onDate" + result.toString());

      },
        onError: (e){
          done=true;
          SPClassLogUtils.spFunPrintLog("WebScoket:onError"+e.toString());
        },
        onDone: (){
          done=true;
          SPClassLogUtils.spFunPrintLog("WebScoket:done");
        },
      );
    }catch (e){
      done=true;
      SPClassLogUtils.spFunPrintLog("WebScoket:catch Error"+e.toString());
    }
    spFunConnect();
  }


  //
   spFunUserLogin()  {
    if(spFunIsLogin()){
      spFunDoMethod({
        "method":"user/login",
        "param":{"oauth_token":
        SPClassApplicaion.spProUserLoginInfo==null? "":SPClassApplicaion.spProUserLoginInfo?.spProOauthToken}
      });


    }
    spFunDoMethod({
      "method":"user/update_setting",
      "param": SPClassApplicaion.spProUserLoginInfo==null?
      {"prompt_scope":"all","score_prompt":"alert","red_card_prompt":"audio;alert","half_prompt":"alert","over_prompt":"alert"}
      :SPClassApplicaion.spProUserLoginInfo?.spProUserSetting?.toJson()});
  }

  //连接
  spFunConnect()  {
    spFunDoMethod({
      "method":"user/connect",
      "param":SPClassApiManager.spFunGetInstance().spFunGetBasicParams()
    });
  }

  spFunCloseConnect(){
    ip="";
    port="";
    if(spProSocketChannel!=null){
      spProSocketChannel?.sink.close();
      spProSocketChannel=null;
    }
  }

  Future<void> spFunDoMethod(Map param) async {

    // 标记
    // SPClassEncryptUtils.spFunEncryptByAes(param)
    //     .then((value){
    //   SPClassLogUtils.spFunPrintLog(json.encode(param));
    //   if(spProSocketChannel!=null){
    //     spProSocketChannel.sink.add(value);
    //   }
    // });
  }

  Future<void> spFunShowMatchNotice(SPClassMatchNotice notice) async {

    if(spFunIsLogin()){
      if(notice.spProNoticeType=="score"){
        if(SPClassApplicaion.spProUserLoginInfo!.spProUserSetting!.spProScorePrompt.contains("vibrate")){
          spFunPlayVibrate();
        }
        if (SPClassApplicaion.spProUserLoginInfo!.spProUserSetting!.spProScorePrompt.contains("audio")){
          spFunPlayAudio(notice.spProNoticeType!);
        }
        if(SPClassApplicaion.spProUserLoginInfo!.spProUserSetting!.spProScorePrompt.contains("alert")){
          SPClassMatchToast.spFunToast(context!, notice);
        }
      }
      if(notice.spProNoticeType=="red_card"){
        if(SPClassApplicaion.spProUserLoginInfo!.spProUserSetting!.spProRedCardPrompt.contains("vibrate")){
          spFunPlayVibrate();
        }
        if (SPClassApplicaion.spProUserLoginInfo!.spProUserSetting!.spProRedCardPrompt.contains("audio")){
          spFunPlayAudio(notice.spProNoticeType!);
        }
        if(SPClassApplicaion.spProUserLoginInfo!.spProUserSetting!.spProRedCardPrompt.contains("alert")){
          SPClassMatchToast.spFunToast(context!, notice);
        }
      }
      if(notice.spProNoticeType=="half"){
        if(SPClassApplicaion.spProUserLoginInfo!.spProUserSetting!.spProHalfPrompt.contains("vibrate")){
          spFunPlayVibrate();
        }
        if (SPClassApplicaion.spProUserLoginInfo!.spProUserSetting!.spProHalfPrompt.contains("audio")){
          spFunPlayAudio(notice.spProNoticeType!);
        }
        if(SPClassApplicaion.spProUserLoginInfo!.spProUserSetting!.spProHalfPrompt.contains("alert")){
          SPClassMatchToast.spFunToast(context!, notice);
        }
      }
      if(notice.spProNoticeType=="over"){
         if(SPClassApplicaion.spProUserLoginInfo!.spProUserSetting!.spProOverPrompt.contains("vibrate")){
             spFunPlayVibrate();
         }
          if (SPClassApplicaion.spProUserLoginInfo!.spProUserSetting!.spProOverPrompt.contains("audio")){
            spFunPlayAudio(notice.spProNoticeType!);
         }
          if(SPClassApplicaion.spProUserLoginInfo!.spProUserSetting!.spProOverPrompt.contains("alert")){
            SPClassMatchToast.spFunToast(context!, notice);
          }
      }
    }else{
      SPClassMatchToast.spFunToast(context!, notice);
    }
  }

  spFunPlayVibrate() async {
    //震动 APP使用
    // bool canVibrate = await Vibrate.canVibrate;
    // Vibrate.vibrate();
  }

  spFunPlayAudio(String type) async {
     var fileName="";
      if (type=="half"){
        fileName="assets/audio/audio_prompt.mp3";
      }  else if (type=="over"){
        fileName="assets/audio/audio_prompt.mp3";
      }else{
        fileName="assets/audio/audio_prompt.mp3";
      }
    SPClassPathUtils.spFunGetFilePathFromAsset(fileName).then((value){
      AudioPlayer().play(value,isLocal: true);
    });

  }

}