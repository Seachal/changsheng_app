
import "dart:typed_data";
import 'package:changshengh5/api/CSClassApiManager.dart';
import 'package:changshengh5/api/CSClassHttpCallBack.dart';
import 'package:changshengh5/app/CSClassApplicaion.dart';
import 'package:changshengh5/pages/common/CSClassDialogUtils.dart';
import 'package:changshengh5/utils/CSClassCommonMethods.dart';
import 'package:changshengh5/utils/CSClassImageUtil.dart';
import 'package:changshengh5/utils/CSClassLogUtils.dart';
import 'package:changshengh5/utils/CSClassToastUtils.dart';
import 'package:changshengh5/utils/colors.dart';
import 'package:changshengh5/widgets/CSClassToolBar.dart';
import "package:dio/dio.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:image_gallery_saver/image_gallery_saver.dart";
import 'package:fluwx/fluwx.dart' as fluwx;


class CSClassContactPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CSClassContactPageState();
  }

}

class  CSClassContactPageState extends State<CSClassContactPage>
{

  String  csProWxId="";
  String  csProWxQrcode="";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    csMethodGetConfCs();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: CSClassToolBar(
        context,title: "联系客服",),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        alignment: Alignment.center,
        color: Color(0xFFF1F1F1),
        child:csProWxQrcode.isEmpty? Container(): Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("${CSClassApplicaion.csProAppName}:$csProWxId",style: TextStyle(fontSize: 20,color: Colors.black),),
            SizedBox(height: 10,),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
              ),
              child:  Image.network(csProWxQrcode,
                width: MediaQuery.of(context).size.width/2,
              ),
            ),
            SizedBox(height: width(15),),
            GestureDetector(
              child:Container(
                padding: EdgeInsets.symmetric(horizontal: width(23),vertical: width(15)),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(27, 141, 224, 0.05),
                    borderRadius: BorderRadius.circular(32)
                  ),
                  child: Text("保存二维码",style: TextStyle(fontSize: sp(23),color: Theme.of(context).primaryColor),)),
              onTap: () async {
                try {
                  CSClassDialogUtils.csMethodShowLoadingDialog(context,barrierDismissible: false,content:"保存中");
                  var response = await Dio().get(csProWxQrcode, options: Options(responseType: ResponseType.bytes));
                  var result =await ImageGallerySaver.saveImage(Uint8List.fromList(response.data));
                  Navigator.of(context).pop();
                        // ImageGallerySaver.saveImage(Uint8List.fromList(response.data)).then((result){
                  //   CSClassLogUtils.csMethodPrintLog(result.toString());
                  //   Navigator.of(context).pop();
                    if(result.toString().isNotEmpty){
                      CSClassToastUtils.csMethodShowToast(msg: "保存成功");
                    }else{
                      CSClassToastUtils.csMethodShowToast(msg: "保存失败");
                    }
                  // });
                } on PlatformException {
                  Navigator.of(context).pop();
                  CSClassToastUtils.csMethodShowToast(msg: "保存失败");
                }
              },
            ),
            SizedBox(height: width(85),),
            GestureDetector(
              child:Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text("去微信添加",style: TextStyle(fontSize: sp(17),color: Theme.of(context).primaryColor),textAlign: TextAlign.justify,),
                  Image.asset(CSClassImageUtil.csMethodGetImagePath("cs_btn_right",),
                    width: width(12),
                    color: MyColors.main1,
                  ),
                ],
              ),
              onTap: () async {
                fluwx.openWeChatApp().then((value){
                  CSClassLogUtils.csMethodPrintLog(value.toString());
                });
              },
            ),
          ],
        ),


      ),

    );
  }

  void csMethodGetConfCs() {

     CSClassApiManager.csMethodGetInstance().csMethodGetConfCs(context:context,csProCallBack: CSClassHttpCallBack(
       csProOnSuccess: (result){
         csProWxId=result.data["wx_id"];
         csProWxQrcode=result.data["wx_qrcode"];
         setState(() {});
       },onError: (e){},csProOnProgress: (v){}
     ));
  }

}