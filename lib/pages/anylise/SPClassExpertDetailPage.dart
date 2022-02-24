
import 'package:changshengh5/api/SPClassApiManager.dart';
import 'package:changshengh5/api/SPClassHttpCallBack.dart';
import 'package:changshengh5/app/SPClassApplicaion.dart';
import 'package:changshengh5/model/SPClassExpertInfo.dart';
import 'package:changshengh5/model/SPClassSchemeListEntity.dart';
import 'package:changshengh5/pages/home/SPClassSchemeItemView.dart';
import 'package:changshengh5/utils/SPClassCommonMethods.dart';
import 'package:changshengh5/utils/SPClassImageUtil.dart';
import 'package:changshengh5/utils/SPClassLogUtils.dart';
import 'package:changshengh5/utils/SPClassMatchDataUtils.dart';
import 'package:changshengh5/utils/SPClassStringUtils.dart';
import 'package:changshengh5/utils/SPClassToastUtils.dart';
import 'package:changshengh5/utils/colors.dart';
import 'package:changshengh5/utils/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';



class SPClassExpertDetailPage extends StatefulWidget{
  SPClassExpertInfo ?info;
  bool ?spProIsStatics;
  SPClassExpertDetailPage(this.info,{this.spProIsStatics:true});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SPClassExpertDetailPageState();
  }

}

class SPClassExpertDetailPageState extends State<SPClassExpertDetailPage> with TickerProviderStateMixin{
  int page=1;
  List<SPClassSchemeListSchemeList> spProSchemeHistory=[];
  List<SPClassSchemeListSchemeList> spProSchemeList=[];
  List<SPClassChartData> spProChartData=[];
  List<int> ?spProDates;
  Container ?spProChartsCon;
  List tabBarList = ['全部','亚洲杯','世锦赛','世锦赛',];
  TabController ?_controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = TabController(length:tabBarList.length,vsync: this);
    spFunGetRecentReport();
    spFunOnRefreshSelf();

