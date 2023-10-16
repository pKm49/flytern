import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flytern/shared/data/constants/ui_constants/style_params.dart';
import 'package:flytern/shared/data/constants/ui_constants/widget_styles.dart';
import 'package:flytern/shared/services/utility-services/widget_generator.dart';
import 'package:flytern/shared/services/utility-services/widget_properties_generator.dart';
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
