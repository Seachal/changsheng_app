//以后支持通过python脚本更改sProUnicodeMask并替换代码里的字符串
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'dart:convert';

import 'package:flutter/services.dart';

class SPClassEncodeUtil{

  static int spProImageEncryptCode = 129;
  static int spProStrEncryptCode = 200;
  static String spProImageSuffix = ".gdata";

  static String spFunImgPath(String imgPath){
    String relativePath = imgPath.replaceAll("assets/", "");
    List<int> path_bytes = [];
    for(var ch in utf8.encode(relativePath)){
      path_bytes.add(ch ^ spProImageEncryptCode);
    }
    var newNmae =  md5.convert(path_bytes);
    //放到assets根目录
    return "assets/" + newNmae.toString() + spProImageSuffix;
  }

  static Uint8List spFunDecodeImgData(Uint8List imgData){
    List<int> realData  = [];
    for(var ch in imgData){
      realData.add(ch ^ spProImageEncryptCode);
    }
    return Uint8List.fromList(realData);
  }



  static String spFunEncodeStr(String str){
    List<int> realData  = [];
    for(var code in str.codeUnits){
      realData.add(code ^ spProStrEncryptCode);
    }
    return base64Encode(realData);
  }

  static String spFunMd5(String plaintext){
    var cipher = md5.convert(utf8.encode(plaintext));
    return "$cipher";
  }

}