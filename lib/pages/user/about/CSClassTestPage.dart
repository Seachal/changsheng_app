
import 'package:changshengh5/app/CSClassApplicaion.dart';
import 'package:changshengh5/app/CSClassGlobalNotification.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CSClassTestPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CSClassTestPageState();
  }

}

class CSClassTestPageState extends State<CSClassTestPage>{
  int debug=0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(CSClassApplicaion.csProDEBUG){
      debug=1;
    }
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("调试"),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
           children: <Widget>[
             Row(
               children: <Widget>[
                 GestureDetector(
                   behavior: HitTestBehavior.translucent,
                   child:  Row(
                     children: <Widget>[
                       Text("测试坏境"),
                       Checkbox(value: debug==1,activeColor: Colors.red,checkColor: Colors.black, onChanged: (bool? value) {  },)
                     ],
                   ),
                   onTap: (){
                     CSClassApplicaion.csProDEBUG=true;
                     CSClassApplicaion.csMethodClearUserState();
                     CSClassApplicaion.csProEventBus.fire("login:change");
                     SharedPreferences.getInstance().then((sp)=>sp.setBool("test", true));
                     debug=1;
                     setState(() {});
                     CSClassGlobalNotification.csMethodGetInstance()?.csMethodCloseConnect();
                     CSClassGlobalNotification.csMethodGetInstance()?.csMethodInitWebSocket();
                   },
                 ),
                 GestureDetector(
                   behavior: HitTestBehavior.translucent,
                   child:Row(
                     children: <Widget>[
                       Text("正式环境"),
                       Checkbox(value: debug!=1,activeColor: Colors.red,checkColor: Colors.black, onChanged: (bool? value) {  },)
                     ],
                   ),
                   onTap: (){
                     CSClassApplicaion.csProDEBUG=false;
                     CSClassApplicaion.csMethodClearUserState();
                     CSClassApplicaion.csProEventBus.fire("login:change");
                     SharedPreferences.getInstance().then((sp)=>sp.setBool("test", false));
                     debug=0;
                     setState(() {});
                     CSClassGlobalNotification.csMethodGetInstance()?.csMethodCloseConnect();
                     CSClassGlobalNotification.csMethodGetInstance()?.csMethodInitWebSocket();
                   },
                 )
               ],
             ),

             Row(
               children: <Widget>[
                 Flexible(
                   flex: 1,
                   fit: FlexFit.tight,
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: <Widget>[
                       Text("打印log"),
                     ],
                   ),
                 ),

                 Switch(
                   activeColor:Theme.of(context).primaryColor,
                   value: CSClassApplicaion.csProLOG_OPEN,
                   onChanged: (value){
                     CSClassApplicaion.csProLOG_OPEN=value;
                     setState(() {
                     });
                   },
                 )
               ],
             ),


           ],
        ),
      ),
    );
  }

}