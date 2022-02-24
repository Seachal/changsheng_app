
import 'package:changshengh5/api/SPClassApiManager.dart';
import 'package:changshengh5/api/SPClassHttpCallBack.dart';
import 'package:changshengh5/utils/SPClassCommonMethods.dart';
import 'package:changshengh5/utils/SPClassToastUtils.dart';
import 'package:changshengh5/utils/colors.dart';
import 'package:changshengh5/widgets/SPClassToolBar.dart';
import 'package:flutter/material.dart';


class SPClassFeedbackPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return StateFeedback();
  }

}

class StateFeedback extends State<SPClassFeedbackPage>{
  String spProContent="";
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      resizeToAvoidBottomInset:false,
      appBar: SPClassToolBar(
        context,title: "意见反馈",),
      body: Container(
        color: Color(0xFFF1F1F1),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: <Widget>[
            Container(height: 0.4,color: Colors.grey[300],),
            Container(
              height: height(200),
              padding: EdgeInsets.only(right: width(10),left: width(24),bottom: height(10)),
              color: Colors.white,
                child: TextField(
                  style: TextStyle(fontSize: width(14),textBaseline:TextBaseline.alphabetic ),
                  onChanged: (value){
                    if(mounted){
                      setState(() {
                          spProContent=value;
                      });
                    }
                  },
                  maxLength: 500,
                  maxLines: 15,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "简要描述你要反馈的问题和意见",
                      hintStyle: TextStyle(fontSize: width(14),textBaseline:TextBaseline.alphabetic,color: Color(0xFF999999) )
                  ),
              ),
            ),
            SizedBox(height: 10,),
            Container(
              height: 1,
              color: Colors.grey[200],
            ),
            SizedBox(height: 10,),
            GestureDetector(
              child:  Container(
                height: width(46),
                alignment: Alignment.center,
                child:Container(
                  alignment: Alignment.center,
                  height: width(46),
                  width: width(230),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(width(4)),
                    color: MyColors.main1
                  ),
                  child:Text("提交",style: TextStyle(fontSize: sp(19),color: Colors.white),),
                ) ,
              ),
              onTap: () async {
                if(spProContent.isEmpty){
                  SPClassToastUtils.spFunShowToast(msg: "提交内容不能为空");
                }else{
                  SPClassApiManager.spFunGetInstance().spFunGiveFeedback(context:context,queryParameters: {"content":spProContent,},spProCallBack: SPClassHttpCallBack(
                    spProOnSuccess: (result){
                      SPClassToastUtils.spFunShowToast(msg: "提交成功");
                      Navigator.of(context).pop();
                    },onError: (e){},spProOnProgress: (v){}
                  ));
                }
              },
            ),
          ],

        ),
      ),
    );
  }

}