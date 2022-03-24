import 'dart:convert';


import 'package:changshengh5/utils/LocalStorage.dart';
import 'package:changshengh5/utils/CSClassCommonMethods.dart';
import 'package:changshengh5/utils/CSClassImageUtil.dart';
import 'package:changshengh5/utils/CSClassToastUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'orderPage.dart';


class SpecsItem extends StatefulWidget {
  final Map ?data;
  const SpecsItem({Key ?key,this.data}) : super(key: key);

  @override
  _SpecsItemState createState() => _SpecsItemState();
}

class _SpecsItemState extends State<SpecsItem> {
  List colors = [
    {'name':'红色','isSelected':true},
    {'name':'黄色','isSelected':false},
    {'name':'绿色','isSelected':false},
  ];
  List sizes = [
    {'name':'S','isSelected':true},
    {'name':'M','isSelected':false},
    {'name':'L','isSelected':false},
  ];
  String _color ='红色';
  String _size = 'S';
  int count =1;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(width(15)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Image.asset(
                  CSClassImageUtil.csMethodGetImagePath('close',),
                  width: width(15),
                ),
              )
            ],
          ),
          Expanded(child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[

                Row(
                  children: <Widget>[
                    Image.asset(
                      CSClassImageUtil.csMethodGetShopImagePath('${widget.data!['image']}-1'),
                      height: width(108),
                    ),
                    SizedBox(width: width(10),),
                    Container(
                      height: width(108),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          RichText(
                            text: TextSpan(
                                text: '￥',
                                style: TextStyle(
                                    fontSize: sp(12), color: Color(0xFFD93616),fontWeight: FontWeight.bold),
                                children: [
                                  TextSpan(
                                    text: '${widget.data!['price']}',
                                    style: TextStyle(
                                        fontSize: sp(17), color: Color(0xFFD93616),fontWeight: FontWeight.bold),
                                  ),
                                ]
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                                text: '请选择  ',
                                style: TextStyle(fontSize: sp(15),color: Color(0xFF333333),),
                                children: [
                                  TextSpan(
                                      text: '$_color  $_size',
                                      style: TextStyle(fontSize: sp(15),color: Color(0xFF999999),)
                                  )
                                ]
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
//          颜色
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: width(35),),
                      Text('颜色',style: TextStyle(
                          fontSize: sp(15),color: Color(0xFF333333)
                      ),),
                      SizedBox(height: width(12),),
                      Row(
                        children: colors.map((e) {
                          return specsWidget(colors,e,'颜色');
                        }).toList(),
                      )
                    ],
                  ),
                ),
                // 尺寸
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: width(35),),
                      Text('尺寸',style: TextStyle(
                          fontSize: sp(15),color: Color(0xFF333333)
                      ),),
                      SizedBox(height: width(12),),
                      Row(
                        children: sizes.map((e) {
                          return specsWidget(sizes,e,'尺寸');
                        }).toList(),
                      )
                    ],
                  ),
                ),
//          数量
                Container(
                  margin: EdgeInsets.symmetric(vertical: width(24)),
                  child: Row(
                    children: <Widget>[
                      Text('数量',style: TextStyle(
                          fontSize: sp(15),color: Color(0xFF333333)
                      ),),
                      Expanded(
                        child: SizedBox(),
                      ),
                      GestureDetector(
                        onTap: (){
                          if(widget.data!['count']<=1){
                            return;
                          }
                          widget.data!['count']--;
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
                        child: Text('${widget.data!['count']}',style: TextStyle(fontSize: sp(15),color: Color(0xFF333333)),textAlign: TextAlign.center,),
                      ),
                      GestureDetector(
                        onTap: (){
                          widget.data!['count']++;
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
                  ),
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: GestureDetector(
                        onTap: (){
                          int shopCarId =0;
                          if(LocalStorage.get('shopCarId')!=null){
                            shopCarId =LocalStorage.get('shopCarId')+1;
                            LocalStorage.save('shopCarId', shopCarId);
                          }else{
                            LocalStorage.save('shopCarId', shopCarId);
                          }

                          widget.data!['color']=_color;
                          widget.data!['size']=_size;
                          widget.data!['shopCarId']=shopCarId;
                          List shopCarList = [];
                          if (LocalStorage.get('shopCarList') != null) {
                            shopCarList = jsonDecode(LocalStorage.get('shopCarList'));
                          }
                          shopCarList.add(widget.data);
                          LocalStorage.save('shopCarList', jsonEncode(shopCarList));
                          Navigator.pop(context);
                          CSClassToastUtils.csMethodShowToast(msg: "加入购物车成功");
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
                          widget.data!['color']=_color;
                          widget.data!['size']=_size;
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => OrderPage(dataList: [widget.data],)));
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
                SizedBox(
                  height: width(20),
                )
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget specsWidget(List list,Map map,String type){
    return GestureDetector(
      onTap: (){
        for(int i=0;i<list.length;i++){
          list[i]['isSelected'] =false;
        }
        map['isSelected'] =true;
        if(type=='颜色'){
          _color = map['name'];
        }else{
          _size = map['name'];
        }
        setState(() {

        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: map['isSelected']?Color(0xFFD93616):Color(0xFFF5F6F7),
          borderRadius: BorderRadius.circular(width(16)),
        ),
        margin: EdgeInsets.only(right: width(12)),
        padding: EdgeInsets.symmetric(horizontal: width(19),vertical: width(6)),
        child: Text(map['name'],style: TextStyle(color: map['isSelected']?Colors.white:Color(0xFF333333),),),
      ),
    );
  }
}
