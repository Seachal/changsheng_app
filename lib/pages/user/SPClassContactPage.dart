
import "dart:typed_data";
import 'package:changshengh5/api/SPClassApiManager.dart';
import 'package:changshengh5/api/SPClassHttpCallBack.dart';
import 'package:changshengh5/app/SPClassApplicaion.dart';
import 'package:changshengh5/pages/common/SPClassDialogUtils.dart';
import 'package:changshengh5/untils/SPClassCommonMethods.dart';
import 'package:changshengh5/untils/SPClassImageUtil.dart';
import 'package:changshengh5/untils/SPClassLogUtils.dart';
import 'package:changshengh5/untils/SPClassToastUtils.dart';
import 'package:changshengh5/untils/colors.dart';
import 'package:changshengh5/widgets/SPClassToolBar.dart';
import "package:dio/dio.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:image_gallery_saver/image_gallery_saver.dart";


class SPClassContactPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SPClassContactPageState();
  }

}

class  SPClassContactPageState extends State<SPClassContactPage>
{

  String  spProWxId="";
  String  spProWxQrcode="";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    spFunGetConfCs();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: SPClassToolBar(
        context,title: "联系客服",),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        alignment: Alignment.center,
        color: Color(0xFFF1F1F1),
        child:spProWxQrcode.isEmpty? Container(): Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("${SPClassApplicaion.spProAppName}:$spProWxId",style: TextStyle(fontSize: 20,color: Colors.black),),
            SizedBox(height: 10,),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
              ),
              child:  Image.network(spProWxQrcode,
                width: MediaQuery.of(context).size.width/2,
              ),
            ),
            SizedBox(height: width(15),),
            // GestureDetector(
            //   child:Container(
            //     padding: EdgeInsets.symmetric(horizontal: width(23),vertical: width(15)),
            //       decoration: BoxDecoration(
            //         color: Color.fromRGBO(27, 141, 224, 0.05),
            //         borderRadius: BorderRadius.circular(32)
            //       ),
            //       child: Text("保存二维码",style: TextStyle(fontSize: sp(23),color: Theme.of(context).primaryColor),)),
            //   onTap: () async {
            //     try {
            //       SPClassDialogUtils.spFunShowLoadingDialog(context,barrierDismissible: false,content:"保存中");
            //       var response = await Dio().get(spProWxQrcode, options: Options(responseType: ResponseType.bytes));
            //       ImageGallerySaver.saveImage(Uint8List.fromList(response.data)).then((result){
            //         SPClassLogUtils.spFunPrintLog(result.toString());
            //         Navigator.of(context).pop();
            //         if(result.toString().isNotEmpty){
            //           SPClassToastUtils.spFunShowToast(msg: "保存成功");
            //         }else{
            //           SPClassToastUtils.spFunShowToast(msg: "保存失败");
            //         }
            //       });
            //     } on PlatformException {
            //       Navigator.of(context).pop();
            //       SPClassToastUtils.spFunShowToast(msg: "保存失败");
            //     }
            //   },
            // ),
            // SizedBox(height: width(85),),
            // GestureDetector(
            //   child:Row(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     crossAxisAlignment: CrossAxisAlignment.center,
            //     children: <Widget>[
            //       Text("去微信添加",style: TextStyle(fontSize: sp(17),color: Theme.of(context).primaryColor),textAlign: TextAlign.justify,),
            //       Image.asset(SPClassImageUtil.spFunGetImagePath("ic_btn_right",),
            //         width: width(12),
            //         color: MyColors.main1,
            //       ),
            //     ],
            //   ),
            //   onTap: () async {
            //     // fluwx.openWeChatApp().then((value){
            //     //   SPClassLogUtils.spFunPrintLog(value.toString());
            //     // });
            //   },
            // ),
          ],
        ),


      ),

    );
  }

  void spFunGetConfCs() {

     SPClassApiManager.spFunGetInstance().spFunGetConfCs(context:context,spProCallBack: SPClassHttpCallBack(
       spProOnSuccess: (result){
         spProWxId=result.data["wx_id"];
         spProWxQrcode=result.data["wx_qrcode"];
         setState(() {});
       },onError: (e){},spProOnProgress: (v){}
     ));
  }

}