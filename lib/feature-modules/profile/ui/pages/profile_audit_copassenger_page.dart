import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flytern/feature-modules/profile/controllers/copax_controller.dart';
import 'package:flytern/shared/controllers/shared_controller.dart';
import 'package:flytern/shared/data/constants/ui_constants/asset_urls.dart';
import 'package:flytern/shared/data/constants/ui_constants/style_params.dart';
import 'package:flytern/shared/data/constants/ui_constants/widget_styles.dart';
import 'package:flytern/shared/data/models/business_models/country.dart';
import 'package:flytern/shared/data/models/business_models/gender.dart';
import 'package:flytern/shared/data/models/business_models/general_item.dart';
import 'package:flytern/shared/services/utility-services/form_validator.dart';
import 'package:flytern/shared/services/utility-services/widget_generator.dart';
import 'package:flytern/shared/services/utility-services/widget_properties_generator.dart';
import 'package:flytern/shared/ui/components/country_selector.dart';
import 'package:flytern/shared/ui/components/custom_date_picker.dart';
import 'package:flytern/shared/ui/components/dropdown_selector.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class ProfileAuditCopassengerPage extends StatefulWidget {
  const ProfileAuditCopassengerPage({super.key});

  @override
  State<ProfileAuditCopassengerPage> createState() =>
      _ProfileAuditCopassengerPageState();
}

