import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flytern/shared-module/constants/ui_specific/style_params.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/widget_styles.shared.constant.dart';
import 'package:flytern/shared-module/services/utility-services/widget_generator.shared.service.dart';
import 'package:flytern/shared-module/services/utility-services/widget_properties_generator.shared.service.dart';
import 'package:get/get.dart';

class SharedHtmlViewerPage extends StatelessWidget {

  String title;
  String htmlData;
  SharedHtmlViewerPage({super.key, required this.htmlData, required this.title});

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Container(
      height: screenheight*.85,
      width: screenwidth,
      padding: flyternLargePaddingAll,
      child: Column(
        children: [
          Text(title,
              style: getHeadlineMediumStyle(context).copyWith(
                  color: flyternGrey80, fontWeight: flyternFontWeightBold),textAlign: TextAlign.center),
          addVerticalSpace(flyternSpaceMedium),
          Expanded(child: SingleChildScrollView(
            child: Html(
              data: htmlData,
            ),
          ))
        ],
      ),
    );
  }
}
