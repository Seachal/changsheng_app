import 'package:changshengh5/api/SPClassApiManager.dart';
import 'package:changshengh5/api/SPClassHttpCallBack.dart';
import 'package:changshengh5/app/SPClassApplicaion.dart';
import 'package:changshengh5/model/SPClassCoupon.dart';
import 'package:changshengh5/untils/SPClassCommonMethods.dart';
import 'package:changshengh5/untils/SPClassImageUtil.dart';
import 'package:changshengh5/untils/SPClassNavigatorUtils.dart';
import 'package:changshengh5/untils/SPClassStringUtils.dart';
import 'package:changshengh5/untils/SPClassToastUtils.dart';
import 'package:changshengh5/untils/colors.dart';
import 'package:changshengh5/widgets/SPClassPrecisionLimitFormatter.dart';
import 'package:changshengh5/widgets/SPClassToolBar.dart';
import "package:flutter/gestures.dart";
import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import "package:url_launcher/url_launcher.dart";

import "package:flutter_screenutil/flutter_screenutil.dart";

import 'SPClassDiamondHistoryPage.dart';
// import "package:fluwx/fluwx.dart" as fluwx;
// import "package:tobias/tobias.dart" as tobias;


class SPClassRechargeDiamondPage extends StatefulWidget {
  double spProMoneySelect;
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SPClassRechargeDiamondPageState();
  }

  SPClassRechargeDiamondPage({this.spProMoneySelect:0});
}

class SPClassRechargeDiamondPageState extends State<SPClassRechargeDiamondPage> {
  int spProSelectIndex=0;
  TextEditingController ?spProTextEditingController;
  var rechargeString=[
    {"value_diamond":"18","value":"18","in_put":false,"double":false,"limit":false},
    {"value_diamond":"38","value":"38","in_put":false,"double":false,"limit":false},
    {"value_diamond":"88","value":"88","in_put":false,"double":false,"limit":false},
    {"value_diamond":"168","value":"168","in_put":false,"double":false,"limit":false},
    {"value_diamond":"388","value":"388","in_put":false,"double":false,"limit":false},
    {"value_diamond":"888","value":"888","in_put":false,"double":false,"limit":false},
  ];

  var spProPayType="weixin";
  var spProOrderNum="";
  var spProIsAliPayWeb="1";
  var spProIsWechatWeb="1";

  List<SPClassCoupon> coupons=[];

  SPClassCoupon ?selectCoupon;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    SPClassApiManager.spFunGetInstance().spFunLogAppEvent(spProEventName: "click_pay",);

    SPClassApiManager.spFunGetInstance().spFunShowPConfig(spProCallBack: SPClassHttpCallBack(
        spProOnSuccess: (result){
          SPClassApplicaion.spProShowPListEntity=result;
          spFunInitConfig();
        },onError: (e){},spProOnProgress: (v){}
    ));
    // 标记 App使用
    // tobias.isAliPayInstalled().then((value){
    //   spProIsAliPayWeb=value? "0":"1";
    // });
    // fluwx.isWeChatInstalled.then((value){
    //   spProIsWechatWeb=value? "0":"1";
    // });
    spProTextEditingController=TextEditingController();
    spProTextEditingController!.addListener(() {
      setState(() {

      });
    });
    //标记 App使用
    // fluwx.weChatResponseEventHandler.listen((response){
    //   //do something
    //   switch(response.errCode){
    //     case 0:
    //      if(spProOrderNum.isNotEmpty){
    //         spFunQueryOrder();
    //      }
    //     break;
    //     case -1:
    //       SPClassToastUtils.spFunShowToast(msg: "支付异常："+response.errStr);
    //       break;
    //     case -2:
    //       SPClassToastUtils.spFunShowToast(msg: "已取消");
    //       if(spProOrderNum.isNotEmpty){
    //         SPClassApiManager.spFunGetInstance().spFunCancelOrder(spProOrderNum:spProOrderNum,context: context);
    //       }
    //       break;
    //   }
    //
    // });

