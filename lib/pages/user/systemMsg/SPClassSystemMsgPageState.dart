
import 'package:changshengh5/api/SPClassApiManager.dart';
import 'package:changshengh5/api/SPClassHttpCallBack.dart';
import 'package:changshengh5/app/SPClassApplicaion.dart';
import 'package:changshengh5/model/SPClassBaseModelEntity.dart';
import 'package:changshengh5/model/SPClassSystemMsg.dart';
import 'package:changshengh5/pages/common/SPClassNoDataView.dart';
import 'package:changshengh5/untils/SPClassCommonMethods.dart';
import 'package:changshengh5/untils/SPClassImageUtil.dart';
import 'package:changshengh5/untils/SPClassNavigatorUtils.dart';
import 'package:changshengh5/widgets/SPClassBallFooter.dart';
import 'package:changshengh5/widgets/SPClassBallHeader.dart';
import 'package:changshengh5/widgets/SPClassToolBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

import 'SPClassSysMsgDetailPage.dart';


class SPClassSystemMsgPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SPClassSystemMsgPageState();
  }

}


class SPClassSystemMsgPageState extends State<SPClassSystemMsgPage>{
  List<SPClassSystemMsg>  spProMsgList=[];
  EasyRefreshController ?spProController;

  var spProUserSubscription;

  int spProPage=1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    spProController=EasyRefreshController();


  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: SPClassToolBar(
        context,title: "系统消息",),
      body: buildContent(),
    );
  }


  Widget buildContent() {


      return Container(
        decoration: BoxDecoration(
          color: Color(0xFFF1F1F1),
          border: Border(top: BorderSide(width: 0.4,color: Colors.grey[300]!))
        ),
        child: EasyRefresh.custom(
          header: SPClassBallHeader(
              textColor: Color(0xFF666666)
          ),
          footer: SPClassBallFooter(
              textColor: Color(0xFF666666)
          ),
          firstRefresh: true,
          controller:spProController ,
          onRefresh: spFunGetList,
          onLoad: spFunGetMoreList,
          emptyWidget:spProMsgList.isEmpty? SPClassNoDataView():null,
          slivers: <Widget>[
            SliverList(
              delegate: SliverChildBuilderDelegate((c,i){
                return GestureDetector(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border(bottom: BorderSide(width: 0.4,color: Colors.grey[300]!))
                    ),
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.all(10),
                    child:Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.all(width(4)),
                              child: Image.asset(
                                SPClassImageUtil.spFunGetImagePath("ic_sysmgs"),
                                width: width(23),
                                height: width(23),
                              ),
                            ),
                            Stack(
                              children: <Widget>[
                                Text(spProMsgList[i].title!,style: TextStyle(fontSize: sp(13),color:Color(0xFF999999)),),
                                spProMsgList[i].spProIsRead!  ? Container()
                                    : Positioned(
                                  top:0,
                                  right:0,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Color(0xFFEB3E1C),
                                        borderRadius: BorderRadius.circular(width(6))),
                                    width: width(8),
                                    height: width(8),
                                  ),
                                )
                              ],
                            ),
                            Expanded(
                              child: SizedBox(),
                            ),
                            Text(spProMsgList[i].spProAddTime!,style: TextStyle(fontSize: sp(12),color:Colors.grey),),
                          ],
                        ),
                        Text(spProMsgList[i].content!,style: TextStyle(fontSize: sp(13),color:Color(0xFF333333)),),
                      ],
                    ),
                  ),
                  onTap: (){
                    SPClassApiManager.spFunGetInstance().spFunReadMsg(context: context,queryParameters: {"msg_id":spProMsgList[i].spProMsgId},
                        spProCallBack: SPClassHttpCallBack<SPClassBaseModelEntity>(
                            spProOnSuccess: (result){
                              spProMsgList[i].spProIsRead=true;

                              spFunGetList();
                            },onError: (e){},spProOnProgress: (v){}
                        )
                    );

                    if(spProMsgList[i].spProPageUrl!.isEmpty){
                      SPClassNavigatorUtils.spFunPushRoute(context,  SPClassSysMsgDetailPage(spProMsgList[i]));
                    }else{
                      //标记H5没有web
                      // SPClassNavigatorUtils.spFunPushRoute(context,  SPClassWebPage(spProMsgList[i].spProPageUrl,spProMsgList[i].title));
                    }

                  },
                );
              },
                childCount: spProMsgList.length,
              ),
            )
          ],
        ),
      );

  }

  Future<void>  spFunGetList() async{
    spProPage=1;
  return  SPClassApiManager.spFunGetInstance().spFunMsgList<SPClassSystemMsg>(queryParameters: {"page":"1"},
    spProCallBack: SPClassHttpCallBack(spProOnSuccess: (result){
      spProMsgList=result.spProDataList;
      var unreadNum=0;
      spProMsgList.forEach((item){
        if(!item.spProIsRead!){
          unreadNum++;
        }
      });
      if(unreadNum==0){
        if(SPClassApplicaion.spProUserLoginInfo?.spProUnreadMsgNum!=null&&double.parse(SPClassApplicaion.spProUserLoginInfo!.spProUnreadMsgNum!)>=0){
          SPClassApplicaion.spProUserLoginInfo?.spProUnreadMsgNum="0";
          SPClassApplicaion.spFunGetUserInfo();
        }
      }
      spProController!.finishRefresh(success: true);
      spProController!.resetLoadState();
      if(mounted){setState(() {});}
    },
    onError: (e){
      spProController!.finishRefresh(success: false);

    },spProOnProgress: (v){}
    )
  );
  }

  Future<void>  spFunGetMoreList() {
    return  SPClassApiManager.spFunGetInstance().spFunMsgList<SPClassSystemMsg>(queryParameters: {"page":(spProPage+1).toString()},
        spProCallBack: SPClassHttpCallBack(spProOnSuccess: (result){
          spProMsgList.addAll(result.spProDataList);
          if(result.spProDataList.length>0){
            spProPage++;
            spProController!.finishLoad(success: true);
          }else{
            spProController!.finishLoad(noMore: true);
          }
          if(mounted){setState(() {});}
        },
            onError: (e){
              spProController!.finishLoad(success: false);

            },spProOnProgress: (v){},
        )
    );


  }
}