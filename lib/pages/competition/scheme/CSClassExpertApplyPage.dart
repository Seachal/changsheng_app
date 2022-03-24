
import 'dart:async';
import 'dart:io';
import 'package:changshengh5/api/CSClassApiManager.dart';
import 'package:changshengh5/api/CSClassHttpCallBack.dart';
import 'package:changshengh5/app/CSClassApplicaion.dart';
import 'package:changshengh5/model/CSClassBaseModelEntity.dart';
import 'package:changshengh5/utils/CSClassCommonMethods.dart';
import 'package:changshengh5/utils/CSClassImageUtil.dart';
import 'package:changshengh5/utils/CSClassToastUtils.dart';
import 'package:changshengh5/utils/colors.dart';
import 'package:changshengh5/widgets/CSClassToolBar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class CSClassExpertApplyPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CSClassExpertApplyPageState();
  }

}

class CSClassExpertApplyPageState  extends State<CSClassExpertApplyPage>{
  bool csProCloseTitle=false;
  int csProCurrentSecond=0;
  String csProPhoneNumber="";
  String QQNumber="";
  String csProRealName="";
  String csProNickName="";
  String csProIdNumber="";
  String csProPhoneCode="";
  File ?csProFrontFile;
  File ?csProBackFile;
  String csProIdFrontUrl="";
  String csProIdBackUrl="";
  String csProApplyReason="";
  var csProTimer;

