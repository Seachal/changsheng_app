import 'package:changshengh5/api/SPClassApiManager.dart';
import 'package:changshengh5/api/SPClassHttpCallBack.dart';
import 'package:changshengh5/app/SPClassApplicaion.dart';
import 'package:changshengh5/model/SPClassCreatOrderEntity.dart';
import 'package:changshengh5/utils/SPClassCommonMethods.dart';
import 'package:changshengh5/utils/SPClassImageUtil.dart';
import 'package:changshengh5/utils/SPClassNavigatorUtils.dart';
import 'package:changshengh5/utils/SPClassStringUtils.dart';
import 'package:changshengh5/utils/SPClassToastUtils.dart';
import 'package:changshengh5/widgets/SPClassToolBar.dart';
import "package:flutter/gestures.dart";
import "package:flutter/material.dart";
import "package:fluwx/fluwx.dart" as fluwx;
import "package:tobias/tobias.dart" as tobias;
import "package:url_launcher/url_launcher.dart";

import 'SPClassContactPage.dart';

class SPClassUnionPlatDetailPage extends StatefulWidget {
  double ?spProOrderMoney;
  double ?spProDiamond;
  VoidCallback ?callback;
  SPClassUnionPlatDetailPage({this.spProOrderMoney, this.spProDiamond, this.callback});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SPClassUnionPlatDetailPageState();
  }
}

class SPClassUnionPlatDetailPageState extends State<SPClassUnionPlatDetailPage> {
  var spProPayType="weixin";
  var spProOrderNum="";
  var spProIsAliPayWeb="1";
  var spProIsWechatWeb="1";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    tobias.isAliPayInstalled().then((value){
      spProIsAliPayWeb=value? "0":"1";
    });
    fluwx.isWeChatInstalled.then((value){
      spProIsWechatWeb=value? "0":"1";
    });

    fluwx.weChatResponseEventHandler.listen((response){
      //do something
      switch(response.errCode){
        case 0:
         if(spProOrderNum.isNotEmpty){
            spFunQueryOrder();
         }
        break;
        case -1:
          SPClassToastUtils.spFunShowToast(msg: "支付异常："+
              "${response.errStr}");
          break;
        case -2:
          SPClassToastUtils.spFunShowToast(msg: "已取消");
          if(spProOrderNum.isNotEmpty){
            SPClassApiManager.spFunGetInstance().spFunCancelOrder(spProOrderNum:spProOrderNum,context: context);
          }
          break;
      }

    });

