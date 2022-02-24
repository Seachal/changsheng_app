
import 'dart:async';
import 'dart:io';
import 'package:changshengh5/api/SPClassApiManager.dart';
import 'package:changshengh5/api/SPClassHttpCallBack.dart';
import 'package:changshengh5/app/SPClassApplicaion.dart';
import 'package:changshengh5/model/SPClassBaseModelEntity.dart';
import 'package:changshengh5/utils/SPClassCommonMethods.dart';
import 'package:changshengh5/utils/SPClassImageUtil.dart';
import 'package:changshengh5/utils/SPClassToastUtils.dart';
import 'package:changshengh5/utils/colors.dart';
import 'package:changshengh5/widgets/SPClassToolBar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class SPClassExpertApplyPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SPClassExpertApplyPageState();
  }

}

class SPClassExpertApplyPageState  extends State<SPClassExpertApplyPage>{
  bool spProCloseTitle=false;
  int spProCurrentSecond=0;
  String spProPhoneNumber="";
  String QQNumber="";
  String spProRealName="";
  String spProNickName="";
  String spProIdNumber="";
  String spProPhoneCode="";
  File ?spProFrontFile;
  File ?spProBackFile;
  String spProIdFrontUrl="";
  String spProIdBackUrl="";
  String spProApplyReason="";
  var spProTimer;

