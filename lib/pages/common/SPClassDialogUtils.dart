import 'package:changshengh5/untils/SPClassCommonMethods.dart';
import 'package:changshengh5/untils/colors.dart';
import 'package:flutter/material.dart';

import 'SPClassLoadingBall.dart';


class SPClassDialogUtils {

  static void spFunShowConfirmDialog(BuildContext context,Widget showChild,VoidCallback callback,{bool barrierDismissible=true,bool showCancelBtn:true}){
    showDialog<void>(context: context, barrierDismissible: barrierDismissible,
      builder: (BuildContext context) {
           return WillPopScope(
          child: Material(
            color: Colors.transparent,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: width(133),
                  margin: EdgeInsets.symmetric(horizontal: width(46)),
                  decoration:BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8)
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Flexible(flex: 1,
                        child: Container(
                          padding: EdgeInsets.only(left: width(23),right: width(23)),
                          decoration: BoxDecoration(
                            border: Border(bottom: BorderSide(color: Color(0xFFF2F2F2),width: 0.5))
                          ),
                          alignment: Alignment.center,
                          child:showChild ,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          showCancelBtn? Expanded(
                            child:  GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              child: Container(
                                alignment: Alignment.center,
                                height: width(45),
                                decoration: BoxDecoration(
                                    // borderRadius: BorderRadius.circular(5),
                                    // border: Border.all(color: Colors.grey[200],width: 1)
                                      border: Border(right: BorderSide(color: Colors.grey[200]!,width: 1))
                                ),
                                child: Text("取消",style: TextStyle(fontSize: sp(15),color: Color(0xFF333333)),),
                              ),
                              onTap: (){
                                Navigator.of(context).pop();
                              },
                            ),
                          ):SizedBox(),
                          Expanded(child: GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            child: Container(
                              alignment: Alignment.center,
                              height: width(45),
                              child: Text("确定",style: TextStyle(fontSize: sp(15),color: MyColors.main1),),
                            ),
                            onTap: (){
                              callback();
                              Navigator.of(context).pop();
                            },
                          ),)
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          onWillPop: () async {
            return barrierDismissible;
          },
        );
      },
    );// user must tap button!)
  }


  static void spFunShowLoadingDialog(BuildContext context,{bool barrierDismissible=false,String ?content,VoidCallback ?dismiss}){
    showDialog<void>(context: context, barrierDismissible: barrierDismissible,
      builder: (BuildContext context) {
        return WillPopScope(
          child: Dialog(
            elevation: 0,
            backgroundColor: Colors.transparent,
              child: Container(
                height: width(120),
                child: Center(
                  child: SPClassLoadingBall(content: content!,dismiss: dismiss,),
                ),
              ),
          ),
          onWillPop: () async {
            return barrierDismissible;
          },
        );
      },
    );// user must tap button!)
  }

  static Future<Object?> spFunShowTranslateDialog<T>({
    required BuildContext context,
    bool barrierDismissible = true,
    @Deprecated(
        'Instead of using the "child" argument, return the child from a closure '
            'provided to the "builder" argument. This will ensure that the BuildContext '
            'is appropriate for widgets built in the dialog.'
    ) Widget ?child,
    WidgetBuilder ?builder,
  }) {
    assert(child == null || builder == null);
    assert(debugCheckHasMaterialLocalizations(context));

    final ThemeData theme = Theme.of(context, );
    return showGeneralDialog(
      context: context,
      pageBuilder: (BuildContext buildContext, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        final Widget pageChild = child ?? Builder(builder: builder!);
        return SafeArea(
          child: Builder(
              builder: (BuildContext context) {
                return theme != null
                    ? Theme(data: theme, child: pageChild)
                    : pageChild;
              }
          ),
        );
      },
      barrierDismissible: barrierDismissible,
      barrierLabel: MaterialLocalizations
          .of(context)
          .modalBarrierDismissLabel,
      barrierColor:Color(0x03000000),
      transitionDuration: const Duration(milliseconds: 150),
      transitionBuilder: _spFunBuildMaterialDialogTransitions,
    );

  }


 static Widget _spFunBuildMaterialDialogTransitions(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
    return FadeTransition(
      opacity: CurvedAnimation(
        parent: animation,
        curve: Curves.easeOut,
      ),
      child: child,
    );
  }
}