import 'package:changshengh5/model/CSClassGuessMatchInfo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'CSClassMatchDetailSchemeListPage.dart';
import 'CSClassMatchIntelligencePage.dart';



class CSClassMatchRecomPage extends  StatefulWidget{
  CSClassGuessMatchInfo csProGuessInfo;

  CSClassMatchRecomPage(this.csProGuessInfo);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CSClassMatchRecomPageState();
  }

}

class CSClassMatchRecomPageState extends State<CSClassMatchRecomPage> with TickerProviderStateMixin<CSClassMatchRecomPage> ,AutomaticKeepAliveClientMixin{
  var index=0;
  PageController ?csProPageController;
  List<Widget> views =[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    views=[CSClassMatchDetailSchemeListPage(widget.csProGuessInfo),CSClassMatchIntelligencePage(widget.csProGuessInfo)];
    csProPageController=PageController();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    super.build(context);
    return Container(
      color: Color(0xFFF1F1F1),
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: <Widget>[
          Expanded(
            child:PageView(
              controller: csProPageController,
              physics: NeverScrollableScrollPhysics(),
              children:views,
            ),
          )
        ],
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;



}

