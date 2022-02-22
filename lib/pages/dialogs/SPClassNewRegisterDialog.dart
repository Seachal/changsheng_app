import 'package:changshengh5/pages/user/SPClassNewUserWalFarePage.dart';
import 'package:changshengh5/untils/SPClassCommonMethods.dart';
import 'package:changshengh5/untils/SPClassImageUtil.dart';
import 'package:changshengh5/untils/SPClassNavigatorUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


///新人福利界面
class SPClassNewRegisterDialog extends StatefulWidget{
  VoidCallback ?callback;

  SPClassNewRegisterDialog({this.callback});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SPClassNewRegisterDialogState();
  }

}

class SPClassNewRegisterDialogState extends State<SPClassNewRegisterDialog>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(
      child:Dialog(
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              onTap: (){
                Navigator.of(context).pop();
                if(widget.callback!=null){
                  widget.callback!();

                }
              },
              child: Container(
                alignment: Alignment.centerRight,
                padding: EdgeInsets.only(bottom: width(23)),
                child: Image.asset(
                  SPClassImageUtil.spFunGetImagePath("ic_close"),
                  width: width(23),
                ),
              ),
            ),
            GestureDetector(
              onTap: (){
                Navigator.of(context).pop();
                SPClassNavigatorUtils.spFunPushRoute(context, SPClassNewUserWalFarePage());
              },
              child: Image.asset(
                SPClassImageUtil.spFunGetImagePath("new_user"),
                width: width(351),
              ),
            ),
          ],
        ),
      ),
      onWillPop:() async{
        return false;
      },
    );
  }

}