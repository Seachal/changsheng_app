import 'package:changshengh5/api/SPClassApiManager.dart';
import 'package:changshengh5/api/SPClassHttpCallBack.dart';
import 'package:changshengh5/model/SPClassExpertIncome.dart';
import 'package:changshengh5/model/SPClassExpertIncomeDetail.dart';
import 'package:changshengh5/pages/common/SPClassNoDataView.dart';
import 'package:changshengh5/utils/SPClassCommonMethods.dart';
import 'package:changshengh5/utils/SPClassDateUtils.dart';
import 'package:changshengh5/utils/SPClassImageUtil.dart';
import 'package:changshengh5/utils/SPClassStringUtils.dart';
import 'package:changshengh5/widgets/SPClassBallFooter.dart';
import 'package:changshengh5/widgets/SPClassBallHeader.dart';
import 'package:changshengh5/widgets/SPClassToolBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class SPClassExpertIncomeDetailPage extends StatefulWidget{
  List<SPClassExpertIncome> spProDayList=[];
  int spProDayIndex;
  SPClassExpertIncomeDetailPage(this.spProDayList,{this.spProDayIndex:0});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SPClassExpertIncomeDetailPageState();
  }

}

class SPClassExpertIncomeDetailPageState extends State<SPClassExpertIncomeDetailPage>{
  var index=0;
  EasyRefreshController ?spProRefreshController;
  int page=1;

  List<SPClassExpertIncomeDetail> incomes=[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    spFunOnRefresh();
    index=widget.spProDayIndex;
    spProRefreshController=EasyRefreshController();



  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: SPClassToolBar(
        context,
        title:"订单明细",
      ),
      body: Container(
        color: Color(0xFFF2F2F2),
        child: EasyRefresh.custom(
          controller:spProRefreshController ,
          header: SPClassBallHeader(
              textColor: Color(0xFF666666)
          ),
          footer: SPClassBallFooter(
              textColor: Color(0xFF666666)
          ),
          onRefresh: spFunOnRefresh,
          onLoad: spFunOnMore,
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

                    incomes.length==0?SPClassNoDataView(height: width(250),):SizedBox(),
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
                                      SPClassDateUtils.spFunDateFormatByString(item.spProStTime!, "MM-dd")
                                      ,style: TextStyle(fontSize: sp(10)),),
                                  ),
                                ),
                                Expanded(
                                  child: Center(
                                    child: Text(
                                          item.spProLeagueName!.toLowerCase()+"\n"+
                                          (SPClassStringUtils.spFunMaxLength(item.spProTeamOne!,length: 3)+"vs"+SPClassStringUtils.spFunMaxLength(item.spProTeamTwo!,length: 3))
                                      ,style: TextStyle(fontSize: sp(10)),textAlign: TextAlign.center,),
                                  ),
                                ),
                                Container(
                                  width: width(30),
                                  child: Center(
                                    child:(item.spProVerifyStatus =="-1")?
                                    Image.asset(
                                      SPClassImageUtil.spFunGetImagePath("ic_scheme_exption",),
                                      width: width(19),):
                                    Container(
                                      padding: EdgeInsets.symmetric(vertical:width(3)),
                                      width: width(19),
                                      decoration: BoxDecoration(
                                        color:item.spProIsWin=="-1"?   null:(item.spProIsWin=="1" ?Color(0xFFDE3C31):(item.spProIsWin=="2" ?Colors.green:Colors.grey)),
                                        borderRadius: BorderRadius.circular(width(5))
                                      ),
                                      alignment: Alignment.center,
                                      child: Text(spFunGetWinText(item.spProIsWin!),style: TextStyle(color:item.spProIsWin=="-1"?   Colors.black:Colors.white,fontSize: sp(10),
                                          fontWeight: item.spProIsWin=="-1"? FontWeight.bold:null),),
                                    ),
                                  ),
                                ),



                                Container(
                                  width: width(45),
                                  child: Center(
                                    child: Text(SPClassStringUtils.spFunSqlitZero(item.spProDiamond!)+" 钻石",style: TextStyle(fontSize: sp(10)),),
                                  ),
                                ),

                                Container(
                                  width: width(35),
                                  child: Center(
                                    child: Text((item.spProCanReturn=="1"? "是":"否"),style: TextStyle(fontSize: sp(10)),),
                                  ),
                                ),

                                Container(
                                  width: width(40),
                                  child: Center(
                                    child: Text((double.tryParse(item.spProExpertIncome!)!>0? "+":"")+SPClassStringUtils.spFunSqlitZero(item.spProExpertIncome!),style: TextStyle(fontSize: sp(10),color: Colors.red),),
                                  ),
                                ),

                                Container(
                                  width: width(45),
                                  child: Center(
                                    child: Text(spFunGetStatusText(item.status!),style: TextStyle(fontSize: sp(10),color: spFunGetStatusColor(item.status!)),),
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

  Future<void>  spFunOnRefresh() async {
    page=1;

    return  SPClassApiManager.spFunGetInstance().spFunSchemeOrderList<SPClassExpertIncomeDetail>(queryParameters: {"page":page.toString(),/*"income_st_date":widget.spProDayList[index].spProStDate*/},spProCallBack: SPClassHttpCallBack(
        spProOnSuccess: (result){
          spProRefreshController?.finishRefresh(noMore: false,success: true);
          spProRefreshController?.resetLoadState();
          setState(() {
            incomes=result.spProDataList;
          });
        },
        onError: (value){
          spProRefreshController?.finishRefresh(success: false);
        },spProOnProgress: (v){}
    ));
  }
  Future<void>  spFunOnMore() async {
    await  SPClassApiManager.spFunGetInstance().spFunSchemeOrderList<SPClassExpertIncomeDetail>(queryParameters: {"page":(page+1).toString(),/*"income_st_date":widget.spProDayList[index].spProStDate*/},spProCallBack: SPClassHttpCallBack(
        spProOnSuccess: (list){
          if(list.spProDataList.length==0){
            spProRefreshController?.finishLoad(noMore: true);
          }else{
            page++;
            spProRefreshController?.finishLoad(noMore: false);

          }

          if(mounted){
            setState(() {
              incomes.addAll(list.spProDataList);
            });
          }
        },
        onError: (value){
          spProRefreshController?.finishLoad(success: false);

        },spProOnProgress: (v){}
    ));

  }

  String spFunGetStatusText(String status) {

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

  Color spFunGetStatusColor(String status) {

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

  String spFunGetWinText(String spProIsWin) {
   // _win：1为结果未知，0表示输 1表示赢 2表示平局
    if(spProIsWin=="-1"){
      return "--";
    }
    if(spProIsWin=="0"){
      return "黑";
    }
    if(spProIsWin=="1"){
      return "红";
    }
    if(spProIsWin=="2"){
      return "走";
    }
    return "";

  }


}