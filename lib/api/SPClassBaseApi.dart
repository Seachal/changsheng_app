
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:changshengh5/app/SPClassApplicaion.dart';
import 'package:changshengh5/model/SPClassBaseModelEntity.dart';
import 'package:changshengh5/pages/common/SPClassDialogUtils.dart';
import 'package:changshengh5/untils/SPClassCommonMethods.dart';
import 'package:changshengh5/untils/SPClassLogUtils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';


import '../SPClassEncodeUtil.dart';
import 'SPClassHttpCallBack.dart';
import 'SPClassHttpManager.dart';
import 'SPClassNetConfig.dart';




enum Method{
 GET,
 POST,
 UPLOAD,
 DOWNLOAD
}

class SPClassBaseApi{

  static var spProShowDialogCount=0;
  //GET请求
  Future<void> spFunGet<T>({Object ?jsonObject,String ?url,Map<String,dynamic> ?queryParameters,bool isBaseParams:true,bool spProIsLoading:false,bool isToast:false,bool isTimeOut:false,BuildContext ?context,SPClassHttpCallBack<T> ?spProCallBack,bool isDemo:false}) async {
    await spFunRequest<T>(jsonObject: jsonObject,method:Method.GET,url: url,queryParameters: queryParameters,isBaseParams: isBaseParams,isTimeOut:isTimeOut,spProIsLoading: spProIsLoading,isToast: isToast,context: context,spProCallBack: spProCallBack,isDemo: isDemo);

  }
  Future<void> spFunPost<T>({Object ?jsonObject,String ?url,Map<String,dynamic> ?queryParameters,Map<String,dynamic> ?spProBodyParameters,bool isBaseParams:true,bool spProIsLoading:false,bool isToast:false,BuildContext ?context,SPClassHttpCallBack<T> ?spProCallBack}) async {

    await spFunRequest<T>(jsonObject: jsonObject,method:Method.POST,url: url!,queryParameters: queryParameters!,spProBodyParameters: spProBodyParameters!,isBaseParams: isBaseParams,spProIsLoading: spProIsLoading,isToast: isToast,context: context!,spProCallBack: spProCallBack!);
  }

  Future<void> spFunUpload<T>({String ?url,BuildContext ?context,SPClassHttpCallBack<T> ?spProCallBack,List<File> ?files,String ?fileName,params, Map<String, dynamic>? queryParameters,}) async {
    await spFunRequest<T>(method:Method.UPLOAD,url: url!,isBaseParams: true,spProIsLoading: true,isToast: true,context: context!,spProCallBack: spProCallBack!,fileName: fileName!,files: files!,queryParameters:queryParameters );
  }

  Future<void> spFunDownLoad<T>({String ?url,SPClassHttpCallBack<T> ?spProCallBack,String ?savePath}) async {
    await spFunRequest<T>(method:Method.DOWNLOAD,url: url!,isBaseParams: true,spProIsLoading: false,isToast: false,spProCallBack: spProCallBack!,savePath: savePath!);
  }

