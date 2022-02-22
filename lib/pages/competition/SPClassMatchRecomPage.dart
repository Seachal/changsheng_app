import 'package:changshengh5/model/SPClassGuessMatchInfo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'SPClassMatchDetailSchemeListPage.dart';
import 'SPClassMatchIntelligencePage.dart';



class SPClassMatchRecomPage extends  StatefulWidget{
  SPClassGuessMatchInfo spProGuessInfo;

  SPClassMatchRecomPage(this.spProGuessInfo);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SPClassMatchRecomPageState();
  }

}

class SPClassMatchRecomPageState extends State<SPClassMatchRecomPage> with TickerProviderStateMixin<SPClassMatchRecomPage> ,AutomaticKeepAliveClientMixin{
  var index=0;
  PageController ?spProPageController;
  List<Widget> views =[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    views=[SPClassMatchDetailSchemeListPage(widget.spProGuessInfo),SPClassMatchIntelligencePage(widget.spProGuessInfo)];
    spProPageController=PageController();
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
              controller: spProPageController,
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

