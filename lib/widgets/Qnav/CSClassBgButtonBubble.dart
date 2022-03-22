
import 'package:changshengh5/utils/colors.dart';
import 'package:flutter/material.dart';

class CSClassBgButtonBubble extends CustomPainter{
  final csProHeightOffset=15;
  late Paint csProPaint = new Paint();
  double ?csProTransformOffset;
  CSClassBgButtonBubble({this.csProTransformOffset}){

    if(csProPaint==null){
      csProPaint =Paint()
        ..isAntiAlias=true
        ..strokeCap=StrokeCap.round
        ..style=PaintingStyle.fill
        ..strokeJoin=StrokeJoin.round;
  }

  }

  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    var centerOffset=Offset(size.width /2,size.height/2);
    var radius= ((size.height/2)*0.7);
    var anchorControlOffset=radius*0.8;
    var dipControlOffset=radius*0.55;
    final x0 = centerOffset.dx;
    final x1 = centerOffset.dx;
    final y=-1.0;

    csProPaint.shader=null;
    if(csProTransformOffset!>0){
      csProPaint.color=Colors.white;

      final path = Path()
        ..moveTo(0, csProHeightOffset*csProTransformOffset!)
        ..lineTo(x0-radius-anchorControlOffset,  csProHeightOffset*csProTransformOffset!)
        ..lineTo(x0-radius-anchorControlOffset, csProHeightOffset*csProTransformOffset!)
        ..cubicTo(x0 - radius + 2, dipControlOffset, x0 - anchorControlOffset, y, x0, y)
        ..lineTo(x1, y)
        ..cubicTo(x1 + anchorControlOffset, y, x1 + radius - 2, dipControlOffset, x0+radius+anchorControlOffset, csProHeightOffset*csProTransformOffset!)
        ..lineTo( x0+radius+anchorControlOffset, csProHeightOffset*csProTransformOffset!)
        ..lineTo( size.width, csProHeightOffset*csProTransformOffset!)
        ..lineTo(size.width, size.height)
        ..lineTo(0, size.height);

     canvas.drawPath(path, csProPaint);
    }




    if(csProPaint.shader==null){
      csProPaint.shader=new LinearGradient(colors:[MyColors.main1,MyColors.main1]).createShader(Rect.fromCenter(center: centerOffset,width: radius*2,height:radius*2));
    }
    canvas.drawCircle(centerOffset, radius, csProPaint);
    if(csProTransformOffset!>0){
      var tranheight=csProTransformOffset;
      if(tranheight==1){
        tranheight=0;
      }
      Path path =Path()
        ..moveTo(centerOffset.dx-radius*0.93, centerOffset.dy+radius*0.4)
        ..quadraticBezierTo(centerOffset.dx, size.height+(radius*0.6)*tranheight!, centerOffset.dx+radius*0.93, centerOffset.dy+radius*0.4);
      canvas.drawPath(path, csProPaint);

    }




  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }



}