import 'package:flutter/material.dart';
import 'package:flytern/shared-module/data/constants/ui_constants/style_params.dart';

class AuthSelectorCurveClipper extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {

    Path path_0 = Path();
    path_0.moveTo(size.width*0.2617108,size.height*0.8626387);
    path_0.cubicTo(size.width*0.1829686,size.height*1.017719,size.width*0.04869654,size.height*1.007503,0,size.height*0.9912774);
    path_0.lineTo(0,0);
    path_0.lineTo(size.width*0.9976314,0);
    path_0.lineTo(size.width*0.9976314,size.height*0.7701032);
    path_0.cubicTo(size.width*1.006971,size.height*0.9132871,size.width*0.8294236,size.height*1.104206,size.width*0.6482016,size.height*0.7927903);
    path_0.cubicTo(size.width*0.4684318,size.height*0.4838710,size.width*0.3821426,size.height*0.6254516,size.width*0.2617108,size.height*0.8626387);
    path_0.close();

    Paint paint_0_fill = Paint()..style=PaintingStyle.fill;
    paint_0_fill.color = flyternBackgroundWhite;
    canvas.drawPath(path_0,paint_0_fill);

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}