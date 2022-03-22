
import 'package:changshengh5/api/CSClassApiManager.dart';
import 'package:changshengh5/api/CSClassHttpCallBack.dart';
import 'package:changshengh5/app/CSClassApplicaion.dart';
import 'package:changshengh5/model/CSClassExpertInfo.dart';
import 'package:changshengh5/model/CSClassSchemeListEntity.dart';
import 'package:changshengh5/pages/home/CSClassSchemeItemView.dart';
import 'package:changshengh5/utils/CSClassCommonMethods.dart';
import 'package:changshengh5/utils/CSClassImageUtil.dart';
import 'package:changshengh5/utils/CSClassLogUtils.dart';
import 'package:changshengh5/utils/CSClassMatchDataUtils.dart';
import 'package:changshengh5/utils/CSClassStringUtils.dart';
import 'package:changshengh5/utils/CSClassToastUtils.dart';
import 'package:changshengh5/utils/colors.dart';
import 'package:changshengh5/utils/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';



class CSClassExpertDetailPage extends StatefulWidget{
  CSClassExpertInfo ?info;
  bool ?csProIsStatics;
  CSClassExpertDetailPage(this.info,{this.csProIsStatics:true});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CSClassExpertDetailPageState();
  }

}

class CSClassExpertDetailPageState extends State<CSClassExpertDetailPage> with TickerProviderStateMixin{
  int page=1;
  List<CSClassSchemeListSchemeList> csProSchemeHistory=[];
  List<CSClassSchemeListSchemeList> csProSchemeList=[];
  List<CSClassChartData> csProChartData=[];
  List<int> ?csProDates;
  Container ?csProChartsCon;
  List tabBarList = ['全部',];
  TabController ?_controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.info!.csProExpertLeaguesRecent!.isNotEmpty){
      for (var e in widget.info!.csProExpertLeaguesRecent!) {
        tabBarList.add(e['league_name']);
      }
    }
    _controller = TabController(length:tabBarList.length,vsync: this);
    csMethodGetRecentReport();
    csMethodOnRefreshSelf();

    if(widget.csProIsStatics!){
      CSClassApiManager.csMethodGetInstance().csMethodLogAppEvent(csProEventName: "view_expert",targetId:widget.info!.csProUserId);
    }


    
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    ///
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Stack(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              child: Image.asset(
                CSClassImageUtil.csMethodGetImagePath("zhuanjiabg"),
              ),
            ),
            Column(
              children: <Widget>[
                appBarWidget(),
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          autoInfo(),
                          chartWidget(),
                          expertScheme(),
                          historyScheme(),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget appBarWidget(){
    return Container(
      margin:
      EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      child: Commons.getAppBar(
        title: '专家详情',
        appBarLeft: InkWell(
          child: Image.asset(
            CSClassImageUtil.csMethodGetImagePath("arrow_right"),
            width: width(23),
          ),
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
      ),
    );
  }

  Widget autoInfo(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        GestureDetector(
          onTap: () {
          },
          child: Container(
            margin: EdgeInsets.only(left: width(15),right: width(15),top: width(8)),
            child: Row(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    // border: Border.all(width: 2,color: Colors.white),
                    borderRadius:
                    BorderRadius.circular(width(150)),
                    color: Colors.white,
                  ),
                  padding: EdgeInsets.all(width(2)),
                  child: ClipOval(
                    child: (widget.info?.csProAvatarUrl ==
                        null ||
                        widget.info!.csProAvatarUrl!.isEmpty)
                        ? Image.asset(
                      CSClassImageUtil.csMethodGetImagePath(
                          "ic_default_avater"),
                      width: width(46),
                      height: width(46),
                    )
                        : Image.network(
                      widget.info!.csProAvatarUrl!,
                      width: width(46),
                      height: width(46),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: width(6)),
                    child: Column(
                      mainAxisAlignment:
                      MainAxisAlignment.start,
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          widget.info
                              ?.csProNickName??'',
                          style: TextStyle(
                              fontSize: sp(15),
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                          maxLines: 1,
                        ),
                        SizedBox(
                          height: width(4),
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              CSClassStringUtils.csMethodMaxLength(widget.info?.intro??'',
                                  length: 6),
                              style: TextStyle(
                                fontSize: sp(12),
                                color: Colors.white,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: width(9)),
                              color: Colors.white,
                              height: height(width(8)),
                              width: width(0.5),
                            ),
                            Text(
                              '粉丝：${ widget.info?.csProFollowerNum??0}',
                              style: TextStyle(
                                fontSize: sp(12),
                                color: Colors.white,
                              ),
                              maxLines: 1,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                // 关注
                GestureDetector(
                    child: Container(
                      width: width(61),
                      height: width(27),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color:  widget.info!.csProIsFollowing!?Colors.transparent:Colors.white,
                          borderRadius: BorderRadius.circular(150),
                          border: Border.all(width: width(1),color:  widget.info!.csProIsFollowing!?Color.fromRGBO(255, 255, 255, 0.6):Colors.transparent)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(widget.info!.csProIsFollowing!? Icons.check:Icons.add,color:  widget.info!.csProIsFollowing!?Color.fromRGBO(255, 255, 255, 0.6):MyColors.main1,size: width(12),),
                          Text(  widget.info!.csProIsFollowing!? "已关注":"关注",style: TextStyle(fontSize: sp(12),color: widget.info!.csProIsFollowing!? Color.fromRGBO(255, 255, 255, 0.6):MyColors.main1),),

                        ],
                      ),
                    ),
                    onTap: (){
                      if(csMethodIsLogin(context: context)){
                        CSClassApiManager.csMethodGetInstance().csMethodFollowExpert(isFollow: ! widget.info!.csProIsFollowing!,csProExpertUid:  widget.info!.csProUserId,context: context,csProCallBack: CSClassHttpCallBack(
                            csProOnSuccess: (result){
                              if(! widget.info!.csProIsFollowing!){
                                CSClassToastUtils.csMethodShowToast(msg: "关注成功");
                                widget.info!.csProIsFollowing=true;
                              }else{
                                widget.info!.csProIsFollowing=false;
                              }
                              if(mounted){
                                setState(() {});
                              }
                            },onError: (e){},csProOnProgress: (v){}
                        ));
                      }
                    }
                ),
              ],
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: width(15),right: width(15),top: width(12),bottom: width(12)),
          child: Text('观看各种比赛，拥有丰富的购彩经验',style: TextStyle(color: Colors.white,fontSize: sp(13)),),
        ),
        Container(
          height: width(28),
          color: Color.fromRGBO(255, 255, 255, 0.1),
          padding: EdgeInsets.symmetric(horizontal: width(15),),
          child: Row(
            children: <Widget>[
              Text('擅长联赛:',style: TextStyle(color: Colors.white,fontSize: sp(12)),),
              Expanded(
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: tabBarList.map((e){
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                       e=='全部'?SizedBox(): Container(
                          margin: EdgeInsets.only(left: width(8)),
                          alignment: Alignment.center,
                          child: Text(e,style: TextStyle(color: MyColors.main1,fontSize: sp(12)),),
                          padding: EdgeInsets.symmetric(horizontal: width(8)),
                          decoration: BoxDecoration(
                              color: Color(0xFFF1F8FE),
                              borderRadius: BorderRadius.circular(width(9))
                          ),
                        )
                      ],
                    );
                  }).toList(),
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  Widget chartWidget(){
    return  Container(
      padding: EdgeInsets.all(width(10)),
      margin: EdgeInsets.only(left: width(15),right: width(15),top: width(12)),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow:[
            BoxShadow(
              offset: Offset(2,5),
              color: Color(0x0D000000),
              blurRadius:width(6,),),
            BoxShadow(
              offset: Offset(-5,1),
              color: Color(0x0D000000),
              blurRadius:width(6,),
            )
          ],
          borderRadius: BorderRadius.circular(width(7))
      ),
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                border: Border(bottom: BorderSide(width: 0.4,color: Color(0xFFF2F2F2)))
            ),
            child: TabBar(
              labelColor: MyColors.main1,
              labelPadding: EdgeInsets.zero,
              unselectedLabelColor: MyColors.grey_66,
              indicatorColor: MyColors.main1,
              unselectedLabelStyle:TextStyle(fontSize: sp(15),),
              isScrollable: true,
              indicatorSize:TabBarIndicatorSize.tab,
              labelStyle: TextStyle(fontSize: sp(15),
                fontWeight: FontWeight.bold,),
              indicatorPadding: EdgeInsets.symmetric(horizontal: width(6)),
              controller:_controller,
              tabs: tabBarList.map((key) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: width(10)),
                  child: Tab(
                    text: key,
                  ),
                );
              }).toList(),
            ),
          ),
          // csProChartData.isEmpty? SizedBox():
          // csMethodBuildCharts(),
          csProChartData.isEmpty? SizedBox(): Container(
            height:width(150),
            child: TabBarView(
              controller: _controller,
              children: tabBarList.map((e) {
                      return csMethodBuildCharts(e=='全部'?csProChartData:csMethodGetLeagueRecent(widget.info!.csProExpertLeaguesRecent![tabBarList.indexOf(e)-1]['recent10']));
              }).toList(),
            ),
          ),
          SizedBox(height: 7,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
               Expanded(
                child: Container(
                  height: width(66),
                  decoration: BoxDecoration(
                      color: Color(0xFFF6F6F6),
                      borderRadius: BorderRadius.circular(width(6))
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text("${widget.info!.csProCurrentRedNum}",style: TextStyle(fontSize: sp(23),color: Color(0xFFE3494B),fontWeight: FontWeight.bold)),
                      Text("最近连红",style: TextStyle(fontSize: sp(12),color: MyColors.grey_33),),
                    ],
                  ),
                ),
              ),
              SizedBox(width: width(8),),
              //历史最高
              Expanded(
                child: Container(
                  height: width(66),
                  decoration: BoxDecoration(
                      color: Color(0xFFF6F6F6),
                      borderRadius: BorderRadius.circular(width(6))
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text("${widget.info!.csProMaxRedNum}",style: TextStyle(fontSize: sp(23),color: Color(0xFFE3494B),fontWeight: FontWeight.bold,)),
                      Text("历史最高连红",style: TextStyle(fontSize: sp(12),color: MyColors.grey_33),),

                    ],
                  ),
                ),
              ),
              SizedBox(width: width(8),),
              // 回报率
              Expanded(
                child: Container(
                  height: width(66),
                  decoration: BoxDecoration(
                      color: Color(0xFFF6F6F6),
                      borderRadius: BorderRadius.circular(width(6))
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      RichText(
                        text: TextSpan(
                          text: '${(double.tryParse(widget.info!.csProRecentProfitSum!)!*100).toStringAsFixed(0)}',
                          style: TextStyle(fontSize: sp(23),color: Color(0xFFE3494B),fontWeight: FontWeight.bold,),
                          children: [
                            TextSpan(
                              text: '%',
                              style:TextStyle(fontSize: sp(13),color: Color(0xFFE3494B),fontWeight: FontWeight.bold,)
                            )
                          ]
                        ),
                      ),
                      Text("最近回报率",style: TextStyle(fontSize: sp(12),color: MyColors.grey_33),),
                    ],
                  ),
                ),
              ),
            ],
          ),


        ],

      ),
    );
  }

  Widget expertScheme(){
    return  csProSchemeList.length==0?SizedBox():  Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: width(6),
            color: Color(0xFFF2F2F2),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(left: width(15),bottom: width(12),top: width(23)),
            decoration: BoxDecoration(
                border: Border(bottom: BorderSide(width: 0.4,color: Color(0xFFF2F2F2)))
            ),
            child:Text("本专家方案(${csProSchemeList.length})",style: TextStyle(fontWeight: FontWeight.bold,fontSize: sp(17),color: MyColors.grey_33)),

          ),
          ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsets.only(bottom: width(5)),
              itemCount: csProSchemeList.length,
              itemBuilder: (c,index){
                var item=csProSchemeList[index];
                return CSClassSchemeItemView(item,csProCanClick: false,csProShowLine:csProSchemeList.length>(index+1));
              })
        ],
      ),
    );
  }

  Widget historyScheme(){
    return  Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width,
      child:csProSchemeHistory.length==0?SizedBox(): Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: width(6),
            color: Color(0xFFF2F2F2),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(left: width(15),right: width(15),top: width(23),bottom: width(12)),
            decoration: BoxDecoration(
                border: Border(bottom: BorderSide(width: 0.4,color: Color(0xFFF2F2F2)))
            ),
            child:  Text("历史推荐",style: TextStyle(fontWeight: FontWeight.bold,fontSize: sp(17)),),
          ),
          ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsets.only(bottom: width(5)),
              itemCount: csProSchemeHistory.length,
              itemBuilder: (c,index){
                var item=csProSchemeHistory[index];
                return Stack(
                  children: <Widget>[
                    CSClassSchemeItemView(item,csProShowRate: false,csProShowLine:csProSchemeHistory.length>(index+1),),
                    Positioned(
                      top: 10,
                      right:  width(13) ,
                      child: Image.asset(
                        (item.csProIsWin=="1")? CSClassImageUtil.csMethodGetImagePath("ic_result_red"):
                        (item.csProIsWin=="0")? CSClassImageUtil.csMethodGetImagePath("ic_result_hei"):
                        (item.csProIsWin=="2")? CSClassImageUtil.csMethodGetImagePath("ic_result_zou"):"",
                        width: width(40),
                      ),
                    ),
                  ],
                );
              })
        ],
      ),
    );
  }

  void csMethodOnRefreshSelf() {
    CSClassApiManager.csMethodGetInstance().csMethodSchemeList(queryParameters: {"expert_uid":widget.info!.csProUserId,"page":"1","fetch_type":"expert"},csProCallBack: CSClassHttpCallBack<CSClassSchemeListEntity>(
        csProOnSuccess: (list){
          list.csProSchemeList!.forEach((itemx){
            if(itemx.csProIsOver=="1"){
             csProSchemeHistory.add(itemx);
            }else{
              csProSchemeList.add(itemx);

            }
          });
          if(mounted){
            setState(() {
         });
          }
        },
        onError: (value){
        },csProOnProgress: (v){}
    ));
  }

  void csMethodGetRecentReport() {
      csProDates=  CSClassMatchDataUtils.csMethodCalcDateCount(widget.info!.csProLast10Result!);
      csProDates!.sort((left,right)=>right.compareTo(left));
      csProDates!.forEach((item){
        csProChartData.add(CSClassChartData((CSClassMatchDataUtils.csMethodCalcCorrectRateByDate(widget.info!.csProLast10Result!,item)*100).roundToDouble(),"近"+
            "${item.toString()}"+
                "场"));
       });

      if(csProChartData.length==1){
        csProChartData.add(CSClassChartData(csProChartData[0].y,""));

      }

      setState(() {});

  }

  List<CSClassChartData> csMethodGetLeagueRecent(String? recent10){
    if(recent10==null){
      return [];
    }
    List<CSClassChartData> data=[];
    List list=  CSClassMatchDataUtils.csMethodCalcDateCount(recent10);
    list.sort((left,right)=>right.compareTo(left));
    list.forEach((item){
      data.add(CSClassChartData((CSClassMatchDataUtils.csMethodCalcCorrectRateByDate(recent10,item)*100).roundToDouble(),"近"+
          "${item.toString()}"+
          "场"));
    });
    if(data.length==1){
      data.add(CSClassChartData(data[0].y,""));

    }
    return data;
  }

  Widget csMethodBuildCharts(List<CSClassChartData> data) {
    return Container(
      height:width(150),
      child:SfCartesianChart(
        plotAreaBorderWidth: 0,
        margin: EdgeInsets.only(right: 20,top: 10,bottom: 10),
        onTooltipRender: (TooltipArgs args) {
          final NumberFormat format = NumberFormat.decimalPattern();
          var text=  format.format(args.dataPoints![args.pointIndex!.toInt()].y).toString();
          CSClassLogUtils.csMethodPrintLog("text：${text.toString()}");
        },
        title: ChartTitle(text: ""),
        legend: Legend(
            isVisible: false,
            overflowMode: LegendItemOverflowMode.wrap),
        primaryXAxis: CategoryAxis(
            labelStyle:TextStyle(fontSize: sp(12)),
            labelPlacement: LabelPlacement.onTicks,
            majorGridLines: MajorGridLines(width: 0.4)),
        primaryYAxis: NumericAxis(
            maximum: 100,
            labelFormat: '{value}%',
            interval: 25,
            axisLine: AxisLine(width: 0),
            labelStyle: TextStyle(fontSize: sp(12)),
            majorTickLines: MajorTickLines(color: Colors.transparent)),
        series: <AreaSeries<CSClassChartData, String>>[
          AreaSeries<CSClassChartData, String>(
              animationDuration: 2500,
              enableTooltip: true,
              gradient:LinearGradient(colors:[Colors.white.withOpacity(0.5),Colors.red.withOpacity(0.5)],begin: Alignment.bottomCenter,end: Alignment.topCenter),
              dataSource: data,
              borderColor: Colors.red,
              borderWidth: 1,
              xValueMapper: (CSClassChartData sales, _) => sales.x,
              yValueMapper: (CSClassChartData sales, _) => sales.y,
              name: "近期胜率",
              markerSettings: MarkerSettings(
                  isVisible: true, color:Colors.red,borderColor: Colors.white)),


        ],
        tooltipBehavior: TooltipBehavior(enable: true,color: Colors.red,borderColor:Colors.cyan ),
      ),

    );
     // csProChartsCon ??= Container(
     //     height:width(150),
     //     child:SfCartesianChart(
     //       plotAreaBorderWidth: 0,
     //       onTooltipRender: (TooltipArgs args) {
     //         final NumberFormat format = NumberFormat.decimalPattern();
     //         var text=  format.format(args.dataPoints![args.pointIndex!.toInt()].y).toString();
     //         CSClassLogUtils.csMethodPrintLog("text：${text.toString()}");
     //       },
     //       title: ChartTitle(text: ""),
     //       legend: Legend(
     //           isVisible: false,
     //           overflowMode: LegendItemOverflowMode.wrap),
     //       primaryXAxis: CategoryAxis(
     //            labelStyle:TextStyle(fontSize: sp(12)),
     //           labelPlacement: LabelPlacement.onTicks,
     //           majorGridLines: MajorGridLines(width: 0.4)),
     //       primaryYAxis: NumericAxis(
     //           maximum: 100,
     //           labelFormat: '{value}%',
     //           interval: 25,
     //           axisLine: AxisLine(width: 0),
     //           labelStyle: TextStyle(fontSize: sp(12)),
     //           majorTickLines: MajorTickLines(color: Colors.transparent)),
     //       series: <AreaSeries<CSClassChartData, String>>[
     //         AreaSeries<CSClassChartData, String>(
     //             animationDuration: 2500,
     //             enableTooltip: true,
     //             gradient:LinearGradient(colors:[Colors.white.withOpacity(0.5),Colors.red.withOpacity(0.5)],begin: Alignment.bottomCenter,end: Alignment.topCenter),
     //             dataSource: csProChartData,
     //             borderColor: Colors.red,
     //             borderWidth: 1,
     //             xValueMapper: (CSClassChartData sales, _) => sales.x,
     //             yValueMapper: (CSClassChartData sales, _) => sales.y,
     //             name: "近期胜率",
     //             markerSettings: MarkerSettings(
     //                 isVisible: true, color:Colors.red,borderColor: Colors.white)),
     //
     //
     //       ],
     //       tooltipBehavior: TooltipBehavior(enable: true,color: Colors.red,borderColor:Colors.cyan ),
     //     ),
     //
     //   );
     // return csProChartsCon;
  }


}

class CSClassChartData {
  CSClassChartData( this.y,this.x,);
   String x;
   double y;
   String z="xsdsadsa";

}



