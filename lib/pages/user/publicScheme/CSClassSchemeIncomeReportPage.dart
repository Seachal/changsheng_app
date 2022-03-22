import 'package:changshengh5/api/CSClassApiManager.dart';
import 'package:changshengh5/api/CSClassHttpCallBack.dart';
import 'package:changshengh5/app/CSClassApplicaion.dart';
import 'package:changshengh5/model/CSClassExpertIncome.dart';
import 'package:changshengh5/model/CSClassIncomeReport.dart';
import 'package:changshengh5/pages/common/CSClassNoDataView.dart';
import 'package:changshengh5/pages/dialogs/CSClassWithdrawIncomeTipDialog.dart';
import 'package:changshengh5/utils/CSClassCommonMethods.dart';
import 'package:changshengh5/utils/CSClassNavigatorUtils.dart';
import 'package:changshengh5/utils/CSClassStringUtils.dart';
import 'package:changshengh5/utils/CSClassToastUtils.dart';
import 'package:changshengh5/utils/colors.dart';
import 'package:changshengh5/widgets/CSClassBallFooter.dart';
import 'package:changshengh5/widgets/CSClassBallHeader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

import 'CSClassExpertIncomeDetailPage.dart';


class CSClassSchemeIncomeReportPage extends StatefulWidget{

  CSClassSchemeIncomeReportPage();
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CSClassSchemeIncomeReportPageState();
  }

}

class CSClassSchemeIncomeReportPageState extends State<CSClassSchemeIncomeReportPage> {
  EasyRefreshController ?csProRefreshController;
  int page=1;
  CSClassIncomeReport ?csProIncomeReport;

  List<CSClassExpertIncome> incomes=[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    csMethodOnRefresh();
    csProRefreshController=EasyRefreshController();
    CSClassApplicaion.csProEventBus.on<String>().listen((event) {
      if(event=="refresh:myscheme"){
        csMethodOnRefresh();
      }
    });



  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Container(
      color: Color(0xFFF1F1F1),
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

                        /*!csMethodShowMore()?  GestureDetector(
                         child: Row(
                           children: <Widget>[
                             Text("订单明细",style: TextStyle(fontSize: sp(11),color:Color(0xFF888888) ),),
                             CSClassEncryptImage.asset(CSClassImageUtil.csMethodGetImagePath("ic_btn_right"),
                               width: width(11),
                             ),
                           ],
                         ),
                         onTap: (){
                           CSClassNavigatorUtils.csMethodPushRoute(context, CSClassExpertIncomeDetailPage(incomes));

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
                                          CSClassNavigatorUtils.csMethodPushRoute(context, CSClassExpertIncomeDetailPage(incomes));
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
                                    Text(csProIncomeReport==null? "0.00":csProIncomeReport!.csProPaidIncome!,style: TextStyle(fontSize: sp(31),color: Color(0xFFDE3C31),fontWeight: FontWeight.bold),),

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
                                          if( (csProIncomeReport==null||double.parse(csProIncomeReport!.csProUnpaidIncome!)<=0)){
                                            CSClassToastUtils.csMethodShowToast(msg: "暂无可提现金额");
                                            return;
                                          }
                                          CSClassApiManager.csMethodGetInstance().csMethodWithdrawIncome(context: context,csProCallBack: CSClassHttpCallBack(
                                              csProOnSuccess: (result){
                                                showDialog(context: context, builder: (BuildContext context) {
                                                  return CSClassWithdrawIncomeTipDialog();
                                                });
                                                csMethodOnRefresh();
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
                                    Text(csProIncomeReport==null? "0.00":csProIncomeReport!.csProUnpaidIncome!,style: TextStyle(fontSize: sp(31),color: Color(0xFFDE3C31),fontWeight: FontWeight.bold),),
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

                  incomes.isEmpty?CSClassNoDataView(height: width(250),):SizedBox(),

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
                                    child: Text(item.csProStDate!+"\n"+item.csProEdDate!,style: TextStyle(fontSize: sp(10),color: MyColors.grey_99),),
                                  ),
                                ),
                                Container(
                                  width: width(40),
                                  child: Center(
                                    child: Text(item.csProSchemeNum!,style: TextStyle(fontSize: sp(10)),),
                                  ),
                                ),

                                Expanded(
                                  child: Center(
                                    child: Text("￥ "+item.csProSchemeAllDiamond!,style: TextStyle(fontSize: sp(10)),),
                                  ),
                                ),

                                Expanded(
                                  child: Center(
                                    child: Text((double.parse(item.proportion!)*100).toStringAsFixed(2)+"%",style: TextStyle(fontSize: sp(10)),),
                                  ),
                                ),

                                Expanded(
                                  child: Center(
                                    child: Text("￥"+CSClassStringUtils.csMethodSqlitZero(item.income!),style: TextStyle(fontSize: sp(10),color:  Color(0xFFDE3C31)),),
                                  ),
                                ),
                                Expanded(
                                  child: Center(
                                    child: Text(csMethodGetStatusText(item.status!),style: TextStyle(fontSize: sp(10),
                                        color:getStatusColor(item.status!)),),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          onTap: (){
                            if(csMethodShowMore()){
                              CSClassNavigatorUtils.csMethodPushRoute(context, CSClassExpertIncomeDetailPage(incomes,csProDayIndex: index,));
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

  Future<void>  csMethodOnRefresh() async {
    page=1;
    CSClassApiManager.csMethodGetInstance().csMethodIncomeReport(queryParameters: {},csProCallBack: CSClassHttpCallBack(
        csProOnSuccess: (result){
          csProRefreshController?.finishRefresh(noMore: false,success: true);
          csProRefreshController?.resetLoadState();
         setState(() {
           csProIncomeReport=result;
         });
        },
        onError: (value){
          csProRefreshController?.finishRefresh(success: false);
        },csProOnProgress: (v){}
    ));
    return  CSClassApiManager.csMethodGetInstance().csMethodIncomeList<CSClassExpertIncome>(queryParameters: {"page":page.toString()},csProCallBack: CSClassHttpCallBack(
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
    await  CSClassApiManager.csMethodGetInstance().csMethodIncomeList<CSClassExpertIncome>(queryParameters: {"page":(page+1).toString(),},csProCallBack: CSClassHttpCallBack(
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

  csMethodShowMore() {
    if(CSClassApplicaion.csProUserLoginInfo?.csProExpertType=="outer_expert"&&incomes.length>0){

      return true ;
    }
    return false;
  }



}