import 'dart:async';

import 'package:flutter/cupertino.dart';


/**
 * 跑马灯控件
 *
 */
class CSClassMarqueeWidget extends StatefulWidget{
  Widget ?child;
  double ?distance;//每秒滚动的距离

  CSClassMarqueeWidget({@required this.child,this.distance:80});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CSClassMarqueeWidgetState();
  }

}

class CSClassMarqueeWidgetState extends State<CSClassMarqueeWidget>{
  Size ?csProWidgetSize;
  ScrollController ?scrollController;
  int ?csProPerHashCode;
  Timer ?csProPeriodicTimer;

  bool csProCanScroll=true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollController=ScrollController();



  }


  void csMethodStartScroll() {
    scrollController!.animateTo(0, duration: Duration(milliseconds: 10), curve: Curves.linear);
    if(csProPeriodicTimer!=null){
      csProPeriodicTimer!.cancel();
    }
    if(context.size!=null&&context.size!.width>=csProWidgetSize!.width){
      csProCanScroll=false;
      setState(() {

      });
      return;
    }
    var periodic=(csProWidgetSize!.width/widget.distance!)*1000;
    csMethodScrollView(periodic);
    csProPeriodicTimer= Timer.periodic(Duration(milliseconds: periodic.floor()+1000), (timer){
      csMethodScrollView(periodic);
    });
  }

  void csMethodScrollView(double periodic){
    if(scrollController!.position!=null
        &&!scrollController!.position.isScrollingNotifier.value
        &&csProWidgetSize!=null){
      scrollController!.animateTo(
          scrollController!.offset+csProWidgetSize!.width,
          duration: Duration(milliseconds: periodic.floor()), curve: Curves.linear);
    }
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    if(!csProCanScroll){

      return widget.child!;
    }

    return  ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        controller: scrollController,
        scrollDirection: Axis.horizontal,
        itemBuilder: (c,index){
          return CSClassWidgetSizeListener(
            child:widget.child,
            csProSizeChange: (size){
              if(this.csProWidgetSize==null){
                this.csProWidgetSize=size;
                csMethodStartScroll();
              }else if(this.csProWidgetSize!=null&&this.csProWidgetSize!.width!=size.width){
                this.csProWidgetSize=size;
                csMethodStartScroll();
              }
            },
          );
        });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    if(csProPeriodicTimer!=null){
      csProPeriodicTimer!.cancel();
      scrollController!.dispose();
    }
  }

}


class  CSClassWidgetSizeListener extends StatefulWidget
{
  Widget ?child;
  ValueChanged<Size> ?csProSizeChange;
  CSClassWidgetSizeListener({@required this.child,this.csProSizeChange});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CSClassWidgetSizeListenerState();
  }


}

class CSClassWidgetSizeListenerState extends State<CSClassWidgetSizeListener>{

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((duration) {
      if(widget.csProSizeChange!=null&&context.size!=null){
        widget.csProSizeChange!(new Size(context.size!.width,context.size!.height));
      }
    });
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
  }
  @override
  Widget build(BuildContext context) {

    return widget.child!;
  }


}