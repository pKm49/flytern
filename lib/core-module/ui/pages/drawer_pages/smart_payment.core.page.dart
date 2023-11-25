import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flytern/feature-modules/flight_booking/controllers/flight_booking_controller.dart';
import 'package:flytern/shared-module/data/constants/app_specific/app_route_names.dart';
import 'package:flytern/shared-module/data/constants/ui_constants/asset_urls.dart';
import 'package:flytern/shared-module/data/constants/ui_constants/style_params.dart';
import 'package:flytern/shared-module/data/constants/ui_constants/widget_styles.dart';
import 'package:flytern/shared-module/services/utility-services/form_validator.dart';
import 'package:flytern/shared-module/services/utility-services/widget_generator.dart';
import 'package:flytern/shared-module/services/utility-services/widget_properties_generator.dart';
import 'package:flytern/shared-module/ui/components/data_capsule_card.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class SmartPaymentPage extends StatefulWidget {
  const SmartPaymentPage({super.key});

  @override
  State<SmartPaymentPage> createState() => _SmartPaymentPageState();
}

class _SmartPaymentPageState extends State<SmartPaymentPage> {
  TextEditingController bookingIdController = TextEditingController();
  final flightBookingController = Get.find<FlightBookingController>();
  final GlobalKey<FormState> smartPaymentFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Obx(
      () => Scaffold(
          appBar: AppBar(
            title: Text("smart_payment".tr),
            elevation: 0.5,
          ),
          body: Form(
            key: smartPaymentFormKey,
            child: Container(
              width: screenwidth,
              height: screenheight,
              color: flyternBackgroundWhite,
              child: ListView(
                children: [
                  Container(
                    width: screenwidth,
                    padding: flyternLargePaddingAll,
                    height: flyternSpaceLarge,
                    decoration: BoxDecoration(
                      color: flyternGrey10,
                    ),
                  ),
                  Container(
                    padding: flyternLargePaddingHorizontal.copyWith(
                        top: flyternSpaceLarge, bottom: flyternSpaceMedium),
                    color: flyternBackgroundWhite,
                    child: TextFormField(
                        controller: bookingIdController,
                        validator: (value) =>
                            checkIfNameFormValid(value, "booking_id".tr),
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: "enter_booking_id".tr,
                        )),
                  ),
                  Container(
                    color: flyternBackgroundWhite,
                    padding: flyternLargePaddingAll.copyWith(top: 0),
                    child: DataCapsuleCard(
                      label: "Note : " + "enter_booking_id_message".tr,
                      theme: 2,
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
          bottomSheet: Container(
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
                      if (smartPaymentFormKey.currentState!.validate() &&
                          !flightBookingController
                              .isSmartPaymentCheckLoading.value) {
                        FocusManager.instance.primaryFocus?.unfocus();
                        flightBookingController
                            .checkSmartPayment(bookingIdController.value.text);
                      }

                    },
                    child:
                        flightBookingController.isSmartPaymentCheckLoading.value
                            ? LoadingAnimationWidget.prograssiveDots(
                                color: flyternBackgroundWhite,
                                size: 20,
                              )
                            : Text("submit".tr)),
              ),
            ),
          )),
    );
  }
}
