import 'package:changshengh5/api/CSClassApiManager.dart';
import 'package:changshengh5/api/CSClassHttpCallBack.dart';
import 'package:changshengh5/model/CSClassGuessMatchInfo.dart';
import 'package:changshengh5/model/CSClassSchemeListEntity.dart';
import 'package:changshengh5/pages/common/CSClassNoDataView.dart';
import 'package:changshengh5/pages/home/CSClassSchemeItemView.dart';
import 'package:changshengh5/utils/CSClassCommonMethods.dart';
import 'package:changshengh5/widgets/CSClassBallFooter.dart';
import 'package:changshengh5/widgets/CSClassBallHeader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';


class CSClassMatchDetailSchemeListPage extends StatefulWidget{
  CSClassGuessMatchInfo csProGuessInfo;

  CSClassMatchDetailSchemeListPage(this.csProGuessInfo);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CSClassMatchDetailSchemeListPageState();
  }

}

class CSClassMatchDetailSchemeListPageState extends State<CSClassMatchDetailSchemeListPage>{
  int page=1;
  EasyRefreshController ?controller;
  List<CSClassSchemeListSchemeList> csProSchemeList=[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    controller=EasyRefreshController();
    csMethodOnRefresh();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow:[
            BoxShadow(
              offset: Offset(2,5),
              color: Color(0x0C000000),
              blurRadius:width(6,),),
            BoxShadow(
              offset: Offset(-5,1),
              color: Color(0x0C000000),
              blurRadius:width(6,),
            )
          ],
          borderRadius: BorderRadius.circular(width(7))
      ),
      // margin: EdgeInsets.only(left: width(10),right: width(10),top: width(7)),
      child: EasyRefresh.custom(
        controller: controller,
        onRefresh: csMethodOnRefresh,
        onLoad: csMethodOnMore,
        header: CSClassBallHeader(
            textColor: Color(0xFF666666)
        ),
        footer: CSClassBallFooter(
            textColor: Color(0xFF666666)
        ),
        emptyWidget: csProSchemeList.isEmpty? CSClassNoDataView():null,
        slivers: <Widget>[
          SliverToBoxAdapter(child: SizedBox(height: height(5),),),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (context, index) {
                var schemeItem=csProSchemeList[index];
                return CSClassSchemeItemView(schemeItem);

              },
              childCount: csProSchemeList.length,
            ),
          ),
        ],
      ),

    );
  }

  Future<void>  csMethodOnRefresh() async{
    page=1;

    return  CSClassApiManager.csMethodGetInstance().csMethodSchemeList(queryParameters: {"guess_match_id":widget.csProGuessInfo.csProGuessMatchId,"page":page.toString(),"fetch_type":"guess_match"},csProCallBack: CSClassHttpCallBack(
        csProOnSuccess: (list){
          controller!.finishRefresh(success: true);
          controller!.resetLoadState();
          if(mounted){
            setState(() {
              csProSchemeList=list.csProSchemeList!;
            });
          }
        },
        onError: (value){
          controller!.finishRefresh(success: false);
        },csProOnProgress: (v){}
    ));

  }

  Future<void>  csMethodOnMore() async {
    await  CSClassApiManager.csMethodGetInstance().csMethodSchemeList(queryParameters: {"guess_match_id":widget.csProGuessInfo.csProGuessMatchId,"page":(page+1).toString(),"fetch_type":"guess_match"},csProCallBack: CSClassHttpCallBack(
        csProOnSuccess: (list){

          if(list.csProSchemeList!.isEmpty){
            controller!.finishLoad(noMore: true);
          }else{
            page++;
            controller!.finishLoad(success: true);

          }
          if(mounted){
            setState(() {
              csProSchemeList.addAll(list.csProSchemeList!);
            });
          }
        },
        onError: (value){
          controller!.finishLoad(success: false);
        },csProOnProgress: (v){}
    ));
  }

}