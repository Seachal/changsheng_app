import 'package:changshengh5/api/SPClassApiManager.dart';
import 'package:changshengh5/api/SPClassHttpCallBack.dart';
import 'package:changshengh5/app/SPClassApplicaion.dart';
import 'package:changshengh5/model/SPClassExpertIncome.dart';
import 'package:changshengh5/model/SPClassIncomeReport.dart';
import 'package:changshengh5/pages/common/SPClassNoDataView.dart';
import 'package:changshengh5/pages/dialogs/SPClassWithdrawIncomeTipDialog.dart';
import 'package:changshengh5/utils/SPClassCommonMethods.dart';
import 'package:changshengh5/utils/SPClassNavigatorUtils.dart';
import 'package:changshengh5/utils/SPClassStringUtils.dart';
import 'package:changshengh5/utils/SPClassToastUtils.dart';
import 'package:changshengh5/utils/colors.dart';
import 'package:changshengh5/widgets/SPClassBallFooter.dart';
import 'package:changshengh5/widgets/SPClassBallHeader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

import 'SPClassExpertIncomeDetailPage.dart';


class SPClassSchemeIncomeReportPage extends StatefulWidget{

  SPClassSchemeIncomeReportPage();
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SPClassSchemeIncomeReportPageState();
  }

}

class SPClassSchemeIncomeReportPageState extends State<SPClassSchemeIncomeReportPage> {
  EasyRefreshController ?spProRefreshController;
  int page=1;
  SPClassIncomeReport ?spProIncomeReport;

  List<SPClassExpertIncome> incomes=[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    spFunOnRefresh();
    spProRefreshController=EasyRefreshController();
    SPClassApplicaion.spProEventBus.on<String>().listen((event) {
      if(event=="refresh:myscheme"){
        spFunOnRefresh();
      }
    });



  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Container(
      color: Color(0xFFF1F1F1),
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
              decoration: BoxDecoration(
                  color: Colors.white,
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    height: width(52),
                    margin: EdgeInsets.only(left: width(15),right: width(15)),
                    decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(width: 1,color: Color(0xFFF2F2F2)))
                    ),
                    child: Row(
                      children: <Widget>[
                        SizedBox(width: 4,),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Text("我的收益",style:TextStyle(fontSize: sp(17),fontWeight: FontWeight.w500),),
                            ],
                          ),
                        ),

