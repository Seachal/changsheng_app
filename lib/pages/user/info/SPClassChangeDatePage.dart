
import 'package:changshengh5/api/SPClassApiManager.dart';
import 'package:changshengh5/api/SPClassHttpCallBack.dart';
import 'package:changshengh5/app/SPClassApplicaion.dart';
import 'package:changshengh5/untils/SPClassCommonMethods.dart';
import 'package:changshengh5/untils/SPClassToastUtils.dart';
import 'package:changshengh5/untils/colors.dart';
import 'package:changshengh5/widgets/SPClassToolBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



typedef StringCallback =  Function(String value);
class SPClassChangeDatePage extends StatefulWidget{
  StringCallback callback;
  String spProValueOrg;
  SPClassChangeDatePage(this.spProValueOrg,this.callback,);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SPClassChangeDatePageState();
  }

}


class SPClassChangeDatePageState extends State<SPClassChangeDatePage>{
  String ?spProNickName;

  TextEditingController ?spProController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    spProController=TextEditingController(text: widget.spProValueOrg);
    spProNickName=widget.spProValueOrg.toString();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
      appBar: SPClassToolBar(
        context,
        title:"个人资料",
        spProBgColor: MyColors.main1,
        iconColor: 0xFFFFFFFF,
        actions: <Widget>[
          FlatButton(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(width(3)),
                color: MyColors.main1
              ),
              padding: EdgeInsets.only(left: width(9),right: width(9),top: width(5),bottom: width(5)),
              child: Text("保存",style: TextStyle(color: Colors.white),),
            ),
            onPressed: (){

              if(spProNickName!.isEmpty){
                SPClassToastUtils.spFunShowToast(msg: "请输入昵称");
              }
              SPClassApiManager.spFunGetInstance().spFunUpdateInfo(context:context,queryParameters: {"nick_name":spProNickName},spProCallBack: SPClassHttpCallBack(
                spProOnSuccess: (result){
                  SPClassToastUtils.spFunShowToast(msg: "修改成功");
                  SPClassApplicaion.spFunGetUserInfo(context: context);
                  Navigator.of(context).pop();
                },onError: (e){},spProOnProgress: (v){}
              ));

            },
          )
        ],
      ),
      body: Container(
          decoration: BoxDecoration(
              color: Color(0xFFF1F1F1),
              border: Border(top: BorderSide(color: Color(0xFFDDDDDD),width: 0.4))
          ),
        child: Column(
           children: <Widget>[
             Container(
               alignment: Alignment.center,
               padding: EdgeInsets.only(left:  width(15)),
               height: height(48),
               decoration: BoxDecoration(
                 color: Colors.white,
                 border: Border(bottom: BorderSide(width: 1,color: Colors.grey[200]!))
               ),
               child: TextField(
                 controller: spProController,
                 decoration: InputDecoration(
                     border: InputBorder.none,
                   hintText: "请输入昵称",
                   hintStyle: TextStyle(fontSize: sp(13))
                 ),
                 onChanged: (value){

                   spProNickName=value;

                 },
               ),
             )
           ],
        ),
      ),
    );
  }


}