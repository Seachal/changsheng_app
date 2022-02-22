import 'package:changshengh5/app/SPClassApplicaion.dart';
import 'package:changshengh5/pages/common/SPClassDialogUtils.dart';
import 'package:changshengh5/pages/login/SPClassChangePwdPage.dart';
import 'package:changshengh5/untils/SPClassCommonMethods.dart';
import 'package:changshengh5/untils/SPClassImageUtil.dart';
import 'package:changshengh5/untils/SPClassNavigatorUtils.dart';
import 'package:changshengh5/untils/colors.dart';
import 'package:changshengh5/widgets/SPClassToolBar.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


class SPClassSettingPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SPClassSettingPageState();
  }
}

class SPClassSettingPageState extends State<SPClassSettingPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: SPClassToolBar(
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
                          SPClassImageUtil.spFunGetImagePath("ic_btn_right"),
                          width: width(11),
                        ),
                        SizedBox(
                          width: width(10),
                        )
                      ],
                    ),
                  ),
                  onTap: () {
                    if (spFunIsLogin(context: context)) {
                      SPClassNavigatorUtils.spFunPushRoute(
                          context, SPClassChangePwdPage());
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
                          SPClassImageUtil.spFunGetImagePath("ic_btn_right"),
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
              //             "${SPClassApplicaion.spProPackageInfo.version}",
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
              //       SPClassApiManager.spFunGetInstance().spFunCheckUpdate(
              //           context: context,
              //           spProCallBack:
              //               SPClassHttpCallBack(spProOnSuccess: (result) {
              //             if (result.spProNeedUpdate) {
              //               showDialog<void>(
              //                   context: context,
              //                   builder: (BuildContext cx) {
              //                     return SPClassVersionCheckDialog(
              //                       result.spProIsForced,
              //                       result.spProUpdateDesc,
              //                       result.spProAppVersion,
              //                       spProDownloadUrl: result.spProDownloadUrl,
              //                       spProCancelCallBack: () {
              //                         Navigator.of(context).pop();
              //                       },
              //                     );
              //                   });
              //             } else {
              //               SPClassToastUtils.spFunShowToast(
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
          SPClassApplicaion.spFunClearUserState();
          SPClassApplicaion.spProEventBus.fire("login:gameout");
          SPClassApplicaion.spProEventBus.fire("login:gamelist");
          SPClassApplicaion.spProEventBus.fire("login:out");
          SPClassNavigatorUtils.spFunPopAll(context);
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
                    SPClassDialogUtils.spFunShowConfirmDialog(
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
                      SPClassApplicaion.spFunClearUserState();
                      SPClassApplicaion.spProEventBus.fire("login:out");
                      SPClassNavigatorUtils.spFunPopAll(context);
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
