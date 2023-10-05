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
  String title;
  String name;
  String email;
  String mobile;
  bool isActionAllowed;
    UserDetailsCard({super.key, required this.title,
    required this.name,
      required this.email,
      required this.isActionAllowed,
      required this.mobile
    });

  final ExpansionTileController controller = ExpansionTileController();

  @override
  Widget build(BuildContext context) {

    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Container(
      padding: flyternLargePaddingHorizontal,
      color: flyternBackgroundWhite,
      child: Theme(
        data: ThemeData().copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(

          tilePadding: EdgeInsets.zero,
          controller: controller,
          title:   Text(title),
          children: <Widget>[

            Padding(
              padding: flyternSmallPaddingVertical,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("full_name".tr,style: getBodyMediumStyle(context).copyWith(color: flyternGrey60)),
                  Text(name,style: getBodyMediumStyle(context).copyWith(color: flyternGrey80)),
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
                  Text("email_address".tr,style: getBodyMediumStyle(context).copyWith(color: flyternGrey60)),
                  Text(email,style: getBodyMediumStyle(context).copyWith(color: flyternGrey80)),
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
                Text("mobile_number".tr,style: getBodyMediumStyle(context).copyWith(color: flyternGrey60)),
                Text(mobile,style: getBodyMediumStyle(context).copyWith(color: flyternGrey80)),
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
