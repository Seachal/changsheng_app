
import 'package:changshengh5/utils/CSClassCommonMethods.dart';
import 'package:changshengh5/utils/CSClassToastUtils.dart';
import 'package:changshengh5/widgets/CSClassToolBar.dart';
import 'package:flutter/material.dart';
import 'package:city_pickers/city_pickers.dart';


class AddAddress extends StatefulWidget {
  const AddAddress({Key ?key}) : super(key: key);

  @override
  _AddAddressState createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _phoneController = new TextEditingController();
  TextEditingController _addressController = new TextEditingController();
  TextEditingController _detailController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:CSClassToolBar(
        context,
        title: '添加地址',
      ),
      backgroundColor: Color(0xFFF2F2F2),
      bottomNavigationBar: bottomBtn(),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.only(top: width(17),),
          padding: EdgeInsets.symmetric(vertical: width(20),horizontal: width(15)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text('收货人:',style: TextStyle(fontSize: sp(17),fontWeight: FontWeight.w500),),
                  SizedBox(
                    width: width(27),
                  ),
                  Expanded(
                    child: TextField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        hintText: '请输入名字'
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: width(20),
              ),
              Row(
                children: <Widget>[
                  Text('手机号码:',style: TextStyle(fontSize: sp(17),fontWeight: FontWeight.w500),),
                  SizedBox(
                    width: width(10),
                  ),
                  Expanded(
                    child: TextField(
                      controller: _phoneController,
                      maxLength: 11,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: '请输入号码',
                        counterText: ''
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: width(20),
              ),
              Row(
                children: <Widget>[
                  Text('所在地区:',style: TextStyle(fontSize: sp(17),fontWeight: FontWeight.w500),),
                  SizedBox(
                    width: width(10),
                  ),
                  Expanded(
                    child: TextField(
                      readOnly: true,
                      onTap: (){
                        selectCity();
                      },
                      controller: _addressController,
                      decoration: InputDecoration(
                          hintText: '省、市、区、街道',
                          counterText: ''
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: width(20),
              ),
              Row(
                children: <Widget>[
                  Text('详细地址:',style: TextStyle(fontSize: sp(17),fontWeight: FontWeight.w500),),
                  SizedBox(
                    width: width(10),
                  ),
                  Expanded(
                    child: TextField(
                      controller: _detailController,
                      decoration: InputDecoration(
                          hintText: '小区/乡村',
                          counterText: ''
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget bottomBtn(){
    return GestureDetector(
      onTap: (){
        submit();
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: width(15)),
        padding: EdgeInsets.symmetric(vertical: width(15)),
        decoration: BoxDecoration(
          color: Color(0xFFEB3E1C),
          borderRadius: BorderRadius.circular(width(26))
        ),
        child: Text('保存',style: TextStyle(color: Colors.white,fontSize: sp(15),),textAlign: TextAlign.center,),
      ),
    );
  }

  selectCity()async{
    FocusScope.of(context).requestFocus(FocusNode());
    Result? tempResult =await CityPickers.showCityPicker(
      context: context,
      height: width(200)
    );
    _addressController.text = '${tempResult?.provinceName}${tempResult?.cityName}${tempResult?.areaName}';
    setState(() {

    });
  }

  submit(){

    if(_nameController.text.isEmpty){
      CSClassToastUtils.csMethodShowToast(msg: "名字不能为空");
      return;
    }
    if(_phoneController.text.isEmpty){
      CSClassToastUtils.csMethodShowToast(msg: "号码不能为空");
      return;
    }
    if(_addressController.text.isEmpty){
      CSClassToastUtils.csMethodShowToast(msg: "地区不能为空");
      return;
    }
    if(_detailController.text.isEmpty){
      CSClassToastUtils.csMethodShowToast(msg: "地址不能为空");
      return;
    }
    Map address ={
      'name':_nameController.text,
      'phone':_phoneController.text,
      'city':_addressController.text,
      'detail':_detailController.text,
    };
    Navigator.pop(context,address);
  }
}
