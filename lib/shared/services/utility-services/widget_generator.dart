import 'package:flutter/material.dart';

Widget addVerticalSpace(double height){
  return SizedBox(
    height: height,
    width: 1,
  );
}

Widget addHorizontalSpace(double width){
  return SizedBox(
    width: width,
    height: 1,
  );
}