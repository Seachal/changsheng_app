import 'package:changshengh5/api/CSClassApiManager.dart';
import 'package:changshengh5/api/CSClassHttpCallBack.dart';
import 'package:changshengh5/model/CSClassSchemeListEntity.dart';
import 'package:changshengh5/pages/common/CSClassNoDataView.dart';
import 'package:changshengh5/pages/home/CSClassSchemeItemView.dart';
import 'package:changshengh5/utils/CSClassCommonMethods.dart';
import 'package:changshengh5/utils/CSClassDateUtils.dart';
import 'package:changshengh5/utils/CSClassImageUtil.dart';
import 'package:changshengh5/widgets/CSClassBallFooter.dart';
import 'package:changshengh5/widgets/CSClassBallHeader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';


class CSClassBuySchemeListPage extends StatefulWidget{
   String csProIsOver;

   CSClassBuySchemeListPage(this.csProIsOver);
   @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CSClassBuySchemeListPageState();
  }

}

class CSClassBuySchemeListPageState extends State<CSClassBuySchemeListPage>{
  List<CSClassSchemeListSchemeList> csProSchemeList=[];//全部
  EasyRefreshController ?csProRefreshController;
  int csProItemIndex=0;
  int page=1;
  var csProItemBeginValues=[""];
  var csProNowDate;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    csProRefreshController=EasyRefreshController();
    csProNowDate=CSClassDateUtils.dateFormatByDate(DateTime.now(), "yyyy-MM-dd");
    csProItemBeginValues.clear();
    csProItemBeginValues.add(CSClassDateUtils.dateFormatByDate(DateTime.now(), "yyyy-MM-dd"));
    csProItemBeginValues.add(CSClassDateUtils.dateFormatByDate(DateTime.now().subtract(new Duration(days: 1)), "yyyy-MM-dd"));
    csProItemBeginValues.add(CSClassDateUtils.dateFormatByDate(DateTime.now().subtract(new Duration(days: 6)), "yyyy-MM-dd"));


  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: <Widget>[
        Expanded(
          child: Container(
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
              emptyWidget:csProSchemeList.length==0?  CSClassNoDataView():null,
              onRefresh: csMethodOnRefresh,
              onLoad: csMethodOnMore,
              slivers: <Widget>[

                SliverToBoxAdapter(
                  child: Container(
                    margin: EdgeInsets.only(left: width(10),right: width(10),bottom: width(10)),
                    padding: EdgeInsets.only(top: width(5),bottom: width(5)),
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
                          return Stack(
                            children: <Widget>[
                              CSClassSchemeItemView(schemeItem,csProShowRate: false,),
                              Positioned(
                                top: 10,
                                right:  width(13) ,
                                child: Image.asset(
                                  (schemeItem.csProIsWin=="1")? CSClassImageUtil.csMethodGetImagePath("cs_result_red"):
                                  (schemeItem.csProIsWin=="0")? CSClassImageUtil.csMethodGetImagePath("cs_result_hei"):
                                  (schemeItem.csProIsWin=="2")? CSClassImageUtil.csMethodGetImagePath("cs_result_zou"):"",
                                  width: width(40),
                                ),
                              ),
                            ],
                          );
                        }),
                  ),
                ),

              ],
            ),
          ),
        )
      ],
    );
  }

  Future<void>  csMethodOnRefresh() async {
    page=1;
    var queryParameters;
    if(widget.csProIsOver=="1"&&csProItemIndex<3){
      queryParameters={"fetch_type":"my_bought","is_over":widget.csProIsOver,"page":page.toString(),"ed_date": csProNowDate, "st_date":csProItemBeginValues[csProItemIndex]};
    }else{
      queryParameters={"fetch_type":"my_bought","is_over":widget.csProIsOver,"page":page.toString(),};
    }
    return  CSClassApiManager.csMethodGetInstance().csMethodSchemeList(queryParameters: queryParameters,csProCallBack: CSClassHttpCallBack<CSClassSchemeListEntity>(
        csProOnSuccess: (list){
          csProRefreshController!.finishRefresh(noMore: false,success: true);
          csProRefreshController!.resetLoadState();
          if(mounted){
            setState(() {
              csProSchemeList=list.csProSchemeList!;
            });
          }
        },
        onError: (value){
          csProRefreshController!.finishRefresh(success: false);
        },csProOnProgress: (v){},
    ));
  }

  Future<void>  csMethodOnMore() async {
    var  queryParameters;
    if(widget.csProIsOver=="1"&&csProItemIndex<3){
      queryParameters={"fetch_type":"my_bought","is_over":widget.csProIsOver,"page":(page+1).toString(),"ed_date": csProNowDate, "st_date":csProItemBeginValues[csProItemIndex]};
    }else{
      queryParameters={"fetch_type":"my_bought","is_over":widget.csProIsOver,"page":(page+1).toString(),};
    }
    await  CSClassApiManager.csMethodGetInstance().csMethodSchemeList(queryParameters: queryParameters,csProCallBack: CSClassHttpCallBack<CSClassSchemeListEntity>(
        csProOnSuccess: (list){
          if(list.csProSchemeList!.length==0){
            csProRefreshController!.finishLoad(noMore: true);
          }else{
            page++;
            csProRefreshController!.finishLoad(noMore: false);

          }

          if(mounted){
            setState(() {
              csProSchemeList.addAll(list.csProSchemeList!);
            });
          }
        },
        onError: (value){
          csProRefreshController!.finishLoad(success: false);

        }
    ));

  }



}