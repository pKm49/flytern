import 'package:flutter/material.dart';
import 'package:flytern/feature-modules/flight_booking/ui/components/flight_airport_lable_card.dart';
import 'package:flytern/shared-module/constants/ui_specific/asset_urls.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/style_params.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/widget_styles.shared.constant.dart';
import 'package:flytern/shared-module/services/utility-services/widget_generator.shared.service.dart';
import 'package:flytern/shared-module/services/utility-services/widget_properties_generator.shared.service.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class UserDetailsCard extends StatelessWidget {
  String passportNumber;
  String name;
  String age;
  String gender;
  bool isActionAllowed;
  final GestureTapCallback onDelete;
  final GestureTapCallback onEdit;

  UserDetailsCard({super.key, required this.passportNumber,
    required this.name,
      required this.age,
      required this.isActionAllowed,
      required this.gender,
      required this.onDelete,
      required this.onEdit,
    });

  final ExpansionTileController controller = ExpansionTileController();

  @override
  Widget build(BuildContext context) {

    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Container(
      padding: flyternLargePaddingHorizontal,
      decoration: BoxDecoration(
          color: flyternBackgroundWhite,
          border: flyternDefaultBorderBottomOnly),
      child: Theme(
        data: ThemeData().copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding: EdgeInsets.zero,
          controller: controller,
          title:   Text(name),
          children: <Widget>[
            Padding(
              padding: flyternSmallPaddingVertical,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("gender".tr,style: getBodyMediumStyle(context).copyWith(color: flyternGrey60)),
                  Text(gender,style: getBodyMediumStyle(context).copyWith(color: flyternGrey80)),
                ],
              ),
            ),
            Visibility(
              visible: age !="",
              child: Container(
                  color:flyternBackgroundWhite,
                  child: Divider()),
            ),
            Visibility(
              visible: age !="",
              child: Padding(
                padding: flyternSmallPaddingVertical,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("age".tr,style: getBodyMediumStyle(context).copyWith(color: flyternGrey60)),
                    Text(age,style: getBodyMediumStyle(context).copyWith(color: flyternGrey80)),
                  ],
                ),
              ),
            ),
            Visibility(
              visible: passportNumber !="",
              child: Container(
                  color:flyternBackgroundWhite,
                  child: Divider()),
            ),
            Visibility(
              visible: passportNumber !="",
              child: Padding(
                padding: flyternSmallPaddingVertical,                    child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("passport_number".tr,style: getBodyMediumStyle(context).copyWith(color: flyternGrey60)),
                  Text(passportNumber,style: getBodyMediumStyle(context).copyWith(color: flyternGrey80)),
                ],
              ),
              ),
            ),

            Visibility(
                visible: isActionAllowed,
                child: Padding(
                  padding: flyternLargePaddingVertical,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
              children: [
                  InkWell(
                      onTap: onEdit,
                      child: Icon(Ionicons.create_outline,color: flyternPrimaryColor)),
                addHorizontalSpace(flyternSpaceSmall),
                InkWell(
                    onTap:onDelete ,child: Icon(Ionicons.trash_bin_outline,color: flyternGuideRed))
              ],
            ),
                ))
          ],
        ),
      ),
    );
  }
}