  var csProExpertType="足球";
  List typeList =['足球','篮球'];
  TextEditingController ?csProNickTextEditingController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    csProNickTextEditingController=TextEditingController(text: CSClassApplicaion.csProUserInfo!.csProNickName);
    csProNickName=csProNickTextEditingController!.text;
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar:CSClassToolBar(context,
      title: "申请专家",
      csProBgColor: MyColors.main1,
        iconColor: 0xffffffff,
      ),
      body:Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[

              AnimatedContainer(
                duration: Duration(milliseconds: 500),
                child: Container(
                  color: Color.fromRGBO(255, 106, 77, 0.1),
                  height: !csProCloseTitle ?height(33):0,
                  child: Row(
                    children: <Widget>[
                    SizedBox(width:width(15) ,),
                    Text("为了更好的为您服务，请务必填写真实信息",style: TextStyle(fontSize:  sp(13),color: Color(0xFFEB3E1C),)),
                      csProCloseTitle ? Container(): Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          GestureDetector(
                            child: Icon(Icons.close,color: Color(0xFFCCCCCC),size: width(20),),
                            onTap: (){
                              if(mounted){
                                setState(() {csProCloseTitle=true;});
                              }
                            },
                          ),

                        ],
                      ),
                    ),
                      SizedBox(width:width(10) ,),

                    ],
                  ),
                ),
              ),
              /// 专家类型
              Container(
                margin: EdgeInsets.only(left: width(20),right:width(20),top: width(17)),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Image.asset(
                          CSClassImageUtil.csMethodGetImagePath("cs_edit_content"),
                          fit: BoxFit.contain,
                          width: width(18),
                        ),
                        SizedBox(width: width(5),),
                        Text("专家类型",style: TextStyle(fontSize:  sp(13),color: Color(0xFF333333)),),
                        SizedBox(width: width(5),),
                        Text("*",style: TextStyle(fontSize:  sp(14),color: MyColors.main2),)
                      ],
                    ),
                    SizedBox(height: width(10),),
                    Row(
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: GestureDetector(
                            onTap: (){
                              csProExpertType='足球';
                              setState(() {
                              });
                            },
                            child: Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.symmetric(vertical: width(8)),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(width(16)),
                                  color: csProExpertType=='足球'?MyColors.main1:Color(0xFFF5F6F7)
                              ),
                              child: Text('足球',style: TextStyle(fontSize: sp(13),color: csProExpertType=='足球'? Colors.white:MyColors.grey_99),),
                            ),
                          ),
                        ),
                        SizedBox(width: width(13),),
                        Expanded(
                          flex: 1,
                          child: GestureDetector(
                            onTap: (){
                              csProExpertType='篮球';
                              setState(() {
                              });
                            },
                            child: Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.symmetric(vertical: width(8)),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(width(16)),
                                  color: csProExpertType=='篮球'?MyColors.main1:Color(0xFFF5F6F7)
                              ),
                              child: Text('篮球',style: TextStyle(fontSize: sp(13),color: csProExpertType=='篮球'? Colors.white:MyColors.grey_99),),
                            ),
                          ),
                        ),
                      ],
                    )
                    // GestureDetector(
                    //   child: Container(
                    //     padding: EdgeInsets.symmetric(vertical: 10),
                    //     child: Row(
                    //       children: <Widget>[
                    //         SizedBox(width: width(22)),
                    //         Expanded(
                    //           child: Row(
                    //             mainAxisAlignment: MainAxisAlignment.start,
                    //             children: <Widget>[
                    //               Text(csProExpertType,style: TextStyle(fontSize:  sp(12),color: Color(0xFF333333)),)
                    //             ],
                    //           ),
                    //         ),
                    //         Image.asset(CSClassImageUtil.csMethodGetImagePath("cs_btn_right"),
                    //           width: width(11),
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    //   onTap: (){
                    //     showModalBottomSheet(
                    //       context: context,
                    //       builder: (BuildContext context) {
                    //         return CSClassBottomLeaguePage(<String>["足球","篮球","电竞"],"请选择专家",(index){
                    //           setState(() {
                    //             csProExpertType=["足球","篮球","电竞"][index];
                    //           });
                    //         },initialIndex:["足球","篮球","电竞"].indexOf(csProExpertType),);
                    //       },
                    //     );
                    //   },
                    // )

                  ],
                ),
              ),
              /// 实名认证
              Container(
                margin: EdgeInsets.only(left: width(20),right:width(20),top: width(25)),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Image.asset(
                          CSClassImageUtil.csMethodGetImagePath("cs_login_account"),
                          fit: BoxFit.contain,
                          width: width(18),
                        ),
                        SizedBox(width: width(5),),
                        Text("实名认证",style: TextStyle(fontSize:  sp(13),color: Color(0xFF333333)),),
                        SizedBox(width: width(5),),
                        Text("*",style: TextStyle(fontSize:  sp(12),color:  MyColors.main2),)
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: width(15),),
                            margin: EdgeInsets.symmetric(vertical: width(8)),
                            decoration: BoxDecoration(
                              color: Color(0xFFF5F6F7),
                              borderRadius: BorderRadius.circular(150)
                            ),
                            child: TextField(
                              maxLines: 1,
                              style: TextStyle(fontSize:  sp(12),color: Color(0xFF333333)),
                              decoration: InputDecoration(
                                hintText: "请填写真实姓名，用于结算与认证",
                                hintStyle: TextStyle(fontSize:  sp(12),color: Color(0xFFC6C6C6)),
                                border: InputBorder.none,
                              ),
                              onChanged: (value){
                                csProRealName=value;
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: width(15),),
                            decoration: BoxDecoration(
                                color: Color(0xFFF5F6F7),
                                borderRadius: BorderRadius.circular(150)
                            ),
                            child: TextField(
                              maxLines: 1,
                              style: TextStyle(fontSize:  sp(12),color: Color(0xFF333333)),
                              decoration: InputDecoration(
                                hintText: "请填写真实身份证号，用于结算与认证",
                                hintStyle: TextStyle(fontSize:  sp(12),color: Color(0xFFC6C6C6)),
                                border: InputBorder.none,
                              ),
                              onChanged: (value){
                                csProIdNumber=value;
                              },
                            ),
                          )
                        )
                      ],
                    ),
                  ],
                ),
              ),
              /// 昵称
              // Container(
              //   decoration: BoxDecoration(
              //       border: Border(bottom: BorderSide(width: 0.4,color: Colors.grey[300]))
              //   ),
              //   margin: EdgeInsets.only(left: width(20),right:width(20),top: height(10)),
              //   child: Column(
              //     children: <Widget>[
              //       Row(
              //         children: <Widget>[
              //           Image.asset(
              //             CSClassImageUtil.csMethodGetImagePath("cs_login_account"),
              //             fit: BoxFit.contain,
              //             width: width(18),
              //           ),
              //           SizedBox(width: width(5),),
              //           Text("昵称",style: TextStyle(fontSize:  sp(13),color: Color(0xFF333333)),),
              //           SizedBox(width: width(5),),
              //           Text("*必填",style: TextStyle(fontSize:  sp(12),color: Color(0xFFFBA311)),)
              //         ],
              //       ),
              //       Row(
              //         children: <Widget>[
              //           SizedBox(width: width(22)),
              //           Expanded(
              //             flex: 1,
              //             child: TextField(
              //               maxLines: 1,
              //               controller: csProNickTextEditingController,
              //               style: TextStyle(fontSize:  sp(13),color: Color(0xFF333333)),
              //               decoration: InputDecoration(
              //                 hintText: "请填写昵称",
              //                 hintStyle: TextStyle(fontSize:  sp(13),color: Color(0xFFC6C6C6)),
              //                 border: InputBorder.none,
              //               ),
              //               onChanged: (value){
              //                 csProNickName=value;
              //               },
              //             ),
              //           )
              //         ],
              //       )
              //     ],
              //   ),
              // ),

              /// 身份证号
              // Container(
              //   decoration: BoxDecoration(
              //       border: Border(bottom: BorderSide(width: 0.4,color: Colors.grey[300]))
              //   ),
              //   margin: EdgeInsets.only(left: width(20),right:width(20),top: height(10)),
              //   child: Column(
              //     children: <Widget>[
              //       Row(
              //         children: <Widget>[
              //           Image.asset(
              //             CSClassImageUtil.csMethodGetImagePath("cs_user_id_num"),
              //             fit: BoxFit.contain,
              //             width: width(18),
              //           ),
              //           SizedBox(width: width(5),),
              //           Text("身份证号",style: TextStyle(fontSize:  sp(13),color: Color(0xFF333333)),),
              //           SizedBox(width: width(5),),
              //           Text("*必填",style: TextStyle(fontSize:  sp(12),color: Color(0xFFFBA311)),)
              //         ],
              //       ),
              //       Row(
              //         children: <Widget>[
              //           SizedBox(width: width(22)),
              //           Expanded(
              //             flex: 1,
              //             child: TextField(
              //               maxLines: 1,
              //               style: TextStyle(fontSize:  sp(13),color: Color(0xFF333333)),
              //               decoration: InputDecoration(
              //                 hintText: "请填写真实身份证号，用于结算与认证",
              //                 hintStyle: TextStyle(fontSize:  sp(13),color: Color(0xFFC6C6C6)),
              //                 border: InputBorder.none,
              //               ),
              //               onChanged: (value){
              //                 csProIdNumber=value;
              //               },
              //             ),
              //           )
              //         ],
              //       )
              //     ],
              //   ),
              // ),

              /// 上传身份证
              Container(
                margin: EdgeInsets.only(left: width(20),right:width(20),top: width(25)),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Image.asset(
                          CSClassImageUtil.csMethodGetImagePath("cs_user_id_num"),
                          fit: BoxFit.contain,
                          width: width(18),
                        ),
                        SizedBox(width: width(5),),
                        Text("比赛分析",style: TextStyle(fontSize:  sp(13),color: Color(0xFF333333)),),
                        Text("(截图在其他平台的分析)",style: TextStyle(fontSize:  sp(12),color: MyColors.grey_99),),
                        SizedBox(width: width(5),),
                        Text("*",style: TextStyle(fontSize:  sp(12),color: MyColors.main2),)
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        SizedBox(width: width(22)),
                        Expanded(
                          flex: 1,
                          child: Row(
                            children: <Widget>[
                              GestureDetector(
                                child:  Container(
                                  margin: EdgeInsets.only(top: height(10),right: width(10),bottom:width(10) ),
                                  width: width(107),
                                  height: height(67),
                                  decoration: BoxDecoration(
                                      color: Color(0xFFF5F5F5),
                                      border: Border.all(width: 0.4,color: Colors.grey[300]!)
                                  ),
                                  alignment: Alignment.center,
                                  child: csProFrontFile==null?Image.asset(
                                    CSClassImageUtil.csMethodGetImagePath("cs_add_pic"),
                                    fit: BoxFit.contain,
                                    width: width(18),
                                  ):Image.file(
                                    csProFrontFile!,
                                    width: width(107),
                                    height: height(67),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                onTap: () async {
                                  final ImagePicker _picker = ImagePicker();
                                  XFile? xImage = await _picker.pickImage(source: ImageSource.gallery);
                                  if(xImage==null){return;}
                                  File image  =File(xImage.path);
                                  if(mounted){
                                    setState(() {
                                      csProIdFrontUrl="";
                                      csProFrontFile=image;
                                    });
                                  }

                                },
                              ),
                              GestureDetector(
                                child:  Container(
                                  margin: EdgeInsets.only(top: height(10),right: width(10),bottom:width(10) ),
                                  width: width(107),
                                  height: height(67),
                                  decoration: BoxDecoration(
                                      color: Color(0xFFF5F5F5),
                                      border: Border.all(width: 0.4,color: Colors.grey[300]!)
                                  ),
                                  alignment: Alignment.center,
                                  child: csProBackFile==null?Image.asset(
                                    CSClassImageUtil.csMethodGetImagePath("cs_add_pic"),
                                    fit: BoxFit.contain,
                                    width: width(18),
                                  ):Image.file(
                                    csProBackFile!,
                                    width: width(107),
                                    height: height(67),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                onTap: () async {
                                  final ImagePicker _picker = ImagePicker();
                                  XFile? xImage = await _picker.pickImage(source: ImageSource.gallery);
                                  if(xImage==null){return;}
                                  if(mounted){
                                    File image  =File(xImage.path);
                                    setState(() {
                                      csProIdBackUrl="";
                                      csProBackFile=image;
                                    });
                                  }

                                },
                              ),

                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),

              /// 申请理由
        //       Container(
        //           decoration: BoxDecoration(
        //       border: Border(bottom: BorderSide(width: 0.4,color: Colors.grey[300]))
        //   ),
        //         margin: EdgeInsets.only(left: width(20),right:width(20),top: height(10)),
        //         child: Column(
        //     children: <Widget>[
        //       Row(
        //         children: <Widget>[
        //           Image.asset(
        //             CSClassImageUtil.csMethodGetImagePath("cs_edit_content"),
        //             fit: BoxFit.contain,
        //             width: width(18),
        //           ),
        //           SizedBox(width: width(5),),
        //           Text("申请理由",style: TextStyle(fontSize:  sp(13),color: Color(0xFF333333)),),
        //           SizedBox(width: width(5),),
        //           Text("*必填",style: TextStyle(fontSize:  sp(12),color: Color(0xFFFBA311)),)
        //         ],
        //       ),
        //       Row(
        //         children: <Widget>[
        //           SizedBox(width: width(22)),
        //           Expanded(
        //             flex: 1,
        //             child: TextField(
        //               maxLines: 5,
        //               style: TextStyle(fontSize:  sp(13),color: Color(0xFF333333)),
        //               decoration: InputDecoration(
        //                 hintText: "请填写您成为专家的理由吧",
        //                 hintStyle: TextStyle(fontSize:  sp(13),color: Color(0xFFC6C6C6)),
        //                 border: InputBorder.none,
        //               ),
        //               onChanged: (value){
        //                 csProApplyReason=value;
        //               },
        //             ),
        //           )
        //         ],
        //       )
        //     ],
        //   ),
        // ),

              ///QQ号码
              // Container(
              //   decoration: BoxDecoration(
              //       border: Border(bottom: BorderSide(width: 0.4,color: Colors.grey[300]))
              //   ),
              //   margin: EdgeInsets.only(left: width(20),right:width(20),top: height(10)),
              //   child: Column(
              //     children: <Widget>[
              //       Row(
              //         children: <Widget>[
              //           Image.asset(
              //             CSClassImageUtil.csMethodGetImagePath("cs_login_account"),
              //             fit: BoxFit.contain,
              //             width: width(18),
              //           ),
              //           SizedBox(width: width(5),),
              //           Text("QQ号码",style: TextStyle(fontSize:  sp(13),color: Color(0xFF333333)),),
              //           SizedBox(width: width(5),),
              //           Text("*必填",style: TextStyle(fontSize:  sp(12),color: Color(0xFFFBA311)),)
              //         ],
              //       ),
              //       Row(
              //         children: <Widget>[
              //           SizedBox(width: width(22)),
              //           Expanded(
              //             flex: 1,
              //             child: TextField(
              //               maxLines: 1,
              //               style: TextStyle(fontSize:  sp(13),color: Color(0xFF333333)),
              //               decoration: InputDecoration(
              //                 hintText: "请填写QQ号码",
              //                 hintStyle: TextStyle(fontSize:  sp(13),color: Color(0xFFC6C6C6)),
              //                 border: InputBorder.none,
              //               ),
              //               onChanged: (value){
              //                 if(mounted){
              //                   setState(() {
              //                     QQNumber=value;
              //                   });
              //                 }
              //               },
              //             ),
              //           )
              //         ],
              //       )
              //     ],
              //   ),
              // ),
              ///手机号码
              Container(
                margin: EdgeInsets.only(left: width(20),right:width(20),top: height(10)),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Image.asset(
                          CSClassImageUtil.csMethodGetImagePath("cs_login_account"),

                          fit: BoxFit.contain,
                          width: width(18),
                        ),
                        SizedBox(width: width(5),),
                        Text("手机验证",style: TextStyle(fontSize:  sp(13),color: Color(0xFF333333)),),
                        SizedBox(width: width(5),),
                        Text("*",style: TextStyle(fontSize:  sp(12),color: MyColors.main2),)
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: width(15),),
                            margin: EdgeInsets.symmetric(vertical: width(8)),
                            decoration: BoxDecoration(
                                color: Color(0xFFF5F6F7),
                                borderRadius: BorderRadius.circular(150)
                            ),
                            child: TextField(
                              maxLines: 1,
                              style: TextStyle(fontSize:  sp(13),color: Color(0xFF333333)),
                              decoration: InputDecoration(
                                hintText: "请填写手机号码",
                                hintStyle: TextStyle(fontSize:  sp(13),color: Color(0xFFC6C6C6)),
                                border: InputBorder.none,
                              ),
                              onChanged: (value){
                                if(mounted){
                                  setState(() {
                                    csProPhoneNumber=value;
                                  });
                                }
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: width(15),),
                            margin: EdgeInsets.only(right: width(89)),
                            decoration: BoxDecoration(
                                color: Color(0xFFF5F6F7),
                                borderRadius: BorderRadius.circular(150)
                            ),
                            child: TextField(
                              maxLines: 1,
                              style: TextStyle(fontSize:  sp(12),color: Color(0xFF333333)),
                              decoration: InputDecoration(
                                hintText: "输入验证码",
                                hintStyle: TextStyle(fontSize:  sp(12),color: Color(0xFFC6C6C6)),
                                border: InputBorder.none,
                              ),
                              onChanged: (value){
                                csProPhoneCode=value;
                              },
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            if(csProPhoneNumber.length != 11 || csProCurrentSecond > 0){
                              return;
                            }
                            csMethodDoSendCode();
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: width(9),vertical: width(10)),
                            decoration: BoxDecoration(
                              border: Border.all(color: Color(0xFFE6E6E6),width: 1),
                              borderRadius: BorderRadius.circular(150),
                            ),
                            child: Text(csProCurrentSecond > 0
                                ? "已发送" + csProCurrentSecond.toString() + "s"
                                : "获取验证码",style: TextStyle(fontSize: sp(12),color: MyColors.grey_99),),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              ///验证码
              // Container(
              //   margin: EdgeInsets.only(left: width(20),right:width(20),top: height(10)),
              //   child: Column(
              //     children: <Widget>[
              //       Row(
              //         children: <Widget>[
              //           Image.asset(
              //             CSClassImageUtil.csMethodGetImagePath("cs_login_account"),
              //             fit: BoxFit.contain,
              //             width: width(18),
              //           ),
              //           SizedBox(width: width(5),),
              //           Text("验证码",style: TextStyle(fontSize:  sp(13),color: Color(0xFF333333)),),
              //           SizedBox(width: width(5),),
              //           Text("*必填",style: TextStyle(fontSize:  sp(12),color: Color(0xFFFBA311)),)
              //         ],
              //       ),
              //       Row(
              //         children: <Widget>[
              //           SizedBox(width: width(22)),
              //           Expanded(
              //             flex: 1,
              //             child: Row(
              //               children: <Widget>[
              //                 Flexible(
              //                   flex: 1,
              //                   fit: FlexFit.tight,
              //                   child: TextField(
              //                     maxLines: 1,
              //                     style: TextStyle(fontSize:  sp(13),color: Color(0xFF333333)),
              //                     decoration: InputDecoration(
              //                       hintText: "请填写手机验证码",
              //                       hintStyle: TextStyle(fontSize:  sp(13),color: Color(0xFFC6C6C6)),
              //                       border: InputBorder.none,
              //                     ),
              //                     onChanged: (value){
              //                           csProPhoneCode=value;
              //                     },
              //                   ),
              //                 ),
              //                 OutlineButton(
              //                   padding: EdgeInsets.zero,
              //                   child: Text(csProCurrentSecond > 0
              //                       ? "已发送" + csProCurrentSecond.toString() + "s"
              //                       : "获取验证码",style: TextStyle(fontSize: sp(11)),),
              //                   borderSide: BorderSide(
              //                       color: Theme.of(context).primaryColor, width: 1),
              //                   textColor: Theme.of(context).primaryColor,
              //                   disabledBorderColor: Colors.grey[300],
              //                   onPressed: (csProPhoneNumber.length != 11 || csProCurrentSecond > 0)
              //                       ? null
              //                       : () {
              //                     csMethodDoSendCode();
              //                   },
              //                 )
              //               ],
              //             ),
              //           )
              //         ],
              //       )
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
        bottomNavigationBar: Container(
          height: width(61),
          child:GestureDetector(
            child:  Container(
              color: MyColors.main1,
              alignment: Alignment.center,
              child:Container(
                alignment: Alignment.center,
                height: width(61),
                child:Text("提交认证",style: TextStyle(fontSize: sp(19),color: Colors.white,fontWeight: FontWeight.w500),),
              ) ,
            ),
            onTap: () async {
              csMethodCommit();

            },
          ),
        )
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    if(csProTimer!=null){
      csProTimer.cancel();
    }

  }
  void csMethodDoSendCode() {


    CSClassApiManager.csMethodGetInstance().csMethodSendCode(csProPhoneNumber: csProPhoneNumber,context: context,csProCodeType: "apply_expert",csProCallBack: CSClassHttpCallBack(
      csProOnSuccess: (value){
      CSClassToastUtils.csMethodShowToast(msg: "发送成功");
      setState(() {csProCurrentSecond = 60;});
       csProTimer=   Timer.periodic(Duration(seconds: 1), (second) {
        setState(() {
          if (csProCurrentSecond > 0) {
            setState(() {
              csProCurrentSecond = csProCurrentSecond-1;
            });
          } else {
            second.cancel();
          }
        });
      });
      },onError: (e){},csProOnProgress: (v){}
    ));

  }

  void csMethodCommit() {

    if(csProRealName.isEmpty){
      CSClassToastUtils.csMethodShowToast(msg: "请填写真实姓名");
      return;
    }
    // if(csProNickName.isEmpty){
    //   CSClassToastUtils.csMethodShowToast(msg: "请填写真实姓名");
    //   return;
    // }
    if(csProIdNumber.isEmpty){
      CSClassToastUtils.csMethodShowToast(msg: "请填写身份证号码");
      return;
    }
    if(csProBackFile==null||csProFrontFile==null){
      CSClassToastUtils.csMethodShowToast(msg: "请上传比赛分析");
      return;
    }
    // if(csProApplyReason.isEmpty){
    //   CSClassToastUtils.csMethodShowToast(msg: "请填写申请理由");
    //   return;
    // }
    // if(QQNumber.isEmpty){
    //   CSClassToastUtils.csMethodShowToast(msg: "请填写QQ号码");
    //   return;
    // }
    if(csProPhoneNumber.isEmpty){
      CSClassToastUtils.csMethodShowToast(msg: "请填写手机号码");
      return;
    }
    if(csProPhoneCode.isEmpty){
      CSClassToastUtils.csMethodShowToast(msg: "请填写验证码");
      return;
    }

    if(csProIdFrontUrl.isEmpty){
      CSClassApiManager.csMethodGetInstance().csMethodUploadFiles(context:context,files:[csProFrontFile!,csProBackFile!],params: {"is_multi":"1","is_private":"1"},
          csProCallBack: CSClassHttpCallBack<CSClassBaseModelEntity>(
        csProOnSuccess: (result){
          var images=[];
          result.data.forEach((pic){
            images.add(pic);
          });
          csProIdFrontUrl=images[0];
          csProIdBackUrl=images[1];
          csMethodCommitInfo();
        },onError: (e){},csProOnProgress: (v){}
      )  );
    }else{
      csMethodCommitInfo();
    }

  }

  void csMethodCommitInfo() {
    var paramKey="";
     if(csProExpertType=="足球"){
       paramKey="is_zq_expert";
     }else if(csProExpertType=="篮球"){
       paramKey="is_lq_expert";

     }else if(csProExpertType=="电竞"){
       paramKey="is_es_expert";
     }
    CSClassApiManager.csMethodGetInstance().csMethodExpertApply(
        csProBodyParameters:{"real_name":csProRealName,"id_number":csProIdNumber,"phone_number":csProPhoneNumber.trim(),"phone_code":csProPhoneCode.trim(),
          "id_front_url":csProIdFrontUrl,"id_back_url":csProIdBackUrl,"apply_reason":'新版本不需要填写原因'/*csProApplyReason*/,"qq_number":'10000'/*QQNumber*/,"nick_name":csProNickName,paramKey:"1"}
        ,context: context,csProCallBack: CSClassHttpCallBack<CSClassBaseModelEntity>(
        csProOnSuccess: (value){
          CSClassApplicaion.csProUserLoginInfo!.csProExpertVerifyStatus="0";
          CSClassToastUtils.csMethodShowToast(msg: "提交成功");
          Navigator.of(context).pop();
        },onError: (e){},csProOnProgress: (v){}
    ) );
  }


}