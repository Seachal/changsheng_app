
import 'package:changshengh5/utils/CSClassCommonMethods.dart';
import 'package:changshengh5/utils/CSClassImageUtil.dart';
import 'package:changshengh5/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';



class CSClassNoDataView extends StatefulWidget{
  double ?height;
  Size ?iconSize;
  String ?content;

  CSClassNoDataView({this.height,this.iconSize,this.content});

  CSClassNoDataViewState createState()=>CSClassNoDataViewState();
}

class CSClassNoDataViewState extends State<CSClassNoDataView>{
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
                CSClassImageUtil.csMethodGetImagePath('empty'),
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