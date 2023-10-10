import 'package:flutter/material.dart';
import 'package:flytern/shared/data/constants/ui_constants/asset_urls.dart';
import 'package:flytern/shared/data/constants/ui_constants/style_params.dart';
import 'package:flytern/shared/data/constants/ui_constants/widget_styles.dart';
import 'package:flytern/shared/services/utility-services/widget_generator.dart';
import 'package:flytern/shared/services/utility-services/widget_properties_generator.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class FlightMealSelectionPage extends StatefulWidget {
  const FlightMealSelectionPage({super.key});

  @override
  State<FlightMealSelectionPage> createState() =>
      _FlightMealSelectionPageState();
}

class _FlightMealSelectionPageState extends State<FlightMealSelectionPage> {

  int selectedRoute = 1;
  int selectedPassenger = 1;
  int selectedMeal = 1;

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        title: Text('select_meal'.tr),
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
              child: Text("select_meal".tr,
                  style: getBodyMediumStyle(context).copyWith(
                      color: flyternGrey80, fontWeight: flyternFontWeightBold)),
            ),
            Container(
              color: flyternBackgroundWhite,
              padding: flyternLargePaddingHorizontal.copyWith(top: flyternSpaceMedium,bottom: flyternSpaceSmall),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  Expanded(
                    child: Row(
                      children: [

                        Container(
                            decoration: BoxDecoration(
                              borderRadius:
                              BorderRadius.circular(flyternBorderRadiusExtraSmall),

                            ),
                            clipBehavior: Clip.hardEdge,
                            width: screenwidth*.15,
                            child: Image.asset(ASSETS_MEAL_1_SAMPLE,width: screenwidth*.15)),

                        addHorizontalSpace(flyternSpaceMedium),

                        Text("Burger",
                            style: getBodyMediumStyle(context)
                                .copyWith(color: flyternGrey80)),
                        addHorizontalSpace(flyternSpaceSmall),
                        Text("(AED 50)",
                            style: getBodyMediumStyle(context)
                                .copyWith(color: flyternGrey40)),
                      ],
                    ),
                  ),
                  Radio(
                    activeColor: flyternSecondaryColor,
                    value: 1,
                    groupValue: selectedMeal,
                    onChanged: (value) {
                      setState(() {
                        print(value);
                        selectedMeal = value!;
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

                        Container(
                            decoration: BoxDecoration(
                              borderRadius:
                              BorderRadius.circular(flyternBorderRadiusExtraSmall),

                            ),
                            clipBehavior: Clip.hardEdge,
                            width: screenwidth*.15,
                            child: Image.asset(ASSETS_MEAL_2_SAMPLE,width: screenwidth*.15)),

                        addHorizontalSpace(flyternSpaceMedium),

                        Text("Pizza",
                            style: getBodyMediumStyle(context)
                                .copyWith(color: flyternGrey80)),
                        addHorizontalSpace(flyternSpaceSmall),
                        Text("(AED 50)",
                            style: getBodyMediumStyle(context)
                                .copyWith(color: flyternGrey40)),
                      ],
                    ),
                  ),
                  Radio(
                    activeColor: flyternSecondaryColor,
                    value: 2,
                    groupValue: selectedMeal,
                    onChanged: (value) {
                      setState(() {
                        print(value);
                        selectedMeal = value!;
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

                        Container(
                            decoration: BoxDecoration(
                              borderRadius:
                              BorderRadius.circular(flyternBorderRadiusExtraSmall),

                            ),
                            clipBehavior: Clip.hardEdge,
                            width: screenwidth*.15,
                            child: Image.asset(ASSETS_MEAL_3_SAMPLE,width: screenwidth*.15)),

                        addHorizontalSpace(flyternSpaceMedium),

                        Text("Steak",
                            style: getBodyMediumStyle(context)
                                .copyWith(color: flyternGrey80)),
                        addHorizontalSpace(flyternSpaceSmall),
                        Text("(AED 50)",
                            style: getBodyMediumStyle(context)
                                .copyWith(color: flyternGrey40)),
                      ],
                    ),
                  ),
                  Radio(
                    activeColor: flyternSecondaryColor,
                    value: 2,
                    groupValue: selectedMeal,
                    onChanged: (value) {
                      setState(() {
                        print(value);
                        selectedMeal = value!;
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
