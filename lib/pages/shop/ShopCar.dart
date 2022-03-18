import 'dart:convert';


import 'package:changshengh5/utils/LocalStorage.dart';
import 'package:changshengh5/utils/SPClassCommonMethods.dart';
import 'package:changshengh5/utils/SPClassImageUtil.dart';
import 'package:changshengh5/utils/SPClassToastUtils.dart';
import 'package:changshengh5/widgets/SPClassToolBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'orderPage.dart';

class ShopCar extends StatefulWidget {
  const ShopCar({Key ?key}) : super(key: key);

  @override
  _ShopCarState createState() => _ShopCarState();
}

class _ShopCarState extends State<ShopCar> {
  int count =1;
  bool isSelectAll =false;
  bool isEdit =false;
  List shopCarList =[];
  List selectList =[];
  List selectIdList =[];
  int money =0;

  @override
  void initState() {
    if (LocalStorage.get('shopCarList') != null) {
      shopCarList = jsonDecode(LocalStorage.get('shopCarList'));
    }
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SPClassToolBar(
        context,
        title: '购物车',
        actions: <Widget>[
          GestureDetector(
            onTap: (){
              isEdit =!isEdit;
              setState(() {

              });
            },
            child: Container(
              padding: EdgeInsets.only(right: width(15),top: width(15)),
              child: Text(isEdit?'完成':'编辑',style: TextStyle(color: Colors.black,fontSize: sp(15)),),
            ),
          )
        ],
      ),
      backgroundColor: Color(0xFFF2F2F2),
      body: SingleChildScrollView(
        child: Container(
          child:Column(
            children: shopCarList.map((e) {
              return productItem(e);
            }).toList(),
          ) ,
        ),
      ),
      bottomNavigationBar: bottomBtn(),
    );
  }

  Widget productItem (Map data){
    return Container(
      padding: EdgeInsets.all(width(15)),
      margin: EdgeInsets.only(top: width(8)),
      color: Colors.white,
      child:  Row(
        children: <Widget>[
          GestureDetector(
            onTap: (){
              if(selectIdList.contains(data['shopCarId'])){
                selectList.remove(data);
                selectIdList.remove(data['shopCarId']);
              }else{
                selectIdList.add(data['shopCarId']);
                selectList.add(data);
              }
              if(selectIdList.length==shopCarList.length){
                isSelectAll=true;
              }else{
                isSelectAll=false;
              }
              money=0;
              for(int i=0;i<selectList.length;i++){
                money = money + int.parse((selectList[i]['price']*selectList[i]['count']).toString());
              }
              setState(() {
              });

            },
            child: Image.asset(
              SPClassImageUtil.spFunGetImagePath(selectIdList.contains(data['shopCarId'])?'ic_select':'ic_seleect_un',), //ic_seleect_un
              height: width(23),
            ),
          ),
          Image.asset(
            SPClassImageUtil.spFunGetShopImagePath('${data['image']}-1'),
            height: width(96),
          ),
          Expanded(
            child: Container(
              height: width(96),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('${data['name']}',style: TextStyle(fontSize: sp(13),color: Color(0xFF333333),),maxLines: 2,overflow: TextOverflow.ellipsis,),
                  Text('${data['color']} ${data['size']}',style: TextStyle(fontSize: sp(13),color: Color(0xFFCCCCCC),),),
                  Row(
                    children: <Widget>[
                      // Expanded(child: Text('￥${data['price']}',style: TextStyle(fontSize: sp(17),color: Color(0xFFD93616),fontWeight: FontWeight.bold),)),
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                              text: '￥',
                              style: TextStyle(
                                  fontSize: sp(12), color: Color(0xFFEB3E1C),fontWeight: FontWeight.bold),
                              children: [
                                TextSpan(
                                  text: '${data['price']}',
                                  style: TextStyle(
                                    fontSize: sp(17), color: Color(0xFFEB3E1C),fontWeight: FontWeight.bold),
                                ),
                              ]
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          if(data['count']<=1){
                            return;
                          }
                          data['count']--;
                          money=0;
                          for(int i=0;i<selectList.length;i++){
                            money = money + int.parse((selectList[i]['price']*selectList[i]['count']).toString());
                          }
                          setState(() {

                          });
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: width(9)),
                          decoration: BoxDecoration(
                              color: Color(0xFFE6E6E6),
                              borderRadius: BorderRadius.horizontal(left: Radius.circular(150))
                          ),
                          child: Text('-',style: TextStyle(fontSize: sp(15),color: Color(0xFF333333)),textAlign: TextAlign.center,),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: width(9)),
                        margin: EdgeInsets.symmetric(horizontal: width(2)),
                        decoration: BoxDecoration(
                          color: Color(0xFFE6E6E6),
                        ),
                        child: Text('${data['count']}',style: TextStyle(fontSize: sp(15),color: Color(0xFF333333)),textAlign: TextAlign.center,),
                      ),
                      GestureDetector(
                        onTap: (){
                          data['count']++;
                          money=0;
                          for(int i=0;i<selectList.length;i++){
                            money = money + int.parse((selectList[i]['price']*selectList[i]['count']).toString());
                          }
                          setState(() {

                          });
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: width(9)),
                          decoration: BoxDecoration(
                              color: Color(0xFFE6E6E6),
                              borderRadius: BorderRadius.horizontal(right: Radius.circular(150))
                          ),
                          child: Text('+',style: TextStyle(fontSize: sp(15),color: Color(0xFF333333)),textAlign: TextAlign.center,),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget bottomBtn(){
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: width(15),vertical: width(18)),
      child: isEdit?
      Row(
        children: <Widget>[
          GestureDetector(
            onTap: (){
              isSelectAll = !isSelectAll;
              setState(() {

              });
            },
            child: Image.asset(
              SPClassImageUtil.spFunGetImagePath(isSelectAll?'ic_select':'ic_seleect_un',),
              height: width(23),
            ),
          ),
          SizedBox(
            width:width(4),
          ),
          Text('全选',style: TextStyle(fontSize: sp(15),color: Color(0xFF333333)),),
          Expanded(
            child: SizedBox(),
          ),
          GestureDetector(
            onTap: (){
              for(int i=0;i<shopCarList.length;i++){
                if(selectIdList.contains(shopCarList[i]['shopCarId'])){
                  selectIdList.remove(shopCarList[i]['shopCarId']);
                  selectList.remove(shopCarList[i]);
                  shopCarList.removeAt(i);
                  LocalStorage.save('shopCarList', jsonEncode(shopCarList));
                  SPClassToastUtils.spFunShowToast(msg: "删除成功");
                  setState(() {

                  });
                }
              }
            },
            child:  Container(
              padding: EdgeInsets.symmetric(horizontal: width(33),vertical: width(10)),
              margin: EdgeInsets.only(left: width(15)),
              decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFFD93616),width: 0.4),
                  borderRadius: BorderRadius.circular(width(19))
              ),
              child: Text('删除',style: TextStyle(fontSize: sp(15),color: Color(0xFFD93616),),),
            ),
          )
        ],
      ):
      Row(
        children: <Widget>[
          GestureDetector(
            onTap: (){
              isSelectAll = !isSelectAll;
              if(isSelectAll){
                for(int i=0;i<shopCarList.length;i++){
                  selectList.add(shopCarList[i]);
                  selectIdList.add(shopCarList[i]['shopCarId']);
                }
              }else{
                selectList=[];
                selectIdList=[];
              }
              money=0;
              for(int i=0;i<selectList.length;i++){
                money = money + int.parse((selectList[i]['price']*selectList[i]['count']).toString());
              }
              setState(() {

              });
            },
            child: Image.asset(
              SPClassImageUtil.spFunGetImagePath(isSelectAll?'ic_select':'ic_seleect_un',),
              height: width(23),
            ),
          ),
          SizedBox(
            width:width(4),
          ),
          Text('全选',style: TextStyle(fontSize: sp(15),color: Color(0xFF333333)),),
          Expanded(
            child: SizedBox(),
          ),
          Text('总金额',style: TextStyle(fontSize: sp(15),color: Color(0xFF333333)),),
          RichText(
            text: TextSpan(
                text: '￥',
                style: TextStyle(
                    fontSize: sp(12), color: Color(0xFFEB3E1C),fontWeight: FontWeight.bold),
                children: [
                  TextSpan(
                    text: '$money',
                    style: TextStyle(
                        fontSize: sp(17), color: Color(0xFFEB3E1C),fontWeight: FontWeight.bold),
                  ),
                ]
            ),
          ),
          GestureDetector(
            onTap: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => OrderPage(dataList:selectList,)));
            },
            child:  Container(
              padding: EdgeInsets.symmetric(horizontal: width(16),vertical: width(10)),
              margin: EdgeInsets.only(left: width(15)),
              decoration: BoxDecoration(
                  color: Color(0xFFD93616),
                  borderRadius: BorderRadius.circular(width(19))
              ),
              child: Text('去结算',style: TextStyle(fontSize: sp(15),color: Colors.white),),
            ),
          )
        ],
      ),
    );
  }
}
