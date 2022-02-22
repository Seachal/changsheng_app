
import 'package:changshengh5/app/SPClassApplicaion.dart';
import 'package:changshengh5/app/SPClassGlobalNotification.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SPClassTestPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SPClassTestPageState();
  }

}

class SPClassTestPageState extends State<SPClassTestPage>{
  int debug=0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(SPClassApplicaion.spProDEBUG){
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
                 Expanded(
                   child:GestureDetector(
                     behavior: HitTestBehavior.opaque,
                     child: Row(
                       children: <Widget>[
                         Text("测试坏境"),
                         Checkbox(value: debug==1,activeColor: Colors.red,checkColor: Colors.red, onChanged: (bool? value) {  },)
                       ],
                     ),
                     onTap: (){
                       SPClassApplicaion.spProDEBUG=true;
                       SPClassApplicaion.spFunClearUserState();
                       SPClassApplicaion.spProEventBus.fire("login:change");
                       SharedPreferences.getInstance().then((sp)=>sp.setBool("test", true));
                       debug=1;
                       setState(() {});
                       SPClassGlobalNotification.spFunGetInstance()?.spFunCloseConnect();
                       SPClassGlobalNotification.spFunGetInstance()?.spFunInitWebSocket();
                     },
                   ),
                 ),
                 Expanded(
                   child:GestureDetector(
                     behavior: HitTestBehavior.opaque,
                     child: Row(
                       children: <Widget>[
                         Text("正式环境"),
                         Checkbox(value: debug!=1,activeColor: Colors.red,checkColor: Colors.red, onChanged: (bool? value) {  },)
                       ],
                     ),
                     onTap: (){
                       SPClassApplicaion.spProDEBUG=false;
                       SPClassApplicaion.spFunClearUserState();
                       SPClassApplicaion.spProEventBus.fire("login:change");
                       SharedPreferences.getInstance().then((sp)=>sp.setBool("test", false));
                       debug=0;
                       setState(() {});
                       SPClassGlobalNotification.spFunGetInstance()?.spFunCloseConnect();
                       SPClassGlobalNotification.spFunGetInstance()?.spFunInitWebSocket();
                     },
                   ),
                 ),
               ],
             ),

             // Row(
             //   children: <Widget>[
             //     Flexible(
             //       flex: 1,
             //       fit: FlexFit.tight,
             //       child: Column(
             //         crossAxisAlignment: CrossAxisAlignment.start,
             //         children: <Widget>[
             //           Text("打印log"),
             //         ],
             //       ),
             //     ),
             //
             //     Switch(
             //       activeColor:Theme.of(context).primaryColor,
             //       value: SPClassApplicaion.spProLOG_OPEN,
             //       onChanged: (value){
             //         SPClassApplicaion.spProLOG_OPEN=value;
             //         setState(() {
             //         });
             //       },
             //     )
             //   ],
             // ),


           ],
        ),
      ),
    );
  }

}