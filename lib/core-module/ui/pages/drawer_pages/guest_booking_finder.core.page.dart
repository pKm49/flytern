import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flytern/feature-modules/flight_booking/controllers/flight_booking.controller.dart';
import 'package:flytern/shared-module/controllers/shared.controller.dart';
import 'package:flytern/shared-module/constants/app_specific/route_names.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/asset_urls.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/style_params.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/widget_styles.shared.constant.dart';
import 'package:flytern/shared-module/models/country.dart';
import 'package:flytern/shared-module/services/utility-services/form_validator.shared.service.dart';
import 'package:flytern/shared-module/services/utility-services/toaster_snackbar_shower.shared.service.dart';
import 'package:flytern/shared-module/services/utility-services/widget_generator.shared.service.dart';
import 'package:flytern/shared-module/services/utility-services/widget_properties_generator.shared.service.dart';
import 'package:flytern/shared-module/ui/components/country_selector.shared.component.dart';
import 'package:flytern/shared-module/ui/components/data_capsule_card.shared.component.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class GuestBookingPage extends StatefulWidget {
  const GuestBookingPage({super.key});

  @override
  State<GuestBookingPage> createState() => _GuestBookingPageState();
}

class _GuestBookingPageState extends State<GuestBookingPage> {

  TextEditingController bookingIdController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  final flightBookingController = Get.find<FlightBookingController>();
  final GlobalKey<FormState> smartPaymentFormKey = GlobalKey<FormState>();

  var selectedCountry = Country(
      isDefault: 1,
      countryName: "Kuwait",
      countryCode: "KWT",
      countryISOCode: "KW",
      countryName_Ar: "الكويت",
      flag: "https://flagcdn.com/48x36/kw.png",
      code: "+965");

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Obx(
      () => Scaffold(
          appBar: AppBar(
            title: Text("my_bookings".tr),
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
                    padding: flyternLargePaddingHorizontal.copyWith(
                        top: 0, bottom: flyternSpaceMedium),
                    color: flyternBackgroundWhite,
                    child: TextFormField(
                        controller: emailController,
                        validator: (value) =>
                            checkIfEmailValid(value ),
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: "email".tr,
                        )),
                  ),
                  addVerticalSpace(flyternSpaceLarge),
                  Row(
                    children: [
                      Expanded(child: Divider()),
                      addHorizontalSpace(flyternSpaceSmall),
                      Text("or".tr,style: getBodyMediumStyle(context).copyWith(color: flyternGrey60),),
                      addHorizontalSpace(flyternSpaceSmall),
                      Expanded(child: Divider()),
                    ],
                  ),

                  addVerticalSpace(flyternSpaceLarge),

                  Container(
                    padding: flyternLargePaddingAll,
                     child: Row(
                      children: [
                        Expanded(child: OutlinedButton(
                          onPressed: ()   {
                            Get.toNamed(Approute_login,
                                arguments: [true]  );
                          },
                          child: Text("sign_in".tr),
                        ))
                      ],
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

                        showSnackbar(context, "couldnt_find_booking".tr, "error");

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