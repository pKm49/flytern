import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flytern/feature-modules/flight_booking/controllers/flight_booking_controller.dart';
import 'package:flytern/shared/controllers/shared_controller.dart';
import 'package:flytern/shared/data/constants/app_specific/app_route_names.dart';
import 'package:flytern/shared/data/constants/ui_constants/asset_urls.dart';
import 'package:flytern/shared/data/constants/ui_constants/style_params.dart';
import 'package:flytern/shared/data/constants/ui_constants/widget_styles.dart';
import 'package:flytern/shared/data/models/business_models/country.dart';
import 'package:flytern/shared/services/utility-services/form_validator.dart';
import 'package:flytern/shared/services/utility-services/widget_generator.dart';
import 'package:flytern/shared/services/utility-services/widget_properties_generator.dart';
import 'package:flytern/shared/ui/components/country_selector.dart';
import 'package:flytern/shared/ui/components/data_capsule_card.dart';
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
  TextEditingController mobileController = TextEditingController();
  final flightBookingController = Get.find<FlightBookingController>();
  final GlobalKey<FormState> smartPaymentFormKey = GlobalKey<FormState>();
  final sharedController = Get.find<SharedController>();

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
                        validator: (value) => checkIfEmailValid(value),
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: "email".tr,
                        )),
                  ),
                  Container(
                    padding: flyternLargePaddingHorizontal.copyWith(
                        top: 0, bottom: flyternSpaceMedium),
                    color: flyternBackgroundWhite,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: InkWell(
                            onTap: openCountrySelector,
                            child: Container(
                              decoration:
                              flyternBorderedContainerSmallDecoration.copyWith(
                                  color: flyternGrey10,
                                  border: Border.all(
                                      color: Colors.transparent, width: 0)),
                              padding: flyternMediumPaddingAll.copyWith(
                                  top: flyternSpaceLarge,
                                  bottom: flyternSpaceLarge),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.network(
                                      selectedCountry.flag,
                                      width: 20),
                                  addHorizontalSpace(flyternSpaceMedium),
                                  Expanded(
                                    child: Text(
                                        selectedCountry.code,
                                        style: getBodyMediumStyle(context)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        addHorizontalSpace(flyternSpaceMedium),
                        Expanded(
                          flex: 4,
                          child: TextFormField(
                              controller: mobileController,
                              validator: (value) => checkIfMobileNumberValid(value),
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                labelText: "mobile".tr,
                              )),
                        ),
                      ],
                    ),
                  ),
                  addVerticalSpace(flyternSpaceLarge),

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
                        // flightBookingController
                        //     .checkSmartPayment(bookingIdController.value.text);
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

  void openCountrySelector() {
    showModalBottomSheet(
        useSafeArea: false,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(flyternBorderRadiusSmall),
              topRight: Radius.circular(flyternBorderRadiusSmall)),
        ),
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return CountrySelector(countrySelected: (Country? country) {
            if (country != null) selectedCountry = country;
          });
        });
  }
}