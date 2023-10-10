import 'package:flutter/material.dart';
import 'package:flytern/shared/data/constants/ui_constants/style_params.dart';
import 'package:flytern/shared/data/constants/ui_constants/widget_styles.dart';
import 'package:flytern/shared/services/utility-services/widget_generator.dart';
import 'package:flytern/shared/services/utility-services/widget_properties_generator.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class FlightBaggageSelectionPage extends StatefulWidget {
  const FlightBaggageSelectionPage({super.key});

  @override
  State<FlightBaggageSelectionPage> createState() =>
      _FlightBaggageSelectionPageState();
}

class _FlightBaggageSelectionPageState extends State<FlightBaggageSelectionPage> {

  int selectedRoute = 1;
  int selectedPassenger = 1;
  int selectedBaggage = 1;

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        title: Text('select_baggage'.tr),
      ),
      body: Container(
        width: screenwidth,
        height: screenheight,
        color: flyternGrey10,
        child: ListView(
          children: [
            Padding(
              padding: flyternLargePaddingAll,
              child: Text("route".tr,
                  style: getBodyMediumStyle(context).copyWith(
                      color: flyternGrey80, fontWeight: flyternFontWeightBold)),
            ),
            Container(
              color: flyternBackgroundWhite,
              padding: flyternLargePaddingHorizontal.copyWith(top: flyternSpaceMedium),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  Text("IST to KBL",
                      style: getBodyMediumStyle(context)
                          .copyWith(color: flyternGrey80)),
                  Radio(
                    activeColor: flyternSecondaryColor,
                    value: 1,
                    groupValue: selectedRoute,
                    onChanged: (value) {
                      setState(() {
                        print(value);
                        selectedRoute = value!;
                      });
                    },
                  ),
                ],
              ),
            ),
            Container(
                color: flyternBackgroundWhite,
                padding: flyternLargePaddingHorizontal,
                child: Divider()),
            Container(
              color: flyternBackgroundWhite,
              padding: flyternLargePaddingHorizontal.copyWith(bottom: flyternSpaceMedium),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  Text("KBL to IST",
                      style: getBodyMediumStyle(context)
                          .copyWith(color: flyternGrey80)),
                  Radio(
                    activeColor: flyternSecondaryColor,
                    value: 2,
                    groupValue: selectedRoute,
                    onChanged: (value) {
                      setState(() {
                        print(value);
                        selectedRoute = value!;
                      });
                    },
                  ),
                ],
              ),
            ),

            Padding(
              padding: flyternLargePaddingAll,
              child: Text("passengers".tr,
                  style: getBodyMediumStyle(context).copyWith(
                      color: flyternGrey80, fontWeight: flyternFontWeightBold)),
            ),
            Container(
              color: flyternBackgroundWhite,
              padding: flyternLargePaddingHorizontal.copyWith(top: flyternSpaceMedium),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  Text("Adult - Andrew Martin",
                      style: getBodyMediumStyle(context)
                          .copyWith(color: flyternGrey80)),
                  Radio(
                    activeColor: flyternSecondaryColor,
                    value: 1,
                    groupValue: selectedPassenger,
                    onChanged: (value) {
                      setState(() {
                        print(value);
                        selectedPassenger = value!;
                      });
                    },
                  ),
                ],
              ),
            ),
            Container(
                color: flyternBackgroundWhite,
                padding: flyternLargePaddingHorizontal,
                child: Divider()),
            Container(
              color: flyternBackgroundWhite,
              padding: flyternLargePaddingHorizontal.copyWith(bottom: flyternSpaceMedium),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  Text("Child - John Murphy",
                      style: getBodyMediumStyle(context)
                          .copyWith(color: flyternGrey80)),
                  Radio(
                    activeColor: flyternSecondaryColor,
                    value: 2,
                    groupValue: selectedPassenger,
                    onChanged: (value) {
                      setState(() {
                        print(value);
                        selectedPassenger = value!;
                      });
                    },
                  ),
                ],
              ),
            ),


            Padding(
              padding: flyternLargePaddingAll,
              child: Text("select_baggage".tr,
                  style: getBodyMediumStyle(context).copyWith(
                      color: flyternGrey80, fontWeight: flyternFontWeightBold)),
            ),
            Container(
              color: flyternBackgroundWhite,
              padding: flyternLargePaddingHorizontal.copyWith(top: flyternSpaceMedium),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Text("Free",
                            style: getBodyMediumStyle(context)
                                .copyWith(color: flyternGrey80)),
                        addHorizontalSpace(flyternSpaceSmall),
                        Text("(20kg pcs)",
                            style: getBodyMediumStyle(context)
                                .copyWith(color: flyternGrey40)),
                      ],
                    ),
                  ),
                  Radio(
                    activeColor: flyternSecondaryColor,
                    value: 1,
                    groupValue: selectedBaggage,
                    onChanged: (value) {
                      setState(() {
                        print(value);
                        selectedBaggage = value!;
                      });
                    },
                  ),
                ],
              ),
            ),
            Container(
                color: flyternBackgroundWhite,
                padding: flyternLargePaddingHorizontal,
                child: Divider()),
            Container(
              color: flyternBackgroundWhite,
              padding: flyternLargePaddingHorizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Text("AED 100",
                            style: getBodyMediumStyle(context)
                                .copyWith(color: flyternGrey80)),
                        addHorizontalSpace(flyternSpaceSmall),
                        Text("(30kg pcs)",
                            style: getBodyMediumStyle(context)
                                .copyWith(color: flyternGrey40)),
                      ],
                    ),
                  ),
                  Radio(
                    activeColor: flyternSecondaryColor,
                    value: 2,
                    groupValue: selectedBaggage,
                    onChanged: (value) {
                      setState(() {
                        print(value);
                        selectedBaggage = value!;
                      });
                    },
                  ),
                ],
              ),
            ),
            Container(
                color: flyternBackgroundWhite,
                padding: flyternLargePaddingHorizontal,
                child: Divider()),
            Container(
              color: flyternBackgroundWhite,
              padding: flyternLargePaddingHorizontal.copyWith(bottom: flyternSpaceMedium),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  Expanded(
                    child: Row(
                      children: [
                        Text("AED 150",
                            style: getBodyMediumStyle(context)
                                .copyWith(color: flyternGrey80)),
                        addHorizontalSpace(flyternSpaceSmall),
                        Text("(40kg pcs)",
                            style: getBodyMediumStyle(context)
                                .copyWith(color: flyternGrey40)),
                      ],
                    ),
                  ),
                  Radio(
                    activeColor: flyternSecondaryColor,
                    value: 2,
                    groupValue: selectedBaggage,
                    onChanged: (value) {
                      setState(() {
                        print(value);
                        selectedBaggage = value!;
                      });
                    },
                  ),
                ],
              ),
            ),




            Container(
              height: 70+(flyternSpaceSmall*2),
              padding: flyternLargePaddingAll,
            )
          ],
        ),
      ),
      bottomSheet: Container(
        width: screenwidth,
        color: flyternBackgroundWhite,
        height: 60 + (flyternSpaceSmall * 2),
        padding: flyternLargePaddingAll.copyWith(
            top: flyternSpaceSmall, bottom: flyternSpaceSmall),
        child: Center(
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(style: getElevatedButtonStyle(context),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("add".tr)),
          ),
        ),
      ),
    );
  }
}
