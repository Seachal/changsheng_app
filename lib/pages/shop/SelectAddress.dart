import 'dart:convert';


import 'package:changshengh5/utils/LocalStorage.dart';
import 'package:changshengh5/utils/SPClassCommonMethods.dart';
import 'package:changshengh5/widgets/SPClassToolBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import 'AddAddress.dart';

class SelectAddress extends StatefulWidget {
  const SelectAddress({Key? key}) : super(key: key);

  @override
  _SelectAddressState createState() => _SelectAddressState();
}

class _SelectAddressState extends State<SelectAddress> {
  List addressList =[];

  @override
  void initState() {
    if(LocalStorage.get('addressList')!=null){
      addressList = jsonDecode(LocalStorage.get('addressList'));
    }
    // TODO: implement initState
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:SPClassToolBar(
        context,
        title: '收货地址',
        actions: <Widget>[
          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>AddAddress())).then((value) {
                if(value!=null){
                  addressList.add(value);
                  LocalStorage.save('addressList', jsonEncode(addressList));
                  setState(() {
                  });
                }
              });
            },
            child: Container(
              padding: EdgeInsets.only(top: width(16),right: width(15)),
              child: Text('添加地址',style: TextStyle(fontSize: sp(15),color: Colors.black),),
            ),
          )
        ],
      ),
      backgroundColor: Color(0xFFF2F2F2),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: width(12),vertical: width(10)),
              child: Text('当前配送至',style: TextStyle(color: Color(0xFF999999),fontSize: sp(12)),),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: addressList.map((e){
                return GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: (){
                    Navigator.pop(context,e);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: width(15),vertical: width(12),),
                    margin: EdgeInsets.only(bottom: width(13)),
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('${e['name']}  ${e['phone']}',style: TextStyle(fontSize: sp(15),color: Color(0xFF333333)),),
                            Text('${e['city']}  ${e['detail']}',style: TextStyle(fontSize: sp(12),color: Color(0xFF999999)),),
                          ],
                        ),
                        GestureDetector(
                          onTap: (){
                            addressList.remove(e);
                            setState(() {
                            });
                            LocalStorage.save('addressList', jsonEncode(addressList));
                          },
                          child: Icon(Icons.delete,color: Color(0xFF999999,),size: width(23),),
                        )
                      ],
                    ),
                  ),
                );
              }).toList(),
            )
          ],
        ),
      ),
    );
  }
}
