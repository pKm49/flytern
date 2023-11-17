import 'package:flutter/material.dart';
import 'package:flytern/shared/data/constants/ui_constants/style_params.dart';
import 'package:flytern/shared/services/utility-services/widget_properties_generator.dart';
import 'package:get/get.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {

    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text("notifications".tr),
      ),
      body: Container(
        width: screenwidth,
        height: screenheight,
        child: Stack(
          children: [
            Container(
              width: screenwidth,
              height: screenheight,
              color: flyternGrey10,
              child: Center(
                child: Text("no_item".tr,style: getBodyMediumStyle(context)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
