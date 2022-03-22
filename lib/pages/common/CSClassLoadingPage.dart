import 'dart:async';
import 'package:changshengh5/utils/CSClassCommonMethods.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'AnimationImagePage.dart';

class CSClassLoadingPage extends StatefulWidget{


  CSClassLoadingPageState createState()=>CSClassLoadingPageState();
}

class CSClassLoadingPageState extends State<CSClassLoadingPage> with SingleTickerProviderStateMixin
{
  late AnimationController csProController;
  late Timer csProTimer;
  int csProCurrentTime=0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    csProTimer=Timer.periodic(Duration(seconds: 1), (value){
      csProCurrentTime++;
      if(mounted){
        setState(() {});
      }
    });
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    // csProController.stop();
    csProTimer.cancel();
  }
@override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white
      ),
      child: Center(
          child:  Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              AnimationImagePage(width: width(100),height: width(100),),
              // SizedBox(height: 15,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    width: width(12),
                  ),
                  Text("正在加载",style: TextStyle(fontSize: 14,color: Color(0xFF666666)),),
                  Text((csProCurrentTime%3==0 ?".  ":(csProCurrentTime%3==1? ".. ":"...")),style: TextStyle(fontSize: 14,color: Color(0xFF666666)),),

                ],
              )
            ],
          ),
      ) ,
    );
  }


}