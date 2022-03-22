import 'package:changshengh5/api/CSClassApiManager.dart';
import 'package:changshengh5/api/CSClassHttpCallBack.dart';
import 'package:changshengh5/app/CSClassApplicaion.dart';
import 'package:changshengh5/model/CSClassCoupon.dart';
import 'package:changshengh5/utils/CSClassCommonMethods.dart';
import 'package:changshengh5/utils/CSClassImageUtil.dart';
import 'package:changshengh5/utils/CSClassNavigatorUtils.dart';
import 'package:changshengh5/utils/CSClassStringUtils.dart';
import 'package:changshengh5/utils/CSClassToastUtils.dart';
import 'package:changshengh5/utils/colors.dart';
import 'package:changshengh5/widgets/CSClassPrecisionLimitFormatter.dart';
import 'package:changshengh5/widgets/CSClassToolBar.dart';
import "package:flutter/gestures.dart";
import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import "package:url_launcher/url_launcher.dart";

import "package:flutter_screenutil/flutter_screenutil.dart";

import 'CSClassDiamondHistoryPage.dart';
import "package:fluwx/fluwx.dart" as fluwx;
import "package:tobias/tobias.dart" as tobias;


class CSClassRechargeDiamondPage extends StatefulWidget {
  double csProMoneySelect;
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CSClassRechargeDiamondPageState();
  }

  CSClassRechargeDiamondPage({this.csProMoneySelect:0});
}

class CSClassRechargeDiamondPageState extends State<CSClassRechargeDiamondPage> {
  int csProSelectIndex=0;
  TextEditingController ?csProTextEditingController;
  var rechargeString=[
    {"value_diamond":"18","value":"18","in_put":false,"double":false,"limit":false},
    {"value_diamond":"38","value":"38","in_put":false,"double":false,"limit":false},
    {"value_diamond":"88","value":"88","in_put":false,"double":false,"limit":false},
    {"value_diamond":"168","value":"168","in_put":false,"double":false,"limit":false},
    {"value_diamond":"388","value":"388","in_put":false,"double":false,"limit":false},
    {"value_diamond":"888","value":"888","in_put":false,"double":false,"limit":false},
  ];

  var csProPayType="weixin";
  var csProOrderNum="";
  var csProIsAliPayWeb="0";
  var csProIsWechatWeb="0";

  List<CSClassCoupon> coupons=[];

  CSClassCoupon ?selectCoupon;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    CSClassApiManager.csMethodGetInstance().csMethodLogAppEvent(csProEventName: "click_pay",);

    CSClassApiManager.csMethodGetInstance().csMethodShowPConfig(csProCallBack: CSClassHttpCallBack(
        csProOnSuccess: (result){
          CSClassApplicaion.csProShowPListEntity=result;
          csMethodInitConfig();
        },onError: (e){},csProOnProgress: (v){}
    ));
    tobias.isAliPayInstalled().then((value){
      csProIsAliPayWeb=value? "0":"1";
    });
    fluwx.isWeChatInstalled.then((value){
      csProIsWechatWeb=value? "0":"1";
    });
    csProTextEditingController=TextEditingController();
    csProTextEditingController!.addListener(() {
      setState(() {

      });
    });
    fluwx.weChatResponseEventHandler.listen((response){
      //do something
      switch(response.errCode){
        case 0:
         if(csProOrderNum.isNotEmpty){
            csMethodQueryOrder();
         }
        break;
        case -1:
          CSClassToastUtils.csMethodShowToast(msg: "支付异常："+response.errStr!);
          break;
        case -2:
          CSClassToastUtils.csMethodShowToast(msg: "已取消");
          if(csProOrderNum.isNotEmpty){
            CSClassApiManager.csMethodGetInstance().csMethodCancelOrder(csProOrderNum:csProOrderNum,context: context);
          }
          break;
      }

    });

