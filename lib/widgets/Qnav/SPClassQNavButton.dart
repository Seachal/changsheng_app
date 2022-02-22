import 'package:changshengh5/untils/SPClassCommonMethods.dart';
import 'package:flutter/material.dart';

import 'SPClassBgButtonBubble.dart';


class SPClassQNavButton extends StatefulWidget{
  SPClassQNavTab ?spProTabView;
  double ?spProNavHeight ;
  double ?spProTextSize ;
  bool ?selected;
  final VoidCallback ?spProOnPress;
  SPClassQNavButton({this.spProTabView,this.spProNavHeight,this.selected,this.spProTextSize,this.spProOnPress});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SPClassQNavButtonState();
  }


}

class SPClassQNavButtonState extends State<SPClassQNavButton> with TickerProviderStateMixin<SPClassQNavButton> {
  double spProMaxOffset=15;
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
      spFunStartAnimation();
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
            SizedBox(width:viewWidth,height: widget.spProNavHeight,),
            Positioned(
              child:Container(
                transform: Matrix4.translationValues(0, widget.selected!? -(spProMaxOffset*_animation!.value):0, 0),
                child: CustomPaint(
                  painter:widget.selected!?  SPClassBgButtonBubble(spProTransformOffset: _animation!.value):null,
                  child: Container(
                    margin: widget.selected!? null: EdgeInsets.only(bottom: height(14)),
                    alignment: Alignment.center,
                    child: Container(
                      constraints:BoxConstraints.tight(Size( width(27),width(27))),
                      child: Image.asset(widget.spProTabView!.spProTabImage!,color: widget.selected!? Colors.white:null,),
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
              child:Text(widget.spProTabView!.spProTabText!,style:TextStyle(color: widget.selected!? Color(0xFF1B8DE0):Color(0xFFA8A8A8),fontSize: widget.spProTextSize
              ),),
              bottom: height(5),),
            (widget.selected!||widget.spProTabView!.badge==0)?  SizedBox():Positioned(
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
        onTap: ()=>widget.spProOnPress!(),
      ),
    );
  }


  @override
  void didUpdateWidget(oldWidget) {
    spFunStartAnimation();
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _animationController!.dispose();
    super.dispose();
  }

  void spFunStartAnimation() {
    if(widget.selected!&&!_animationWidthController!.isAnimating){
      _animationWidthController!.forward();
    }else{
      _animationController!.reverse();
      _animationWidthController!.reverse();
    }
  }
}

class  SPClassQNavTab{
  String ?spProTabText;
  String ?spProTabImage;
  int badge =0;

  SPClassQNavTab({this.spProTabText, this.spProTabImage,this.badge:0});
}