class _ProfileAuditCopassengerPageState
    extends State<ProfileAuditCopassengerPage> {
  final coPaxController = Get.find<CoPaxController>();
  final sharedController = Get.find<SharedController>();
  final GlobalKey<FormState> auditCoPaxFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Scaffold(
        appBar: AppBar(
          title: Text(coPaxController.isCreation.value?"add_co_passenger".tr:"update_co_passenger".tr),
          elevation: 0.5,
        ),
        body: Form(
          key: auditCoPaxFormKey,
          child: Obx(
            () => Container(
              width: screenwidth,
              height: screenheight,
              color: flyternGrey10,
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
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                              controller:
                                  coPaxController.firsNameController.value,
                              validator: (value) =>
                                  checkIfNameFormValid(value, "first_name".tr),
                              keyboardType: TextInputType.name,
                              decoration: InputDecoration(
                                labelText: "first_name".tr,
                              )),
                        ),
                        addHorizontalSpace(flyternSpaceMedium),
                        Expanded(
                          child: TextFormField(
                              controller:
                                  coPaxController.lastNameController.value,
                              validator: (value) =>
                                  checkIfNameFormValid(value, "last_name".tr),
                              keyboardType: TextInputType.name,
                              decoration: InputDecoration(
                                labelText: "last_name".tr,
                              )),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: flyternLargePaddingHorizontal.copyWith(
                        top: flyternSpaceExtraSmall,
                        bottom: flyternSpaceMedium),
                    color: flyternBackgroundWhite,
                    child: Row(
                      children: [
                        Expanded(
                            child: Container(
                          decoration:
                              flyternBorderedContainerSmallDecoration.copyWith(
                                  color: flyternGrey10,
                                  border: Border.all(
                                      color: flyternGrey10, width: .2)),
                          padding: flyternMediumPaddingHorizontal.copyWith(
                              top: flyternSpaceExtraSmall,
                              bottom: flyternSpaceExtraSmall),
                          child: DropDownSelector(
                            titleText: "gender".tr,
                            selected: coPaxController.gender.value,
                            items: [
                              for (var i = 0;
                                  i < sharedController.genders.length;
                                  i++)
                                GeneralItem(
                                    id: sharedController.genders[i].code,
                                    name: sharedController.genders[i].name)
                            ],
                            hintText: "gender".tr,
                            valueChanged: (newGender) {
                              List<Gender> genders = sharedController.genders
                                  .where((e) => e.code == newGender)
                                  .toList();
                              if (genders.isNotEmpty) {
                                coPaxController.changeGender(genders[0]);
                              }
                            },
                          ),
                        )),
                        addHorizontalSpace(flyternSpaceMedium),
                        Expanded(
                          child: TextFormField(
                              readOnly: true,
                              onTap: () {
                                showDOBPickerDialog(true,coPaxController.dob.value);
                              },
                              controller: coPaxController.dobController.value,
                              validator: (value) =>
                                  checkIfNameFormValid(value, "dob".tr),
                              keyboardType: TextInputType.name,
                              decoration: InputDecoration(
                                hintText: "DD-MM-YY",
                                labelText: "dob".tr,
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
                        readOnly: true,
                        onTap: () {
                          openCountrySelector(true);
                        },
                        controller: coPaxController.nationalityController.value,
                        validator: (value) =>
                            checkIfNameFormValid(value, "nationality".tr),
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          labelText: "enter_nationality".tr,
                        )),
                  ),
                  Container(
                    padding: flyternLargePaddingHorizontal.copyWith(
                        top: 0, bottom: flyternSpaceMedium),
                    color: flyternBackgroundWhite,
                    child: TextFormField(
                        controller:
                            coPaxController.passportNumberController.value,
                        validator: (value) =>
                            checkIfNameFormValid(value, "passport_number".tr),
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: "enter_passport".tr,
                        )),
                  ),
                  Container(
                    padding: flyternLargePaddingHorizontal.copyWith(
                        top: 0, bottom: flyternSpaceMedium),
                    color: flyternBackgroundWhite,
                    child: TextFormField(
                        readOnly: true,
                        onTap: () {
                          openCountrySelector(false);
                        },
                        controller:
                            coPaxController.passportCountryController.value,
                        validator: (value) => checkIfNameFormValid(
                            value, "enter_passport_country".tr),
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: "enter_passport_country".tr,
                        )),
                  ),
                  Container(
                    padding: flyternLargePaddingHorizontal.copyWith(
                        top: 0, bottom: flyternSpaceMedium),
                    color: flyternBackgroundWhite,
                    child: TextFormField(
                        readOnly: true,
                        onTap: () {
                          showDOBPickerDialog(false,coPaxController.passportExpiry.value);
                        },
                        controller:
                            coPaxController.passportExpiryController.value,
                        validator: (value) => checkIfNameFormValid(
                            value, "enter_passport_expiry".tr),
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: "DD-MM-YY",
                          labelText: "enter_passport_expiry".tr,
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
        ),
        bottomSheet: Obx(
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
                      if (auditCoPaxFormKey.currentState!.validate() &&
                          !coPaxController.isSubmitting.value) {
                        FocusManager.instance.primaryFocus?.unfocus();
                        if (coPaxController.isCreation.value) {
                          coPaxController.createCoPax();
                        } else {
                          coPaxController.editCoPax();
                        }
                      }
                    },
                    child: coPaxController.isSubmitting.value
                        ? const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(
                              color: flyternBackgroundWhite,
                            ),
                          )
                        : Text(coPaxController.isCreation.value
                            ? "add".tr
                            : "update".tr)),
              ),
            ),
          ),
        ));
  }

  void openCountrySelector(bool isNationality) {
    showModalBottomSheet(
        useSafeArea: false,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(flyternBorderRadiusSmall),
              topRight: Radius.circular(flyternBorderRadiusSmall)),
        ),
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return CountrySelector(
            countrySelected: (Country? country) {
              if (country != null) {
                if (isNationality) {
                  coPaxController.changeNationality(country);
                } else {
                  coPaxController.changePassportCountry(country);
                }
              }
            },
          );
        });
  }

  void showDOBPickerDialog(bool isDOB, DateTime dateTime) {
    showModalBottomSheet(
        useSafeArea: false,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(flyternBorderRadiusSmall),
              topRight: Radius.circular(flyternBorderRadiusSmall)),
        ),
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) {
          return CustomDatePicker(
            selectedDate: dateTime,
            dateSelected: (DateTime? dateTime) {
              if (dateTime != null) {
                if (isDOB) {
                  coPaxController.changeDateOfBirth(dateTime);
                } else {
                  coPaxController.changePassportExpiry(dateTime);
                }
              }
            },
          );
        });
  }
}
