import 'package:flutter/material.dart';
import 'package:flytern/shared-module/constants/ui_specific/style_params.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/widget_styles.shared.constant.dart';
import 'package:flytern/shared-module/services/utility-services/widget_generator.shared.service.dart';
import 'package:flytern/shared-module/services/utility-services/widget_properties_generator.shared.service.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class SectionTitleContainer extends StatelessWidget {

  bool isLarge;
  String name;
  String linkName;
  String linkUrl;

  SectionTitleContainer({super.key,
    required this.isLarge,
    required this.name,
    required this.linkName,
    required this.linkUrl
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 3,
          child: Text(
            name,
            style:isLarge? getHeadlineMediumStyle(context).copyWith(
                color: flyternGrey80,
                fontWeight: flyternFontWeightBold):
            getBodyMediumStyle(context).copyWith(
                color: flyternGrey80,
                fontWeight: flyternFontWeightBold),
          ),
        ),
        Expanded(
            flex: 1,
            child: InkWell(
              onTap: (){
                Get.toNamed(linkUrl);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    linkName,
                    style: getBodyMediumStyle(context)
                        .copyWith(color: flyternTertiaryColor),
                  ),
                  addHorizontalSpace(flyternSpaceExtraSmall),
                  Icon(Ionicons.chevron_forward,
                      color: flyternTertiaryColor,
                      size: flyternFontSize20)
                ],
              ),
            ))
      ],
    );
  }

}
