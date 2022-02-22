import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'SPClassQNavButton.dart';

class SPClassQNavBar extends StatefulWidget{
  double ?spProNavHeight;
  double ?spProNavTextSize=14;
  ValueChanged<int>   ?spProPageChange;
  List<SPClassQNavTab> spProNavTabs;
  int ?spProSelectIndex=0;
  SPClassQNavBar({ required this.spProNavTabs,this.spProNavHeight:56,this.spProNavTextSize,this.spProPageChange,this.spProSelectIndex});
  SPClassQNavBarState createState()=> SPClassQNavBarState();
}

class SPClassQNavBarState extends  State<SPClassQNavBar>{

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
            offset:Offset(0,-2),
            color: Color(0x33000000),
            blurRadius: 15,
            spreadRadius: 4
          )
        ]
      ),
      width: viewSize.width,
      height: widget.spProNavHeight,
      child:
      Row(
        children: spFunBuildNavButtons(),
      ),
    );
  }

  spFunBuildNavButtons() {
    return widget.spProNavTabs.map((tabItem){
      return SPClassQNavButton(
        spProTabView: tabItem,
        spProTextSize: widget.spProNavTextSize,
        spProNavHeight: widget.spProNavHeight,
        selected: widget.spProSelectIndex==widget.spProNavTabs.indexOf(tabItem),
        spProOnPress:()=>spFunOnTapItem(widget.spProNavTabs.indexOf(tabItem)),);
    }).toList();
  }

  spFunOnTapItem(int index) {
    if(widget.spProSelectIndex!=index){
      setState(() {
        widget.spProSelectIndex=index;
      });
      widget.spProPageChange!(widget.spProSelectIndex!);
    }
  }

}