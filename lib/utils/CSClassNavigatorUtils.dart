

import 'package:changshengh5/widgets/CSClassAnimationRoute.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


typedef PageCallBack = Widget Function();

class CSClassNavigatorUtils{

/*  static void push(BuildContext context,PageCallBack t){
   Navigator.of(context).push(MaterialPageRoute (
        builder:(context){return t();}));
  }*/
  static csMethodPushRoute(BuildContext context,Widget t,{ValueChanged ?callback}){
//    return  Navigator.of(context).push(CSClassAnimationRoute(t)).then((value){
//    if(callback!=null){callback();}
//    return true;
//  });
    Navigator.push(context, CupertinoPageRoute(builder: (context)=>t)).then((value){
      if(callback != null){ callback(value); }
    });
  }

  static void csMethodPopAll(BuildContext context){
    while(Navigator.canPop(context)){
      Navigator.of(context).pop();
    }
  }

  static Future pushAndRemoveAll(BuildContext context,Widget t){
    return Navigator.pushAndRemoveUntil(context, CupertinoPageRoute(builder: (context) => t), (route) => route == null);
  }
}