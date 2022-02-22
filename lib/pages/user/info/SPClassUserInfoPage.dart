
import 'dart:io';

import 'package:changshengh5/api/SPClassApiManager.dart';
import 'package:changshengh5/api/SPClassHttpCallBack.dart';
import 'package:changshengh5/app/SPClassApplicaion.dart';
import 'package:changshengh5/pages/common/SPClassCropImagePage.dart';
import 'package:changshengh5/pages/dialogs/SPClassBottomLeaguePage.dart';
import 'package:changshengh5/untils/SPClassCommonMethods.dart';
import 'package:changshengh5/untils/SPClassDateUtils.dart';
import 'package:changshengh5/untils/SPClassImageUtil.dart';
import 'package:changshengh5/untils/SPClassLogUtils.dart';
import 'package:changshengh5/untils/SPClassNavigatorUtils.dart';
import 'package:changshengh5/untils/SPClassToastUtils.dart';
import 'package:changshengh5/untils/colors.dart';
import 'package:changshengh5/widgets/SPClassToolBar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_pickers/pickers.dart';

import 'SPClassChangeDatePage.dart';


class SPClassUserInfoPage extends  StatefulWidget{

  SPClassUserInfoPageState createState()=>SPClassUserInfoPageState();


}
class SPClassUserInfoPageState extends State<SPClassUserInfoPage>
{
  var spProUserSubscription;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    spProUserSubscription =SPClassApplicaion.spProEventBus.on<String>().listen((event) {
      if(event=="userInfo"){
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    spProUserSubscription.cancel();
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
      ),
      body: Container(
        decoration: BoxDecoration(
            color: Color(0xFFF1F1F1),
            border: Border(top: BorderSide(color: Color(0xFFDDDDDD),width: 0.4))
        ),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              GestureDetector(
               behavior:HitTestBehavior.opaque ,
               child:Container(
                 padding: EdgeInsets.only(right: width(20),left:width(24)),
                 height: height(67),
                 decoration: BoxDecoration(
                     color: Colors.white,
                     border: Border(bottom: BorderSide(width: 0.4,color: Colors.grey[300]!))),
                 child:  Row(
                   children: <Widget>[
                     Text("头像",style: TextStyle(fontSize:sp(14),color: Colors.black ),),
                     Flexible(
                       flex: 1,
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.end,
                         children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.white, width: 2),
                                borderRadius: BorderRadius.circular(32.0)),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: spFunIsLogin()&&SPClassApplicaion.spProUserInfo!.spProAvatarUrl!=''?   Image.network(
                                SPClassApplicaion.spProUserInfo!.spProAvatarUrl,
                                width: 46,
                                height: 46,
                              ):
                              Image.asset(
                                SPClassImageUtil.spFunGetImagePath("ic_default_avater"),
                                width: 46,
                                height: 46,
                              ),
                            ),
                          ),
                           Image.asset(SPClassImageUtil.spFunGetImagePath("ic_btn_right"),
                             width: width(11),
                           ),                         ],
                       ),
                     )
                   ],
                 ),
               ),
                 onTap: ()  {

                 if(SPClassApplicaion.spProUserLoginInfo!.spProExpertVerifyStatus!="1"){
                   spFunChangeUserAvater();
                 }else{
                   SPClassToastUtils.spFunShowToast(msg: "审核专家通过的专家不能修改头像");
                 }
                 },
             ),
              GestureDetector(
                behavior:HitTestBehavior.opaque ,
                child:Container(
                  padding: EdgeInsets.only(right: width(20),left:width(24)),
                  height: height(48),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(bottom: BorderSide(width: 0.4,color: Colors.grey[300]!))),
                  child:  Row(
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("昵称",style: TextStyle(fontSize:sp(14),color: Colors.black ),),
                          Text("昵称只能修改一次",style: TextStyle(fontSize:sp(9),color: Colors.red ),),
                        ],
                      ),
                      Flexible(
                        flex: 1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Text(SPClassApplicaion.spProUserInfo!.spProNickName,style: TextStyle(fontSize:sp(14),color: Color(0xFF333333) ),),

                            SPClassApplicaion.spProUserInfo?.spProLockNickName=="1" ? Image.asset(SPClassImageUtil.spFunGetImagePath("ic_btn_right"),
                              width: width(11),
                            ):Image.asset(SPClassImageUtil.spFunGetImagePath("ic_btn_right"),
                              width: width(11),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                onTap: ()  {

                  if( SPClassApplicaion.spProUserInfo?.spProLockNickName=="1"){
                  }else{
                    SPClassNavigatorUtils.spFunPushRoute(context,  SPClassChangeDatePage(SPClassApplicaion.spProUserInfo!.spProNickName,(value){}));
                  }
                },
              ),
              GestureDetector(
                behavior:HitTestBehavior.opaque ,
                child:Container(
                  padding: EdgeInsets.only(right: width(20),left:width(24)),
                  height: height(48),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(bottom: BorderSide(width: 0.4,color: Colors.grey[300]!))),
                  child:  Row(
                    children: <Widget>[
                      Text("性别",style: TextStyle(fontSize:sp(14),color: Colors.black ),),
                      Flexible(
                        flex: 1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Text(SPClassApplicaion.spProUserInfo?.gender=="unknown"?  "未知":SPClassApplicaion.spProUserInfo!.gender=="male"? "男":"女",style: TextStyle(fontSize:sp(14),color: Color(0xFF333333) ),),

                            Image.asset(SPClassImageUtil.spFunGetImagePath("ic_btn_right"),
                              width: width(11),
                            ),                          ],
                        ),
                      )
                    ],
                  ),
                ),
                onTap: ()  {
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return SPClassBottomLeaguePage(<String>["男","女"],"请选择性别",(index){

                        spFunChangeUseInfo({"gender":index==0 ? "male":"female"});
                      },initialIndex: 0,);
                    },
                  );
                },
              ),
              GestureDetector(
                behavior:HitTestBehavior.opaque ,
                child:Container(
                  padding: EdgeInsets.only(right: width(20),left:width(24)),
                  height: height(48),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(bottom: BorderSide(width: 0.4,color: Colors.grey[300]!))),
                  child:  Row(
                    children: <Widget>[
                      Text("生日",style: TextStyle(fontSize:sp(14),color: Colors.black ),),
                      Flexible(
                        flex: 1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Text(SPClassApplicaion.spProUserInfo!.birthday,style: TextStyle(fontSize:sp(14),color: Color(0xFF333333) ),),

                            Image.asset(SPClassImageUtil.spFunGetImagePath("ic_btn_right"),
                              width: width(11),
                            ),                          ],
                        ),
                      )
                    ],
                  ),
                ),
                onTap: ()  {
                  Pickers.showDatePicker(
                    context,
                    onConfirm: (p) {
                        spFunChangeUseInfo({"birthday":"${p.year}-${p.month!<10?'0${p.month}':p.month}-${p.day}"});
                    },
                  );

                },
              ),
              GestureDetector(
                behavior:HitTestBehavior.opaque ,
                child:Container(
                  padding: EdgeInsets.only(right: width(20),left:width(24)),
                  height: height(48),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(bottom: BorderSide(width: 0.4,color: Colors.grey[300]!))),
                  child:  Row(
                    children: <Widget>[
                      Text("地区",style: TextStyle(fontSize:sp(14),color: Colors.black ),),
                      Flexible(
                        flex: 1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Text(SPClassApplicaion.spProUserInfo!.province+SPClassApplicaion.spProUserInfo!.city,style: TextStyle(fontSize:sp(14),color: Color(0xFF333333) ),),

                          ],
                        ),
                      )
                    ],
                  ),
                ),
                onTap: ()  {


                },
              ),
              GestureDetector(
                behavior:HitTestBehavior.opaque ,
                child:Container(
                  padding: EdgeInsets.only(right: width(20),left:width(24)),
                  height: height(48),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(bottom: BorderSide(width: 0.4,color: Colors.grey[300]!))),
                  child:  Row(
                    children: <Widget>[
                      Text("电话号码",style: TextStyle(fontSize:sp(14),color: Colors.black ),),
                      Flexible(
                        flex: 1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Text(SPClassApplicaion.spProUserInfo!.spProPhoneNumber,style: TextStyle(fontSize:sp(14),color: Color(0xFF333333) ),),

                          ],
                        ),
                      )
                    ],
                  ),
                ),
                onTap: ()  {
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void spFunChangeUserAvater()async {
    final ImagePicker _picker = ImagePicker();
    XFile? xImage = await _picker.pickImage(source: ImageSource.gallery);
    if(xImage==null){return;}
    File image = File(xImage.path);
    SPClassNavigatorUtils.spFunPushRoute(context, SPClassCropImagePage(image,(result){
         List<File> results=[];
         results.add(result);
          SPClassApiManager.spFunGetInstance().spFunDoUpdateAvatar(context:context,spProCallBack: SPClassHttpCallBack(
             spProOnSuccess: (result){
               var spProAvatarUrl=result.data['avatar_url'];
               if(spProAvatarUrl!=null){
                 SPClassApplicaion.spProUserInfo!.spProAvatarUrl=spProAvatarUrl;
                 if(mounted){
                   setState(() {});
                 }
               }
             },onError: (e){},
             spProOnProgress: (progress){
               SPClassLogUtils.spFunPrintLog("progress:${(progress*100).toStringAsFixed(0)} %");
             }
         ),files:results,fileName:"avatar");

    }));
  }

  void spFunChangeUseInfo(Map<String,dynamic> params) {

    SPClassApiManager.spFunGetInstance().spFunUpdateInfo(context:context,queryParameters:params,spProCallBack: SPClassHttpCallBack(
        spProOnSuccess: (result){
          SPClassApplicaion.spFunGetUserInfo(context: context);
        },onError: (e){},spProOnProgress: (v){}
    ));
  }

}