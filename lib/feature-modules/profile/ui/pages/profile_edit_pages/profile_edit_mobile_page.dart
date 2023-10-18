import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flytern/feature-modules/profile/controllers/profile_controller.dart';
import 'package:flytern/shared/controllers/shared_controller.dart';
import 'package:flytern/shared/data/constants/ui_constants/asset_urls.dart';
import 'package:flytern/shared/data/constants/ui_constants/style_params.dart';
import 'package:flytern/shared/data/constants/ui_constants/widget_styles.dart';
import 'package:flytern/shared/data/models/business_models/country.dart';
import 'package:flytern/shared/services/utility-services/form_validator.dart';
import 'package:flytern/shared/services/utility-services/widget_generator.dart';
import 'package:flytern/shared/services/utility-services/widget_properties_generator.dart';
import 'package:flytern/shared/ui/components/country_selector.dart';
import 'package:get/get.dart';

class ProfileEditMobilePage extends StatefulWidget {
  const ProfileEditMobilePage({super.key});

  @override
  State<ProfileEditMobilePage> createState() => _ProfileEditMobilePageState();
}

class _ProfileEditMobilePageState extends State<ProfileEditMobilePage> {
  final profileController = Get.find<ProfileController>();
  final GlobalKey<FormState> updateProfileFormKey = GlobalKey<FormState>();
  final sharedController = Get.find<SharedController>();

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Scaffold(
        appBar: AppBar(
          title: Text("change_mobile".tr),
          elevation: 0.5,
        ),
        body:  Obx(
              ()=> Container(
            width: screenwidth,
            height: screenheight,
            color: flyternGrey10,
            child: ListView(
              children: [
                Container(
                  padding: flyternLargePaddingAll,
                  color: flyternBackgroundWhite,
                  margin: flyternMediumPaddingVertical,
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
                                    sharedController.selectedCountry.value.flag,
                                    width: 20),
                                addHorizontalSpace(flyternSpaceMedium),
                                Expanded(
                                  child: Text(
                                      sharedController.selectedCountry.value.code,
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
                            controller: profileController.mobileController.value,
                            validator: (value) => checkIfEmailValid(value),
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: "mobile".tr,
                            )),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomSheet:  Obx(
              () => Container(
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
                    child:profileController.isMobileSubmitting.value
                        ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                        color: flyternBackgroundWhite,
                      ),
                    )
                        : Text("update".tr)),
              ),
            ),
          ),
        ));
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
            if (country != null) profileController.changeMobileCountry(country);
          });
        });
  }
}
