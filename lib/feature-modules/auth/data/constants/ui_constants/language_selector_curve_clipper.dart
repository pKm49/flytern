import 'package:flutter/material.dart';
import 'package:flytern/shared-module/constants/ui_specific/style_params.shared.constant.dart';

class LanguageSelectorCurveClipper extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {

    Path path_0 = Path();
    path_0.moveTo(128.5,42.581689);
    path_0.cubicTo(89.8376,-5.4933112,23.91,-2.3263112,0,2.7036888);
    path_0.lineTo(0,309.99969);
    path_0.lineTo(489.837,309.99969);
    path_0.lineTo(489.837,71.267689);
    path_0.cubicTo(494.423,26.880689000000004,407.24699999999996,-32.304311,318.267,64.234689);
    path_0.cubicTo(230,159.99969,187.632,116.10969,128.5,42.581689);
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