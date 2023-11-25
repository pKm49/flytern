import 'package:flutter/material.dart';
import 'package:flytern/feature-modules/flight_booking/controllers/flight_booking_controller.dart';
import 'package:flytern/feature-modules/flight_booking/ui/components/flight_addon_services_item_card.dart';
  import 'package:flytern/shared-module/constants/app_specific/route_names.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/asset_urls.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/style_params.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/widget_styles.shared.constant.dart';
import 'package:flytern/shared-module/services/utility-services/toaster_snackbar_shower.shared.service.dart';
 import 'package:flytern/shared-module/services/utility-services/widget_properties_generator.shared.service.dart';
import 'package:flytern/shared-module/ui/components/contact_details_getter.shared.component.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class FlightAddonServicesPage extends StatefulWidget {
  const FlightAddonServicesPage({super.key});

  @override
  State<FlightAddonServicesPage> createState() => _FlightAddonServicesPageState();
}

class _FlightAddonServicesPageState extends State<FlightAddonServicesPage> {

  final flightBookingController = Get.find<FlightBookingController>();

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Obx(
      ()=> Scaffold(
        appBar: AppBar(
          elevation: 0.5,
          title: Text("add_ons".tr),
        ),
        body: Container(
          width: screenwidth,
          height: screenheight,
          color: flyternGrey10,
          child: ListView(
            children: [
              Padding(
                padding: flyternLargePaddingAll,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("add_on_services".tr,
                        style: getBodyMediumStyle(context).copyWith(
                            color: flyternGrey80, fontWeight: flyternFontWeightBold)),
                    Text("flight_details".tr,
                        style: getBodyMediumStyle(context).copyWith(
                      decoration: TextDecoration.underline,
                            color: flyternTertiaryColor )),
                  ],
                ),
              ),

              Visibility(
                visible: flightBookingController.isSeatSelection.value,
                child: FlightAddonServicesItemCard(
                  onPressed: (){
                    flightBookingController.getSeats();
                  },
                  isComplete: flightBookingController.isSeatsSaved.value,
                  ImageUrl: ASSETS_SEAT_ICON,
                  keyLabel: "seats".tr,
                  valueLabel: "available_seats".tr,
                ),
              ),
              Visibility(
                visible: flightBookingController.isMealSelection.value,
                child: Container(
                    color: flyternBackgroundWhite,
                    padding: flyternLargePaddingHorizontal,
                    child: Divider()),
              ),
              Visibility(
                visible: flightBookingController.isMealSelection.value,
                child: FlightAddonServicesItemCard(
                   onPressed: (){
                    flightBookingController.getMeals();
                  },
                  isComplete:flightBookingController.isMealsSaved.value,
                  ImageUrl: ASSETS_MEAL_ICON,
                  keyLabel: "meal".tr,
                  valueLabel: "select_meal".tr,
                ),
              ),
              Visibility(
                visible: flightBookingController.isExtraBaggageSelection.value,
                child: Container(
                    color: flyternBackgroundWhite,
                    padding: flyternLargePaddingHorizontal,
                    child: Divider()),
              ),
              Visibility(
                visible: flightBookingController.isExtraBaggageSelection.value,
                child: FlightAddonServicesItemCard(
                  onPressed: (){
                    flightBookingController.getExtraPackages();
                  },
                  isComplete: flightBookingController.isExtraLuggagesSaved.value,
                  ImageUrl: ASSETS_LUGGAGE_ICON,
                  keyLabel: "baggage".tr,
                  valueLabel: "select_baggage".tr,
                ),
              ),
            ],
          ),
        ),
        bottomSheet: Container(
          width: screenwidth,
          color: flyternBackgroundWhite,
          height: 60+(flyternSpaceSmall*2),
          padding: flyternLargePaddingAll.copyWith(top: flyternSpaceSmall,bottom: flyternSpaceSmall),
          child: Center(
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(style: getElevatedButtonStyle(context),
                  onPressed: () {
                    handleSubmission();
                  },
                  child:flightBookingController
                      .isFlightTravellerDataSaveLoading.value
                      ? LoadingAnimationWidget.prograssiveDots(
                    color: flyternBackgroundWhite,
                    size: 20,
                  )
                      : Text("next".tr )),
            ),
          ),
        ),
      ),
    );
  }

  void handleSubmission() {

    // if(!flightBookingController.isSeatsSaved.value){
    //   showSnackbar(context, "please_select_seat".tr, "error");
    // }else if(!flightBookingController.isMealsSaved.value){
    //   showSnackbar(context, "please_select_meal".tr, "error");
    // }else if(!flightBookingController.isExtraLuggagesSaved.value){
    //   showSnackbar(context, "please_select_baggage".tr, "error");
    // }else{
    //   flightBookingController.getPaymentGateways(false);
    // }
    flightBookingController.getPaymentGateways(false);

  }

  bool isSeatsSelectionComplete(){

    bool isSeatsSelected = true;

    flightBookingController.flightAddonSetSeatData.value.listOfSelection.forEach((element) {
      if(element.seatId == "-1"){
        isSeatsSelected = false;
      }
    });

    return isSeatsSelected;
  }

  bool isMealsSelectionComplete(){
    bool isMealsSelected = true;

    flightBookingController.flightAddonSetMealData.value.listOfSelection.forEach((element) {
      if(element.mealId == "-1"){
        isMealsSelected = false;
      }
    });

    return isMealsSelected;
  }

  bool isBaggageSelectionComplete(){
    bool isExtraPackageSelected = true;

    flightBookingController.flightAddonSetExtraPackageData.value.listOfSelection.forEach((element) {
      if(element.extraLuaggageId == "-1"){
        isExtraPackageSelected = false;
      }
    });

    return isExtraPackageSelected;
  }
}