  var spProExpertType="足球";
  List typeList =['足球','篮球'];
  TextEditingController ?spProNickTextEditingController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    spProNickTextEditingController=TextEditingController(text: SPClassApplicaion.spProUserInfo!.spProNickName);
    spProNickName=spProNickTextEditingController!.text;
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar:SPClassToolBar(context,
      title: "申请专家",
      spProBgColor: MyColors.main1,
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
                  height: !spProCloseTitle ?height(33):0,
                  child: Row(
                    children: <Widget>[
                    SizedBox(width:width(15) ,),
                    Text("为了更好的为您服务，请务必填写真实信息",style: TextStyle(fontSize:  sp(13),color: Color(0xFFEB3E1C),)),
                      spProCloseTitle ? Container(): Flexible(
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
                                setState(() {spProCloseTitle=true;});
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
                          SPClassImageUtil.spFunGetImagePath("ic_edit_content"),
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
                              spProExpertType='足球';
                              setState(() {
                              });
                            },
                            child: Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.symmetric(vertical: width(8)),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(width(16)),
                                  color: spProExpertType=='足球'?MyColors.main1:Color(0xFFF5F6F7)
                              ),
                              child: Text('足球',style: TextStyle(fontSize: sp(13),color: spProExpertType=='足球'? Colors.white:MyColors.grey_99),),
                            ),
                          ),
                        ),
                        SizedBox(width: width(13),),
                        Expanded(
                          flex: 1,
                          child: GestureDetector(
                            onTap: (){
                              spProExpertType='篮球';
                              setState(() {
                              });
                            },
                            child: Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.symmetric(vertical: width(8)),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(width(16)),
                                  color: spProExpertType=='篮球'?MyColors.main1:Color(0xFFF5F6F7)
                              ),
                              child: Text('篮球',style: TextStyle(fontSize: sp(13),color: spProExpertType=='篮球'? Colors.white:MyColors.grey_99),),
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
                    //               Text(spProExpertType,style: TextStyle(fontSize:  sp(12),color: Color(0xFF333333)),)
                    //             ],
                    //           ),
                    //         ),
                    //         Image.asset(SPClassImageUtil.spFunGetImagePath("ic_btn_right"),
                    //           width: width(11),
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    //   onTap: (){
                    //     showModalBottomSheet(
                    //       context: context,
                    //       builder: (BuildContext context) {
                    //         return SPClassBottomLeaguePage(<String>["足球","篮球","电竞"],"请选择专家",(index){
                    //           setState(() {
                    //             spProExpertType=["足球","篮球","电竞"][index];
                    //           });
                    //         },initialIndex:["足球","篮球","电竞"].indexOf(spProExpertType),);
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
                          SPClassImageUtil.spFunGetImagePath("ic_login_account"),
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
                                spProRealName=value;
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
                                spProIdNumber=value;
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
              //             SPClassImageUtil.spFunGetImagePath("ic_login_account"),
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
              //               controller: spProNickTextEditingController,
              //               style: TextStyle(fontSize:  sp(13),color: Color(0xFF333333)),
              //               decoration: InputDecoration(
              //                 hintText: "请填写昵称",
              //                 hintStyle: TextStyle(fontSize:  sp(13),color: Color(0xFFC6C6C6)),
              //                 border: InputBorder.none,
              //               ),
              //               onChanged: (value){
              //                 spProNickName=value;
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
              //             SPClassImageUtil.spFunGetImagePath("ic_user_id_num"),
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
              //                 spProIdNumber=value;
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
                          SPClassImageUtil.spFunGetImagePath("ic_user_id_num"),
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
                                  child: spProFrontFile==null?Image.asset(
                                    SPClassImageUtil.spFunGetImagePath("ic_add_pic"),
                                    fit: BoxFit.contain,
                                    width: width(18),
                                  ):Image.file(
                                    spProFrontFile!,
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
                                      spProIdFrontUrl="";
                                      spProFrontFile=image;
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
                                  child: spProBackFile==null?Image.asset(
                                    SPClassImageUtil.spFunGetImagePath("ic_add_pic"),
                                    fit: BoxFit.contain,
                                    width: width(18),
                                  ):Image.file(
                                    spProBackFile!,
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
                                      spProIdBackUrl="";
                                      spProBackFile=image;
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
        //             SPClassImageUtil.spFunGetImagePath("ic_edit_content"),
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
        //                 spProApplyReason=value;
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
              //             SPClassImageUtil.spFunGetImagePath("ic_login_account"),
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
                          SPClassImageUtil.spFunGetImagePath("ic_login_account"),

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
                                    spProPhoneNumber=value;
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
                                spProPhoneCode=value;
                              },
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            if(spProPhoneNumber.length != 11 || spProCurrentSecond > 0){
                              return;
                            }
                            spFunDoSendCode();
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: width(9),vertical: width(10)),
                            decoration: BoxDecoration(
                              border: Border.all(color: Color(0xFFE6E6E6),width: 1),
                              borderRadius: BorderRadius.circular(150),
                            ),
                            child: Text(spProCurrentSecond > 0
                                ? "已发送" + spProCurrentSecond.toString() + "s"
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
              //             SPClassImageUtil.spFunGetImagePath("ic_login_account"),
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
              //                           spProPhoneCode=value;
              //                     },
              //                   ),
              //                 ),
              //                 OutlineButton(
              //                   padding: EdgeInsets.zero,
              //                   child: Text(spProCurrentSecond > 0
              //                       ? "已发送" + spProCurrentSecond.toString() + "s"
              //                       : "获取验证码",style: TextStyle(fontSize: sp(11)),),
              //                   borderSide: BorderSide(
              //                       color: Theme.of(context).primaryColor, width: 1),
              //                   textColor: Theme.of(context).primaryColor,
              //                   disabledBorderColor: Colors.grey[300],
              //                   onPressed: (spProPhoneNumber.length != 11 || spProCurrentSecond > 0)
              //                       ? null
              //                       : () {
              //                     spFunDoSendCode();
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
              spFunCommit();

            },
          ),
        )
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    if(spProTimer!=null){
      spProTimer.cancel();
    }

  }
  void spFunDoSendCode() {


    SPClassApiManager.spFunGetInstance().spFunSendCode(spProPhoneNumber: spProPhoneNumber,context: context,spProCodeType: "apply_expert",spProCallBack: SPClassHttpCallBack(
      spProOnSuccess: (value){
      SPClassToastUtils.spFunShowToast(msg: "发送成功");
      setState(() {spProCurrentSecond = 60;});
       spProTimer=   Timer.periodic(Duration(seconds: 1), (second) {
        setState(() {
          if (spProCurrentSecond > 0) {
            setState(() {
              spProCurrentSecond = spProCurrentSecond-1;
            });
          } else {
            second.cancel();
          }
        });
      });
      },onError: (e){},spProOnProgress: (v){}
    ));

  }

  void spFunCommit() {

    if(spProRealName.isEmpty){
      SPClassToastUtils.spFunShowToast(msg: "请填写真实姓名");
      return;
    }
    // if(spProNickName.isEmpty){
    //   SPClassToastUtils.spFunShowToast(msg: "请填写真实姓名");
    //   return;
    // }
    if(spProIdNumber.isEmpty){
      SPClassToastUtils.spFunShowToast(msg: "请填写身份证号码");
      return;
    }
    if(spProBackFile==null||spProFrontFile==null){
      SPClassToastUtils.spFunShowToast(msg: "请上传比赛分析");
      return;
    }
    // if(spProApplyReason.isEmpty){
    //   SPClassToastUtils.spFunShowToast(msg: "请填写申请理由");
    //   return;
    // }
    // if(QQNumber.isEmpty){
    //   SPClassToastUtils.spFunShowToast(msg: "请填写QQ号码");
    //   return;
    // }
    if(spProPhoneNumber.isEmpty){
      SPClassToastUtils.spFunShowToast(msg: "请填写手机号码");
      return;
    }
    if(spProPhoneCode.isEmpty){
      SPClassToastUtils.spFunShowToast(msg: "请填写验证码");
      return;
    }

    if(spProIdFrontUrl.isEmpty){
      SPClassApiManager.spFunGetInstance().spFunUploadFiles(context:context,files:[spProFrontFile!,spProBackFile!],params: {"is_multi":"1","is_private":"1"},
          spProCallBack: SPClassHttpCallBack<SPClassBaseModelEntity>(
        spProOnSuccess: (result){
          var images=[];
          result.data.forEach((pic){
            images.add(pic);
          });
          spProIdFrontUrl=images[0];
          spProIdBackUrl=images[1];
          spFunCommitInfo();
        },onError: (e){},spProOnProgress: (v){}
      )  );
    }else{
      spFunCommitInfo();
    }

  }

  void spFunCommitInfo() {
    var paramKey="";
     if(spProExpertType=="足球"){
       paramKey="is_zq_expert";
     }else if(spProExpertType=="篮球"){
       paramKey="is_lq_expert";

     }else if(spProExpertType=="电竞"){
       paramKey="is_es_expert";
     }
    SPClassApiManager.spFunGetInstance().spFunExpertApply(
        spProBodyParameters:{"real_name":spProRealName,"id_number":spProIdNumber,"phone_number":spProPhoneNumber.trim(),"phone_code":spProPhoneCode.trim(),
          "id_front_url":spProIdFrontUrl,"id_back_url":spProIdBackUrl,"apply_reason":'新版本不需要填写原因'/*spProApplyReason*/,"qq_number":'10000'/*QQNumber*/,"nick_name":spProNickName,paramKey:"1"}
        ,context: context,spProCallBack: SPClassHttpCallBack<SPClassBaseModelEntity>(
        spProOnSuccess: (value){
          SPClassApplicaion.spProUserLoginInfo!.spProExpertVerifyStatus="0";
          SPClassToastUtils.spFunShowToast(msg: "提交成功");
          Navigator.of(context).pop();
        },onError: (e){},spProOnProgress: (v){}
    ) );
  }


}