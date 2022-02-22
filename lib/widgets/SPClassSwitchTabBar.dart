import 'package:changshengh5/untils/colors.dart';
import 'package:flutter/material.dart';


class SPClassSwitchTabBar extends StatefulWidget{
   double ?height;
   double ?width;
   double ?fontSize;
   List<String> ?spProTabTitles;
   ValueChanged<int> ?spProTabChanged;
   ValueChanged<SPClassSwitchTabBarState> ?spProGetState;
   int ?index;

  @override
  State<StatefulWidget> createState() => SPClassSwitchTabBarState();

   SPClassSwitchTabBar({@required this.height, @required this.width,this.spProTabTitles,this.fontSize:16,this.spProTabChanged,this.index,this.spProGetState});

}

class SPClassSwitchTabBarState extends State<SPClassSwitchTabBar> with TickerProviderStateMixin{
  AnimationController ?spProAnimationController;
  Animation<double> ?animation;

  AnimationController ?spProScaleController;
  Animation<double> ?spProAnimationScale;
  int spProPerIndex=0;
  int index=0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.spProGetState!=null){
      widget.spProGetState!(this);
    }
    spProPerIndex=widget.index!;
    index=widget.index!;
    spProAnimationController=AnimationController(duration: Duration(milliseconds: 200),vsync: this);
    animation=Tween<double>(begin: (widget.width!/widget.spProTabTitles!.length)*index,end: 1,).animate(spProAnimationController!);
    spProScaleController=AnimationController(duration: Duration(milliseconds: 200),vsync: this);
    spProAnimationScale=Tween<double>(begin: 0,end: 1,).animate(spProScaleController!);
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
             children:widget.spProTabTitles!.map((item){
               return Expanded(
                 child: GestureDetector(
                   behavior: HitTestBehavior.opaque,
                   child: Center(
                     child: Text(
                       item,style: TextStyle(color: Colors.white,fontSize:widget.fontSize,fontWeight: FontWeight.w400),
                     ),
                   ),
                   onTap: ()=>spFunStartAnmat(widget.spProTabTitles!.indexOf(item)),
                 ),
               );
             }).toList(),
           ),
         ),
         Positioned(
           left: animation!.value,
           width: widget.width!/widget.spProTabTitles!.length,
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
               child: Text(widget.spProTabTitles![spProPerIndex],style:TextStyle(color: MyColors.main1,fontSize: widget.fontSize,
                 fontWeight: FontWeight.w500,),

                 ),
             ),
           ) ,
         ),
       ],
    );
  }

  spFunStartAnmat(int index){
    var realWidth=widget.width!/widget.spProTabTitles!.length;
    animation=Tween<double>(begin:realWidth*spProPerIndex,end:realWidth*index,).animate(spProAnimationController!);
    animation!.addListener((){
      setState(() {});
    });
    animation!.addStatusListener((status){
     /* if(status==AnimationStatus.completed){
        spProScaleController.reset();
        spProScaleController.forward();
      }*/
    });
    spProAnimationController!.reset();
    spProAnimationController!.forward();
    spProPerIndex=index;

    if(widget.spProTabChanged!=null){
      widget.spProTabChanged!(index);
    }

  }
}