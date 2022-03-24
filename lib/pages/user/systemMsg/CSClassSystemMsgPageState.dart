
import 'package:changshengh5/api/CSClassApiManager.dart';
import 'package:changshengh5/api/CSClassHttpCallBack.dart';
import 'package:changshengh5/app/CSClassApplicaion.dart';
import 'package:changshengh5/model/CSClassBaseModelEntity.dart';
import 'package:changshengh5/model/CSClassSystemMsg.dart';
import 'package:changshengh5/pages/common/CSClassNoDataView.dart';
import 'package:changshengh5/pages/news/CSClassWebPageState.dart';
import 'package:changshengh5/utils/CSClassCommonMethods.dart';
import 'package:changshengh5/utils/CSClassImageUtil.dart';
import 'package:changshengh5/utils/CSClassNavigatorUtils.dart';
import 'package:changshengh5/widgets/CSClassBallFooter.dart';
import 'package:changshengh5/widgets/CSClassBallHeader.dart';
import 'package:changshengh5/widgets/CSClassToolBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

import 'CSClassSysMsgDetailPage.dart';


class CSClassSystemMsgPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CSClassSystemMsgPageState();
  }

}


class CSClassSystemMsgPageState extends State<CSClassSystemMsgPage>{
  List<CSClassSystemMsg>  csProMsgList=[];
  EasyRefreshController ?csProController;

  var csProUserSubscription;

  int csProPage=1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    csProController=EasyRefreshController();


  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: CSClassToolBar(
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
          header: CSClassBallHeader(
              textColor: Color(0xFF666666)
          ),
          footer: CSClassBallFooter(
              textColor: Color(0xFF666666)
          ),
          firstRefresh: true,
          controller:csProController ,
          onRefresh: csMethodGetList,
          onLoad: csMethodGetMoreList,
          emptyWidget:csProMsgList.isEmpty? CSClassNoDataView():null,
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
                                CSClassImageUtil.csMethodGetImagePath("cs_sysmgs"),
                                width: width(23),
                                height: width(23),
                              ),
                            ),
                            Stack(
                              children: <Widget>[
                                Text(csProMsgList[i].title!,style: TextStyle(fontSize: sp(13),color:Color(0xFF999999)),),
                                csProMsgList[i].csProIsRead!  ? Container()
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
                            Text(csProMsgList[i].csProAddTime!,style: TextStyle(fontSize: sp(12),color:Colors.grey),),
                          ],
                        ),
                        Text(csProMsgList[i].content!,style: TextStyle(fontSize: sp(13),color:Color(0xFF333333)),),
                      ],
                    ),
                  ),
                  onTap: (){
                    CSClassApiManager.csMethodGetInstance().csMethodReadMsg(context: context,queryParameters: {"msg_id":csProMsgList[i].csProMsgId},
                        csProCallBack: CSClassHttpCallBack<CSClassBaseModelEntity>(
                            csProOnSuccess: (result){
                              csProMsgList[i].csProIsRead=true;

                              csMethodGetList();
                            },onError: (e){},csProOnProgress: (v){}
                        )
                    );

                    if(csProMsgList[i].csProPageUrl!.isEmpty){
                      CSClassNavigatorUtils.csMethodPushRoute(context,  CSClassSysMsgDetailPage(csProMsgList[i]));
                    }else{
                      CSClassNavigatorUtils.csMethodPushRoute(context,  CSClassWebPage(csProMsgList[i].csProPageUrl!,csProMsgList[i].title!));
                    }

                  },
                );
              },
                childCount: csProMsgList.length,
              ),
            )
          ],
        ),
      );

  }

  Future<void>  csMethodGetList() async{
    csProPage=1;
  return  CSClassApiManager.csMethodGetInstance().csMethodMsgList<CSClassSystemMsg>(queryParameters: {"page":"1"},
    csProCallBack: CSClassHttpCallBack(csProOnSuccess: (result){
      csProMsgList=result.csProDataList;
      var unreadNum=0;
      csProMsgList.forEach((item){
        if(!item.csProIsRead!){
          unreadNum++;
        }
      });
      if(unreadNum==0){
        if(CSClassApplicaion.csProUserLoginInfo?.csProUnreadMsgNum!=null&&double.parse(CSClassApplicaion.csProUserLoginInfo!.csProUnreadMsgNum!)>=0){
          CSClassApplicaion.csProUserLoginInfo?.csProUnreadMsgNum="0";
          CSClassApplicaion.csMethodGetUserInfo();
        }
      }
      csProController!.finishRefresh(success: true);
      csProController!.resetLoadState();
      if(mounted){setState(() {});}
    },
    onError: (e){
      csProController!.finishRefresh(success: false);

    },csProOnProgress: (v){}
    )
  );
  }

  Future<void>  csMethodGetMoreList() {
    return  CSClassApiManager.csMethodGetInstance().csMethodMsgList<CSClassSystemMsg>(queryParameters: {"page":(csProPage+1).toString()},
        csProCallBack: CSClassHttpCallBack(csProOnSuccess: (result){
          csProMsgList.addAll(result.csProDataList);
          if(result.csProDataList.length>0){
            csProPage++;
            csProController!.finishLoad(success: true);
          }else{
            csProController!.finishLoad(noMore: true);
          }
          if(mounted){setState(() {});}
        },
            onError: (e){
              csProController!.finishLoad(success: false);

            },csProOnProgress: (v){},
        )
    );


  }
}