    CSClassApplicaion.csProEventBus.on<String>().listen((event) {
      if(event=="userInfo"){
        if(mounted){
          setState(() {});
        }
      }
    });


    csMethodGetCoupon();

  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar:CSClassToolBar(
          context,
          title: "充值",
          csProBgColor: MyColors.main1,
          iconColor: 0xffffffff,
        ),
        body: Container(
          color: Color(0xFFF1F1F1),
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.only(left: width(15),right: width(15),top: width(12),bottom: width(12)),
                  margin: EdgeInsets.symmetric(vertical: width(6)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text('余额:  ',style: TextStyle(fontSize: sp(13),color: MyColors.grey_99),),
                      Text(CSClassStringUtils.csMethodSqlitZero(CSClassApplicaion.csProUserInfo!.csProDiamond),style: TextStyle(fontSize: sp(23),color: Color(0xFF1B8DE0),height: 0.9),),
                      Image.asset(
                        CSClassImageUtil.csMethodGetImagePath("zhuanshi"),
                        width: width(17),
                      ),

                      Expanded(
                        child: SizedBox(),
                      ),
                      GestureDetector(
                        child: Container(
                          padding: EdgeInsets.only(left: width(8),right: width(8),top: width(6),bottom: width(6)),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(width(15)),
                              border: Border.all(width: 0.4,color: MyColors.grey_99)
                          ),
                          child: Row(
                            children: <Widget>[
                              Text("查看明细",style: TextStyle(color: MyColors.grey_99,fontSize: sp(12)),),
                              Image.asset(CSClassImageUtil.csMethodGetImagePath("ic_btn_right"),
                                width: width(12),
                              ),
                            ],
                          ),
                        ),
                        onTap: (){
                          CSClassNavigatorUtils.csMethodPushRoute(context, CSClassDiamondHistoryPage());
                        },
                      )
                    ],
                  ),
                ),
                   Container(
                     color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: Text(
                          '钻石充值',style: TextStyle(fontSize: sp(19),fontWeight: FontWeight.bold),
                        ),
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.symmetric(horizontal: width(15),vertical: width(10)),
                        decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(width: 0.4,color:Color(0xFFF2F2F2),),)
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(width(13)),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border(bottom: BorderSide(width: 0.4,color: Colors.grey[300]!))
                        ),
                        child: GridView.count(
                          shrinkWrap:true,
                          crossAxisCount: 3,
                          scrollDirection: Axis.vertical,
                          childAspectRatio:width(97)/width(48),
                          mainAxisSpacing:  height(13),
                          physics: NeverScrollableScrollPhysics(),
                          crossAxisSpacing: width(12),
                          children: rechargeString.map((rechargeItem){
                            String? rmb=rechargeItem["value"] as String?;
                            bool? isInput=rechargeItem["in_put"] as bool?;
                            bool? canDouble=rechargeItem["double"] as bool?;
                            bool? limit=rechargeItem["limit"] as bool?;
                            return FlatButton(
                              padding: EdgeInsets.zero,
                              child: Stack(
                                children: <Widget>[
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                        color: csProSelectIndex == rechargeString.indexOf(rechargeItem)
                                        ?Color(0xFFFFEAE6):Color(0xFFF7F7F7),
                                        border: Border.all(
                                            color: csProSelectIndex == rechargeString.indexOf(rechargeItem)
                                                ? Color(0xFFEB3E1C)
                                                : Colors.transparent,
                                            width: 0.5)),
                                    child: isInput! ? TextField(
                                      textAlign: TextAlign.center,
                                      inputFormatters:CSClassApplicaion.csProDEBUG? [CSClassPrecisionLimitFormatter(2)]:[FilteringTextInputFormatter.digitsOnly],
                                      keyboardType: TextInputType.numberWithOptions(),
                                      style: TextStyle(
                                          fontSize: sp(12),
                                          color: Color(0xFF333333),textBaseline: TextBaseline.alphabetic),
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "自定义",
                                        hintStyle: TextStyle(
                                            fontSize: sp(12),
                                            color: Color(0xFF999999),textBaseline: TextBaseline.alphabetic),
                                      ),
                                      controller:csProTextEditingController,
                                      onTap: (){
                                        if(mounted){
                                          setState(() {
                                            selectCoupon=null;
                                            csProSelectIndex=rechargeString.indexOf(rechargeItem);
                                          });

                                        }
                                      },
                                    ):Center(
                                      child:  Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: <Widget>[

                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[
                                              Text(
                                                rechargeItem["value_diamond"].toString(),
                                                style: TextStyle(
                                                    fontSize: sp(16),
                                                    fontWeight: FontWeight.w500,
                                                    color:  csProSelectIndex == rechargeString.indexOf(rechargeItem)
                                                        ? Color(0xFFE3494B)
                                                        :MyColors.main1
                                                ),
                                              ),
                                              Image.asset(
                                                CSClassImageUtil.csMethodGetImagePath("zhuanshi"),
                                                width: width(17),
                                              ),
                                            ],
                                          ),
                                          Text(
                                            // rechargeItem["value_diamond"].toString()+"钻石",
                                            rmb!+"元",
                                            style: TextStyle(
                                                fontSize: sp(11),
                                                color:  csProSelectIndex == rechargeString.indexOf(rechargeItem)
                                                    ? Color(0xFFE3494B)
                                                    :Color(0xFF999999)),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  // Positioned(
                                  //   bottom: 0,
                                  //   right: 0,
                                  //   child:csProSelectIndex == rechargeString.indexOf(rechargeItem)
                                  //       ? Image.asset(
                                  //     CSClassImageUtil.csMethodGetImagePath("ic_select_lab"),
                                  //     width: width(18),
                                  //   ):SizedBox(),
                                  // ),
                                  Positioned(
                                    top: 0,
                                    left: 0,
                                    child:limit! ? Image.asset(
                                      CSClassImageUtil.csMethodGetImagePath("ic_recharge_limit"),
                                      width: width(25),
                                    ):SizedBox(),
                                  ),

                                  Positioned(
                                    top: 0.5,
                                    bottom: 0.5,
                                    left:0.5,
                                    child: canDouble! ? Container(
                                      padding: EdgeInsets.all(width(2)),
                                      decoration: BoxDecoration(
                                          borderRadius:BorderRadius.horizontal(left: Radius.circular(3)),
                                          color:Color(0xFFE36649)),
                                      alignment: Alignment.center,
                                      width: width(15),
                                      child: Text(
                                          "首充翻倍",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(fontSize: sp(7),letterSpacing: 0,wordSpacing: 0, color: Colors.white
                                             ,)
                                      ),
                                    ):SizedBox(),
                                  ),
                                ],
                              ),
                              onPressed: (){
                                if(mounted){
                                  setState(() {
                                    selectCoupon=null;
                                    csProSelectIndex=rechargeString.indexOf(rechargeItem);
                                  });
                                }
                              },
                            );
                          }).toList(),
                        ),
                      ),
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
                                    CSClassImageUtil.csMethodGetImagePath("ic_pay_wx"),
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
                                          csProPayType=="weixin"? CSClassImageUtil.csMethodGetImagePath("ic_select"):CSClassImageUtil.csMethodGetImagePath("ic_un_select"),
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
                                  csProPayType="weixin";
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
                                    CSClassImageUtil.csMethodGetImagePath("ic_pay_alipay"),
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
                                          csProPayType=="alipay"? CSClassImageUtil.csMethodGetImagePath("ic_select"):CSClassImageUtil.csMethodGetImagePath("ic_un_select"),
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
                                  csProPayType="alipay";
                                });
                              }
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 10,),

                    ],

                  ),
                ),

                Container(
                  padding: EdgeInsets.all(width(15)),
                  child: RichText(
                    text: TextSpan(text: "温馨提示:"+
                        "\n\n",style: TextStyle(fontSize: sp(13),color: Color(0xFF888888)),
                        children: [
                          TextSpan(text: "1.常胜体育",style: TextStyle(fontSize: sp(12),color: Color(0xFF888888))),
                          TextSpan(text: "非购彩平台",style: TextStyle(fontSize: sp(12),color: Color(0xFFDE3C31))),
                          TextSpan(text: "，充值所得钻石只可用于购买专家推荐方案，",style: TextStyle(fontSize: sp(12),color: Color(0xFF888888))),
                          TextSpan(text: "不支持提现、购彩等操作；"+
                              "\n\n",style: TextStyle(fontSize: sp(12),color: Color(0xFFDE3C31))),
                          TextSpan(text: "2.如在充值过程或购买方案过程中遇到问题，请及时联系常胜体育客服。（客服微信号：",style: TextStyle(fontSize: sp(12),color: Color(0xFF888888))),
                          TextSpan(text: "kk_lzy",style: TextStyle(fontSize: sp(12),color: Color(0xFFDE3C31)),recognizer: new TapGestureRecognizer(
                          )..onTap=(){
                            // 标签
                           // CSClassNavigatorUtils.csMethodPushRoute(context, CSClassContactPage());
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
        bottomNavigationBar:GestureDetector(
          child: Container(
            alignment: Alignment.center,
            
            height: width(48),
            margin: EdgeInsets.symmetric(horizontal: width(16),vertical: width(8)),
            decoration: BoxDecoration(
              color: MyColors.main1,
              borderRadius: BorderRadius.circular(8)
            ),
            child:Text("立即支付",style: TextStyle(fontSize: sp(15),color: Colors.white),),
          ) ,
          onTap: () async {


            String? value;
            if(rechargeString[csProSelectIndex]["in_put"] ==true){
              value=csProTextEditingController!.text;
            }else{
              value=rechargeString[csProSelectIndex]["value"] as String?;
            }
            if(value==null||value.isEmpty||double.tryParse(value)==0){
              CSClassToastUtils.csMethodShowToast(msg: "请输入金额");
              return;
            }
            csProOrderNum="";
            CSClassApiManager.csMethodGetInstance().csMethodCreateOrder(queryParameters: {
              "pay_type_key":csProPayType,
              "coupon_id":selectCoupon==null? "":selectCoupon!.csProCouponId,
              "money":selectCoupon==null? value:(CSClassStringUtils.csMethodSqlitZero((double.tryParse(value)!-double.tryParse(selectCoupon!.csPromoney!)!).toStringAsFixed(2))),
              "is_web":csProPayType=="weixin"? csProIsWechatWeb:csProIsAliPayWeb},
                context:context,
                csProCallBack: CSClassHttpCallBack(
                  csProOnSuccess: (value){
                    csProOrderNum=value.csProOrderNum!;
                    if(csProPayType=="weixin"){
                      if(csProIsWechatWeb=="1"){
                        launch(value.url!);
                      }else{
                        fluwx.payWithWeChat( appId: value.appid!,
                          partnerId: value.partnerid!,
                          prepayId: value.csProPrepayid!,
                          packageValue: "Sign=WXPay",
                          nonceStr: value.noncestr!,
                          timeStamp: value.timestamp!,
                          sign: value.sign!,
                        );
                      }
                    }else if(csProPayType=="alipay"){
                      if(csProIsAliPayWeb=="1"){
                        launch(value.url!);
                      }else{
                        tobias.aliPay(value.csProOrderInfo!).then((value){
                          switch(int.tryParse(value["resultStatus"].toString())){
                            case 9000:
                              if(csProOrderNum.isNotEmpty){
                                csMethodQueryOrder();
                              }
                              break;
                            case 8000:
                              break;
                            case 6002:
                              CSClassToastUtils.csMethodShowToast(msg: "支付异常："+value["memo"].toString());
                              break;
                            case 6001:
                              CSClassToastUtils.csMethodShowToast(msg: "已取消");
                              if(csProOrderNum.isNotEmpty){
                                CSClassApiManager.csMethodGetInstance().csMethodCancelOrder(csProOrderNum:csProOrderNum,context: context);
                              }
                              break;
                          }
                        });
                      }

                    }


                  },onError: (e){},csProOnProgress: (v){},
                )
            );
          },
        ),

    );
  }

  void csMethodQueryOrder() {

    CSClassApiManager.csMethodGetInstance().csMethodGetOrderStatus(csProOrderNum:csProOrderNum,context: context,
        csProCallBack: CSClassHttpCallBack(
            csProOnSuccess: (value){
              if(value.response!["data"]["status"]=="0"){
                csMethodQueryOrder();
              }else if(value.response!["data"]["status"]=="1"){
                CSClassToastUtils.csMethodShowToast(msg: "充值成功");
                CSClassApplicaion.csMethodGetUserInfo();
                Navigator.of(context).pop();

              }
            },onError: (e){},csProOnProgress: (v){},
        )
    );
  }

  void csMethodInitConfig() {
    if(CSClassApplicaion.csProShowPListEntity==null){
      return;
    }
    var result=CSClassApplicaion.csProShowPListEntity;
    rechargeString.clear();
    var csProExchangeRate=double.tryParse(result!.csProExchangeRate!);
    result.csProMoneyList!.forEach((item){

      if(double.tryParse(item)==widget.csProMoneySelect){
        csProSelectIndex=result.csProMoneyList!.indexOf(item);
      }
      var doubleRate=1;
      if(result.csProDoubleMoneys!.contains(item)){doubleRate=2;}
      rechargeString.add({"value_diamond":CSClassStringUtils.csMethodSqlitZero((double.tryParse(item)!*csProExchangeRate!*doubleRate).toString()), "value":item,"in_put":false,"double":false,"limit":false});
    });
    result.csProPayedMoneyList!.forEach((item){
      rechargeString.forEach((map){
        if(map["double"]==true&&double.tryParse(item)==double.tryParse(map["value"].toString())){
          map["value_diamond"]=(double.parse(map["value_diamond"].toString())/2).toStringAsFixed(0);
        }
      });
    });
    result.csProMoney2Diamond!.forEach((key,value){
      rechargeString.forEach((map){
        if(double.tryParse(key.toString())==double.tryParse(map["value"].toString())){
          map["value_diamond"]=value.toString();
          map["limit"]=true;
        }
      });
    });

    if(CSClassApplicaion.csProDEBUG){
      rechargeString.add({"value_diamond":"0","value":"0","in_put":true,"double":false,"limit":false});
    }

    setState(() {});
  }

  csMethodGetCoupon()  {

    CSClassApiManager.csMethodGetInstance().csMethodCouponMyList<CSClassCoupon>(queryParameters: {"status":"unused"},csProCallBack: CSClassHttpCallBack(
        csProOnSuccess: (list){
          setState(() {
            coupons=list.csProDataList;
          });
        },
        onError: (value){
        },csProOnProgress: (v){},
    ));
  }

  List<CSClassCoupon> csMethodGetUseCouponList(){
    List<CSClassCoupon> list =[];
    double? csProMoney=0.0;
    String? value;
    if(rechargeString[csProSelectIndex]["in_put"]==true){
      value=csProTextEditingController!.text;
    }else{
      value=rechargeString[csProSelectIndex]["value"] as String?;
    }

    if(value!=null&&value.isNotEmpty){
      csProMoney=double.tryParse(value);
    }

    coupons.forEach((item) {
       if(csProMoney!>=double.tryParse(item.csProMinMoney!)!){
         list.add(item);
       }
    });

    return list;
  }
}
