
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:changshengh5/app/CSClassApplicaion.dart';
import 'package:changshengh5/model/CSClassBaseModelEntity.dart';
import 'package:changshengh5/pages/common/CSClassDialogUtils.dart';
import 'package:changshengh5/utils/AesUtils.dart';
import 'package:changshengh5/utils/CSClassCommonMethods.dart';
import 'package:changshengh5/utils/CSClassLogUtils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';


import '../CSClassEncodeUtil.dart';
import 'CSClassHttpCallBack.dart';
import 'CSClassHttpManager.dart';
import 'CSClassNetConfig.dart';




enum Method{
 GET,
 POST,
 UPLOAD,
 DOWNLOAD
}

class CSClassBaseApi{

  static var csProShowDialogCount=0;
  //GET请求
  Future<void> csMethodGet<T>({Object ?jsonObject,String ?url,Map<String,dynamic> ?queryParameters,bool isBaseParams:true,bool csProIsLoading:false,bool isToast:false,bool isTimeOut:false,BuildContext ?context,CSClassHttpCallBack<T> ?csProCallBack,bool isDemo:false}) async {
    await csMethodRequest<T>(jsonObject: jsonObject,method:Method.GET,url: url,queryParameters: queryParameters,isBaseParams: isBaseParams,isTimeOut:isTimeOut,csProIsLoading: csProIsLoading,isToast: isToast,context: context,csProCallBack: csProCallBack,isDemo: isDemo);

  }
  Future<void> csMethodPost<T>({Object ?jsonObject,String ?url,Map<String,dynamic> ?queryParameters,Map<String,dynamic> ?csProBodyParameters,bool isBaseParams:true,bool csProIsLoading:false,bool isToast:false,BuildContext ?context,CSClassHttpCallBack<T> ?csProCallBack}) async {

    await csMethodRequest<T>(jsonObject: jsonObject,method:Method.POST,url: url!,queryParameters: queryParameters!,csProBodyParameters: csProBodyParameters!,isBaseParams: isBaseParams,csProIsLoading: csProIsLoading,isToast: isToast,context: context!,csProCallBack: csProCallBack!);
  }

  Future<void> csMethodUpload<T>({String ?url,BuildContext ?context,CSClassHttpCallBack<T> ?csProCallBack,List<File> ?files,String ?fileName,params, Map<String, dynamic>? queryParameters,}) async {
    await csMethodRequest<T>(method:Method.UPLOAD,url: url!,isBaseParams: true,csProIsLoading: true,isToast: true,context: context!,csProCallBack: csProCallBack!,fileName: fileName!,files: files!,queryParameters:queryParameters );
  }

  Future<void> csMethodDownLoad<T>({String ?url,CSClassHttpCallBack<T> ?csProCallBack,String ?savePath}) async {
    await csMethodRequest<T>(method:Method.DOWNLOAD,url: url!,isBaseParams: true,csProIsLoading: false,isToast: false,csProCallBack: csProCallBack!,savePath: savePath!);
  }