  Future<void> spFunRequest<T>({dynamic jsonObject,Method ?method,String ?url,Map<String,dynamic> ?queryParameters,Map<String,dynamic> ?spProBodyParameters,bool ?isBaseParams,bool ?isDemo,bool ?isTimeOut,bool ?spProIsLoading,bool ?isToast,BuildContext ?context,SPClassHttpCallBack<T> ?spProCallBack,List<File> ?files,String ?fileName,String ?savePath}) async {
    /// 传参进行统一处理, 加上基本参数
    SPClassBaseModelEntity ?result;
    CancelToken? cancelToken;
    try{
      Map<String, dynamic> params ;
      if(isBaseParams!){
        params=  spFunGetBasicParams();
    }else{
      params=  spFunGetCommonParams();}
      if (queryParameters != null) {
      params.addAll(queryParameters);
    }
      Response ?response;
      cancelToken =CancelToken();
      var httpManager=SPClassHttpManager.spFunGetInstance();
      var baseUrl=((isDemo!=null) ? SPClassNetConfig.spFunGetBasicUrlByValue(isDemo):spFunGetBaseUrl());
      httpManager.options.baseUrl=baseUrl;
      if((isTimeOut==null||!isTimeOut)){
        httpManager.options.sendTimeout=SPClassHttpManager.Timeout;
        httpManager.options.connectTimeout=SPClassHttpManager.Timeout;
        httpManager.options.receiveTimeout=SPClassHttpManager.Timeout;
      }else{
        httpManager.options.sendTimeout=SPClassHttpManager.Timeout*4;
        httpManager.options.connectTimeout=SPClassHttpManager.Timeout*4;
        httpManager.options.receiveTimeout=SPClassHttpManager.Timeout*4;
      }

      if(spProIsLoading!&&context!=null){
        spProShowDialogCount++;
        SPClassDialogUtils.spFunShowLoadingDialog(context,barrierDismissible: true,content:"加载中",dismiss: (){
          if(cancelToken!=null){
            spProShowDialogCount--;
            cancelToken.cancel();
          }
        });
      }

      url=SPClassApplicaion.spProEncrypt? SPClassEncodeUtil.spFunEncodeStr(url!) : url;

      switch(method){
        case  Method.GET:
          if(SPClassApplicaion.spProEncrypt){
            //标记
            // var  urlEncode  =Transformer.urlEncodeMap(params);
            // var aes=  await Cipher2.encryptAesCbc128Padding7(urlEncode,"0CD29CA6CFF94F22","4BE6FB7804494C64");
            // var spProEncrypParameter=  base64Encode(utf8.encode(aes));
            // response  =await httpManager.get(url!+"?"+spProEncrypParameter,cancelToken:cancelToken);
          }else{
            response  =await httpManager.get(url!,queryParameters: params,cancelToken:cancelToken,);
            // try {
            //   await httpManager.get(url!,queryParameters: params,cancelToken:cancelToken);
            // } on DioError catch (e) {
            //   if (e.response != null) {
            //     print(e.response?.data);
            //     print(e.response?.headers);
            //     print(e.response?.requestOptions);
            //   } else {
            //     // Something happened in setting up or sending the request that triggered an Error
            //     print(e.requestOptions);
            //     print(e.message);
            //   }
            // }

          }
          break;
        case Method.POST:
          if(SPClassApplicaion.spProEncrypt){
            //标记
            // var  urlEncode  =Transformer.urlEncodeMap(params);
            // var aes=  await Cipher2.encryptAesCbc128Padding7(urlEncode,"0CD29CA6CFF94F22","4BE6FB7804494C64");
            // var spProEncrypParameter=  base64Encode(utf8.encode(aes));
            // response  =await httpManager.post(url!+"?"+spProEncrypParameter,data: Transformer.urlEncodeMap(spProBodyParameters!),cancelToken:cancelToken);
          }else{
            response  =await httpManager.post(url!,queryParameters: params,data:Transformer.urlEncodeMap(spProBodyParameters!),cancelToken:cancelToken );

          }
          break;
        case Method.UPLOAD:
          for(var i=0;i<files!.length;i++){
              var result = await FlutterImageCompress.compressWithFile(files[i].absolute.path, quality: 80,);
              params.putIfAbsent((fileName==null)? i.toString():fileName, ()=>MultipartFile.fromBytes(result!,filename:"${i.toString()}pic.jpg"));
            }

          FormData formData = new FormData();
            if (params != null) {
              formData = FormData.fromMap(params);
            }

            response = await httpManager.post(url!, data: formData,onSendProgress: (int count, int total){
              if(total>0&&count>0){
                if(spProCallBack!=null&&spProCallBack.spProOnProgress!=null){
                  spProCallBack.spProOnProgress(count/total);
                }
              }
            },options: Options(
              receiveTimeout:SPClassHttpManager.Timeout*10,
              sendTimeout:SPClassHttpManager.Timeout*10,
            ),cancelToken: cancelToken);

          break;
        case Method.DOWNLOAD:
             response=await httpManager.download(url!,savePath,onReceiveProgress: (int count, int total){
               if(total>0&&count>0){
                 if(spProCallBack!=null&&spProCallBack.spProOnProgress!=null){
                   spProCallBack.spProOnProgress(count/total);
                 }
               }
             },options: Options(
               receiveTimeout:SPClassHttpManager.Timeout*20,
               sendTimeout:SPClassHttpManager.Timeout*20,
             ));
          break;
      }

      if(response?.statusCode==200){
        if(method==Method.DOWNLOAD){
          result =SPClassBaseModelEntity("1","suceess",true);
        }else{
          Map<String,dynamic> data;
          if(response?.data is Map){
            data=response?.data;
          }else{
            data=json.decode(response?.data);
          }

          if(SPClassApplicaion.spProEncrypt){
            //标记
            // data["data"] = json.decode(await Cipher2.decryptAesCbc128Padding7(data["data"],"0CD29CA6CFF94F22","4BE6FB7804494C64"));
          }
          print('请求url：${httpManager.options.baseUrl}$url');
          print('请求参数：$queryParameters');
          print('请求参数body：$spProBodyParameters');
          print('返回数据：${data}');
          result=SPClassBaseModelEntity.formJson(data);
          result.spFunGetObject<T>(object: jsonObject);
          if(result.code=="401"){
            SPClassApplicaion.spFunClearUserState();
          }
        }

      }else{
         result =SPClassBaseModelEntity(response?.statusCode.toString(),"网络异常:statusCode:${response?.statusCode}",false);
      }

    }on  DioError catch(e){
      switch(e.type){
        case DioErrorType.connectTimeout:
        case DioErrorType.sendTimeout:
        case DioErrorType.receiveTimeout:
        result =SPClassBaseModelEntity("","网络异常:请求超时",false);
        break;
        case DioErrorType.response:
          result =SPClassBaseModelEntity("","网络异常: statusCode:${e.response?.statusCode}",false);
          break;
        case DioErrorType.cancel:
          isToast=false;
          result =SPClassBaseModelEntity("","网络异常:请求取消",false);
          break;
        case DioErrorType.other:
          result =SPClassBaseModelEntity("","网络异常:请检查网络情况",false);
          // TODO: Handle this case.
          break;
      }
    } catch (exception){
       result =SPClassBaseModelEntity("".toString(),"网络异常:解析异常",false);
       SPClassLogUtils.spFunPrintLog(exception.toString());
    }finally{
      cancelToken=null;
      /* 标记
      spFunHideDialog(context!);
       */
      if(context!=null){
        spFunHideDialog(context);
      }
      if(isToast!){
        result?.spFunToast();
      }
      if(result!.spFunIsSuccess()){
        if(spProCallBack!=null&&spProCallBack.spProOnSuccess!=null){
          spProCallBack.spProOnSuccess(result.spFunGetObject<T>(object: jsonObject)!);
        }
      }

      if(result.spFunIsFail()){
        SPClassLogUtils.spFunPrintLog("Fail: ${result.msg}  ${url!.trim()}");
        if(spProCallBack!=null&&spProCallBack.onError!=null){
          spProCallBack.onError(result);
        }
      }
    }
  }


