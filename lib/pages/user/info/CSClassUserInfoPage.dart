
import 'dart:io';

import 'package:changshengh5/api/CSClassApiManager.dart';
import 'package:changshengh5/api/CSClassHttpCallBack.dart';
import 'package:changshengh5/app/CSClassApplicaion.dart';
import 'package:changshengh5/pages/common/CSClassCropImagePage.dart';
import 'package:changshengh5/pages/dialogs/CSClassBottomLeaguePage.dart';
import 'package:changshengh5/utils/CSClassCommonMethods.dart';
import 'package:changshengh5/utils/CSClassDateUtils.dart';
import 'package:changshengh5/utils/CSClassImageUtil.dart';
import 'package:changshengh5/utils/CSClassLogUtils.dart';
import 'package:changshengh5/utils/CSClassNavigatorUtils.dart';
import 'package:changshengh5/utils/CSClassToastUtils.dart';
import 'package:changshengh5/utils/colors.dart';
import 'package:changshengh5/widgets/CSClassToolBar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_pickers/pickers.dart';

import 'CSClassChangeDatePage.dart';


class CSClassUserInfoPage extends  StatefulWidget{

  CSClassUserInfoPageState createState()=>CSClassUserInfoPageState();


}
class CSClassUserInfoPageState extends State<CSClassUserInfoPage>
{
  var csProUserSubscription;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    csProUserSubscription =CSClassApplicaion.csProEventBus.on<String>().listen((event) {
      if(event=="userInfo"){
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    csProUserSubscription.cancel();
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
                              child: csMethodIsLogin()&&CSClassApplicaion.csProUserInfo!.csProAvatarUrl!=''?   Image.network(
                                CSClassApplicaion.csProUserInfo!.csProAvatarUrl,
                                width: 46,
                                height: 46,
                              ):
                              Image.asset(
                                CSClassImageUtil.csMethodGetImagePath("ic_default_avater"),
                                width: 46,
                                height: 46,
                              ),
                            ),
                          ),
                           Image.asset(CSClassImageUtil.csMethodGetImagePath("ic_btn_right"),
                             width: width(11),
                           ),                         ],
                       ),
                     )
                   ],
                 ),
               ),
                 onTap: ()  {

                 if(CSClassApplicaion.csProUserLoginInfo!.csProExpertVerifyStatus!="1"){
                   csMethodChangeUserAvater();
                 }else{
                   CSClassToastUtils.csMethodShowToast(msg: "审核专家通过的专家不能修改头像");
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
                            Text(CSClassApplicaion.csProUserInfo!.csProNickName,style: TextStyle(fontSize:sp(14),color: Color(0xFF333333) ),),

                            CSClassApplicaion.csProUserInfo?.csProLockNickName=="1" ? Image.asset(CSClassImageUtil.csMethodGetImagePath("ic_btn_right"),
                              width: width(11),
                            ):Image.asset(CSClassImageUtil.csMethodGetImagePath("ic_btn_right"),
                              width: width(11),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                onTap: ()  {

                  if( CSClassApplicaion.csProUserInfo?.csProLockNickName=="1"){
                  }else{
                    CSClassNavigatorUtils.csMethodPushRoute(context,  CSClassChangeDatePage(CSClassApplicaion.csProUserInfo!.csProNickName,(value){}));
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
                            Text(CSClassApplicaion.csProUserInfo?.gender=="unknown"?  "未知":CSClassApplicaion.csProUserInfo!.gender=="male"? "男":"女",style: TextStyle(fontSize:sp(14),color: Color(0xFF333333) ),),

                            Image.asset(CSClassImageUtil.csMethodGetImagePath("ic_btn_right"),
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
                      return CSClassBottomLeaguePage(<String>["男","女"],"请选择性别",(index){

                        csMethodChangeUseInfo({"gender":index==0 ? "male":"female"});
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
                            Text(CSClassApplicaion.csProUserInfo!.birthday,style: TextStyle(fontSize:sp(14),color: Color(0xFF333333) ),),

                            Image.asset(CSClassImageUtil.csMethodGetImagePath("ic_btn_right"),
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
                        csMethodChangeUseInfo({"birthday":"${p.year}-${p.month!<10?'0${p.month}':p.month}-${p.day}"});
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
                            Text(CSClassApplicaion.csProUserInfo!.province+CSClassApplicaion.csProUserInfo!.city,style: TextStyle(fontSize:sp(14),color: Color(0xFF333333) ),),

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
                            Text(CSClassApplicaion.csProUserInfo!.csProPhoneNumber,style: TextStyle(fontSize:sp(14),color: Color(0xFF333333) ),),

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

  void csMethodChangeUserAvater()async {
    final ImagePicker _picker = ImagePicker();
    XFile? xImage = await _picker.pickImage(source: ImageSource.gallery);
    if(xImage==null){return;}
    File image = File(xImage.path);
    CSClassNavigatorUtils.csMethodPushRoute(context, CSClassCropImagePage(image,(result){
         List<File> results=[];
         results.add(result);
          CSClassApiManager.csMethodGetInstance().csMethodDoUpdateAvatar(context:context,csProCallBack: CSClassHttpCallBack(
             csProOnSuccess: (result){
               var csProAvatarUrl=result.data['avatar_url'];
               if(csProAvatarUrl!=null){
                 CSClassApplicaion.csProUserInfo!.csProAvatarUrl=csProAvatarUrl;
                 if(mounted){
                   setState(() {});
                 }
               }
             },onError: (e){},
             csProOnProgress: (progress){
               CSClassLogUtils.csMethodPrintLog("progress:${(progress*100).toStringAsFixed(0)} %");
             }
         ),files:results,fileName:"avatar");

    }));
  }

  void csMethodChangeUseInfo(Map<String,dynamic> params) {

    CSClassApiManager.csMethodGetInstance().csMethodUpdateInfo(context:context,queryParameters:params,csProCallBack: CSClassHttpCallBack(
        csProOnSuccess: (result){
          CSClassApplicaion.csMethodGetUserInfo(context: context);
        },onError: (e){},csProOnProgress: (v){}
    ));
  }

}