import 'package:flutter/material.dart';


class SPClassImageUtil {

  static String spFunGetImagePath(String fileName, {String format: '.webp'}) {
    return 'assets/images/$fileName$format';
  }

  static FadeInImage spFunNetWordImage({
    String placeholder:'ic_app_logo',
    required String url,
    double  ?width,
    double  ?height,
    BoxFit fit:BoxFit.cover
  }
    ){
    return FadeInImage.assetNetwork(
      placeholder: spFunGetImagePath(placeholder),
      image: url,
      width: width,
      height: height,
      fit: fit,
      imageErrorBuilder: (c,e,s){
        /*SPClassLogUtils.spFunPrintLog(e.toString());*/
        return Image.asset(spFunGetImagePath(placeholder),
          width: width,
          height: height,
          fit: fit,
        );
      });
  }

  //  获取商城的图片
  static String spFunGetShopImagePath(String fileName, {String format: '.png'}) {
    return 'assets/shop/$fileName$format';
  }
}
