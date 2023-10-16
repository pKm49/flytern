import 'package:flutter/material.dart';
import 'package:flytern/shared/data/constants/ui_constants/style_params.dart';
import 'package:flytern/shared/data/constants/ui_constants/widget_styles.dart';
import 'package:flytern/shared/services/utility-services/widget_generator.dart';
import 'package:flytern/shared/services/utility-services/widget_properties_generator.dart';
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
            ),
            addVerticalSpace(flyternSpaceMedium),
            Row(
              children: [
                Expanded(
                    child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "no".tr,
                    style: getBodyMediumStyle(context).copyWith(
                      fontWeight: flyternFontWeightBold,
                     color: flyternPrimaryColor
                    ),
                    textAlign: TextAlign.center,
                  ),
                )),
                Expanded(
                    child: InkWell(
                  onTap: () {
                    onClick();
                  },
                  child: Text(
                    "yes".tr,
                    style: getBodyMediumStyle(context)
                        .copyWith(fontWeight: FontWeight.bold,color: flyternGuideRed),
                    textAlign: TextAlign.center,
                  ),
                ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
