import 'package:flutter/material.dart';
import 'package:flytern/feature-modules/flight_booking/controllers/flight_booking_controller.dart';
import 'package:flytern/shared/data/constants/ui_constants/asset_urls.dart';
import 'package:flytern/shared/data/constants/ui_constants/style_params.dart';
import 'package:flytern/shared/data/constants/ui_constants/widget_styles.dart';
import 'package:flytern/shared/services/utility-services/widget_generator.dart';
import 'package:flytern/shared/services/utility-services/widget_properties_generator.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class FlightMealSelectionPage extends StatefulWidget {
  const FlightMealSelectionPage({super.key});

  @override
  State<FlightMealSelectionPage> createState() =>
      _FlightMealSelectionPageState();
}

class _FlightMealSelectionPageState extends State<FlightMealSelectionPage> {

  String selectedMeal = "1";
  final flightBookingController = Get.find<FlightBookingController>();

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Obx(
          () => Scaffold(
        appBar: AppBar(
          elevation: 0.5,
          title: Text('select_meal'.tr),
        ),
            body: Stack(
              children: [
                Visibility(
                    visible: flightBookingController.isGetMealsLoading.value,
                    child: Center(
                        child: LoadingAnimationWidget.prograssiveDots(
                          color: flyternSecondaryColor,
                          size: 50,
                        ))),
                Visibility(
                  visible: !flightBookingController.isGetMealsLoading.value,
                  child: Container(
                    width: screenwidth,
                    height: screenheight,
                    color: flyternGrey10,
                    child: ListView(
                      children: [
                        Padding(
                          padding: flyternLargePaddingAll,
                          child: Text("route".tr,
                              style: getBodyMediumStyle(context).copyWith(
                                  color: flyternGrey80,
                                  fontWeight: flyternFontWeightBold)),
                        ),
                        for (var i = 0;
                        i < flightBookingController.addonRoutes.length;
                        i++)
                          Container(
                            decoration: BoxDecoration(
                                color: flyternBackgroundWhite,
                                border: flyternDefaultBorderBottomOnly),
                            padding: flyternLargePaddingHorizontal.copyWith(
                                top: flyternSpaceMedium,
                                bottom: i ==
                                    flightBookingController.addonRoutes.length -
                                        1
                                    ? flyternSpaceMedium
                                    : 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                    flightBookingController
                                        .addonRoutes[i].groupName,
                                    style: getBodyMediumStyle(context)
                                        .copyWith(color: flyternGrey80)),
                                Radio(
                                  activeColor: flyternSecondaryColor,
                                  value: flightBookingController
                                      .addonRoutes[i].routeID,
                                  groupValue: flightBookingController.selectedRouteForMeal.value,
                                  onChanged: (value) {
                                    setState(() {
                                      if(value !=null){
                                        flightBookingController.changeSelectedRouteForMeal(value) ;
                                      }
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
                                  color: flyternGrey80,
                                  fontWeight: flyternFontWeightBold)),
                        ),
                        for (var i = 0;
                        i < flightBookingController.addonPassengers.length;
                        i++)
                          Container(
                            decoration: BoxDecoration(
                                color: flyternBackgroundWhite,
                                border: flyternDefaultBorderBottomOnly),
                            padding: flyternLargePaddingHorizontal.copyWith(
                                top: flyternSpaceMedium,
                                bottom: i ==
                                    flightBookingController
                                        .addonPassengers.length -
                                        1
                                    ? flyternSpaceMedium
                                    : 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                    flightBookingController
                                        .addonPassengers[i].fullName,
                                    style: getBodyMediumStyle(context)
                                        .copyWith(color: flyternGrey80)),
                                Radio(
                                  activeColor: flyternSecondaryColor,
                                  value: flightBookingController
                                      .addonPassengers[i].passengerID,
                                  groupValue: flightBookingController.selectedPassengerForMeal.value,
                                  onChanged: (value) {
                                    setState(() {
                                      print(value);
                                      if(value !=null){
                                        flightBookingController.changeSelectedPassengerForMeal(value) ;
                                      }
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
                        for (var i = 0;
                        i < flightBookingController.addonMeals.length;
                        i++)
                          Visibility(
                            visible: flightBookingController
                                .addonMeals[i].routeID ==
                                flightBookingController.selectedRouteForMeal.value,
                          child: Container(
                            decoration: BoxDecoration(
                                color: flyternBackgroundWhite,
                                border: flyternDefaultBorderBottomOnly),
                            padding: flyternLargePaddingHorizontal.copyWith(
                                top: flyternSpaceSmall,
                                bottom: flyternSpaceSmall),child: Row(
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
                                          child:
                                          Image.network(
                                            flightBookingController.addonMeals
                                                .value[i].name,
                                            width: screenwidth * .15,
                                            height: screenwidth * .15,
                                            errorBuilder:
                                                (context, error, stackTrace) {
                                              return Container(
                                                color: flyternGrey20,
                                                  width: screenwidth * .15,
                                                  height: screenwidth * .15);
                                            },
                                          )),

                                      addHorizontalSpace(flyternSpaceMedium),

                                      Text(flightBookingController.addonMeals
                                          .value[i].name,
                                          style: getBodyMediumStyle(context)
                                              .copyWith(color: flyternGrey80)),
                                      addHorizontalSpace(flyternSpaceSmall),
                                      Text("(${flightBookingController.addonMeals
                                          .value[i].unit} ${flightBookingController.addonMeals
                                          .value[i].price})",
                                          style: getBodyMediumStyle(context)
                                              .copyWith(color: flyternGrey40)),
                                    ],
                                  ),
                                ),
                                Radio(
                                  activeColor: flyternSecondaryColor,
                                  value: "${flightBookingController.addonMeals
                                    .value[i].mealId}",
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
                        ),
                        Container(
                          height: 70 + (flyternSpaceSmall * 2),
                          padding: flyternLargePaddingAll,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            bottomSheet: !flightBookingController.isGetMealsLoading.value
                ? Container(
              width: screenwidth,
              color: flyternBackgroundWhite,
              height: 60 + (flyternSpaceSmall * 2),
              padding: flyternLargePaddingAll.copyWith(
                  top: flyternSpaceSmall, bottom: flyternSpaceSmall),
              child: Center(
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      style: getElevatedButtonStyle(context),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("apply".tr)),
                ),
              ),
            )
                : Container(width: screenwidth, height: 10),
      
      ),
    );
  }
}
