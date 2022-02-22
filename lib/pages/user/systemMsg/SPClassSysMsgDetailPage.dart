
import 'package:changshengh5/model/SPClassSystemMsg.dart';
import 'package:changshengh5/untils/SPClassCommonMethods.dart';
import 'package:flutter/material.dart';



class SPClassSysMsgDetailPage extends StatefulWidget{
  SPClassSystemMsg content;
  SPClassSysMsgDetailPage(this.content);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SPClassSysMsgDetailPageState();
  }

}

class SPClassSysMsgDetailPageState extends State<SPClassSysMsgDetailPage>{

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("详情"),
      ),
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                child: Text(widget.content.title!,style: TextStyle(fontSize: sp(18),color: Color(0xFF333333,),)),
              ),

              Container(
                padding: EdgeInsets.all(10),
                alignment: Alignment.centerLeft,
                child: Text(widget.content.content!,style: TextStyle(fontSize: sp(16),color: Color(0xFF333333,),)),
              ),

              Container(
                margin: EdgeInsets.only(left: 10),
                alignment: Alignment.centerLeft,
                child: Text(widget.content.spProAddTime!,style: TextStyle(fontSize: sp(14),color: Colors.grey,)),
              ),
            ],
          ),
        ),
      ),
    );
  }

}