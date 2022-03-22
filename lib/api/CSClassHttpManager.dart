
import 'dart:io';

import 'package:dio/dio.dart';


class CSClassHttpManager  {

  static const int Timeout  =15000;

 static Dio ?_mInstance;
 static Dio get instance =>csMethodGetInstance();


 static Dio csMethodGetInstance() {
   if (_mInstance == null) {
     _mInstance = new Dio();
     _mInstance!.options = BaseOptions(
       receiveTimeout: Timeout,
       connectTimeout: Timeout,
       sendTimeout:Timeout ,
       contentType:"application/x-www-form-urlencoded",
     );
     // 标记
     //添加拦截Log
     // _mInstance!.interceptors.add(

         // InterceptorsWrapper(onRequest: (RequestOptions options) {
         //   CSClassLogUtils.csMethodPrintLog("Method:${options.method}  Url:${options.uri}");
         //   // Do something before request is sent
         //   return options; //continue
         // }, onResponse: (Response response) {
         //   CSClassLogUtils.csMethodPrintLog(
         //       "Url:${response.request.uri.path}  StatusCode:${response
         //           ?.statusCode}  ");
         //   CSClassLogUtils.csMethodPrintLog("Data${response.data}");
         //   // Do something with response data
         //   return response; // continue
         // }, onError: (DioError e) {
         //   CSClassLogUtils.csMethodPrintLog("Url:${e.request?.uri?.path} DioError：${e.message}");
         //   // Do something with response error
         //   return e; //continue
         // })
    // );
   }
   return _mInstance!;

 }


}