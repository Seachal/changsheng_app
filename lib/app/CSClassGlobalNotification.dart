
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:changshengh5/api/CSClassApiManager.dart';
import 'package:changshengh5/api/CSClassHttpCallBack.dart';
import 'package:changshengh5/model/CSClassMatchNotice.dart';
import 'package:changshengh5/utils/AesUtils.dart';
import 'package:changshengh5/utils/CSClassLogUtils.dart';
import 'package:changshengh5/utils/CSClassPathUtils.dart';
import 'package:changshengh5/widgets/CSClassMatchToast.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'package:connectivity/connectivity.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';


import 'CSClassApplicaion.dart';

class CSClassGlobalNotification {
  static CSClassGlobalNotification ?_instance;
  String ip="";
  String port="";
  IOWebSocketChannel ?csProSocketChannel;
  bool done=false;
  BuildContext ?context;
  CSClassGlobalNotification._(){
    csMethodInitWebSocket();
  }
  static CSClassGlobalNotification? csMethodGetInstance({BuildContext? buildContext}) {
    _instance ??= CSClassGlobalNotification._();
    if(buildContext!=null){
      _instance?.context=buildContext;
    }
    return _instance;
  }

  void csMethodInitWebSocket() {

    if(ip.isEmpty||port.isEmpty){
      CSClassApiManager.csMethodGetInstance().csMethodSportAppConf(csProCallBack: CSClassHttpCallBack(
          csProOnSuccess: (result){
            print('Socket数据：${result.data}');
            // ip=result.data["app_server"]["ip"]?.toString();
            ip="39.108.251.200";
            port=result.data["app_server"]["port"].toString();
            csMethodConnectWebSocket();
          },onError: (v){},csProOnProgress: (v){},
      ));
    }else{
      csMethodConnectWebSocket();

    }

     Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if(done){
        csMethodConnectWebSocket();
      }
    });

    Timer.periodic(Duration(seconds: 10), (timer){
      if(done){
        csMethodConnectWebSocket();
      }
    });
  }

  Future<void> csMethodConnectWebSocket() async {
     if(ip.isEmpty||port.isEmpty){
       return;
     }
    try{
      if(csProSocketChannel!=null){
        csProSocketChannel?.sink.close();
      }
      var wsHost= "ws://"+ip+":"+port;
      csProSocketChannel = IOWebSocketChannel.connect(wsHost);
      csProSocketChannel?.stream.listen((message) async {
        done=false;
        //标记
        // var result=json.decode(await CSClassEncryptUtils.csMethodDecryptByAes(message));
        var result=json.decode(AesUtils.decryptAes(message));

        if(result["method"]=="connectSuccess"){
         csMethodUserLogin();
        }else if(result["method"]=="eventNotice") {
          var notice = CSClassMatchNotice(json: result["param"]);
          // if(CSClassHomePageState.csProHomeMatchType=="足球"){
            csMethodShowMatchNotice(notice);
          // }
          CSClassApplicaion.csProEventBus.fire("score:refresh");
        }
        CSClassLogUtils.csMethodPrintLog("onDate" + result.toString());

      },
        onError: (e){
          done=true;
          CSClassLogUtils.csMethodPrintLog("WebScoket:onError"+e.toString());
        },
        onDone: (){
          done=true;
          CSClassLogUtils.csMethodPrintLog("WebScoket:done");
        },
      );
    }catch (e){
      done=true;
      CSClassLogUtils.csMethodPrintLog("WebScoket:catch Error"+e.toString());
    }
    csMethodConnect();
  }


  //
   csMethodUserLogin()  {
    if(csMethodIsLogin()){
      csMethodDoMethod({
        "method":"user/login",
        "param":{"oauth_token":
        CSClassApplicaion.csProUserLoginInfo==null? "":CSClassApplicaion.csProUserLoginInfo?.csProOauthToken}
      });


    }
    csMethodDoMethod({
      "method":"user/update_setting",
      "param": CSClassApplicaion.csProUserLoginInfo==null?
      {"prompt_scope":"all","score_prompt":"alert","red_card_prompt":"audio;alert","half_prompt":"alert","over_prompt":"alert"}
      :CSClassApplicaion.csProUserLoginInfo?.csProUserSetting?.toJson()});
  }

  //连接
  csMethodConnect()  {
    csMethodDoMethod({
      "method":"user/connect",
      "param":CSClassApiManager.csMethodGetInstance().csMethodGetBasicParams()
    });
  }

  csMethodCloseConnect(){
    ip="";
    port="";
    if(csProSocketChannel!=null){
      csProSocketChannel?.sink.close();
      csProSocketChannel=null;
    }
  }

  Future<void> csMethodDoMethod(Map param) async {

    // CSClassEncryptUtils.csMethodEncryptByAes(param)
    //     .then((value){
    //   CSClassLogUtils.csMethodPrintLog(json.encode(param));
    //   if(csProSocketChannel!=null){
    //     csProSocketChannel.sink.add(value);
    //   }
    // });
    if(csProSocketChannel!=null){
      csProSocketChannel?.sink.add(AesUtils.encryptAes(json.encode(param)));
    }


  }

  Future<void> csMethodShowMatchNotice(CSClassMatchNotice notice) async {

    if(csMethodIsLogin()){
      if(notice.csProNoticeType=="score"){
        if(CSClassApplicaion.csProUserLoginInfo!.csProUserSetting!.csProScorePrompt!.contains("vibrate")){
          csMethodPlayVibrate();
        }
        if (CSClassApplicaion.csProUserLoginInfo!.csProUserSetting!.csProScorePrompt!.contains("audio")){
          csMethodPlayAudio(notice.csProNoticeType!);
        }
        if(CSClassApplicaion.csProUserLoginInfo!.csProUserSetting!.csProScorePrompt!.contains("alert")){
          CSClassMatchToast.csMethodToast(context!, notice);
        }
      }
      if(notice.csProNoticeType=="red_card"){
        if(CSClassApplicaion.csProUserLoginInfo!.csProUserSetting!.csProRedCardPrompt!.contains("vibrate")){
          csMethodPlayVibrate();
        }
        if (CSClassApplicaion.csProUserLoginInfo!.csProUserSetting!.csProRedCardPrompt!.contains("audio")){
          csMethodPlayAudio(notice.csProNoticeType!);
        }
        if(CSClassApplicaion.csProUserLoginInfo!.csProUserSetting!.csProRedCardPrompt!.contains("alert")){
          CSClassMatchToast.csMethodToast(context!, notice);
        }
      }
      if(notice.csProNoticeType=="half"){
        if(CSClassApplicaion.csProUserLoginInfo!.csProUserSetting!.csProHalfPrompt!.contains("vibrate")){
          csMethodPlayVibrate();
        }
        if (CSClassApplicaion.csProUserLoginInfo!.csProUserSetting!.csProHalfPrompt!.contains("audio")){
          csMethodPlayAudio(notice.csProNoticeType!);
        }
        if(CSClassApplicaion.csProUserLoginInfo!.csProUserSetting!.csProHalfPrompt!.contains("alert")){
          CSClassMatchToast.csMethodToast(context!, notice);
        }
      }
      if(notice.csProNoticeType=="over"){
         if(CSClassApplicaion.csProUserLoginInfo!.csProUserSetting!.csProOverPrompt!.contains("vibrate")){
             csMethodPlayVibrate();
         }
          if (CSClassApplicaion.csProUserLoginInfo!.csProUserSetting!.csProOverPrompt!.contains("audio")){
            csMethodPlayAudio(notice.csProNoticeType!);
         }
          if(CSClassApplicaion.csProUserLoginInfo!.csProUserSetting!.csProOverPrompt!.contains("alert")){
            CSClassMatchToast.csMethodToast(context!, notice);
          }
      }
    }else{
      CSClassMatchToast.csMethodToast(context!, notice);
    }
  }

  csMethodPlayVibrate() async {
    bool canVibrate = await Vibrate.canVibrate;
    Vibrate.vibrate();
  }

  csMethodPlayAudio(String type) async {
    if(Platform.isAndroid){
      var fileName="";
      if (type=="half"){
        fileName="assets/audio/audio_prompt.mp3";
      }  else if (type=="over"){
        fileName="assets/audio/audio_prompt.mp3";
      }else{
        fileName="assets/audio/audio_prompt.mp3";
      }
      CSClassPathUtils.csMethodGetFilePathFromAsset(fileName).then((value){
        AudioPlayer().play(value,isLocal: true);
      });
    }


  }

}