
import 'package:changshengh5/api/CSClassApiManager.dart';
import 'package:changshengh5/api/CSClassHttpCallBack.dart';
import 'package:changshengh5/app/CSClassApplicaion.dart';
import 'package:changshengh5/model/CSClassConfRewardEntity.dart';
import 'package:changshengh5/utils/CSClassCommonMethods.dart';
import 'package:changshengh5/utils/CSClassImageUtil.dart';
import 'package:changshengh5/utils/CSClassNavigatorUtils.dart';
import 'package:changshengh5/utils/colors.dart';
import 'package:changshengh5/utils/common.dart';
import 'package:flutter/material.dart';
import 'CSClassRechargeDiamondPage.dart';


class CSClassNewUserWalFarePage extends StatefulWidget{
    @override
    State<StatefulWidget> createState() {
        // TODO: implement createState
        return CSClassNewUserWalFarePageState();
    }

}

class CSClassNewUserWalFarePageState extends State<CSClassNewUserWalFarePage>{
    bool csProIsRegister=false;
    @override
    void initState() {
        // TODO: implement initState
        super.initState();

       CSClassApiManager.csMethodGetInstance().csMethodLogAppEvent(csProEventName: "new_user_reward",);

       if(CSClassApplicaion.csProShowPListEntity==null){
         CSClassApiManager.csMethodGetInstance().csMethodShowPConfig(csProCallBack: CSClassHttpCallBack(
             csProOnSuccess: (result){
               CSClassApplicaion.csProShowPListEntity=result;
               setState(() {});
             },onError: (e){},csProOnProgress: (v){}
         ));
       }
       if(CSClassApplicaion.csProConfReward==null) {
         CSClassApiManager.csMethodGetInstance().csMethodConfReward<CSClassConfRewardEntity>(csProCallBack:CSClassHttpCallBack(
             csProOnSuccess: (value){
               CSClassApplicaion.csProConfReward=value;
               setState(() {});
             },onError: (e){},csProOnProgress: (v){}
         ));
       }


    }
    @override
    Widget build(BuildContext context) {
      return Scaffold(

        body: Stack(
          children: <Widget>[
            Image.asset(
              CSClassImageUtil.csMethodGetImagePath("fuli_bg"),
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.fitWidth,
            ),
            Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).padding.top,
                ),
                Commons.getAppBar(title: '新人好礼',appBarLeft: GestureDetector(
                  child: Image.asset(
                    CSClassImageUtil.csMethodGetImagePath("arrow_right"),
                    width: width(23),
                  ),
                  onTap: (){Navigator.of(context).pop();},)),
                SizedBox(height: height(110),),
                GestureDetector(
                  onTap: (){
                    if(csMethodIsLogin(context: context)){
                      CSClassNavigatorUtils.csMethodPushRoute(context,  CSClassRechargeDiamondPage());
                    }
                  },
                  child: Container(
                    child: Image.asset(
                      CSClassImageUtil.csMethodGetImagePath("fuli_1"),
                      width: MediaQuery.of(context).size.width-54,
                    ),
                  ),
                ),
                SizedBox(height: width(7),),
                GestureDetector(
                  onTap: (){
                    if(csMethodIsLogin(context: context)){
                      CSClassNavigatorUtils.csMethodPushRoute(context,  CSClassRechargeDiamondPage(csProMoneySelect: 168,));
                    }
                  },
                  child: Container(
                    child: Image.asset(
                      CSClassImageUtil.csMethodGetImagePath("fuli_2"),
                      width: MediaQuery.of(context).size.width-54,
                    ),
                  ),
                ),
                SizedBox(height: width(7),),
                GestureDetector(
                  onTap: (){
                    if(csMethodIsLogin(context: context)){
                      CSClassNavigatorUtils.csMethodPushRoute(context,  CSClassRechargeDiamondPage(csProMoneySelect: 388,));
                    }
                  },
                  child: Container(
                    child: Image.asset(
                      CSClassImageUtil.csMethodGetImagePath("fuli_3"),
                      width: MediaQuery.of(context).size.width-54,
                    ),
                  ),
                ),
                SizedBox(height: width(7),),
                GestureDetector(
                  onTap: (){
                    if(csMethodIsLogin(context: context)){
                      CSClassNavigatorUtils.csMethodPushRoute(context,  CSClassRechargeDiamondPage(csProMoneySelect: 888,));
                    }
                  },
                  child: Container(
                    child: Image.asset(
                      CSClassImageUtil.csMethodGetImagePath("fuli_4"),
                      width: MediaQuery.of(context).size.width-54,
                    ),
                  ),
                ),
                SizedBox(height: width(22),),
                Text('更多福利敬请期待...',style: TextStyle(fontSize: sp(15),color: MyColors.grey_66),),
              ],

            )
          ],
        ),
      );
        // TODO: implement build
    }







}