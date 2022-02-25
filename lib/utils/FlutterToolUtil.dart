import 'dart:async';

import 'package:changshengh5/utils/LocalStorage.dart';
import 'package:flutter/services.dart';

class FlutterToolUtil {
  static const MethodChannel _channel =
  MethodChannel('flutter_toolplugin');

  static Future<String> get getKeyChainSyDid async {
    // final String value = await _channel.invokeMethod('getKeyChainSyDid');
    // return value;
    return LocalStorage.get('ChainSyDid');
  }

  static Future<void>  saveKeyChainSyDiy(String value) async {
    LocalStorage.save('ChainSyDid', value);
    // await _channel.invokeMethod('saveChainSyDid',value);
  }

  static Future<String>  getExternalStorage() async {
    return  await _channel.invokeMethod('getExternalStorage');
  }


  static Future<String>  get channelId async {
    return  await _channel.invokeMethod('getChannelId');
  }


}
