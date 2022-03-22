import 'package:flutter/material.dart';


class CSClassImageUtil {

  static String csMethodGetImagePath(String fileName, {String format: '.webp'}) {
    return 'assets/images/$fileName$format';
  }

  static FadeInImage csMethodNetWordImage({
    String placeholder:'ic_app_logo',
    required String url,
    double  ?width,
    double  ?height,
    BoxFit fit:BoxFit.cover
  }
    ){
    return FadeInImage.assetNetwork(
      placeholder: csMethodGetImagePath(placeholder),
      image: url,
      width: width,
      height: height,
      fit: fit,
      imageErrorBuilder: (c,e,s){
        /*CSClassLogUtils.csMethodPrintLog(e.toString());*/
        return Image.asset(csMethodGetImagePath(placeholder),
          width: width,
          height: height,
          fit: fit,
        );
      });
  }

  //  获取商城的图片
  static String csMethodGetShopImagePath(String fileName, {String format: '.png'}) {
    return 'assets/shop/$fileName$format';
  }
}
