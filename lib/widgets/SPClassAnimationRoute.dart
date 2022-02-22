import 'package:flutter/material.dart';


class SPClassAnimationRoute extends PageRouteBuilder {

  final Widget widget;

  SPClassAnimationRoute(this.widget)
      : super(
      transitionDuration: const Duration(milliseconds: 500), //设置动画时长500毫秒
      pageBuilder: (
          BuildContext context,
          Animation<double> animation1,
          Animation<double> animation2){
        return widget;
      },
      transitionsBuilder: (
          BuildContext context,
          Animation<double> animation1,
          Animation<double> animation2,
          Widget child
          ){
        //渐变过渡
//      return FadeTransition(//渐变过渡 0.0-1.0
//        opacity: Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
//          parent: animation1, //动画样式
//          curve: Curves.fastOutSlowIn, //动画曲线
//        )),
//        child: child,
//      );
        //翻转缩放
//      return RotationTransition(
//        turns: Tween(begin: 0.0, end: 1.0).
//        animate(
//          CurvedAnimation(
//            parent: animation1,
//            curve: Curves.fastOutSlowIn,
//          )
//        ),
//        child: ScaleTransition(
//          scale: Tween(begin: 0.0, end: 1.0).
//          animate(CurvedAnimation(parent: animation1, curve: Curves.fastOutSlowIn)),
//          child: child,
//        ),
//      );
        //左右滑动
        return SlideTransition(
          position: Tween<Offset>(
              begin: Offset(1.0, 0.0),
              end: Offset(0.0, 0.0)

          )
              .animate(CurvedAnimation(parent: animation1, curve: Curves.fastOutSlowIn,)),
          child: child,
        );
      }

  );


}