

import 'package:changshengh5/widgets/SPClassAnimationRoute.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


typedef PageCallBack = Widget Function();

class SPClassNavigatorUtils{

/*  static void push(BuildContext context,PageCallBack t){
   Navigator.of(context).push(MaterialPageRoute (
        builder:(context){return t();}));
  }*/
  static Future<Object> spFunPushRoute(BuildContext context,Widget t,{VoidCallback ?callback}){
    return  Navigator.of(context).push(SPClassAnimationRoute(t)).then((value){
    if(callback!=null){callback();}
    return true;
  });

  }

  static void spFunPopAll(BuildContext context){
    while(Navigator.canPop(context)){
      Navigator.of(context).pop();
    }
  }

  static Future pushAndRemoveAll(BuildContext context,Widget t){
    return Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => t), (route) => route == null);
  }
}