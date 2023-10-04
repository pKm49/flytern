import 'package:flutter/material.dart';
import 'package:flytern/feature-modules/flight_booking/ui/components/flight_details_itinerary_card.dart';
import 'package:flytern/shared/data/constants/ui_constants/style_params.dart';
import 'package:flytern/shared/data/constants/ui_constants/widget_styles.dart';
import 'package:flytern/shared/services/utility-services/widget_generator.dart';
import 'package:flytern/shared/services/utility-services/widget_properties_generator.dart';
import 'package:get/get.dart';

class FlightDetailsPage extends StatefulWidget {
  const FlightDetailsPage({super.key});

  @override
  State<FlightDetailsPage> createState() => _FlightDetailsPageState();
}

class _FlightDetailsPageState extends State<FlightDetailsPage> {


  @override
  Widget build(BuildContext context) {

    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        title: Text("flight_details".tr),
      ),
      body: Container(
        width: screenwidth,
        height: screenheight,
        color: flyternGrey10,
        child: ListView(
          children: [
            Padding(
              padding: flyternLargePaddingAll,
              child: Text("itinerary".tr,style: getHeadlineMediumStyle(context).copyWith(color: flyternGrey80,fontWeight: flyternFontWeightBold)),
            ),
            FlightDetailsItineraryCard(),
            addVerticalSpace(flyternSpaceLarge),
            FlightDetailsItineraryCard(),
            Padding(
              padding: flyternLargePaddingAll,
              child: Text("baggage".tr,style: getHeadlineMediumStyle(context).copyWith(color: flyternGrey80,fontWeight: flyternFontWeightBold)),
            ),
          ],
        ),
      ),
    );
  }
}
