import 'package:changshengh5/utils/CSClassCommonMethods.dart';
import 'package:flutter/material.dart';

import 'CSClassBgButtonBubble.dart';


class CSClassQNavButton extends StatefulWidget{
  CSClassQNavTab ?csProTabView;
  double ?csProNavHeight ;
  double ?csProTextSize ;
  bool ?selected;
  final VoidCallback ?csProOnPress;
  CSClassQNavButton({this.csProTabView,this.csProNavHeight,this.selected,this.csProTextSize,this.csProOnPress});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CSClassQNavButtonState();
  }


}

class CSClassQNavButtonState extends State<CSClassQNavButton> with TickerProviderStateMixin<CSClassQNavButton> {
  double csProMaxOffset=15;
   AnimationController ?_animationController;
   AnimationController ?_animationWidthController;
   CurvedAnimation ?_animation;
  @override
  void initState() {
    // TODO: implement initState
    _animationController=AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 350),
    );
    _animationWidthController=AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 250),
    );


    _animation= CurvedAnimation(parent: Tween<double>(begin: 0, end: 1.0).animate(_animationController!),curve:  Curves.bounceOut);
    _animation?.addListener((){
      setState(() {});
    });
    _animationWidthController?.addStatusListener((status){
      if(status==AnimationStatus.completed){
      _animationController?.forward();
      };
    });

    if(widget.selected!){
      csMethodStartAnimation();
    }
    super.initState();

  }
  @override
  Widget build(BuildContext context) {

   final  viewWidth=MediaQuery.of(context).size.width;
    // TODO: implement build
    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        child:Stack(
          alignment: Alignment.center,
          children: <Widget>[
            SizedBox(width:viewWidth,height: widget.csProNavHeight,),
            Positioned(
              child:Container(
                transform: Matrix4.translationValues(0, widget.selected!? -(csProMaxOffset*_animation!.value):0, 0),
                child: CustomPaint(
                  painter:widget.selected!?  CSClassBgButtonBubble(csProTransformOffset: _animation!.value):null,
                  child: Container(
                    margin: widget.selected!? null: EdgeInsets.only(bottom: height(14)),
                    alignment: Alignment.center,
                    child: Container(
                      constraints:BoxConstraints.tight(Size( width(27),width(27))),
                      child: Image.asset(widget.csProTabView!.csProTabImage!,color: widget.selected!? Colors.white:null,),
                    ),
                  ),
                ),
              ),
              top: 0,
              left: 0,
              right: 0,
              bottom: 0,
            ),
            Positioned(
              child:Text(widget.csProTabView!.csProTabText!,style:TextStyle(color: widget.selected!? Color(0xFF1B8DE0):Color(0xFFA8A8A8),fontSize: widget.csProTextSize
              ),),
              bottom: height(5),),
            (widget.selected!||widget.csProTabView!.badge==0)?  SizedBox():Positioned(
              child:Container(
                width: 10,
                height: 10,
                margin: EdgeInsets.only(left:width(27)),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFDE3C31),
                ),
              ),
              top: 5,
              right: 0,
              left: 0,
            ),
          ],
        ),
        onTap: ()=>widget.csProOnPress!(),
      ),
    );
  }


  @override
  void didUpdateWidget(oldWidget) {
    csMethodStartAnimation();
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _animationController!.dispose();
    super.dispose();
  }

  void csMethodStartAnimation() {
    if(widget.selected!&&!_animationWidthController!.isAnimating){
      _animationWidthController!.forward();
    }else{
      _animationController!.reverse();
      _animationWidthController!.reverse();
    }
  }
}

class  CSClassQNavTab{
  String ?csProTabText;
  String ?csProTabImage;
  int badge =0;

  CSClassQNavTab({this.csProTabText, this.csProTabImage,this.badge:0});
}