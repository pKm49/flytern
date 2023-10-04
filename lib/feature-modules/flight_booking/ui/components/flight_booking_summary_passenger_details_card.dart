import 'package:flutter/material.dart';
import 'package:flytern/feature-modules/flight_booking/ui/components/flight_airport_lable_card.dart';
import 'package:flytern/shared/data/constants/ui_constants/asset_urls.dart';
import 'package:flytern/shared/data/constants/ui_constants/style_params.dart';
import 'package:flytern/shared/data/constants/ui_constants/widget_styles.dart';
import 'package:flytern/shared/services/utility-services/widget_generator.dart';
import 'package:flytern/shared/services/utility-services/widget_properties_generator.dart';
import 'package:get/get.dart';

class FlightBookingSummaryPassengerDetailsCard extends StatelessWidget {
  String title;
  String name;
  String email;
  String mobile;
    FlightBookingSummaryPassengerDetailsCard({super.key, required this.title,
    required this.name,
      required this.email,
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
        ],
      ),
    );
  }
}
