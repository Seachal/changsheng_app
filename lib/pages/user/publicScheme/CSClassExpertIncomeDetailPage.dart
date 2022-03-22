import 'package:changshengh5/api/CSClassApiManager.dart';
import 'package:changshengh5/api/CSClassHttpCallBack.dart';
import 'package:changshengh5/model/CSClassExpertIncome.dart';
import 'package:changshengh5/model/CSClassExpertIncomeDetail.dart';
import 'package:changshengh5/pages/common/CSClassNoDataView.dart';
import 'package:changshengh5/utils/CSClassCommonMethods.dart';
import 'package:changshengh5/utils/CSClassDateUtils.dart';
import 'package:changshengh5/utils/CSClassImageUtil.dart';
import 'package:changshengh5/utils/CSClassStringUtils.dart';
import 'package:changshengh5/widgets/CSClassBallFooter.dart';
import 'package:changshengh5/widgets/CSClassBallHeader.dart';
import 'package:changshengh5/widgets/CSClassToolBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class CSClassExpertIncomeDetailPage extends StatefulWidget{
  List<CSClassExpertIncome> csProDayList=[];
  int csProDayIndex;
  CSClassExpertIncomeDetailPage(this.csProDayList,{this.csProDayIndex:0});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CSClassExpertIncomeDetailPageState();
  }

}

class CSClassExpertIncomeDetailPageState extends State<CSClassExpertIncomeDetailPage>{
  var index=0;
  EasyRefreshController ?csProRefreshController;
  int page=1;

