
import 'package:changshengh5/utils/SPClassCommonMethods.dart';
import 'package:changshengh5/utils/SPClassImageUtil.dart';
import 'package:changshengh5/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';



class SPClassNoDataView extends StatefulWidget{
  double ?height;
  Size ?iconSize;
  String ?content;

  SPClassNoDataView({this.height,this.iconSize,this.content});

  SPClassNoDataViewState createState()=>SPClassNoDataViewState();
}

class SPClassNoDataViewState extends State<SPClassNoDataView>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Container(
      height: widget.height!=null?  widget.height:MediaQuery.of(context).size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Stack(
            children: <Widget>[
              Image.asset(
                SPClassImageUtil.spFunGetImagePath('empty'),
                fit: BoxFit.contain,
                width:widget.iconSize!=null? widget.iconSize!.width: width(230),
                height:widget.iconSize!=null? widget.iconSize!.height:  width(230),
              ),
              Positioned(
                bottom: width(40),
                left: 0,
                right: 0,
                child:Text(widget.content==null?"暂无数据":'${widget.content}',style: TextStyle(fontSize: sp(13),color: MyColors.grey_99),textAlign: TextAlign.center,),
              )
            ],
          )
        ],
      ),
    );
  }

}