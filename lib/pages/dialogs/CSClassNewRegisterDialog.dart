import 'package:changshengh5/pages/user/CSClassNewUserWalFarePage.dart';
import 'package:changshengh5/utils/CSClassCommonMethods.dart';
import 'package:changshengh5/utils/CSClassImageUtil.dart';
import 'package:changshengh5/utils/CSClassNavigatorUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


///新人福利界面
class CSClassNewRegisterDialog extends StatefulWidget{
  VoidCallback ?callback;

  CSClassNewRegisterDialog({this.callback});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CSClassNewRegisterDialogState();
  }

}

class CSClassNewRegisterDialogState extends State<CSClassNewRegisterDialog>{
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
                  CSClassImageUtil.csMethodGetImagePath("ic_close"),
                  width: width(23),
                ),
              ),
            ),
            GestureDetector(
              onTap: (){
                Navigator.of(context).pop();
                CSClassNavigatorUtils.csMethodPushRoute(context, CSClassNewUserWalFarePage());
              },
              child: Image.asset(
                CSClassImageUtil.csMethodGetImagePath("new_user"),
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