   Map<String, dynamic> spFunGetBasicParams() {
    Map<String, dynamic> basicParam = {};

      basicParam["oauth_token"] =userLoginInfo==null? "":userLoginInfo!.spProOauthToken;
      basicParam["app_id"] =AppId;
      basicParam["channel_id"] =ChannelId;
      basicParam["app_version"] ='';
      basicParam["sydid"] = '';
      basicParam["did"] ='';

    return basicParam;
  }

   Map<String, dynamic> spFunGetCommonParams() {
    Map<String, dynamic> basicParam = {};
    basicParam["oauth_token"] =SPClassApplicaion.spProUserLoginInfo==null? "":SPClassApplicaion.spProUserLoginInfo?.spProOauthToken??'';
    basicParam["app_id"] =AppId;
    basicParam["channel_id"] =ChannelId;
    basicParam["did"] ='e1652ed8-d5c6-4858-be38-f9f6d3242fb5';
    basicParam["device"] ='M2004J7AC';
    basicParam["os"] ="android";
    basicParam["app_version"] ='3.0.1';
    basicParam["android_id"] ="fa462f316d05e99b";
    basicParam["manufacturer"] = "xiaomi";
    basicParam["sydid"] = '440fc3535f24d276cbd0a2cd15dca44f';
    basicParam["os_version"] ='10';
    basicParam["mac"] ='02:00:00:00:00:00';
    return basicParam;
  }

   spFunGetBaseUrl() {
    return SPClassNetConfig.spFunGetBasicUrl();
  }

   spFunHideDialog(BuildContext context)  {
    if(context==null){
      return;
    }
     while(spProShowDialogCount>0){
       if(Navigator.of(context).canPop()){
         Navigator.of(context).pop();
       }
       spProShowDialogCount--;
     }
  }
}