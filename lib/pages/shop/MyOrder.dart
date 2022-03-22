import 'dart:convert';


import 'package:changshengh5/utils/LocalStorage.dart';
import 'package:changshengh5/utils/SPClassCommonMethods.dart';
import 'package:changshengh5/utils/SPClassImageUtil.dart';
import 'package:changshengh5/utils/colors.dart';
import 'package:changshengh5/widgets/SPClassToolBar.dart';
import 'package:flutter/material.dart';


class MyOrder extends StatefulWidget {
  const MyOrder({Key ?key}) : super(key: key);

  @override
  _MyOrderState createState() => _MyOrderState();
}

class _MyOrderState extends State<MyOrder> with TickerProviderStateMixin{
  List orderList = [];
  List tabBarList =['全部','待发货','待收货','待评价',];
  List otherList =[];
  TabController ?_controller;

  @override
  void initState() {
    _controller =TabController(length: tabBarList.length, vsync: this);
    if(LocalStorage.get('orderList')!=null){
      orderList = jsonDecode(LocalStorage.get('orderList'));
      print('订单：$orderList');
    }
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: SPClassToolBar(
        context,
        title: '我的订单',
        showLead: false,
      ),
      backgroundColor: Color(0xFFF2F2F2),
      body: Column(
        children: <Widget>[
          Container(
            color: Colors.white,
            child: TabBar(
              controller:_controller ,
              indicatorColor: Colors.white,
              labelColor: MyColors.main1,
              unselectedLabelColor: Color(0xFF333333),
              tabs: tabBarList.map((e) {
                return Tab(text: e,);
              }).toList(),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller:_controller ,
              children: <Widget>[
                itemPage(orderList),
                itemPage(orderList),
                itemPage(otherList),
                itemPage(otherList),
              ],
            ),
          )
        ],
      )
    );
  }

  Widget itemPage(List list){
    return SingleChildScrollView(
      child: Column(
        children: list.map((e) {
          List list =e;
          return Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: width(15),vertical: width(20)),
            margin: EdgeInsets.only(bottom: width(8)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Column(
                  children: list.map((data) {
                    return Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: width(96),
                            height: width(96),
                            child: Image.asset(
                              SPClassImageUtil.spFunGetShopImagePath('${data['image']}-1'),
                            ),
                          ),
                          SizedBox(width: width(12),),
                          Expanded(
                            child: Container(
                              height: width(96),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  Expanded(
                                    child: Text(data['name'],style: TextStyle(fontSize: sp(17),color: Color(0xFF333333)),maxLines: 2,overflow: TextOverflow.ellipsis,),
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Text('${data['color']} ${data['size']}',style: TextStyle(fontSize: sp(13),color: Color(0xFFCCCCCC)),),
                                      Expanded(child: SizedBox()),
                                      Text('x${data['count']}',style: TextStyle(fontSize: sp(13),color: Color(0xFF999999),),)
                                    ],
                                  ),
                                  RichText(
                                    text: TextSpan(
                                        text: '￥',
                                        style: TextStyle(
                                            fontSize: sp(10), color: Color(0xFFEB3E1C)),
                                        children: [
                                          TextSpan(
                                            text: '${data['price']}',
                                            style: TextStyle(
                                                fontSize: sp(13), color: Color(0xFFEB3E1C),),
                                          ),
                                        ]
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  }).toList(),
                ),
                SizedBox(height: width(10),),
                Text('待发货',style: TextStyle(fontSize: sp(16)),)
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

}