  List<CSClassExpertIncomeDetail> incomes=[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    csMethodOnRefresh();
    index=widget.csProDayIndex;
    csProRefreshController=EasyRefreshController();



  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: CSClassToolBar(
        context,
        title:"订单明细",
      ),
      body: Container(
        color: Color(0xFFF2F2F2),
        child: EasyRefresh.custom(
          controller:csProRefreshController ,
          header: CSClassBallHeader(
              textColor: Color(0xFF666666)
          ),
          footer: CSClassBallFooter(
              textColor: Color(0xFF666666)
          ),
          onRefresh: csMethodOnRefresh,
          onLoad: csMethodOnMore,
          slivers: <Widget>[
            

            SliverToBoxAdapter(
              child: Container(
                color: Colors.white,
                margin: EdgeInsets.only(bottom: width(6)),
                padding: EdgeInsets.symmetric(horizontal: width(15),vertical: width(12)),
                child: Row(
                  children: <Widget>[
                    Text('累计收入',style: TextStyle(fontSize: sp(15),color: Color(0xFF333333)),),
                    Expanded(
                      child: SizedBox(),
                    ),
                    Text("￥",style: TextStyle(height: 3,fontSize: sp(13),color: Color(0xFFDE3C31),fontWeight: FontWeight.bold),),
                    Text("0.00",style: TextStyle(fontSize: sp(23),color: Color(0xFFDE3C31),),),
                  ],
                ),
              ),
            ),

            SliverToBoxAdapter(
              child: Container(
                padding: EdgeInsets.only(top: width(15)),
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    Container(
                      height: width(25),
                      padding: EdgeInsets.only(left: width(13),right: width(13)),
                      decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(width: 0.4,color: Colors.grey[300]!)),
                        color: Color(0xFFF2F2F2),

                      ),
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: width(30),
                            child: Center(
                              child: Text("时间",style: TextStyle(fontSize: sp(12)),),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: Text("场次",style: TextStyle(fontSize: sp(12)),),
                            ),
                          ),
                          Container(
                            width: width(30),
                            child: Center(
                              child: Text("赛果",style: TextStyle(fontSize: sp(12)),),
                            ),
                          ),


                          Container(
                            width: width(45),
                            child: Center(
                              child: Text("价格",style: TextStyle(fontSize: sp(12)),),
                            ),
                          ),
                          Container(
                            width: width(50),
                            child: Center(
                              child: Text("不中退",style: TextStyle(fontSize: sp(12)),),
                            ),
                          ),
                          Container(
                            width: width(40),
                            child: Center(
                              child: Text("收益",style: TextStyle(fontSize: sp(12)),),
                            ),
                          ),
                          Container(
                            width: width(50),
                            child: Center(
                              child: Text("场次状态",style: TextStyle(fontSize: sp(12)),),
                            ),
                          ),

                        ],
                      ),
                    ),

                    incomes.length==0?CSClassNoDataView(height: width(250),):SizedBox(),
                    ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        itemCount: incomes.length,
                        itemBuilder: (c,index){
                          var item=incomes[index];
                          return   Container(
                            padding: EdgeInsets.symmetric(horizontal: width(13),vertical: width(5)),
                            decoration: BoxDecoration(
                                border: Border(bottom: BorderSide(width: 0.4,color: Colors.grey[300]!))
                            ),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  width: width(30),
                                  child: Center(
                                    child: Text(
                                      CSClassDateUtils.csMethodDateFormatByString(item.csProStTime!, "MM-dd")
                                      ,style: TextStyle(fontSize: sp(10)),),
                                  ),
                                ),
                                Expanded(
                                  child: Center(
                                    child: Text(
                                          item.csProLeagueName!.toLowerCase()+"\n"+
                                          (CSClassStringUtils.csMethodMaxLength(item.csProTeamOne!,length: 3)+"vs"+CSClassStringUtils.csMethodMaxLength(item.csProTeamTwo!,length: 3))
                                      ,style: TextStyle(fontSize: sp(10)),textAlign: TextAlign.center,),
                                  ),
                                ),
                                Container(
                                  width: width(30),
                                  child: Center(
                                    child:(item.csProVerifyStatus =="-1")?
                                    Image.asset(
                                      CSClassImageUtil.csMethodGetImagePath("ic_scheme_exption",),
                                      width: width(19),):
                                    Container(
                                      padding: EdgeInsets.symmetric(vertical:width(3)),
                                      width: width(19),
                                      decoration: BoxDecoration(
                                        color:item.csProIsWin=="-1"?   null:(item.csProIsWin=="1" ?Color(0xFFDE3C31):(item.csProIsWin=="2" ?Colors.green:Colors.grey)),
                                        borderRadius: BorderRadius.circular(width(5))
                                      ),
                                      alignment: Alignment.center,
                                      child: Text(csMethodGetWinText(item.csProIsWin!),style: TextStyle(color:item.csProIsWin=="-1"?   Colors.black:Colors.white,fontSize: sp(10),
                                          fontWeight: item.csProIsWin=="-1"? FontWeight.bold:null),),
                                    ),
                                  ),
                                ),



                                Container(
                                  width: width(45),
                                  child: Center(
                                    child: Text(CSClassStringUtils.csMethodSqlitZero(item.csProDiamond!)+" 钻石",style: TextStyle(fontSize: sp(10)),),
                                  ),
                                ),

                                Container(
                                  width: width(35),
                                  child: Center(
                                    child: Text((item.csProCanReturn=="1"? "是":"否"),style: TextStyle(fontSize: sp(10)),),
                                  ),
                                ),

                                Container(
                                  width: width(40),
                                  child: Center(
                                    child: Text((double.tryParse(item.csProExpertIncome!)!>0? "+":"")+CSClassStringUtils.csMethodSqlitZero(item.csProExpertIncome!),style: TextStyle(fontSize: sp(10),color: Colors.red),),
                                  ),
                                ),

                                Container(
                                  width: width(45),
                                  child: Center(
                                    child: Text(csMethodGetStatusText(item.status!),style: TextStyle(fontSize: sp(10),color: csMethodGetStatusColor(item.status!)),),
                                  ),
                                ),

                              ],
                            ),
                          );
                        }),
                    SizedBox(height: width(12),),


                  ],

                ),
              ),
            ),
          ],
        ),
      ),
    );

  }

  Future<void>  csMethodOnRefresh() async {
    page=1;

    return  CSClassApiManager.csMethodGetInstance().csMethodSchemeOrderList<CSClassExpertIncomeDetail>(queryParameters: {"page":page.toString(),/*"income_st_date":widget.csProDayList[index].csProStDate*/},csProCallBack: CSClassHttpCallBack(
        csProOnSuccess: (result){
          csProRefreshController?.finishRefresh(noMore: false,success: true);
          csProRefreshController?.resetLoadState();
          setState(() {
            incomes=result.csProDataList;
          });
        },
        onError: (value){
          csProRefreshController?.finishRefresh(success: false);
        },csProOnProgress: (v){}
    ));
  }
  Future<void>  csMethodOnMore() async {
    await  CSClassApiManager.csMethodGetInstance().csMethodSchemeOrderList<CSClassExpertIncomeDetail>(queryParameters: {"page":(page+1).toString(),/*"income_st_date":widget.csProDayList[index].csProStDate*/},csProCallBack: CSClassHttpCallBack(
        csProOnSuccess: (list){
          if(list.csProDataList.length==0){
            csProRefreshController?.finishLoad(noMore: true);
          }else{
            page++;
            csProRefreshController?.finishLoad(noMore: false);

          }

          if(mounted){
            setState(() {
              incomes.addAll(list.csProDataList);
            });
          }
        },
        onError: (value){
          csProRefreshController?.finishLoad(success: false);

        },csProOnProgress: (v){}
    ));

  }

  String csMethodGetStatusText(String status) {

    if(status=="not_started"){
      return "未开始";
    }
    if(status=="in_progress"){
      return "进行中";
    }
    if(status=="abnormal"){
      return "异常";
    }
    if(status=="over"){
      return "已结束";
    }
    return status;
  }

  Color csMethodGetStatusColor(String status) {

    if(status=="not_started"){
      return  Colors.grey;
    }
    if(status=="in_progress"){
      return Colors.green;
    }
    if(status=="abnormal"){
      return Colors.red;
    }
    if(status=="over"){
      return Colors.black;
    }
    return Colors.black;
  }

  String csMethodGetWinText(String csProIsWin) {
   // _win：1为结果未知，0表示输 1表示赢 2表示平局
    if(csProIsWin=="-1"){
      return "--";
    }
    if(csProIsWin=="0"){
      return "黑";
    }
    if(csProIsWin=="1"){
      return "红";
    }
    if(csProIsWin=="2"){
      return "走";
    }
    return "";

  }


}