import 'dart:convert';

import 'package:changshengh5/api/CSClassApiManager.dart';
import 'package:changshengh5/api/CSClassHttpCallBack.dart';
import 'package:changshengh5/app/CSClassApplicaion.dart';
import 'package:changshengh5/model/CSClassBaseModelEntity.dart';
import 'package:changshengh5/model/CSClassSchemeListEntity.dart';
import 'package:changshengh5/pages/common/CSClassNoDataView.dart';
import 'package:changshengh5/pages/home/CSClassSchemeItemView.dart';
import 'package:changshengh5/utils/CSClassCommonMethods.dart';
import 'package:changshengh5/utils/CSClassImageUtil.dart';
import 'package:changshengh5/utils/CSClassToastUtils.dart';
import 'package:changshengh5/utils/colors.dart';
import 'package:changshengh5/widgets/CSClassBallFooter.dart';
import 'package:changshengh5/widgets/CSClassBallHeader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';



class CSClassFollowSchemeListPage extends StatefulWidget{
   String csProIsOver;
   CSClassFollowSchemeListPageState ?csProState;
   CSClassFollowSchemeListPage(this.csProIsOver);
   @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return csProState= CSClassFollowSchemeListPageState();
  }

}

class CSClassFollowSchemeListPageState extends State<CSClassFollowSchemeListPage>{
  List<CSClassSchemeListSchemeList> csProSchemeList= [];//全部
  late EasyRefreshController csProRefreshController;
  late int page;
  bool csProShowEdit=false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    csProRefreshController=EasyRefreshController();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      color: Colors.white,
      child: EasyRefresh.custom(
        firstRefresh: true,
        controller:csProRefreshController ,
        header: CSClassBallHeader(
            textColor: Color(0xFF666666)
        ),
        footer: CSClassBallFooter(
            textColor: Color(0xFF666666)
        ),
        emptyWidget: csProSchemeList.length==0 ?CSClassNoDataView(content: '暂无方案',):null,
        onRefresh: csMethodOnRefresh,
        onLoad: csMethodOnMore,
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(width(7))
              ),
              child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: csProSchemeList.length,
                  itemBuilder: (c,index){
                    var schemeItem=csProSchemeList[index];
                    return Container(
                      child: Row(
                        children: <Widget>[
                          GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            child:!csProShowEdit? SizedBox(): Row(
                              children: <Widget>[
                                SizedBox(width: width(10),),
                                Image.asset(CSClassImageUtil.csMethodGetImagePath("ic_check_box"), width: width(18),color:schemeItem.check?  MyColors.main1: Color(0xFFCCCCCC)),
                                SizedBox(width: width(5),),
                              ],
                            ),
                            onTap: (){
                              setState(() {schemeItem.check=!schemeItem.check;});
                            },
                          ),
                          Expanded(
                            child: CSClassSchemeItemView(schemeItem,csProShowProFit: false,),
                          )
                        ],
                      ),
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }

  Future<void>  csMethodOnRefresh() async {
    page=1;
    return  CSClassApiManager.csMethodGetInstance().csMethodSchemeList(queryParameters: {"fetch_type":"my_collected","is_over":widget.csProIsOver,"page":page.toString(),},csProCallBack: CSClassHttpCallBack<CSClassSchemeListEntity>(
        csProOnSuccess: (list){
          csProRefreshController.finishRefresh(noMore: false,success: true);
          csProRefreshController.resetLoadState();
          if(mounted){
            setState(() {
              csProSchemeList=list.csProSchemeList!;
            });
          }
        },
        onError: (value){
          csProRefreshController.finishRefresh(success: false);
        },csProOnProgress: (v){},
    ));
  }

  Future<void>  csMethodOnMore() async {
    await  CSClassApiManager.csMethodGetInstance().csMethodSchemeList(queryParameters: {"fetch_type":"my_collected","is_over":widget.csProIsOver, "page":(page+1).toString()},csProCallBack: CSClassHttpCallBack<CSClassSchemeListEntity>(
        csProOnSuccess: (list){

          if(list.csProSchemeList!.length==0){
            csProRefreshController.finishLoad(noMore: true);
          }else{
            page++;

          }
          if(mounted){
            setState(() {
              csProSchemeList.addAll(list.csProSchemeList!);
            });
          }
        },
        onError: (value){
          csProRefreshController.finishLoad(success: false);

        },csProOnProgress: (v){},
    ));

  }

  void csMethodShowEditList(bool show,{bool all:false}){
      csProSchemeList.forEach((item){
        item.check=all;
      });

     setState(() {
       csProShowEdit=show;
     });
  }

  Future<void> csMethodDeleteCollect(VoidCallback callback) async {
    List<String> schemesIds=[];
    csProSchemeList.forEach((item){
      if(item.check){
        schemesIds.add(item.csProSchemeId!);
      }
    });

    if(schemesIds.length==0){
      CSClassToastUtils.csMethodShowToast(msg: "请勾选方案");
      return;
    }
    var result= JsonEncoder().convert(schemesIds).replaceAll("[", "").replaceAll("]", "").replaceAll(",", ";").replaceAll("\"", "");

    CSClassApiManager.csMethodGetInstance().csMethodCancelCollect(context: context,queryParameters: {"target_id":result,"target_type":"scheme"},csProCallBack: CSClassHttpCallBack<CSClassBaseModelEntity>(
        csProOnSuccess: (result){
          csProRefreshController.callRefresh();
          setState(() {csProShowEdit=false;});
          callback();
        },
        onError: (reslut){
        },csProOnProgress: (v){},
    ));


  }



}