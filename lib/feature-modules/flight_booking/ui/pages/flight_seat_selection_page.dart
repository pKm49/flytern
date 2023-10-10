import 'package:flutter/material.dart';
import 'package:flytern/shared/data/constants/ui_constants/style_params.dart';
import 'package:flytern/shared/data/constants/ui_constants/widget_styles.dart';
import 'package:flytern/shared/services/utility-services/widget_generator.dart';
import 'package:flytern/shared/services/utility-services/widget_properties_generator.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class FlightSeatSelectionPage extends StatefulWidget {
  const FlightSeatSelectionPage({super.key});

  @override
  State<FlightSeatSelectionPage> createState() =>
      _FlightSeatSelectionPageState();
}

class _FlightSeatSelectionPageState extends State<FlightSeatSelectionPage> {

  int selectedRoute = 1;
  int selectedPassenger = 1;

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        title: Text('available_seats'.tr),
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
              child: Text("legend".tr,
                  style: getBodyMediumStyle(context).copyWith(
                      color: flyternGrey80, fontWeight: flyternFontWeightBold)),
            ),
            Container(
              color: flyternBackgroundWhite,
              padding: flyternLargePaddingAll,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  Expanded(
                    child: Row(
                      children: [
                        Icon(Ionicons.square,color: flyternTertiaryColor),
                        addHorizontalSpace(flyternSpaceMedium),
                        Text("available".tr,
                            style: getBodyMediumStyle(context)
                                .copyWith(color: flyternGrey80)),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Icon(Ionicons.square,color: flyternGrey40),
                        addHorizontalSpace(flyternSpaceMedium),
                        Text("occupied".tr,
                            style: getBodyMediumStyle(context)
                                .copyWith(color: flyternGrey80)),
                      ],
                    ),
                  ),

                ],
              ),
            ),

            Padding(
              padding: flyternLargePaddingAll,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text("business_class".tr,
                        style: getBodyMediumStyle(context).copyWith(
                            color: flyternGrey80, fontWeight: flyternFontWeightBold)),
                  ),
                  Icon(Ionicons.wifi,color: flyternGrey60,size: flyternFontSize20),
                  addHorizontalSpace(flyternSpaceSmall),
                  Icon(Ionicons.restaurant_outline,color: flyternGrey60,size: flyternFontSize20),
                  addHorizontalSpace(flyternSpaceSmall),
                  Icon(Ionicons.tv_outline,color: flyternGrey60,size: flyternFontSize20),
                ],
              ),
            ),
            Container(
              color: flyternBackgroundWhite,
              padding: flyternLargePaddingAll,
              height: 250,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("A",style: getBodyMediumStyle(context).copyWith(color: flyternGrey60)),
                            Icon(Ionicons.square,color: flyternTertiaryColor,size: flyternFontSize24*1.3),
                            Icon(Ionicons.square,color: flyternTertiaryColor,size: flyternFontSize24*1.3),
                            Icon(Ionicons.square,color: flyternGrey40,size: flyternFontSize24*1.3),
                            Icon(Ionicons.square,color: flyternGrey40,size: flyternFontSize24*1.3),
                          ],),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("B",style: getBodyMediumStyle(context).copyWith(color: flyternGrey60)),
                            Icon(Ionicons.square,color: flyternTertiaryColor,size: flyternFontSize24*1.3),
                            Icon(Ionicons.square,color: flyternTertiaryColor,size: flyternFontSize24*1.3),
                            Icon(Ionicons.square,color: flyternGrey40,size: flyternFontSize24*1.3),
                            Icon(Ionicons.square,color: flyternGrey40,size: flyternFontSize24*1.3),
                          ],),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("C",style: getBodyMediumStyle(context).copyWith(color: flyternGrey60)),
                            Icon(Ionicons.square,color: flyternGrey40,size: flyternFontSize24*1.3),
                            Icon(Ionicons.square,color: flyternGrey40,size: flyternFontSize24*1.3),
                            Icon(Ionicons.square,color: flyternTertiaryColor,size: flyternFontSize24*1.3),
                            Icon(Ionicons.square,color: flyternGrey40,size: flyternFontSize24*1.3),
                          ],),
                      ],
                    ),
                  ),
                  Padding(
                    padding: flyternLargePaddingHorizontal,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                      Text("",style: getBodyMediumStyle(context).copyWith(color: flyternGrey60)),
                      Text("2",style: getBodyMediumStyle(context).copyWith(color: flyternGrey60)),
                      Text("3",style: getBodyMediumStyle(context).copyWith(color: flyternGrey60)),
                      Text("4",style: getBodyMediumStyle(context).copyWith(color: flyternGrey60)),
                      Text("5",style: getBodyMediumStyle(context).copyWith(color: flyternGrey60)),
                    ],),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("D",style: getBodyMediumStyle(context).copyWith(color: flyternGrey60)),
                            Icon(Ionicons.square,color: flyternTertiaryColor,size: flyternFontSize24*1.3),
                            Icon(Ionicons.square,color: flyternTertiaryColor,size: flyternFontSize24*1.3),
                            Icon(Ionicons.square,color: flyternGrey40,size: flyternFontSize24*1.3),
                            Icon(Ionicons.square,color: flyternGrey40,size: flyternFontSize24*1.3),
                          ],),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("E",style: getBodyMediumStyle(context).copyWith(color: flyternGrey60)),
                            Icon(Ionicons.square,color: flyternTertiaryColor,size: flyternFontSize24*1.3),
                            Icon(Ionicons.square,color: flyternTertiaryColor,size: flyternFontSize24*1.3),
                            Icon(Ionicons.square,color: flyternGrey40,size: flyternFontSize24*1.3),
                            Icon(Ionicons.square,color: flyternGrey40,size: flyternFontSize24*1.3),
                          ],),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("F",style: getBodyMediumStyle(context).copyWith(color: flyternGrey60)),
                            Icon(Ionicons.square,color: flyternGrey40,size: flyternFontSize24*1.3),
                            Icon(Ionicons.square,color: flyternGrey40,size: flyternFontSize24*1.3),
                            Icon(Ionicons.square,color: flyternTertiaryColor,size: flyternFontSize24*1.3),
                            Icon(Ionicons.square,color: flyternGrey40,size: flyternFontSize24*1.3),
                          ],),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: flyternLargePaddingAll,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text("economy_class".tr,
                        style: getBodyMediumStyle(context).copyWith(
                            color: flyternGrey80, fontWeight: flyternFontWeightBold)),
                  ),
                  Icon(Ionicons.wifi,color: flyternGrey60,size: flyternFontSize20),
                  addHorizontalSpace(flyternSpaceSmall),
                  Icon(Ionicons.restaurant_outline,color: flyternGrey60,size: flyternFontSize20),
                  addHorizontalSpace(flyternSpaceSmall),
                  Icon(Ionicons.tv_outline,color: flyternGrey60,size: flyternFontSize20),
                ],
              ),
            ),
            Container(
              color: flyternBackgroundWhite,
              padding: flyternLargePaddingAll,
              height: 250,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("A",style: getBodyMediumStyle(context).copyWith(color: flyternGrey60)),
                            Icon(Ionicons.square,color: flyternTertiaryColor,size: flyternFontSize24*1.3),
                            Icon(Ionicons.square,color: flyternTertiaryColor,size: flyternFontSize24*1.3),
                            Icon(Ionicons.square,color: flyternGrey40,size: flyternFontSize24*1.3),
                            Icon(Ionicons.square,color: flyternGrey40,size: flyternFontSize24*1.3),
                          ],),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("B",style: getBodyMediumStyle(context).copyWith(color: flyternGrey60)),
                            Icon(Ionicons.square,color: flyternTertiaryColor,size: flyternFontSize24*1.3),
                            Icon(Ionicons.square,color: flyternTertiaryColor,size: flyternFontSize24*1.3),
                            Icon(Ionicons.square,color: flyternGrey40,size: flyternFontSize24*1.3),
                            Icon(Ionicons.square,color: flyternGrey40,size: flyternFontSize24*1.3),
                          ],),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("C",style: getBodyMediumStyle(context).copyWith(color: flyternGrey60)),
                            Icon(Ionicons.square,color: flyternGrey40,size: flyternFontSize24*1.3),
                            Icon(Ionicons.square,color: flyternGrey40,size: flyternFontSize24*1.3),
                            Icon(Ionicons.square,color: flyternTertiaryColor,size: flyternFontSize24*1.3),
                            Icon(Ionicons.square,color: flyternGrey40,size: flyternFontSize24*1.3),
                          ],),
                      ],
                    ),
                  ),
                  Padding(
                    padding: flyternLargePaddingHorizontal,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("",style: getBodyMediumStyle(context).copyWith(color: flyternGrey60)),
                        Text("2",style: getBodyMediumStyle(context).copyWith(color: flyternGrey60)),
                        Text("3",style: getBodyMediumStyle(context).copyWith(color: flyternGrey60)),
                        Text("4",style: getBodyMediumStyle(context).copyWith(color: flyternGrey60)),
                        Text("5",style: getBodyMediumStyle(context).copyWith(color: flyternGrey60)),
                      ],),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("D",style: getBodyMediumStyle(context).copyWith(color: flyternGrey60)),
                            Icon(Ionicons.square,color: flyternTertiaryColor,size: flyternFontSize24*1.3),
                            Icon(Ionicons.square,color: flyternTertiaryColor,size: flyternFontSize24*1.3),
                            Icon(Ionicons.square,color: flyternGrey40,size: flyternFontSize24*1.3),
                            Icon(Ionicons.square,color: flyternGrey40,size: flyternFontSize24*1.3),
                          ],),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("E",style: getBodyMediumStyle(context).copyWith(color: flyternGrey60)),
                            Icon(Ionicons.square,color: flyternTertiaryColor,size: flyternFontSize24*1.3),
                            Icon(Ionicons.square,color: flyternTertiaryColor,size: flyternFontSize24*1.3),
                            Icon(Ionicons.square,color: flyternGrey40,size: flyternFontSize24*1.3),
                            Icon(Ionicons.square,color: flyternGrey40,size: flyternFontSize24*1.3),
                          ],),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("F",style: getBodyMediumStyle(context).copyWith(color: flyternGrey60)),
                            Icon(Ionicons.square,color: flyternGrey40,size: flyternFontSize24*1.3),
                            Icon(Ionicons.square,color: flyternGrey40,size: flyternFontSize24*1.3),
                            Icon(Ionicons.square,color: flyternTertiaryColor,size: flyternFontSize24*1.3),
                            Icon(Ionicons.square,color: flyternGrey40,size: flyternFontSize24*1.3),
                          ],),
                      ],
                    ),
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
                child: Text("apply".tr)),
          ),
        ),
      ),
    );
  }
}
