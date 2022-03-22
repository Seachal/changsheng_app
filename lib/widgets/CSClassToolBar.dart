import 'package:changshengh5/utils/CSClassCommonMethods.dart';
import 'package:changshengh5/utils/CSClassImageUtil.dart';
import 'package:changshengh5/utils/colors.dart';
import 'package:flutter/material.dart';

class CSClassToolBar extends AppBar{
  CSClassToolBar(
      BuildContext context,
      {String? title,
       Color csProBgColor:MyColors.main1,
       int iconColor:0xFFFFFFFF,
        List<Widget>? actions,
        bool showLead:true
      }
      ):super(
          leading:!showLead? null: FlatButton(
            child: Image.asset(
              CSClassImageUtil.csMethodGetImagePath("arrow_right"),
              width: width(23),
              color: Color(iconColor),
            ),
            onPressed: (){Navigator.of(context).pop();},),
          elevation:1,
          centerTitle:true,
          backgroundColor:csProBgColor,
          brightness:Brightness.light,
          title:title!=null ?Text(title,style:TextStyle(color: Color(iconColor),fontSize: sp(18)),):null,actions:actions,

  );
}