    SPClassApplicaion.spProEventBus.on<String>().listen((event) {
      if(event=="userInfo"){
        if(mounted){
          setState(() {});
        }
      }
    });


    spFunGetCoupon();

  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar:SPClassToolBar(
          context,
          title: "充值",
          spProBgColor: MyColors.main1,
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
                      Text(SPClassStringUtils.spFunSqlitZero(SPClassApplicaion.spProUserInfo!.spProDiamond),style: TextStyle(fontSize: sp(23),color: Color(0xFF1B8DE0),height: 0.9),),
                      Image.asset(
                        SPClassImageUtil.spFunGetImagePath("zhuanshi"),
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
                              Image.asset(SPClassImageUtil.spFunGetImagePath("ic_btn_right"),
                                width: width(12),
                              ),
                            ],
                          ),
                        ),
                        onTap: (){
                          SPClassNavigatorUtils.spFunPushRoute(context, SPClassDiamondHistoryPage());
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
                                        color: spProSelectIndex == rechargeString.indexOf(rechargeItem)
                                        ?Color(0xFFFFEAE6):Color(0xFFF7F7F7),
                                        border: Border.all(
                                            color: spProSelectIndex == rechargeString.indexOf(rechargeItem)
                                                ? Color(0xFFEB3E1C)
                                                : Colors.transparent,
                                            width: 0.5)),
                                    child: isInput! ? TextField(
                                      textAlign: TextAlign.center,
                                      inputFormatters:SPClassApplicaion.spProDEBUG? [SPClassPrecisionLimitFormatter(2)]:[FilteringTextInputFormatter.digitsOnly],
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
                                      controller:spProTextEditingController,
                                      onTap: (){
                                        if(mounted){
                                          setState(() {
                                            selectCoupon=null;
                                            spProSelectIndex=rechargeString.indexOf(rechargeItem);
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
                                                    color:  spProSelectIndex == rechargeString.indexOf(rechargeItem)
                                                        ? Color(0xFFE3494B)
                                                        :MyColors.main1
                                                ),
                                              ),
                                              Image.asset(
                                                SPClassImageUtil.spFunGetImagePath("zhuanshi"),
                                                width: width(17),
                                              ),
                                            ],
                                          ),
                                          Text(
                                            // rechargeItem["value_diamond"].toString()+"钻石",
                                            rmb!+"元",
                                            style: TextStyle(
                                                fontSize: sp(11),
                                                color:  spProSelectIndex == rechargeString.indexOf(rechargeItem)
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
                                  //   child:spProSelectIndex == rechargeString.indexOf(rechargeItem)
                                  //       ? Image.asset(
                                  //     SPClassImageUtil.spFunGetImagePath("ic_select_lab"),
                                  //     width: width(18),
                                  //   ):SizedBox(),
                                  // ),
                                  Positioned(
                                    top: 0,
                                    left: 0,
                                    child:limit! ? Image.asset(
                                      SPClassImageUtil.spFunGetImagePath("ic_recharge_limit"),
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
                                    spProSelectIndex=rechargeString.indexOf(rechargeItem);
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
                           // SPClassNavigatorUtils.spFunPushRoute(context, SPClassContactPage());
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
        bottomNavigationBar:Container(
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow:[BoxShadow(
                offset: Offset(1,1),
                color: Color(0x1a000000),
                blurRadius:width(6,),
              )]
          ),
          height: width(64)+MediaQuery.of(context).padding.bottom,
          child:Column(
            children: <Widget>[
             /* Container(
                height: width(40),
                padding: EdgeInsets.symmetric(horizontal:width(23)),
                child: Row(
                  children: <Widget>[
                    RichText(text: TextSpan(
                        text: "优惠券 ",
                        style: TextStyle(fontSize: sp(13),color: Color(0xFF333333)),
                        children: [
                          TextSpan(
                            text: coupons.length.toString(),
                            style: TextStyle(color: Color(0xFFEB3F39)),

                          ),
                          TextSpan(
                            text: " 张",

                          )
                        ]
                    ),),
                    Expanded(
                      child:  GestureDetector(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            selectCoupon==null?  RichText(text: TextSpan(
                                text: "当前可使用 ",
                                style: TextStyle(fontSize: sp(13),color: Color(0xFF333333)),
                                children: [
                                  TextSpan(
                                    text: getUseCouponList().length.toString(),
                                    style: TextStyle(color: Color(0xFFEB3F39)),

                                  ),
                                  TextSpan(
                                    text: " 张",

                                  )
                                ]
                            ),):RichText(text: TextSpan(
                                text: "已减 ",
                                style: TextStyle(fontSize: sp(13),color: Color(0xFF333333)),
                                children: [
                                  TextSpan(
                                    text: selectCoupon.money,
                                    style: TextStyle(color: Color(0xFFEB3F39)),
                                  ),
                                  TextSpan(
                                    text: " 元",

                                  )
                                ]
                            ),),
                            Image.asset(ImageUtil.getImagePath("ic_btn_right"),
                              width: width(11),
                            ),

                          ],
                        ),
                        onTap: (){
                          if(getUseCouponList().length>0){
                            showCupertinoModalPopup(context: context, builder:(c)=>
                                PickCouponDialog(
                                  coupons: getUseCouponList(),
                                  select: selectCoupon,
                                  spProValueChanged: (select){
                                    selectCoupon=select;
                                    setState(() {});
                                    FocusScope.of(context).requestFocus(FocusNode());

                                  },
                                ));
                          }else{
                            ToastUtils.showToast(msg: "当前没有可用的优惠券");
                          }
                        },
                      ),
                    )

                  ],
                ),
              ),*/
              GestureDetector(
                child:  Container(
                  height: width(61),
                  alignment: Alignment.topCenter,
                  child:Container(
                    alignment: Alignment.center,
                    // height: height(41),
                      color: MyColors.main1,
                    child:Text("立即支付",style: TextStyle(fontSize: sp(15),color: Colors.white),),
                  ) ,
                ),
                onTap: () async {


                  String? value;
                  if(rechargeString[spProSelectIndex]["in_put"] ==true){
                    value=spProTextEditingController!.text;
                  }else{
                    value=rechargeString[spProSelectIndex]["value"] as String?;
                  }
                  if(value==null||value.isEmpty||double.tryParse(value)==0){
                    SPClassToastUtils.spFunShowToast(msg: "请输入金额");
                    return;
                  }
                  spProOrderNum="";
                  SPClassApiManager.spFunGetInstance().spFunCreateOrder(queryParameters: {
                    "pay_type_key":spProPayType,
                    "coupon_id":selectCoupon==null? "":selectCoupon!.spProCouponId,
                    "money":selectCoupon==null? value:(SPClassStringUtils.spFunSqlitZero((double.tryParse(value)!-double.tryParse(selectCoupon!.spPromoney!)!).toStringAsFixed(2))),
                    "is_web":spProPayType=="weixin"? spProIsWechatWeb:spProIsAliPayWeb},
                      context:context,
                      spProCallBack: SPClassHttpCallBack(
                        spProOnSuccess: (value){
                          // 标记App使用
                          spProOrderNum=value.spProOrderNum!;
                          if(spProPayType=="weixin"){
                            launch(value.url!);
                            // if(spProIsWechatWeb=="1"){
                            //   launch(value.url);
                            // }else{
                            //   fluwx.payWithWeChat( appId: value.appid,
                            //     partnerId: value.partnerid,
                            //     prepayId: value.spProPrepayid,
                            //     packageValue: "Sign=WXPay",
                            //     nonceStr: value.noncestr,
                            //     timeStamp: value.timestamp,
                            //     sign: value.sign,
                            //   );
                            //  }
                          }else if(spProPayType=="alipay"){
                            launch(value.url!);
                            //App使用
                            // if(spProIsAliPayWeb=="1"){
                            //   launch(value.url);
                            // }else{
                            //   tobias.aliPay(value.spProOrderInfo).then((value){
                            //     switch(int.tryParse(value["resultStatus"].toString())){
                            //       case 9000:
                            //         if(spProOrderNum.isNotEmpty){
                            //           spFunQueryOrder();
                            //         }
                            //         break;
                            //       case 8000:
                            //         break;
                            //       case 6002:
                            //         SPClassToastUtils.spFunShowToast(msg: "支付异常："+value["memo"].toString());
                            //         break;
                            //       case 6001:
                            //         SPClassToastUtils.spFunShowToast(msg: "已取消");
                            //         if(spProOrderNum.isNotEmpty){
                            //           SPClassApiManager.spFunGetInstance().spFunCancelOrder(spProOrderNum:spProOrderNum,context: context);
                            //         }
                            //         break;
                            //     }
                            //   });
                            // }

                          }


                        },onError: (e){},spProOnProgress: (v){},
                      )
                  );
                },
              ),
              SizedBox(height: MediaQuery.of(context).padding.bottom,),
            ],
          ),
        )

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

              }
            },onError: (e){},spProOnProgress: (v){},
        )
    );
  }

  void spFunInitConfig() {
    if(SPClassApplicaion.spProShowPListEntity==null){
      return;
    }
    var result=SPClassApplicaion.spProShowPListEntity;
    rechargeString.clear();
    var spProExchangeRate=double.tryParse(result!.spProExchangeRate!);
    result.spProMoneyList!.forEach((item){

      if(double.tryParse(item)==widget.spProMoneySelect){
        spProSelectIndex=result.spProMoneyList!.indexOf(item);
      }
      var doubleRate=1;
      if(result.spProDoubleMoneys!.contains(item)){doubleRate=2;}
      rechargeString.add({"value_diamond":SPClassStringUtils.spFunSqlitZero((double.tryParse(item)!*spProExchangeRate!*doubleRate).toString()), "value":item,"in_put":false,"double":false,"limit":false});
    });
    result.spProPayedMoneyList!.forEach((item){
      rechargeString.forEach((map){
        if(map["double"]==true&&double.tryParse(item)==double.tryParse(map["value"].toString())){
          map["value_diamond"]=(double.parse(map["value_diamond"].toString())/2).toStringAsFixed(0);
        }
      });
    });
    result.spProMoney2Diamond!.forEach((key,value){
      rechargeString.forEach((map){
        if(double.tryParse(key.toString())==double.tryParse(map["value"].toString())){
          map["value_diamond"]=value.toString();
          map["limit"]=true;
        }
      });
    });

    if(SPClassApplicaion.spProDEBUG){
      rechargeString.add({"value_diamond":"0","value":"0","in_put":true,"double":false,"limit":false});
    }

    setState(() {});
  }

  spFunGetCoupon()  {

    SPClassApiManager.spFunGetInstance().spFunCouponMyList<SPClassCoupon>(queryParameters: {"status":"unused"},spProCallBack: SPClassHttpCallBack(
        spProOnSuccess: (list){
          setState(() {
            coupons=list.spProDataList;
          });
        },
        onError: (value){
        },spProOnProgress: (v){},
    ));
  }

  List<SPClassCoupon> spFunGetUseCouponList(){
    List<SPClassCoupon> list =[];
    double? spProMoney=0.0;
    String? value;
    if(rechargeString[spProSelectIndex]["in_put"]==true){
      value=spProTextEditingController!.text;
    }else{
      value=rechargeString[spProSelectIndex]["value"] as String?;
    }

    if(value!=null&&value.isNotEmpty){
      spProMoney=double.tryParse(value);
    }

    coupons.forEach((item) {
       if(spProMoney!>=double.tryParse(item.spProMinMoney!)!){
         list.add(item);
       }
    });

    return list;
  }
}
