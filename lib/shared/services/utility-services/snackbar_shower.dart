import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flytern/shared/data/constants/ui_constants/style_params.dart';
import 'package:get/get.dart';

showSnackbar(   text, type){
  Get.snackbar(
    text,
    "",
    colorText: flyternBackgroundWhite,
    backgroundColor: type =='error'?flyternGuideRed:flyternGuideGreen,
    snackPosition: SnackPosition.BOTTOM
  );
}

showToaster( BuildContext context ,Color color,String text){

  FToast fToast = FToast();
  fToast.init(context);
  print("showToaster showToaster");
  double screenwidth = MediaQuery.of(context).size.width;

  Widget toast = Container(
    width: screenwidth - (flyternSpaceMedium * 2),
    height: 60,
    padding: const EdgeInsets.all(flyternSpaceSmall),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25.0),
      color: color,
    ),
    clipBehavior: Clip.hardEdge,
    child: Center(child: Text(text,maxLines: 2,style: TextStyle(color: flyternBackgroundWhite))),
  );


  fToast.showToast(
    child: toast,
    gravity: ToastGravity.BOTTOM,
    toastDuration: Duration(seconds: 2),
  );
  // Fluttertoast.showToast(
  //     msg: text,
  //     toastLength: Toast.LENGTH_LONG,
  //     gravity: ToastGravity.CENTER,
  //     timeInSecForIosWeb: 1,
  //     backgroundColor: Colors.green,
  //     textColor: Colors.white,
  //     fontSize: 16.0
  // );
}
