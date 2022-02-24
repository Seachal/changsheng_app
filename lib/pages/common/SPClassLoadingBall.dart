import 'dart:async';
import 'package:changshengh5/utils/SPClassCommonMethods.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'AnimationImagePage.dart';



class SPClassLoadingBall extends StatefulWidget{

  String content;
   VoidCallback ?dismiss;
  SPClassLoadingBall({this.content='',this.dismiss});
  SPClassLoadingBallState createState()=>SPClassLoadingBallState();
}

class SPClassLoadingBallState extends State<SPClassLoadingBall> with SingleTickerProviderStateMixin
{
  late AnimationController spProController;
  late Timer spProTimer;
  int spProCurrentTime=0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    spProController= AnimationController(duration: const Duration(milliseconds: 400), vsync: this);
    spProController.addStatusListener((status) async {
      if (status == AnimationStatus.completed) {
        //动画从 controller.forward() 正向执行 结束时会回调此方法
        //重置起点
        spProController.reset();
        //开启
        await Future.delayed(Duration(milliseconds: 100));
        spProController.forward();
      }
    });
    spProController.forward();
    spProTimer=Timer.periodic(Duration(seconds: 1), (value){
      spProCurrentTime++;
      if(mounted){
        setState(() {});
      }
    });
  }

  @override
  void deactivate() {
    super.deactivate();
    // TODO: implement deactivate
    spProController.stop();
    spProTimer.cancel();
  }
@override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    if(widget.dismiss!=null){
      widget.dismiss!();
    }

  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: width(120),
      height: width(120),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(width(10)),
        color: Colors.white,
      ),
      child: Center(
        child:  Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // RotationTransition(
            //   turns: spProController,
            //   alignment: Alignment.center,
            //   child:Image.asset(
            //     SPClassImageUtil.spFunGetImagePath('ic_common_loading'),
            //     width:  width(45),
            //   ) ,
            // ),
            // SizedBox(height: 5,),
            // Image.asset(
            //   SPClassImageUtil.spFunGetImagePath('ic_ball_shadow'),
            //   width:  width(21),
            // ),
            // SizedBox(height: 5,),
            AnimationImagePage(
              width: width(100),
              height: width(100),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(widget.content==''? "正在加载":widget.content,style: TextStyle(fontSize: width(13),color: Color(0xFF666666)),),
                Text((spProCurrentTime%3==0 ?".  ":(spProCurrentTime%3==1? ".. ":"...")),style: TextStyle(fontSize: width(13),color: Color(0xFF666666)),),

              ],
            )
          ],
        ),
      ),
    );
  }


}