  Future<void> csMethodRequest<T>({dynamic jsonObject,Method ?method,String ?url,Map<String,dynamic> ?queryParameters,Map<String,dynamic> ?csProBodyParameters,bool ?isBaseParams,bool ?isDemo,bool ?isTimeOut,bool ?csProIsLoading,bool ?isToast,BuildContext ?context,CSClassHttpCallBack<T> ?csProCallBack,List<File> ?files,String ?fileName,String ?savePath}) async {
    /// 传参进行统一处理, 加上基本参数
    CSClassBaseModelEntity ?result;
    CancelToken? cancelToken;
    try{
      Map<String, dynamic> params ;
      if(isBaseParams!){
        params=  csMethodGetBasicParams();
    }else{
      params=  csMethodGetCommonParams();}
      if (queryParameters != null) {
      params.addAll(queryParameters);
    }
      Response ?response;
      cancelToken =CancelToken();
      var httpManager=CSClassHttpManager.csMethodGetInstance();
      // 标记
      // var baseUrl=((isDemo!=null) ? CSClassNetConfig.csMethodGetBasicUrlByValue(isDemo):csMethodGetBaseUrl());
      var baseUrl=csMethodGetBaseUrl();
      httpManager.options.baseUrl=baseUrl;
      if((isTimeOut==null||!isTimeOut)){
        httpManager.options.sendTimeout=CSClassHttpManager.Timeout;
        httpManager.options.connectTimeout=CSClassHttpManager.Timeout;
        httpManager.options.receiveTimeout=CSClassHttpManager.Timeout;
      }else{
        httpManager.options.sendTimeout=CSClassHttpManager.Timeout*4;
        httpManager.options.connectTimeout=CSClassHttpManager.Timeout*4;
        httpManager.options.receiveTimeout=CSClassHttpManager.Timeout*4;
      }

      if(csProIsLoading!&&context!=null){
        csProShowDialogCount++;
        CSClassDialogUtils.csMethodShowLoadingDialog(context,barrierDismissible: true,content:"加载中",dismiss: (){
          if(cancelToken!=null){
            csProShowDialogCount--;
            cancelToken.cancel();
          }
        });
      }

      url=CSClassApplicaion.csProEncrypt? CSClassEncodeUtil.csMethodEncodeStr(url!) : url;

      switch(method){
        case  Method.GET:
          if(CSClassApplicaion.csProEncrypt){
            var  urlEncode  =Transformer.urlEncodeMap(params);
            var aes=  AesUtils.encryptAes(urlEncode);
            var csProEncrypParameter=  base64Encode(utf8.encode(aes));
            response  =await httpManager.get(url!+"?"+csProEncrypParameter,cancelToken:cancelToken);
          }else{
            response  =await httpManager.get(url!,queryParameters: params,cancelToken:cancelToken,);
            // 测试
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
          if(CSClassApplicaion.csProEncrypt){
            var  urlEncode  =Transformer.urlEncodeMap(params);
            var aes=  AesUtils.encryptAes(urlEncode);
            var csProEncrypParameter=  base64Encode(utf8.encode(aes));
            response  =await httpManager.post(url!+"?"+csProEncrypParameter,data: Transformer.urlEncodeMap(csProBodyParameters!),cancelToken:cancelToken);
          }else{
            response  =await httpManager.post(url!,queryParameters: params,data:Transformer.urlEncodeMap(csProBodyParameters!),cancelToken:cancelToken );

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
                if(csProCallBack!=null&&csProCallBack.csProOnProgress!=null){
                  csProCallBack.csProOnProgress(count/total);
                }
              }
            },options: Options(
              receiveTimeout:CSClassHttpManager.Timeout*10,
              sendTimeout:CSClassHttpManager.Timeout*10,
            ),cancelToken: cancelToken);

          break;
        case Method.DOWNLOAD:
             response=await httpManager.download(url!,savePath,onReceiveProgress: (int count, int total){
               if(total>0&&count>0){
                 if(csProCallBack!=null&&csProCallBack.csProOnProgress!=null){
                   csProCallBack.csProOnProgress(count/total);
                 }
               }
             },options: Options(
               receiveTimeout:CSClassHttpManager.Timeout*20,
               sendTimeout:CSClassHttpManager.Timeout*20,
             ));
          break;
      }

      if(response?.statusCode==200){
        if(method==Method.DOWNLOAD){
          result =CSClassBaseModelEntity("1","suceess",true);
        }else{
          Map<String,dynamic> data;
          if(response?.data is Map){
            data=response?.data;
          }else{
            data=json.decode(response?.data);
          }

          if(CSClassApplicaion.csProEncrypt){
            data["data"] = json.decode( AesUtils.encryptAes(data["data"]));
          }
          print('请求url：${httpManager.options.baseUrl}$url');
          print('请求参数：$queryParameters');
          print('请求参数body：$csProBodyParameters');
          print('返回数据：${data}');
          result=CSClassBaseModelEntity.formJson(data);
          result.csMethodGetObject<T>(object: jsonObject);
          if(result.code=="401"){
            CSClassApplicaion.csMethodClearUserState();
          }
        }

      }else{
         result =CSClassBaseModelEntity(response?.statusCode.toString(),"网络异常:statusCode:${response?.statusCode}",false);
      }

    }on  DioError catch(e){
      switch(e.type){
        case DioErrorType.connectTimeout:
        case DioErrorType.sendTimeout:
        case DioErrorType.receiveTimeout:
        result =CSClassBaseModelEntity("","网络异常:请求超时",false);
        break;
        case DioErrorType.response:
          result =CSClassBaseModelEntity("","网络异常: statusCode:${e.response?.statusCode}",false);
          break;
        case DioErrorType.cancel:
          isToast=false;
          result =CSClassBaseModelEntity("","网络异常:请求取消",false);
          break;
        case DioErrorType.other:
          result =CSClassBaseModelEntity("","网络异常:请检查网络情况",false);
          // TODO: Handle this case.
          break;
      }
    } catch (exception){
       result =CSClassBaseModelEntity("".toString(),"网络异常:解析异常",false);
       CSClassLogUtils.csMethodPrintLog(exception.toString());
    }finally{
      cancelToken=null;
      /* 标记
      csMethodHideDialog(context!);
       */
      if(context!=null){
        csMethodHideDialog(context);
      }
      if(isToast!){
        result?.csMethodToast();
      }
      if(result!.csMethodIsSuccess()){
        if(csProCallBack!=null&&csProCallBack.csProOnSuccess!=null){
          csProCallBack.csProOnSuccess(result.csMethodGetObject<T>(object: jsonObject)!);
        }
      }

      if(result.csMethodIsFail()){
        CSClassLogUtils.csMethodPrintLog("Fail: ${result.msg}  ${url!.trim()}");
        if(csProCallBack!=null&&csProCallBack.onError!=null){
          csProCallBack.onError(result);
        }
      }
    }
  }


   Map<String, dynamic> csMethodGetBasicParams() {
    Map<String, dynamic> basicParam = {};
    basicParam["oauth_token"] =userLoginInfo==null? "":userLoginInfo?.csProOauthToken;
    basicParam["app_id"] =AppId;
    basicParam["channel_id"] =ChannelId;
    basicParam["app_version"] =CSClassApplicaion.csProPackageInfo?.version??'';
    basicParam["sydid"] = CSClassApplicaion.csProSydid;
    basicParam["did"] =Platform.isAndroid ? CSClassApplicaion.csProImei : CSClassNetConfig.csProIosDeviceInfo?.identifierForVendor??'';

    return basicParam;
  }

   Map<String, dynamic> csMethodGetCommonParams() {
     Map<String, dynamic> basicParam = {};
     basicParam["oauth_token"] =CSClassApplicaion.csProUserLoginInfo==null? "":CSClassApplicaion.csProUserLoginInfo?.csProOauthToken??'';
     basicParam["app_id"] =AppId;
     basicParam["channel_id"] =ChannelId;
     basicParam["did"] =Platform.isAndroid ? CSClassApplicaion.csProImei : CSClassNetConfig.csProIosDeviceInfo?.identifierForVendor??'';
     basicParam["device"] =CSClassApplicaion.csProDeviceName;
     basicParam["os"] = Platform.isAndroid ? "android" : "ios";
     basicParam["app_version"] =CSClassApplicaion.csProPackageInfo?.version??'';
     basicParam["android_id"] =Platform.isAndroid ?    CSClassNetConfig.androidInfo?.androidId:"";
     basicParam["manufacturer"] = Platform.isAndroid ? CSClassNetConfig.androidInfo?.manufacturer.toLowerCase():"apple";
     basicParam["sydid"] = CSClassApplicaion.csProSydid;
     basicParam["os_version"] =Platform.isAndroid ?CSClassNetConfig.androidInfo?.version.release:CSClassNetConfig.csProIosDeviceInfo?.systemVersion??'';
     basicParam["mac"] =CSClassApplicaion.csProMacAddress;
    return basicParam;
  }

   csMethodGetBaseUrl() {
    return CSClassNetConfig.csMethodGetBasicUrl();
  }

   csMethodHideDialog(BuildContext context)  {
    if(context==null){
      return;
    }
     while(csProShowDialogCount>0){
       if(Navigator.of(context).canPop()){
         Navigator.of(context).pop();
       }
       csProShowDialogCount--;
     }
  }
}