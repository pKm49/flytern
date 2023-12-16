import 'package:flutter/material.dart';
import 'package:flytern/core-module/controllers/core.controller.dart';
import 'package:flytern/shared-module/constants/app_specific/route_names.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/style_params.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/widget_styles.shared.constant.dart';
import 'package:flytern/shared-module/models/country.dart';
import 'package:flytern/shared-module/services/utility-services/flight_userdata_input_formatter.dart';
import 'package:flytern/shared-module/services/utility-services/form_validator.shared.service.dart';
import 'package:flytern/shared-module/services/utility-services/widget_generator.shared.service.dart';
import 'package:flytern/shared-module/services/utility-services/widget_properties_generator.shared.service.dart';
import 'package:flytern/shared-module/ui/components/country_selector.shared.component.dart';
import 'package:flytern/shared-module/ui/components/data_capsule_card.shared.component.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class HelpCenterPage extends StatefulWidget {
  const HelpCenterPage({super.key});

  @override
  State<HelpCenterPage> createState() => _HelpCenterPageState();
}

class _HelpCenterPageState extends State<HelpCenterPage> {
  TextEditingController bookingIdController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController enquiryController = TextEditingController();
  TextEditingController mobileController = TextEditingController();

  final coreController = Get.find<CoreController>();
  final GlobalKey<FormState> enquiryFormKey = GlobalKey<FormState>();

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
            title: Text("help_center".tr),
            elevation: 0.5,
          ),
          body: Form(
            key: enquiryFormKey,
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
                    padding: flyternLargePaddingAll,
                    color: flyternBackgroundWhite,
                    margin: flyternMediumPaddingVertical,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: InkWell(
                            onTap: openCountrySelector,
                            child: Container(
                              decoration:
                                  flyternBorderedContainerSmallDecoration
                                      .copyWith(
                                          color: flyternGrey20,
                                          border: Border.all(
                                              color: flyternGrey20, width: 0)),
                              padding: flyternMediumPaddingAll.copyWith(
                                  top: flyternSpaceMedium,
                                  bottom: flyternSpaceMedium),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.network(selectedCountry.flag,
                                      width: 17),
                                  addHorizontalSpace(flyternSpaceSmall),
                                  Expanded(
                                    child: Text(selectedCountry.code,
                                        style: getBodyMediumStyle(context)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        addHorizontalSpace(flyternSpaceMedium),
                        Expanded(
                          flex: 5,
                          child: TextFormField(
                              controller: mobileController,
                              validator: (value) =>
                                  checkIfMobileNumberValid(value),
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                labelText: "mobile".tr,
                              )),
                        ),
                      ],
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
                        top: flyternSpaceLarge, bottom: flyternSpaceMedium),
                    color: flyternBackgroundWhite,
                    child: TextFormField(
                        inputFormatters: [
                          FlightUserDataTextFormatter(),
                        ],
                        controller: bookingIdController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: "enter_booking_id".tr,
                        )),
                  ),
                  addVerticalSpace(flyternSpaceLarge),
                  Container(
                    color: flyternBackgroundWhite,
                    padding: flyternLargePaddingAll.copyWith(top: 0),
                    child: DataCapsuleCard(
                      label: "help_center_message".tr,
                      theme: 1,
                    ),
                  ),
                  Container(
                    padding: flyternLargePaddingHorizontal.copyWith(
                        top: 0, bottom: flyternSpaceMedium),
                    color: flyternBackgroundWhite,
                    child: TextFormField(
                        maxLines: 4,
                        controller: enquiryController,
                        validator: (value) =>
                            checkIfNameFormValid(value, "enquiry".tr),
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: "enquiry".tr,
                        )),
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
                      if (enquiryFormKey.currentState!.validate() &&
                          !coreController.isEnquiryLoading.value) {
                        coreController.submitEnquiry(
                          mobileController.value.text,
                          selectedCountry.code,
                          emailController.value.text,
                          bookingIdController.value.text,
                          enquiryController.value.text,
                        );
                      }
                    },
                    child: coreController.isEnquiryLoading.value
                        ? LoadingAnimationWidget.prograssiveDots(
                            color: flyternBackgroundWhite,
                            size: 20,
                          )
                        : Text("send_message".tr)),
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
          return CountrySelector(
              isMobile: true,
              isGlobal: false,
              countrySelected: (Country? country) {
                if (country != null) {
                  selectedCountry = country;
                }
              });
        });
  }
}
