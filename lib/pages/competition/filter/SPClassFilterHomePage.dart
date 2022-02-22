import 'package:changshengh5/app/SPClassApplicaion.dart';
import 'package:changshengh5/untils/SPClassCommonMethods.dart';
import 'package:changshengh5/untils/colors.dart';
import 'package:changshengh5/widgets/SPClassToolBar.dart';
import 'package:flutter/material.dart';

import 'SPClassFilterleagueMatchPage.dart';

typedef CallBack = void Function(String value,String spProIsLottery);

class SPClassFilterHomePage extends StatefulWidget{
  bool ?spProIsHot;
  CallBack ?callback;
  String ?spProChooseLeagueName;
  Map<String,dynamic> ?param;

  SPClassFilterHomePage(this.spProChooseLeagueName,{this.param,this.callback,this.spProIsHot});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SPClassFilterHomePageState();
  }

}

class SPClassFilterHomePageState extends State<SPClassFilterHomePage> with TickerProviderStateMixin{
  var spProTabTitle=["全部","竞彩"];
  TabController? spProTabController;
  List<Widget> views=[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    spProTabController=TabController(length: spProTabTitle.length,vsync: this);
    views=[
      SPClassFilterleagueMatchPage("",widget.spProChooseLeagueName, param: widget.param, callback: widget.callback,spProIsHot: widget.spProIsHot,),
      SPClassFilterleagueMatchPage("1",widget.spProChooseLeagueName, param: widget.param, callback: widget.callback,spProIsHot: widget.spProIsHot,),
   ];
    spProTabController?.addListener(() {
      setState(() {

      });
    });
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: SPClassToolBar(
        context,
        title:"比赛筛选",
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              height: width(6),
              color: Color(0xFFF2F2F2),
            ),
           // 标记
           // SPClassApplicaion.spFunIsShowIosUI() ?SizedBox():
           Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(bottom: BorderSide(width: 0.4,color: Colors.grey[300]!),top: BorderSide(width: 0.4,color: Colors.grey[300]!))
              ),
              child: TabBar(
                  labelColor: MyColors.main1,
                  unselectedLabelColor: const Color(0xFF333333),
                  isScrollable: false,
                  indicatorColor: MyColors.transparent,
                  indicatorPadding: EdgeInsets.symmetric(horizontal: width(80)),
                  labelStyle: TextStyle(fontSize: sp(14),fontWeight: FontWeight.bold),
                  unselectedLabelStyle: TextStyle(fontSize: sp(14),fontWeight: FontWeight.w400,color: Color(0xFF333333)),
                  controller: spProTabController,
                  indicatorSize: TabBarIndicatorSize.tab,
                  tabs:spProTabTitle.map((spProTabTitle){
                    return Column(
                      children: <Widget>[
                        Container(
                          alignment: Alignment.center,
                          height: width(38),
                          child:Text(spProTabTitle,style: TextStyle(letterSpacing: 0,wordSpacing: 0,fontSize: sp(15)),),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: width(65)),
                          height: 2,
                          color:spProTabController!.index==this.spProTabTitle.indexOf(spProTabTitle)? MyColors.main1:Colors.transparent,
                        )
                      ],
                    );
                  }).toList()
              ),
            ),
            Expanded(
              child: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                controller: spProTabController,
                children:views,
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

}