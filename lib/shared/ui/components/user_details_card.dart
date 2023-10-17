import 'package:flutter/material.dart';
import 'package:flytern/feature-modules/flight_booking/ui/components/flight_airport_lable_card.dart';
import 'package:flytern/shared/data/constants/ui_constants/asset_urls.dart';
import 'package:flytern/shared/data/constants/ui_constants/style_params.dart';
import 'package:flytern/shared/data/constants/ui_constants/widget_styles.dart';
import 'package:flytern/shared/services/utility-services/widget_generator.dart';
import 'package:flytern/shared/services/utility-services/widget_properties_generator.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class UserDetailsCard extends StatelessWidget {
  String passportNumber;
  String name;
  String age;
  String gender;
  bool isActionAllowed;
    UserDetailsCard({super.key, required this.passportNumber,
    required this.name,
      required this.age,
      required this.isActionAllowed,
      required this.gender
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
            Container(
                color:flyternBackgroundWhite,
                child: Divider()),
            Padding(
              padding: flyternSmallPaddingVertical,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("age".tr,style: getBodyMediumStyle(context).copyWith(color: flyternGrey60)),
                  Text(age,style: getBodyMediumStyle(context).copyWith(color: flyternGrey80)),
                ],
              ),
            ),
            Container(
                color:flyternBackgroundWhite,
                child: Divider()),
            Padding(
              padding: flyternSmallPaddingVertical,                    child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("passport_number".tr,style: getBodyMediumStyle(context).copyWith(color: flyternGrey60)),
                Text(passportNumber,style: getBodyMediumStyle(context).copyWith(color: flyternGrey80)),
              ],
            ),
            ),

            Visibility(
                visible: isActionAllowed,
                child: Padding(
                  padding: flyternLargePaddingVertical,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
              children: [
                  Icon(Ionicons.create_outline,color: flyternPrimaryColor),
                addHorizontalSpace(flyternSpaceSmall),
                Icon(Ionicons.trash_bin_outline,color: flyternGuideRed)
              ],
            ),
                ))
          ],
        ),
      ),
    );
  }
}
