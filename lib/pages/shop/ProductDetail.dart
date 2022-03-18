import 'dart:convert';

import 'package:changshengh5/app/SPClassApplicaion.dart';
import 'package:changshengh5/utils/SPClassCommonMethods.dart';
import 'package:changshengh5/utils/SPClassImageUtil.dart';
import 'package:changshengh5/widgets/SPClassToolBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';


import 'SelectAddress.dart';
import 'ShopCar.dart';
import 'SpecsItem.dart';
import 'orderPage.dart';

class ProductDetail extends StatefulWidget {
  final Map ?data;
  const ProductDetail({Key ?key, this.data}) : super(key: key);

  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  String ?address;
  List detailImages = [];
  String ?type;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:SPClassToolBar(
        context,
        title: '商品详情',
      ),
      backgroundColor: Colors.white,
      bottomNavigationBar: bottomBtn(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // 轮播图
            Container(
              height: width(300),
              width: MediaQuery.of(context).size.width,
              child: Swiper(
                itemBuilder: (BuildContext context, int index) {
                  return ClipRRect(
                    child: Image.asset(
                      SPClassImageUtil.spFunGetShopImagePath('${widget.data!['image']}-${index+1}'),
                    ),
                  );
                },
                onTap: (index) {},
                itemCount: 2,
                viewportFraction: 1,
                scale: 1,
                autoplay: false,
              ),
            ),

            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: width(15), vertical: width(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // 价格
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      RichText(
                        text: TextSpan(
                            text: '￥',
                            style: TextStyle(
                                fontSize: sp(12), color: Color(0xFFEB3E1C),fontWeight: FontWeight.bold),
                            children: [
                              TextSpan(
                                text: '${widget.data!['price']}',
                                style: TextStyle(
                                    fontSize: sp(17), color: Color(0xFFEB3E1C),fontWeight: FontWeight.bold),
                              )
                            ]
                        ),
                      ),
                      SizedBox(
                        width: width(2),
                      ),
                      RichText(
                        text: TextSpan(
                            text: '￥',
                            style: TextStyle(
                                fontSize: sp(10), color: Color(0XFF999999)),
                            children: [
                              TextSpan(
                                text: '${widget.data!['price']+100}',
                                style: TextStyle(
                                    fontSize: sp(12), color: Color(0XFF999999),fontWeight: FontWeight.w500,decoration: TextDecoration.lineThrough,),
                              )
                            ]
                        ),
                      ),
                      Expanded(
                          child: SizedBox(),
                      ),
                      Text(
                        '已售${widget.data!['sell']}件',
                        style: TextStyle(
                          color: Color(0XFF999999),
                          fontSize: sp(13),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: width(4),
                  ),
                  // 名称
                  Text(
                    '${widget.data!['name']}',
                    style: TextStyle(
                        color: Color(0xFF333333),
                        fontSize: sp(13),
                        ),
                  ),

                ],
              ),
            ),
            //分割线
            Container(
              height: width(2),
              color: Color(0xFFF2F2F2),
            ),
            GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                if(!spFunIsLogin(context: context)){
                  return;
                }
                showModalBottomSheet(context: context, builder: (context){
                  return SpecsItem(data: widget.data,);
                });
              },
              child: Container(
                color: Colors.white,
                padding: EdgeInsets.symmetric(
                    horizontal: width(15), vertical: width(12)),
                child: Row(
                  children: <Widget>[
                    Text('选择',style: TextStyle(fontWeight: FontWeight.bold,fontSize: sp(15),),),
                    SizedBox(width: width(12),),
                    Text(type??'请选择款式',style: TextStyle(fontSize: sp(13),),),
                    Expanded(
                      child: SizedBox(),
                    ),
                    Image.asset(
                      SPClassImageUtil.spFunGetShopImagePath("jiantou_right"),
                      width: width(20),
                    )
                  ],
                ),
              ),
            ),
            Container(
              color: Color(0xFFF2F2F2),
              padding: EdgeInsets.symmetric(vertical: width(20)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: width(1),
                    width: width(33),
                    color: Color(0XFF707070),
                  ),
                  SizedBox(
                    width: width(6),
                  ),
                  Text(
                    '商品详情',
                    style:
                        TextStyle(fontSize: sp(15), color: Color(0xFF666666)),
                  ),
                  SizedBox(
                    width: width(6),
                  ),
                  Container(
                    height: width(1),
                    width: width(33),
                    color: Color(0XFF707070),
                  ),
                ],
              ),
            ),
            productDetail(),
          ],
        ),
      ),
    );
  }

  Widget bottomBtn() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: width(15),vertical: width(6)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width/3,
            child:Row(
              children: <Widget>[
                GestureDetector(
                  onTap: (){
                    if(!spFunIsLogin(context: context)){
                      return;
                    }
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ShopCar()));
                  },
                  child: Image.asset(
                    SPClassImageUtil.spFunGetShopImagePath('shop_car',),
                    width: width(30),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: GestureDetector(
              onTap: (){
                if(!spFunIsLogin(context: context)){
                  return;
                }
                showModalBottomSheet(context: context, builder: (context){
                  return SpecsItem(data: widget.data,);
                });
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: width(10)),
                decoration: BoxDecoration(
                    color: Color(0xFFF29E49),
                    borderRadius: BorderRadius.horizontal(left: Radius.circular(150))
                ),
                child: Text('加入购物车',style: TextStyle(fontSize: sp(15),color: Colors.white),textAlign: TextAlign.center,),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: GestureDetector(
              onTap: (){
                if(!spFunIsLogin(context: context)){
                  return;
                }
                showModalBottomSheet(context: context, builder: (context){
                  return SpecsItem(data: widget.data,);
                });
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: width(10)),
                decoration: BoxDecoration(
                    color: Color(0xFFD93616),
                    borderRadius: BorderRadius.horizontal(right: Radius.circular(150))
                ),
                child: Text('立即购买',style: TextStyle(fontSize: sp(15),color: Colors.white),textAlign: TextAlign.center,),
              ),
            ),
          ),

        ],
      ),
    );
  }

  Widget productDetail(){
    List<Widget> list =[];
    for(int i=0;i<4;i++){
      list.add(Container(
        margin: EdgeInsets.only(bottom: width(24)),
        width: MediaQuery.of(context).size.width,
        child: Image.asset(
          SPClassImageUtil.spFunGetShopImagePath('${widget.data!['image']}-${i+3}'),
          fit: BoxFit.fitWidth,
        ),
      ));
    }
    return Column(
      children: list,
    );
  }
}
