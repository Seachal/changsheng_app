import 'package:changshengh5/utils/colors.dart';
import 'package:flutter/material.dart';


class CSClassSwitchTabBar extends StatefulWidget{
   double ?height;
   double ?width;
   double ?fontSize;
   List<String> ?csProTabTitles;
   ValueChanged<int> ?csProTabChanged;
   ValueChanged<CSClassSwitchTabBarState> ?csProGetState;
   int ?index;

  @override
  State<StatefulWidget> createState() => CSClassSwitchTabBarState();

   CSClassSwitchTabBar({@required this.height, @required this.width,this.csProTabTitles,this.fontSize:16,this.csProTabChanged,this.index,this.csProGetState});

}

class CSClassSwitchTabBarState extends State<CSClassSwitchTabBar> with TickerProviderStateMixin{
  AnimationController ?csProAnimationController;
  Animation<double> ?animation;

  AnimationController ?csProScaleController;
  Animation<double> ?csProAnimationScale;
  int csProPerIndex=0;
  int index=0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.csProGetState!=null){
      widget.csProGetState!(this);
    }
    csProPerIndex=widget.index!;
    index=widget.index!;
    csProAnimationController=AnimationController(duration: Duration(milliseconds: 200),vsync: this);
    animation=Tween<double>(begin: (widget.width!/widget.csProTabTitles!.length)*index,end: 1,).animate(csProAnimationController!);
    csProScaleController=AnimationController(duration: Duration(milliseconds: 200),vsync: this);
    csProAnimationScale=Tween<double>(begin: 0,end: 1,).animate(csProScaleController!);
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
       children: <Widget>[
         Container(
           width: widget.width,
           height: widget.height,
           decoration: BoxDecoration(
             borderRadius: BorderRadius.circular(widget.width!),
             // color: Color(0xFFF2F2F2),
           ),
           child: Row(
             children:widget.csProTabTitles!.map((item){
               return Expanded(
                 child: GestureDetector(
                   behavior: HitTestBehavior.opaque,
                   child: Center(
                     child: Text(
                       item,style: TextStyle(color: Colors.white,fontSize:widget.fontSize,fontWeight: FontWeight.w400),
                     ),
                   ),
                   onTap: ()=>csMethodStartAnmat(widget.csProTabTitles!.indexOf(item)),
                 ),
               );
             }).toList(),
           ),
         ),
         Positioned(
           left: animation!.value,
           width: widget.width!/widget.csProTabTitles!.length,
           height: widget.height,
           child: Container(
             margin: EdgeInsets.symmetric(horizontal: widget.height!*0.07),
             decoration: BoxDecoration(
                 borderRadius: BorderRadius.circular(widget.width!),
                 color: Colors.white
                 // gradient:LinearGradient(
                 //     colors: [
                 //       Color(0xFFF2150C),
                 //       Color(0xFFF24B0C),
                 //     ]
                 // ),
             ),
             child:  Center(
               child: Text(widget.csProTabTitles![csProPerIndex],style:TextStyle(color: MyColors.main1,fontSize: widget.fontSize,
                 fontWeight: FontWeight.w500,),

                 ),
             ),
           ) ,
         ),
       ],
    );
  }

  csMethodStartAnmat(int index){
    var realWidth=widget.width!/widget.csProTabTitles!.length;
    animation=Tween<double>(begin:realWidth*csProPerIndex,end:realWidth*index,).animate(csProAnimationController!);
    animation!.addListener((){
      setState(() {});
    });
    animation!.addStatusListener((status){
     /* if(status==AnimationStatus.completed){
        csProScaleController.reset();
        csProScaleController.forward();
      }*/
    });
    csProAnimationController!.reset();
    csProAnimationController!.forward();
    csProPerIndex=index;

    if(widget.csProTabChanged!=null){
      widget.csProTabChanged!(index);
    }

  }
}