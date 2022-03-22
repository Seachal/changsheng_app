import 'package:changshengh5/app/CSClassApplicaion.dart';
import 'package:changshengh5/utils/CSClassCommonMethods.dart';
import 'package:changshengh5/utils/colors.dart';
import 'package:changshengh5/widgets/CSClassToolBar.dart';
import 'package:flutter/material.dart';

import 'CSClassFilterleagueMatchPage.dart';

typedef CallBack = void Function(String value,String csProIsLottery);

class CSClassFilterHomePage extends StatefulWidget{
  bool ?csProIsHot;
  CallBack ?callback;
  String ?csProChooseLeagueName;
  Map<String,dynamic> ?param;

  CSClassFilterHomePage(this.csProChooseLeagueName,{this.param,this.callback,this.csProIsHot});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CSClassFilterHomePageState();
  }

}

class CSClassFilterHomePageState extends State<CSClassFilterHomePage> with TickerProviderStateMixin{
  var csProTabTitle=["全部","竞彩"];
  TabController? csProTabController;
  List<Widget> views=[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    csProTabController=TabController(length: csProTabTitle.length,vsync: this);
    views=[
      CSClassFilterleagueMatchPage("",widget.csProChooseLeagueName, param: widget.param, callback: widget.callback,csProIsHot: widget.csProIsHot,),
      CSClassFilterleagueMatchPage("1",widget.csProChooseLeagueName, param: widget.param, callback: widget.callback,csProIsHot: widget.csProIsHot,),
   ];
    csProTabController?.addListener(() {
      setState(() {

      });
    });
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: CSClassToolBar(
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
           CSClassApplicaion.csMethodIsShowIosUI() ?SizedBox():
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
                  controller: csProTabController,
                  indicatorSize: TabBarIndicatorSize.tab,
                  tabs:csProTabTitle.map((csProTabTitle){
                    return Column(
                      children: <Widget>[
                        Container(
                          alignment: Alignment.center,
                          height: width(38),
                          child:Text(csProTabTitle,style: TextStyle(letterSpacing: 0,wordSpacing: 0,fontSize: sp(15)),),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: width(65)),
                          height: 2,
                          color:csProTabController!.index==this.csProTabTitle.indexOf(csProTabTitle)? MyColors.main1:Colors.transparent,
                        )
                      ],
                    );
                  }).toList()
              ),
            ),
            Expanded(
              child: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                controller: csProTabController,
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