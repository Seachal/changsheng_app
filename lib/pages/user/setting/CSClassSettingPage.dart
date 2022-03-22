import 'package:changshengh5/app/CSClassApplicaion.dart';
import 'package:changshengh5/pages/common/CSClassDialogUtils.dart';
import 'package:changshengh5/pages/login/CSClassChangePwdPage.dart';
import 'package:changshengh5/utils/CSClassCommonMethods.dart';
import 'package:changshengh5/utils/CSClassImageUtil.dart';
import 'package:changshengh5/utils/CSClassNavigatorUtils.dart';
import 'package:changshengh5/utils/colors.dart';
import 'package:changshengh5/widgets/CSClassToolBar.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


class CSClassSettingPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CSClassSettingPageState();
  }
}

class CSClassSettingPageState extends State<CSClassSettingPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: CSClassToolBar(
        context,
        title: "设置",
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Color(0xFFF7F7F7),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                height: width(6),
              ),
              ///修改密码
              GestureDetector(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: width(46),
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border(
                            bottom: BorderSide(
                                color: Color(0xFFDDDDDD), width: 0.4))),
                    padding: EdgeInsets.only(
                        top: 12, bottom: 12, left: 15, right: 15),
                    child: Row(
                      children: <Widget>[
                        SizedBox(
                          width: width(10),
                        ),
                        Flexible(
                          fit: FlexFit.tight,
                          flex: 1,
                          child: Text("修改密码",
                              style: TextStyle(
                                fontSize: sp(14),
                                color: Color(
                                  0xFF333333,
                                ),
                              )),
                        ),
                        Image.asset(
                          CSClassImageUtil.csMethodGetImagePath("ic_btn_right"),
                          width: width(11),
                        ),
                        SizedBox(
                          width: width(10),
                        )
                      ],
                    ),
                  ),
                  onTap: () {
                    if (csMethodIsLogin(context: context)) {
                      CSClassNavigatorUtils.csMethodPushRoute(
                          context, CSClassChangePwdPage());
                    }
                  }),
              GestureDetector(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: width(46),
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border(
                            bottom: BorderSide(
                                color: Color(0xFFDDDDDD), width: 0.4))),
                    padding: EdgeInsets.only(
                        top: 12, bottom: 12, left: 15, right: 15),
                    child: Row(
                      children: <Widget>[
                        SizedBox(
                          width: width(10),
                        ),
                        Flexible(
                          fit: FlexFit.tight,
                          flex: 1,
                          child: Text("账户管理",
                              style: TextStyle(
                                fontSize: sp(14),
                                color: Color(
                                  0xFF333333,
                                ),
                              )),
                        ),
                        Image.asset(
                          CSClassImageUtil.csMethodGetImagePath("ic_btn_right"),
                          width: width(11),
                        ),
                        SizedBox(
                          width: width(10),
                        )
                      ],
                    ),
                  ),
                  onTap: () {
                    accountManagement();
                  }),
              SizedBox(
                height: width(6),
              ),
              // GestureDetector(
              //     child: Container(
              //       width: MediaQuery.of(context).size.width,
              //       height: width(46),
              //       alignment: Alignment.centerLeft,
              //       decoration: BoxDecoration(
              //           color: Colors.white,
              //           border: Border(
              //               bottom: BorderSide(
              //                   color: Color(0xFFDDDDDD), width: 0.4))),
              //       padding: EdgeInsets.only(
              //           top: 12, bottom: 12, left: 15, right: 15),
              //       child: Row(
              //         children: <Widget>[
              //           SizedBox(
              //             width: width(10),
              //           ),
              //           Flexible(
              //             fit: FlexFit.tight,
              //             flex: 1,
              //             child: Text("版本",
              //                 style: TextStyle(
              //                   fontSize: sp(14),
              //                   color: Color(
              //                     0xFF333333,
              //                   ),
              //                 )),
              //           ),
              //           Text(
              //             "${CSClassApplicaion.csProPackageInfo.version}",
              //             style: TextStyle(
              //                 fontSize: sp(13), color: Color(
              //               0xFF333333,
              //             ),),
              //           ),
              //           SizedBox(
              //             width: width(10),
              //           )
              //         ],
              //       ),
              //     ),
              //     onTap: () {
              //       CSClassApiManager.csMethodGetInstance().csMethodCheckUpdate(
              //           context: context,
              //           csProCallBack:
              //               CSClassHttpCallBack(csProOnSuccess: (result) {
              //             if (result.csProNeedUpdate) {
              //               showDialog<void>(
              //                   context: context,
              //                   builder: (BuildContext cx) {
              //                     return CSClassVersionCheckDialog(
              //                       result.csProIsForced,
              //                       result.csProUpdateDesc,
              //                       result.csProAppVersion,
              //                       csProDownloadUrl: result.csProDownloadUrl,
              //                       csProCancelCallBack: () {
              //                         Navigator.of(context).pop();
              //                       },
              //                     );
              //                   });
              //             } else {
              //               CSClassToastUtils.csMethodShowToast(
              //                   msg: "当前版本已经是最新版本",
              //                   gravity: ToastGravity.CENTER);
              //             }
              //           }));
              //     }),

            ],
          ),
        ),
      ),
      bottomNavigationBar: GestureDetector(
        child: Container(
          color: Color(0xFFF2F2F2),
          height: width(46),
          alignment: Alignment.center,
          child: Text(
            "退出",
            style: TextStyle(
                fontSize: sp(17),
                color: MyColors.red),
          ),
        ),
        onTap: () {
          CSClassApplicaion.csMethodClearUserState();
          CSClassApplicaion.csProEventBus.fire("login:gameout");
          CSClassApplicaion.csProEventBus.fire("login:gamelist");
          CSClassApplicaion.csProEventBus.fire("login:out");
          CSClassNavigatorUtils.csMethodPopAll(context);
        },
      ),
    );
  }

  accountManagement(){
    showDialog(context: context, builder: (context){
      return GestureDetector(
        onTap: (){
          Navigator.pop(context);
        },
        child: Material(
          color: Colors.transparent,
          child: Container(
            height: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                GestureDetector(
                  onTap: (){
                    Navigator.pop(context);
                    CSClassDialogUtils.csMethodShowConfirmDialog(
                        context,
                        RichText(
                          text: TextSpan(
                            text: "确认将个人信息销毁？如有疑问，请联系客服",
                            style:
                            TextStyle(fontSize: 16, color: Color(0xFF333333)),
                            children: <TextSpan>[
                              TextSpan(
                                  text: "",
                                  style: TextStyle(
                                      fontSize: 16, color: Color(0xFF333333))),
                            ],
                          ),
                        ), () {
                      CSClassApplicaion.csMethodClearUserState();
                      CSClassApplicaion.csProEventBus.fire("login:out");
                      CSClassNavigatorUtils.csMethodPopAll(context);
                    }, showCancelBtn: true);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: width(56),
                    color: Colors.white,
                    child: Text('注销',style: TextStyle(fontSize: sp(19),color: MyColors.main2),),
                  ),
                ),
                SizedBox(height: width(8),),
                GestureDetector(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: width(56),
                    color: Colors.white,
                    child: Text('取消',style: TextStyle(fontSize: sp(19),color: MyColors.grey_99),),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
