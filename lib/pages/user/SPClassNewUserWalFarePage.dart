
import 'package:changshengh5/api/SPClassApiManager.dart';
import 'package:changshengh5/api/SPClassHttpCallBack.dart';
import 'package:changshengh5/app/SPClassApplicaion.dart';
import 'package:changshengh5/model/SPClassConfRewardEntity.dart';
import 'package:changshengh5/utils/SPClassCommonMethods.dart';
import 'package:changshengh5/utils/SPClassImageUtil.dart';
import 'package:changshengh5/utils/SPClassNavigatorUtils.dart';
import 'package:changshengh5/utils/colors.dart';
import 'package:changshengh5/utils/common.dart';
import 'package:flutter/material.dart';
import 'SPClassRechargeDiamondPage.dart';


class SPClassNewUserWalFarePage extends StatefulWidget{
    @override
    State<StatefulWidget> createState() {
        // TODO: implement createState
        return SPClassNewUserWalFarePageState();
    }

}

class SPClassNewUserWalFarePageState extends State<SPClassNewUserWalFarePage>{
    bool spProIsRegister=false;
    @override
    void initState() {
        // TODO: implement initState
        super.initState();

       SPClassApiManager.spFunGetInstance().spFunLogAppEvent(spProEventName: "new_user_reward",);

       if(SPClassApplicaion.spProShowPListEntity==null){
         SPClassApiManager.spFunGetInstance().spFunShowPConfig(spProCallBack: SPClassHttpCallBack(
             spProOnSuccess: (result){
               SPClassApplicaion.spProShowPListEntity=result;
               setState(() {});
             },onError: (e){},spProOnProgress: (v){}
         ));
       }
       if(SPClassApplicaion.spProConfReward==null) {
         SPClassApiManager.spFunGetInstance().spFunConfReward<SPClassConfRewardEntity>(spProCallBack:SPClassHttpCallBack(
             spProOnSuccess: (value){
               SPClassApplicaion.spProConfReward=value;
               setState(() {});
             },onError: (e){},spProOnProgress: (v){}
         ));
       }


    }
    @override
    Widget build(BuildContext context) {
      return Scaffold(

        body: Stack(
          children: <Widget>[
            Image.asset(
              SPClassImageUtil.spFunGetImagePath("fuli_bg"),
              width: MediaQuery.of(context).size.width,
            ),
           Column(
             children: <Widget>[
               SizedBox(
                 height: MediaQuery.of(context).padding.top,
               ),
               Commons.getAppBar(title: '新人好礼',appBarLeft: GestureDetector(
                 child: Image.asset(
                   SPClassImageUtil.spFunGetImagePath("arrow_right"),
                   width: width(23),
                 ),
                 onTap: (){Navigator.of(context).pop();},)),
               SizedBox(height: width(161),),
               GestureDetector(
                 onTap: (){
                   if(spFunIsLogin(context: context)){
                     SPClassNavigatorUtils.spFunPushRoute(context,  SPClassRechargeDiamondPage());
                   }
                 },
                 child: Container(
                   child: Image.asset(
                     SPClassImageUtil.spFunGetImagePath("fuli_1"),
                     width: MediaQuery.of(context).size.width-54,
                   ),
                 ),
               ),
               SizedBox(height: width(7),),
               GestureDetector(
                 onTap: (){
                   if(spFunIsLogin(context: context)){
                     SPClassNavigatorUtils.spFunPushRoute(context,  SPClassRechargeDiamondPage(spProMoneySelect: 168,));
                   }
                 },
                 child: Container(
                   child: Image.asset(
                     SPClassImageUtil.spFunGetImagePath("fuli_2"),
                     width: MediaQuery.of(context).size.width-54,
                   ),
                 ),
               ),
               SizedBox(height: width(7),),
               GestureDetector(
                 onTap: (){
                   if(spFunIsLogin(context: context)){
                     SPClassNavigatorUtils.spFunPushRoute(context,  SPClassRechargeDiamondPage(spProMoneySelect: 388,));
                   }
                 },
                 child: Container(
                   child: Image.asset(
                     SPClassImageUtil.spFunGetImagePath("fuli_3"),
                     width: MediaQuery.of(context).size.width-54,
                   ),
                 ),
               ),
               SizedBox(height: width(7),),
               GestureDetector(
                 onTap: (){
                   if(spFunIsLogin(context: context)){
                     SPClassNavigatorUtils.spFunPushRoute(context,  SPClassRechargeDiamondPage(spProMoneySelect: 888,));
                   }
                 },
                 child: Container(
                   child: Image.asset(
                     SPClassImageUtil.spFunGetImagePath("fuli_4"),
                     width: MediaQuery.of(context).size.width-54,
                   ),
                 ),
               ),
               SizedBox(height: width(22),),
               Text('更多福利敬请期待...',style: TextStyle(fontSize: sp(15),color: MyColors.grey_66),)
             ],
           )

          ],
        ),
      );
        // TODO: implement build
    }







}