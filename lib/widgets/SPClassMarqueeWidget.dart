import 'dart:async';

import 'package:flutter/cupertino.dart';


/**
 * 跑马灯控件
 *
 */
class SPClassMarqueeWidget extends StatefulWidget{
  Widget ?child;
  double ?distance;//每秒滚动的距离

  SPClassMarqueeWidget({@required this.child,this.distance:80});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SPClassMarqueeWidgetState();
  }

}

class SPClassMarqueeWidgetState extends State<SPClassMarqueeWidget>{
  Size ?spProWidgetSize;
  ScrollController ?scrollController;
  int ?spProPerHashCode;
  Timer ?spProPeriodicTimer;

  bool spProCanScroll=true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollController=ScrollController();



  }


  void spFunStartScroll() {
    scrollController!.animateTo(0, duration: Duration(milliseconds: 10), curve: Curves.linear);
    if(spProPeriodicTimer!=null){
      spProPeriodicTimer!.cancel();
    }
    if(context.size!=null&&context.size!.width>=spProWidgetSize!.width){
      spProCanScroll=false;
      setState(() {

      });
      return;
    }
    var periodic=(spProWidgetSize!.width/widget.distance!)*1000;
    spFunScrollView(periodic);
    spProPeriodicTimer= Timer.periodic(Duration(milliseconds: periodic.floor()+1000), (timer){
      spFunScrollView(periodic);
    });
  }

  void spFunScrollView(double periodic){
    if(scrollController!.position!=null
        &&!scrollController!.position.isScrollingNotifier.value
        &&spProWidgetSize!=null){
      scrollController!.animateTo(
          scrollController!.offset+spProWidgetSize!.width,
          duration: Duration(milliseconds: periodic.floor()), curve: Curves.linear);
    }
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    if(!spProCanScroll){

      return widget.child!;
    }

    return  ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        controller: scrollController,
        scrollDirection: Axis.horizontal,
        itemBuilder: (c,index){
          return SPClassWidgetSizeListener(
            child:widget.child,
            spProSizeChange: (size){
              if(this.spProWidgetSize==null){
                this.spProWidgetSize=size;
                spFunStartScroll();
              }else if(this.spProWidgetSize!=null&&this.spProWidgetSize!.width!=size.width){
                this.spProWidgetSize=size;
                spFunStartScroll();
              }
            },
          );
        });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    if(spProPeriodicTimer!=null){
      spProPeriodicTimer!.cancel();
      scrollController!.dispose();
    }
  }

}


class  SPClassWidgetSizeListener extends StatefulWidget
{
  Widget ?child;
  ValueChanged<Size> ?spProSizeChange;
  SPClassWidgetSizeListener({@required this.child,this.spProSizeChange});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SPClassWidgetSizeListenerState();
  }


}

class SPClassWidgetSizeListenerState extends State<SPClassWidgetSizeListener>{

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((duration) {
      if(widget.spProSizeChange!=null&&context.size!=null){
        widget.spProSizeChange!(new Size(context.size!.width,context.size!.height));
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