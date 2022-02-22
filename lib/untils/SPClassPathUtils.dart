import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
class SPClassPathUtils{
 // ignore: missing_return
 static Future spFunGetFilePathFromAsset(String fileName) async {
    try {
      //获取file中的数据
      var data = await rootBundle.load(fileName);
      //将数据转为byte类型的数据
      var byte = data.buffer.asUint8List();
      //存储数据路径
      var dir = await getApplicationDocumentsDirectory();
      File file = File(dir.path + "/audio.mp3");
      //将数据写入file中
      File assetFile = await file.writeAsBytes(byte);
      return assetFile.path;
    } catch (e) {
    }
  }
}