import 'dart:convert';


import 'package:changshengh5/api/SPClassApiManager.dart';
import 'package:changshengh5/api/SPClassHttpCallBack.dart';
import 'package:changshengh5/app/SPClassApplicaion.dart';
import 'package:changshengh5/model/SPClassCreatOrderEntity.dart';
import 'package:changshengh5/utils/LocalStorage.dart';
import 'package:changshengh5/utils/SPClassCommonMethods.dart';
import 'package:changshengh5/utils/SPClassImageUtil.dart';
import 'package:changshengh5/utils/SPClassToastUtils.dart';
import 'package:changshengh5/widgets/SPClassToolBar.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:fluwx/fluwx.dart' as fluwx;
import 'package:tobias/tobias.dart' as tobias;


import 'SelectAddress.dart';


class OrderPage extends StatefulWidget {
  final List ?dataList;
  const OrderPage({Key ?key,this.dataList}) : super(key: key);

  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  Map ?userInfo;
  TextEditingController? _controller;
  String spProPayType='weixin';
  int money =0;
  var spProIsAliPayWeb="0";
  var spProIsWechatWeb="0";

  @override
  void initState() {
    for(int i=0;i<widget.dataList!.length;i++){
      money = money+int.parse((widget.dataList![i]!['price']!*widget.dataList![i]!['count']!).toString());
    }
    tobias.isAliPayInstalled().then((value){
      spProIsAliPayWeb=value? "0":"1";
    });
    fluwx.isWeChatInstalled.then((value){
      spProIsWechatWeb=value? "0":"1";
    });
     fluwx.weChatResponseEventHandler.listen((response) {
       if (response.errCode == 0) {
         SPClassToastUtils.spFunShowToast(msg: "购买成功");
         List orderList = [];
         if (LocalStorage.get('orderList') != null) {
           orderList = jsonDecode(LocalStorage.get('orderList'));
         }
         orderList.add(widget.dataList);
         LocalStorage.save('orderList', jsonEncode(orderList));
       }
     });
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SPClassToolBar(
        context,
        title: '确认订单',
      ),
      backgroundColor: Color(0xFFF2F2F2),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            addressWidget(),
            productDetail(),
            messageWidget(),
            payWidget(),
          ],
        ),
      ),
      bottomNavigationBar: bottomBtn(),
    );
  }

  Widget addressWidget(){
    return GestureDetector(
      onTap: (){
        if(spFunIsLogin(context: context)){
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SelectAddress())).then((value) {
            if (value != null) {
              userInfo =value;
              setState(() {});
            }
          });
        }
      },
      child: Container(
        color: Colors.white,
        margin: EdgeInsets.symmetric(vertical: width(8)),
        padding: EdgeInsets.symmetric(horizontal: width(15),vertical: width(15)),
        child: Row(
          children: <Widget>[
            userInfo==null?
            Expanded(
              child: Text('请选择地址~',style: TextStyle(color: Color(0xFF333333),fontSize: sp(15)),),
            ):
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('${userInfo!['name']} ${userInfo!['phone']}',style: TextStyle(color: Color(0xFF333333),fontSize: sp(15)),),
                  Text('${userInfo!['city']}${userInfo!['detail']}',style: TextStyle(color: Color(0xFF333333),fontSize: sp(13)),),
                ],
              ),
            ),
            Image.asset(
              SPClassImageUtil.spFunGetShopImagePath("jiantou_right"),
              width: width(20),
            )
          ],
        ),
      ),
    );
  }

  Widget productDetail(){
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(width(15)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('商品详情',style: TextStyle(fontSize: sp(15),fontWeight: FontWeight.bold),),
          SizedBox(height: width(10),),
          Column(
            children: widget.dataList!.map((e) {
              return Row(
                children: <Widget>[
                  Image.asset(
                    SPClassImageUtil.spFunGetShopImagePath('${e['image']}-1'),
                    height: width(96),
                  ),
                  Expanded(
                    child: Container(
                      height: width(96),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(e['name'],style: TextStyle(fontSize: sp(13),color: Color(0xFF333333),),maxLines: 2,overflow: TextOverflow.ellipsis,),
                          Row(
                            children: <Widget>[
                              Expanded(child: Text('${e['color']} ${e['size']}',style: TextStyle(fontSize: sp(13),color: Color(0xFFCCCCCC)),)),
                              Text('x${e['count']}',style: TextStyle(fontSize: sp(13),color: Color(0xFF333333)),),
                            ],
                          ),
                         RichText(
                            text: TextSpan(
                                text: '￥',
                                style: TextStyle(
                                    fontSize: sp(12), color: Color(0xFFD93616)),
                                children: [
                                  TextSpan(
                                    text: '${e['price']}',
                                    style: TextStyle(
                                        fontSize: sp(17), color: Color(0xFFD93616)),
                                  ),
                                ]
                            ),
                          ),

                        ],
                      ),
                    ),
                  )
                ],
              );
            }).toList(),
          )
        ],
      ),
    );
  }

  Widget messageWidget(){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: width(15)),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Color(0xFFF2F2F2),width: 1))
      ),
      child: Row(
        children: <Widget>[
          Text('留言',style: TextStyle(fontSize: sp(15)),),
          SizedBox(
            width: width(12),
          ),
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: '留言与商家进行沟通',
                  hintStyle: TextStyle(fontSize: sp(13)),
                  counterText: '',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget payWidget(){
    return Container(
      margin: EdgeInsets.only(top: width(12)),
      child: Column(
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
    );
  }

  Widget bottomBtn() {
    return Container(
      color: Colors.white,
      child: Row(
        children: <Widget>[
          Container(
              margin: EdgeInsets.only(left: width(20)),
              child: Text(
                '总金额',
                style: TextStyle(
                    color: Color(0xFF333333),
                    fontSize: sp(15),
                ),
              )),
          Container(
              child:
              RichText(
                text: TextSpan(
                    text: '￥',
                    style: TextStyle(
                        fontSize: sp(12), color: Color(0xFFD93616)),
                    children: [
                      TextSpan(
                        text: '$money',
                        style: TextStyle(
                            fontSize: sp(17), color: Color(0xFFD93616)),
                      ),
                    ]
                ),
              ),
          ),
          Expanded(
            child: SizedBox(),
          ),
          GestureDetector(
            onTap: () {

              if(spFunIsLogin(context: context)){
                if (userInfo ==null) {
                  SPClassToastUtils.spFunShowToast(msg: "请添加收货地址");
                  return;
                }

                SPClassApiManager.spFunGetInstance().spFunCreateOrder(
                    queryParameters: {
                      "pay_type_key": spProPayType,
                      "coupon_id": "",
                      "money": money,
                      "is_web":spProPayType=="weixin"? spProIsWechatWeb:spProIsAliPayWeb
                    },
                    context: context,
                    spProCallBack: SPClassHttpCallBack<SPClassCreatOrderEntity>(
                      spProOnSuccess: (value) {

                        if(spProPayType=='weixin'){
                          if(spProIsWechatWeb=='1'){
                            launch(value.url!);
                            return;
                          }
                          fluwx.payWithWeChat(
                            appId: value.appid!,
                            partnerId: value.partnerid!,
                            prepayId: value.spProPrepayid!,
                            packageValue: "Sign=WXPay",
                            nonceStr: value.noncestr!,
                            timeStamp: value.timestamp!,
                            sign: value.sign!,
                          );
                        }else{
                          if(spProIsAliPayWeb=='1'){
                            launch(value.url!);
                            return;
                          }
                          tobias.aliPay(value.spProOrderInfo!).then((value){
                            switch(int.tryParse(value["resultStatus"].toString())){
                              case 9000:
                                Navigator.pop(context);
                                SPClassToastUtils.spFunShowToast(msg: "购买成功");
                                break;
                              case 8000:
                                break;
                              case 6002:
                                SPClassToastUtils.spFunShowToast(msg: "支付异常："+value["memo"].toString());
                                break;
                              case 6001:
                                SPClassToastUtils.spFunShowToast(msg: "已取消");
                                break;
                            }
                          });
                        }
                      },onError: (v){},spProOnProgress: (v){}
                    ));
              }

            },
            child: Container(
              margin: EdgeInsets.symmetric(
                  vertical: width(12), horizontal: width(15)),
              padding: EdgeInsets.symmetric(
                  horizontal: width(21), vertical: width(10)),
              decoration: BoxDecoration(
                  color: Color(0xFFEB3E1C),
                  borderRadius: BorderRadius.circular(width(19))),
              child: Text(
                '提交订单',
                style: TextStyle(fontSize: sp(15), color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }


}