                        /*!spFunShowMore()?  GestureDetector(
                         child: Row(
                           children: <Widget>[
                             Text("订单明细",style: TextStyle(fontSize: sp(11),color:Color(0xFF888888) ),),
                             SPClassEncryptImage.asset(SPClassImageUtil.spFunGetImagePath("ic_btn_right"),
                               width: width(11),
                             ),
                           ],
                         ),
                         onTap: (){
                           SPClassNavigatorUtils.spFunPushRoute(context, SPClassExpertIncomeDetailPage(incomes));

                         },
                       ):SizedBox()*/

                      ],
                    ),
                  ),
                  SizedBox(height: width(8),),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: width(15)),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child:Container(
                            height: width(92),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(width(6)),
                                color: Color(0xFFF7F7F7),
                            ),
                            padding: EdgeInsets.only(left: width(12),right: width(12)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Expanded(child: Text("累计收益",style: TextStyle(fontSize: sp(11)),)),
                                    GestureDetector(
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(width(9)),
                                              color: Colors.white
                                          ),
                                          width: width(38),
                                          height: width(17),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: <Widget>[
                                              Text("明细",style: TextStyle(fontSize: sp(12),color: MyColors.main1),),
                                            ],
                                          ),
                                        ),
                                        onTap: (){
                                          SPClassNavigatorUtils.spFunPushRoute(context, SPClassExpertIncomeDetailPage(incomes));
                                        }
                                    ),
                                  ],
                                ),

                                SizedBox(height: width(18),),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    Text("￥",style: TextStyle(height: 3,fontSize: sp(13),color: Color(0xFFDE3C31),fontWeight: FontWeight.bold),),
                                    Text(spProIncomeReport==null? "0.00":spProIncomeReport!.spProPaidIncome!,style: TextStyle(fontSize: sp(31),color: Color(0xFFDE3C31),fontWeight: FontWeight.bold),),

                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: width(12),),
                        Expanded(
                          child:Container(
                            height: width(92),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(width(6)),
                              color: Color(0xFFF7F7F7),
                            ),
                            padding: EdgeInsets.only(left: width(12),right: width(12)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Expanded(child: Text("待提现金额",style: TextStyle(fontSize: sp(11)),)),
                                    GestureDetector(
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(width(9)),
                                            color: Colors.white
                                          ),
                                          width: width(38),
                                          height: width(17),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: <Widget>[
                                              Text("提现",style: TextStyle(fontSize: sp(12),color: MyColors.main1),),
                                            ],
                                          ),
                                        ),
                                        onTap: (){
                                          if( (spProIncomeReport==null||double.parse(spProIncomeReport!.spProUnpaidIncome!)<=0)){
                                            SPClassToastUtils.spFunShowToast(msg: "暂无可提现金额");
                                            return;
                                          }
                                          SPClassApiManager.spFunGetInstance().spFunWithdrawIncome(context: context,spProCallBack: SPClassHttpCallBack(
                                              spProOnSuccess: (result){
                                                showDialog(context: context, builder: (BuildContext context) {
                                                  return SPClassWithdrawIncomeTipDialog();
                                                });
                                                spFunOnRefresh();
                                              }
                                          ));
                                        }
                                    ),

                                  ],
                                ),
                                SizedBox(height: width(18),),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text("￥",style: TextStyle(height: 3,fontSize: sp(13),color: Color(0xFFDE3C31),fontWeight: FontWeight.bold),),
                                    Text(spProIncomeReport==null? "0.00":spProIncomeReport!.spProUnpaidIncome!,style: TextStyle(fontSize: sp(31),color: Color(0xFFDE3C31),fontWeight: FontWeight.bold),),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: width(15),),
                ],

              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Container(
              color: Colors.white,
              margin: EdgeInsets.only(bottom: height(8),top: width(8)),
              child: Column(
                children: <Widget>[
                  SizedBox(height: width(13),),
                  Container(
                    height: width(25),
                    padding: EdgeInsets.only(left: width(15),right: width(15)),
                    color: Color(0xFFF2F2F2),
                    child: Row(
                      children: <Widget>[
                         Expanded(
                           child: Center(
                             child: Text("结算周期",style: TextStyle(fontSize: sp(12),color: MyColors.grey_99),),
                           ),
                         ),
                        Container(
                          width: width(40),
                          child: Center(
                            child: Text("发布数",style: TextStyle(fontSize: sp(12),color: MyColors.grey_99),),
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: Text("购买金额",style: TextStyle(fontSize: sp(12),color: MyColors.grey_99),),
                          ),
                        ),

                        Expanded(
                          child: Center(
                            child: Text("分成比例",style: TextStyle(fontSize: sp(12),color: MyColors.grey_99),),
                          ),
                        ),



                        Expanded(
                          child: Center(
                            child: Text("周收益",style: TextStyle(fontSize: sp(12),color: MyColors.grey_99),),
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: Text("结算状态",style: TextStyle(fontSize: sp(12),color: MyColors.grey_99),),
                          ),
                        ),
                      ],
                    ),
                  ),

                  incomes.isEmpty?SPClassNoDataView(height: width(250),):SizedBox(),

                  ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      itemCount: incomes.length,
                      itemBuilder: (c,index){
                        var item=incomes[index];
                        return GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          child: Container(
                            height: width(42),
                            margin: EdgeInsets.only(left: width(15),right: width(15),),
                            decoration: BoxDecoration(
                                border: Border(bottom: BorderSide(width: 0.4,color: Colors.grey[300]!))
                            ),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Center(
                                    child: Text(item.spProStDate!+"\n"+item.spProEdDate!,style: TextStyle(fontSize: sp(10),color: MyColors.grey_99),),
                                  ),
                                ),
                                Container(
                                  width: width(40),
                                  child: Center(
                                    child: Text(item.spProSchemeNum!,style: TextStyle(fontSize: sp(10)),),
                                  ),
                                ),

                                Expanded(
                                  child: Center(
                                    child: Text("￥ "+item.spProSchemeAllDiamond!,style: TextStyle(fontSize: sp(10)),),
                                  ),
                                ),

                                Expanded(
                                  child: Center(
                                    child: Text((double.parse(item.proportion!)*100).toStringAsFixed(2)+"%",style: TextStyle(fontSize: sp(10)),),
                                  ),
                                ),

                                Expanded(
                                  child: Center(
                                    child: Text("￥"+SPClassStringUtils.spFunSqlitZero(item.income!),style: TextStyle(fontSize: sp(10),color:  Color(0xFFDE3C31)),),
                                  ),
                                ),
                                Expanded(
                                  child: Center(
                                    child: Text(spFunGetStatusText(item.status!),style: TextStyle(fontSize: sp(10),
                                        color:getStatusColor(item.status!)),),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          onTap: (){
                            if(spFunShowMore()){
                              SPClassNavigatorUtils.spFunPushRoute(context, SPClassExpertIncomeDetailPage(incomes,spProDayIndex: index,));
                            }

                          },
                        );
                      }),
                  SizedBox(height: width(12),),


                ],

              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void>  spFunOnRefresh() async {
    page=1;
    SPClassApiManager.spFunGetInstance().spFunIncomeReport(queryParameters: {},spProCallBack: SPClassHttpCallBack(
        spProOnSuccess: (result){
          spProRefreshController?.finishRefresh(noMore: false,success: true);
          spProRefreshController?.resetLoadState();
         setState(() {
           spProIncomeReport=result;
         });
        },
        onError: (value){
          spProRefreshController?.finishRefresh(success: false);
        },spProOnProgress: (v){}
    ));
    return  SPClassApiManager.spFunGetInstance().spFunIncomeList<SPClassExpertIncome>(queryParameters: {"page":page.toString()},spProCallBack: SPClassHttpCallBack(
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
    await  SPClassApiManager.spFunGetInstance().spFunIncomeList<SPClassExpertIncome>(queryParameters: {"page":(page+1).toString(),},spProCallBack: SPClassHttpCallBack(
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

    if(status=="0"){
       return "未提现";
     }
    if(status=="1"){
      return "待结算";
    }
    if(status=="2"){
      return "已结算";
    }
    return status;
  }
  Color getStatusColor(String status) {

    if(status=="0"){
      return Colors.green;
    }
    if(status=="1"){
      return Colors.green;
    }
    return Colors.black;
  }
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  spFunShowMore() {
    if(SPClassApplicaion.spProUserLoginInfo?.spProExpertType=="outer_expert"&&incomes.length>0){

      return true ;
    }
    return false;
  }



}