
import 'package:changshengh5/api/CSClassApiManager.dart';
import 'package:changshengh5/api/CSClassHttpCallBack.dart';
import 'package:changshengh5/app/CSClassApplicaion.dart';
import 'package:changshengh5/utils/CSClassCommonMethods.dart';
import 'package:changshengh5/utils/CSClassToastUtils.dart';
import 'package:changshengh5/utils/colors.dart';
import 'package:changshengh5/widgets/CSClassToolBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



typedef StringCallback =  Function(String value);
class CSClassChangeDatePage extends StatefulWidget{
  StringCallback callback;
  String csProValueOrg;
  CSClassChangeDatePage(this.csProValueOrg,this.callback,);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CSClassChangeDatePageState();
  }

}


class CSClassChangeDatePageState extends State<CSClassChangeDatePage>{
  String ?csProNickName;

  TextEditingController ?csProController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    csProController=TextEditingController(text: widget.csProValueOrg);
    csProNickName=widget.csProValueOrg.toString();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
      appBar: CSClassToolBar(
        context,
        title:"个人资料",
        csProBgColor: MyColors.main1,
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

              if(csProNickName!.isEmpty){
                CSClassToastUtils.csMethodShowToast(msg: "请输入昵称");
              }
              CSClassApiManager.csMethodGetInstance().csMethodUpdateInfo(context:context,queryParameters: {"nick_name":csProNickName},csProCallBack: CSClassHttpCallBack(
                csProOnSuccess: (result){
                  CSClassToastUtils.csMethodShowToast(msg: "修改成功");
                  CSClassApplicaion.csMethodGetUserInfo(context: context);
                  Navigator.of(context).pop();
                },onError: (e){},csProOnProgress: (v){}
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
                 controller: csProController,
                 decoration: InputDecoration(
                     border: InputBorder.none,
                   hintText: "请输入昵称",
                   hintStyle: TextStyle(fontSize: sp(13))
                 ),
                 onChanged: (value){

                   csProNickName=value;

                 },
               ),
             )
           ],
        ),
      ),
    );
  }


}