    if(widget.spProIsStatics!){
      SPClassApiManager.spFunGetInstance().spFunLogAppEvent(spProEventName: "view_expert",targetId:widget.info!.spProUserId);
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
                SPClassImageUtil.spFunGetImagePath("zhuanjiabg"),
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
            SPClassImageUtil.spFunGetImagePath("arrow_right"),
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
                    child: (widget.info?.spProAvatarUrl ==
                        null ||
                        widget.info!.spProAvatarUrl!.isEmpty)
                        ? Image.asset(
                      SPClassImageUtil.spFunGetImagePath(
                          "ic_default_avater"),
                      width: width(46),
                      height: width(46),
                    )
                        : Image.network(
                      widget.info!.spProAvatarUrl!,
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
                              ?.spProNickName??'',
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
                              SPClassStringUtils.spFunMaxLength(widget.info?.intro??'',
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
                              '粉丝：${ widget.info?.spProFollowerNum??0}',
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
                          color:  widget.info!.spProIsFollowing!?Colors.transparent:Colors.white,
                          borderRadius: BorderRadius.circular(150),
                          border: Border.all(width: width(1),color:  widget.info!.spProIsFollowing!?Color.fromRGBO(255, 255, 255, 0.6):Colors.transparent)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(widget.info!.spProIsFollowing!? Icons.check:Icons.add,color:  widget.info!.spProIsFollowing!?Color.fromRGBO(255, 255, 255, 0.6):MyColors.main1,size: width(12),),
                          Text(  widget.info!.spProIsFollowing!? "已关注":"关注",style: TextStyle(fontSize: sp(12),color: widget.info!.spProIsFollowing!? Color.fromRGBO(255, 255, 255, 0.6):MyColors.main1),),

                        ],
                      ),
                    ),
                    onTap: (){
                      if(spFunIsLogin(context: context)){
                        SPClassApiManager.spFunGetInstance().spFunFollowExpert(isFollow: ! widget.info!.spProIsFollowing!,spProExpertUid:  widget.info!.spProUserId,context: context,spProCallBack: SPClassHttpCallBack(
                            spProOnSuccess: (result){
                              if(! widget.info!.spProIsFollowing!){
                                SPClassToastUtils.spFunShowToast(msg: "关注成功");
                                widget.info!.spProIsFollowing=true;
                              }else{
                                widget.info!.spProIsFollowing=false;
                              }
                              if(mounted){
                                setState(() {});
                              }
                            },onError: (e){},spProOnProgress: (v){}
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
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(left: width(8)),
                          alignment: Alignment.center,
                          child: Text('亚洲杯',style: TextStyle(color: MyColors.main1,fontSize: sp(12)),),
                          padding: EdgeInsets.symmetric(horizontal: width(8)),
                          decoration: BoxDecoration(
                            color: Color(0xFFF1F8FE),
                            borderRadius: BorderRadius.circular(width(9))
                          ),
                        )
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(left: width(8)),
                          alignment: Alignment.center,
                          child: Text('亚洲杯',style: TextStyle(color: MyColors.main1,fontSize: sp(12)),),
                          padding: EdgeInsets.symmetric(horizontal: width(8)),
                          decoration: BoxDecoration(
                            color: Color(0xFFF1F8FE),
                            borderRadius: BorderRadius.circular(width(9))
                          ),
                        )
                      ],
                    ),
                  ],
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
              isScrollable: false,
              indicatorSize:TabBarIndicatorSize.label,
              labelStyle: TextStyle(fontSize: sp(15),
                fontWeight: FontWeight.bold,),
              indicatorPadding: EdgeInsets.symmetric(horizontal: width(6)),
              controller:_controller,
              tabs: tabBarList.map((key) {
                return Tab(
                  text: key,
                );
              }).toList(),
            ),
          ),
          spProChartData.isEmpty? SizedBox():
          spFunBuildCharts(),
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
                      Text("${widget.info!.spProCurrentRedNum}",style: TextStyle(fontSize: sp(23),color: Color(0xFFE3494B),fontWeight: FontWeight.bold)),
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
                      Text("${widget.info!.spProMaxRedNum}",style: TextStyle(fontSize: sp(23),color: Color(0xFFE3494B),fontWeight: FontWeight.bold,)),
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
                          text: '${(double.tryParse(widget.info!.spProRecentProfitSum!)!*100).toStringAsFixed(0)}',
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
    return  spProSchemeList.length==0?SizedBox():  Container(
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
            child:Text("本专家方案(${spProSchemeList.length})",style: TextStyle(fontWeight: FontWeight.bold,fontSize: sp(17),color: MyColors.grey_33)),

          ),
          ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsets.only(bottom: width(5)),
              itemCount: spProSchemeList.length,
              itemBuilder: (c,index){
                var item=spProSchemeList[index];
                return SPClassSchemeItemView(item,spProCanClick: false,spProShowLine:spProSchemeList.length>(index+1));
              })
        ],
      ),
    );
  }

  Widget historyScheme(){
    return  Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width,
      child:spProSchemeHistory.length==0?SizedBox(): Column(
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
              itemCount: spProSchemeHistory.length,
              itemBuilder: (c,index){
                var item=spProSchemeHistory[index];
                return Stack(
                  children: <Widget>[
                    SPClassSchemeItemView(item,spProShowRate: false,spProShowLine:spProSchemeHistory.length>(index+1),),
                    Positioned(
                      top: 10,
                      right:  width(13) ,
                      child: Image.asset(
                        (item.spProIsWin=="1")? SPClassImageUtil.spFunGetImagePath("ic_result_red"):
                        (item.spProIsWin=="0")? SPClassImageUtil.spFunGetImagePath("ic_result_hei"):
                        (item.spProIsWin=="2")? SPClassImageUtil.spFunGetImagePath("ic_result_zou"):"",
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

  void spFunOnRefreshSelf() {
    SPClassApiManager.spFunGetInstance().spFunSchemeList(queryParameters: {"expert_uid":widget.info!.spProUserId,"page":"1","fetch_type":"expert"},spProCallBack: SPClassHttpCallBack<SPClassSchemeListEntity>(
        spProOnSuccess: (list){
          list.spProSchemeList!.forEach((itemx){
            if(itemx.spProIsOver=="1"){
             spProSchemeHistory.add(itemx);
            }else{
              spProSchemeList.add(itemx);

            }
          });
          if(mounted){
            setState(() {
         });
          }
        },
        onError: (value){
        },spProOnProgress: (v){}
    ));
  }

  void spFunGetRecentReport() {
      spProDates=  SPClassMatchDataUtils.spFunCalcDateCount(widget.info!.spProLast10Result!);
      spProDates!.sort((left,right)=>right.compareTo(left));
      spProDates!.forEach((item){
        spProChartData.add(SPClassChartData((SPClassMatchDataUtils.spFunCalcCorrectRateByDate(widget.info!.spProLast10Result!,item)*100).roundToDouble(),"近"+
            "${item.toString()}"+
                "场"));
       });

      if(spProChartData.length==1){
        spProChartData.add(SPClassChartData(spProChartData[0].y,""));

      }

      setState(() {});

  }

  spFunBuildCharts() {

     spProChartsCon ??= Container(
         height:width(150),
         child:SfCartesianChart(
           plotAreaBorderWidth: 0,
           onTooltipRender: (TooltipArgs args) {
             final NumberFormat format = NumberFormat.decimalPattern();
             var text=  format.format(args.dataPoints![args.pointIndex!.toInt()].y).toString();
             SPClassLogUtils.spFunPrintLog("text：${text.toString()}");
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
           series: <AreaSeries<SPClassChartData, String>>[
             AreaSeries<SPClassChartData, String>(
                 animationDuration: 2500,
                 enableTooltip: true,
                 gradient:LinearGradient(colors:[Colors.white.withOpacity(0.5),Colors.red.withOpacity(0.5)],begin: Alignment.bottomCenter,end: Alignment.topCenter),
                 dataSource: spProChartData,
                 borderColor: Colors.red,
                 borderWidth: 1,
                 xValueMapper: (SPClassChartData sales, _) => sales.x,
                 yValueMapper: (SPClassChartData sales, _) => sales.y,
                 name: "近期胜率",
                 markerSettings: MarkerSettings(
                     isVisible: true, color:Colors.red,borderColor: Colors.white)),


           ],
           tooltipBehavior: TooltipBehavior(enable: true,color: Colors.red,borderColor:Colors.cyan ),
         ),

       );
     return spProChartsCon;
  }


}

class SPClassChartData {
  SPClassChartData( this.y,this.x,);
   String x;
   double y;
   String z="xsdsadsa";

}



