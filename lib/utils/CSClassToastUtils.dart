

import 'package:fluttertoast/fluttertoast.dart';

class CSClassToastUtils {


  static void csMethodShowToast({required String msg,ToastGravity gravity:ToastGravity.CENTER}){
    Fluttertoast.showToast(msg: msg,gravity:gravity,toastLength:Toast.LENGTH_LONG );
  }

}