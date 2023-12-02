import 'package:flutter/material.dart';
import 'package:flytern/shared-module/constants/ui_specific/style_params.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/widget_styles.shared.constant.dart';
import 'package:flytern/shared-module/services/utility-services/widget_generator.shared.service.dart';
import 'package:flytern/shared-module/services/utility-services/widget_properties_generator.shared.service.dart';
import 'package:get/get.dart';
class ConfirmDialogue extends StatelessWidget {

  GestureTapCallback onClick;
  String titleKey;
  String subtitleKey;

  ConfirmDialogue({super.key, required this.onClick, required this.titleKey, required this.subtitleKey});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.all(Radius.circular(flyternBorderRadiusSmall))),
      contentPadding: flyternMediumPaddingAll,
      content: SizedBox(
        height:subtitleKey !=''?
              80+(flyternSpaceMedium*5)
            : 35 + (flyternSpaceMedium * 4),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              titleKey,
              style: getHeadlineMediumStyle(context)
                  .copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            Visibility(
                visible: subtitleKey != '',
                child: addVerticalSpace(flyternSpaceMedium)),

            Visibility(
              visible: subtitleKey != '',
              child: Text(
                subtitleKey,
                style: getBodyMediumStyle(context),textAlign: TextAlign.center,
              ),
            ),
            addVerticalSpace(flyternSpaceMedium),
            Divider(
              thickness: 1.5,
            ) ,
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: InkWell(
                    onTap: () {
                    Navigator.pop(context);
                  },
                    child:  Container(
                      padding: flyternSmallPaddingVertical,
                      child: Text(
                      "no".tr,
                      style: getBodyMediumStyle(context).copyWith(
                        fontWeight: flyternFontWeightBold,
                       color: flyternPrimaryColor
                      ),
                      textAlign: TextAlign.center,
                  ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: InkWell(
                    onTap: () {
                    onClick();
                  },
                    child:  Container(
                      padding: flyternSmallPaddingVertical,
                      child: Text(
                      "yes".tr,
                      style: getBodyMediumStyle(context)
                          .copyWith(fontWeight: FontWeight.bold,color: flyternGuideRed),
                      textAlign: TextAlign.center,
                  ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