    SPClassApplicaion.spProEventBus.on<String>().listen((event) {
      if(event=="userInfo"){
        if(mounted){
          setState(() {});
        }
      }
    });

  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar:SPClassToolBar(
          context,
          title: "订单详情",
        ),
        body: Container(
          color: Color(0xFFF1F1F1),
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  color: Colors.white,
                  height: width(123),
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("应付:",style: TextStyle(fontSize: sp(12)),),
                      RichText(
                        text: TextSpan(text:"￥",style: TextStyle(fontSize: sp(20),color: Color(0xFFE3494B)),
                            children: [
                              TextSpan(text: SPClassStringUtils.spFunSqlitZero((widget.spProOrderMoney!-widget.spProDiamond!).toString()),style:TextStyle(fontSize: sp(50)) ),
                            ]
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: width(10),),
                Container(
                  padding: EdgeInsets.all(width(20)),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(bottom: BorderSide(width: 0.4,color: Colors.grey[300]!))
                  ),
                  child: Row(
                    children: <Widget>[
                      Text("订单金额",style: TextStyle(fontSize: sp(16),color: Color(0xFF333333)),),
                      Expanded(
                        child: SizedBox(),
                      ),
                      Text("${SPClassStringUtils.spFunSqlitZero(widget.spProOrderMoney.toString())}"+
                          "钻石",style: TextStyle(fontSize: sp(17),color: Color(0xFFE3494B),),)
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(width(20)),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(bottom: BorderSide(width: 0.4,color: Colors.grey[300]!))
                  ),
                  child: Row(
                    children: <Widget>[
                      Text("账户余额",style: TextStyle(fontSize: sp(16),color: Color(0xFF333333)),),
                      Expanded(
                        child: SizedBox(),
                      ),
                      Text("${SPClassStringUtils.spFunSqlitZero(widget.spProDiamond.toString())}"+
                          "钻石",style: TextStyle(fontSize: sp(17),color: Color(0xFFE3494B),),)
                    ],
                  ),
                ),
                SizedBox(height: width(10),),
                Column(
                  children: <Widget>[
                    FlatButton(
                      padding: EdgeInsets.zero,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border(bottom: BorderSide(width: 0.4,color: Colors.grey[300]!))
                        ),
                        padding: EdgeInsets.only(left: width(21),right: width(16)),
                        height: height(60),
                        child: Row(
                          children: <Widget>[
                            Image.asset(
                              SPClassImageUtil.spFunGetImagePath("ic_pay_wx"),
                              width: width(37),
                              height: width(37),
                            ),
                            SizedBox(width: width(5),),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text("微信支付", style: TextStyle(fontSize: sp(16), color: Color(0xFF333333)),),
                                Text("支持微信用户使用", style: TextStyle(fontSize: sp(11), color: Color(0xFF999999)),)
                              ],
                            ),
                            Flexible(
                              flex: 1,
                              fit: FlexFit.tight,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Image.asset(
                                    spProPayType=="weixin"? SPClassImageUtil.spFunGetImagePath("ic_select"):SPClassImageUtil.spFunGetImagePath("ic_un_select"),
                                    width: width(15),
                                    height: width(15),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      onPressed: (){
                        if(mounted){
                          setState(() {
                            spProPayType="weixin";
                          });
                        }
                      },
                    ),
                    FlatButton(
                      padding: EdgeInsets.zero,
                      child: Container(
                        padding: EdgeInsets.only(left: width(21),right: width(16)),
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        height: height(60),
                        child: Row(
                          children: <Widget>[
                            Image.asset(
                              SPClassImageUtil.spFunGetImagePath("ic_pay_alipay"),
                              width: width(37),
                              height: width(37),
                            ),
                            SizedBox(width: width(5),),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text("支付宝支付", style: TextStyle(fontSize: sp(16), color: Color(0xFF333333)),),
                                Text("推荐支付宝用户、银行卡用户使用，支持快捷支付", style: TextStyle(fontSize: sp(11), color: Color(0xFF999999)),)
                              ],
                            ),
                            Flexible(
                              flex: 1,
                              fit: FlexFit.tight,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Image.asset(
                                    spProPayType=="alipay"? SPClassImageUtil.spFunGetImagePath("ic_select"):SPClassImageUtil.spFunGetImagePath("ic_un_select"),
                                    width: width(15),
                                    height: width(15),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      onPressed: (){
                        if(mounted){
                          setState(() {
                            spProPayType="alipay";
                          });
                        }
                      },
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.all(width(15)),
                  child: RichText(
                    text: TextSpan(text: "温馨提示:"+
                        "\n\n",style: TextStyle(fontSize: sp(13),color: Color(0xFF888888)),
                        children: [
                          TextSpan(text: "1.常胜体育",style: TextStyle(fontSize: sp(12),color: Color(0xFF888888))),
                          TextSpan(text: "非购彩平台",style: TextStyle(fontSize: sp(12),color: Color(0xFFDE3C31))),
                          TextSpan(text: "，充值所得钻石只可用于购买专家推荐方案，不支持提现、购彩等操作；",style: TextStyle(fontSize: sp(12),color: Color(0xFF888888))),
                          TextSpan(text: "不支持提现、购彩等操作；"+
                              "\n\n",style: TextStyle(fontSize: sp(12),color: Color(0xFFDE3C31))),
                          TextSpan(text: "2.如在充值过程或购买方案过程中遇到问题，请及时联系常胜体育客服。（客服微信号：",style: TextStyle(fontSize: sp(12),color: Color(0xFF888888))),
                          TextSpan(text: "kk_lzy",style: TextStyle(fontSize: sp(12),color: Color(0xFFDE3C31)),recognizer: new TapGestureRecognizer(
                          )..onTap=(){
                           SPClassNavigatorUtils.spFunPushRoute(context, SPClassContactPage());
                          } ),
                          TextSpan(text: ")"+
                              "\n\n",style: TextStyle(fontSize: sp(12),color: Color(0xFF888888))),
                          TextSpan(text: "3.提示若微信支付异常，请尝试支付宝支付",style: TextStyle(fontSize: sp(12),color: Color(0xFF888888))),

                        ]
                    ),
                  ),
                )

              ],
            ),
          ),
    ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
              boxShadow:[BoxShadow(
                offset: Offset(1,1),
                color: Color(0x1a000000),
                blurRadius:width(6,),
              )]
          ),
          height: height(53),
          child:GestureDetector(
            child:  Container(
              color: Colors.white,
              height: height(53),
              alignment: Alignment.center,
              child:Container(
                alignment: Alignment.center,
                height: height(40),
                width: width(320),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(width(3)),
                  gradient: LinearGradient(
                      colors: [Color(0xFFF2150C),Color(0xFFF24B0C)]
                  ),
                  boxShadow:[
                    BoxShadow(
                      offset: Offset(3,3),
                      color: Color(0x4DF23B0C),
                      blurRadius:width(5,),),

                  ],

                ),
                child:Text("立即支付",style: TextStyle(fontSize: sp(15),color: Colors.white),),
              ) ,
            ),
            onTap: () async {

              var value=widget.spProOrderMoney!-widget.spProDiamond!;
              SPClassApiManager.spFunGetInstance().spFunCreateOrder(queryParameters: {"pay_type_key":spProPayType,"money":value,"is_web":spProPayType=="weixin"? spProIsWechatWeb:spProIsAliPayWeb},context:context,
                  spProCallBack: SPClassHttpCallBack<SPClassCreatOrderEntity>(
                    spProOnSuccess: (value){
                      spProOrderNum=value.spProOrderNum!;
                      if(spProPayType=="weixin"){
                        if(spProIsWechatWeb=="1"){
                          launch(value.url!);
                        }else{
                          fluwx.payWithWeChat( appId: value.appid!,
                            partnerId: value.partnerid!,
                            prepayId: value.spProPrepayid!,
                            packageValue: "Sign=WXPay",
                            nonceStr: value.noncestr!,
                            timeStamp: value.timestamp!,
                            sign: value.sign!,
                          );
                         }
                      }else if(spProPayType=="alipay"){
                        if(spProIsAliPayWeb=="1"){
                          launch(value.url!);
                        }else{
                          tobias.aliPay(value.spProOrderInfo!).then((value){
                            switch(int.tryParse(value["resultStatus"].toString())){
                              case 9000:
                                if(spProOrderNum.isNotEmpty){
                                  spFunQueryOrder();
                                }
                                break;
                              case 8000:
                                break;
                              case 6002:
                                SPClassToastUtils.spFunShowToast(msg: "支付异常："+
                                    value["memo"]);
                                break;
                              case 6001:
                                SPClassToastUtils.spFunShowToast(msg: "已取消");
                                if(spProOrderNum.isNotEmpty){
                                  SPClassApiManager.spFunGetInstance().spFunCancelOrder(spProOrderNum:spProOrderNum,context: context);
                                }
                                break;
                            }
                          });
                        }

                      }


                    },onError: (e){},spProOnProgress: (v){}
                  )
              );
            },
          ),
        ),

    );
  }

  void spFunQueryOrder() {

    SPClassApiManager.spFunGetInstance().spFunGetOrderStatus(spProOrderNum:spProOrderNum,context: context,
        spProCallBack: SPClassHttpCallBack(
            spProOnSuccess: (value){
              if(value.response!["data"]["status"]=="0"){
                spFunQueryOrder();
              }else if(value.response!["data"]["status"]=="1"){
                SPClassToastUtils.spFunShowToast(msg: "充值成功");
                SPClassApplicaion.spFunGetUserInfo();
                Navigator.of(context).pop();
                widget.callback!();

              }
            },onError: (e){},spProOnProgress: (v){}
        )
    );
  }
}
