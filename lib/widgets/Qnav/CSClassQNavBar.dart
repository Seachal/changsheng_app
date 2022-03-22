import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'CSClassQNavButton.dart';

class CSClassQNavBar extends StatefulWidget{
  double ?csProNavHeight;
  double ?csProNavTextSize=14;
  ValueChanged<int>   ?csProPageChange;
  List<CSClassQNavTab> csProNavTabs;
  int ?csProSelectIndex=0;
  CSClassQNavBar({ required this.csProNavTabs,this.csProNavHeight:56,this.csProNavTextSize,this.csProPageChange,this.csProSelectIndex});
  CSClassQNavBarState createState()=> CSClassQNavBarState();
}

class CSClassQNavBarState extends  State<CSClassQNavBar>{

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var viewSize=MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              offset:Offset(0,-10),
              color: Color.fromRGBO(0, 0, 0, 0.08),
              blurRadius: 6,
              spreadRadius: 1
          )
//          BoxShadow(
//            offset:Offset(0,-2),
//            color: Color(0x33000000),
//            blurRadius: 15,
//            spreadRadius: 4
//          )
        ]
      ),
      width: viewSize.width,
      height: widget.csProNavHeight,
      child:
      Row(
        children: csMethodBuildNavButtons(),
      ),
    );
  }

  csMethodBuildNavButtons() {
    return widget.csProNavTabs.map((tabItem){
      return CSClassQNavButton(
        csProTabView: tabItem,
        csProTextSize: widget.csProNavTextSize,
        csProNavHeight: widget.csProNavHeight,
        selected: widget.csProSelectIndex==widget.csProNavTabs.indexOf(tabItem),
        csProOnPress:()=>csMethodOnTapItem(widget.csProNavTabs.indexOf(tabItem)),);
    }).toList();
  }

  csMethodOnTapItem(int index) {
    if(widget.csProSelectIndex!=index){
      setState(() {
        widget.csProSelectIndex=index;
      });
      widget.csProPageChange!(widget.csProSelectIndex!);
    }
  }

}