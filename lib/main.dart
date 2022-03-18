import 'package:changshengh5/splash_screen.dart';
import 'package:changshengh5/utils/LocalStorage.dart';
import 'package:changshengh5/utils/SPClassToastUtils.dart';
import 'package:changshengh5/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'app/SPClassApplicaion.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorage.getInstance();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  MyAppState createState() => MyAppState();

}


class MyAppState extends State<MyApp> {
  var spProPopTimer= DateTime.now();


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: SPClassApplicaion.spProAppName,
        theme: ThemeData(
          fontFamily: '',
          brightness: Brightness.light,
          primaryColor: MyColors.main1,
          backgroundColor: Colors.white,
          unselectedWidgetColor: Colors.white70,
          accentColor: Color(0xFF888888),
          // textTheme: GoogleFonts.notoSansSCTextTheme(),
          iconTheme: IconThemeData(
            color: MyColors.main1,
            size: 35.0,
          ),
        ),
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('zh', 'CH'),
          const Locale('en', 'US'),
        ],
        home: CupertinoPageScaffold(
          child: WillPopScope(
            child:  Scaffold(body:SplashScreen()),
            onWillPop: () async{
              if(DateTime.now().difference(spProPopTimer).inSeconds>3){
                SPClassToastUtils.spFunShowToast(msg: "再按一次退出");
              }else{
                return true;
              }
              spProPopTimer=DateTime.now();
              return false;
            },
          ),
        ),
    );
  }
}
