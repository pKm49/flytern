 import 'package:flutter/material.dart';
import 'package:flytern/feature-modules/profile/controllers/copax.profile.controller.dart';
import 'package:flytern/shared-module/controllers/shared.controller.dart';
import 'package:flytern/shared-module/constants/app_specific/default_values.shared.constant.dart';
 import 'package:flytern/shared-module/constants/ui_specific/style_params.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/widget_styles.shared.constant.dart';
import 'package:flytern/shared-module/models/country.dart';
import 'package:flytern/shared-module/models/gender.dart';
import 'package:flytern/shared-module/models/general_item.dart';
import 'package:flytern/shared-module/services/utility-services/flight_userdata_input_formatter.dart';
import 'package:flytern/shared-module/services/utility-services/form_validator.shared.service.dart';
import 'package:flytern/shared-module/services/utility-services/widget_generator.shared.service.dart';
import 'package:flytern/shared-module/services/utility-services/widget_properties_generator.shared.service.dart';
import 'package:flytern/shared-module/ui/components/country_selector.shared.component.dart';
import 'package:flytern/shared-module/ui/components/custom_date_picker.shared.component.dart';
import 'package:flytern/shared-module/ui/components/dropdown_selector.shared.component.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

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
  final GlobalKey<FormState> titleDropDownKey = GlobalKey<FormState>();


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
                          flex: 2,
                          child: Container(
                            decoration:
                            flyternBorderedContainerSmallDecoration.copyWith(
                                color: flyternGrey20,
                                border: Border.all(
                                    color: flyternGrey20, width: .2)),
                            padding: flyternMediumPaddingHorizontal.copyWith(
                                top: flyternSpaceExtraSmall,
                                bottom: flyternSpaceExtraSmall),
                            child: DropDownSelector(
                              key: titleDropDownKey,
                              titleText: "title".tr,
                              selected: coPaxController.title.value,
                              items: [ for (var i = 0;
                              i < sharedController.titleList.length;
                              i++)
                                GeneralItem(
                                    imageUrl: "",
                                    id: sharedController.titleList[i].code,
                                    name: sharedController.titleList[i].name),
                              ],
                              hintText: "title".tr,
                              valueChanged: (newGender) {
                                List<Gender> titles = sharedController.titleList
                                    .where((e) => e.code == newGender)
                                    .toList();
                                if (titles.isNotEmpty) {
                                  coPaxController.changeTitle(titles[0]);
                                }

                              },
                            ),
                          ),
                        ),
                        addHorizontalSpace(flyternSpaceMedium),

                        Expanded(
                          flex: 3,
                          child: TextFormField(
                              inputFormatters: [
                                FlightUserDataTextFormatter(),
                              ],
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
                          flex: 3,
                          child: TextFormField(
                              inputFormatters: [
                                FlightUserDataTextFormatter(),
                              ],
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
                                  color: flyternGrey20,
                                  border: Border.all(
                                      color: flyternGrey20, width: .2)),
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
                                    imageUrl: "",
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
                        inputFormatters: [
                          FlightUserDataTextFormatter(),
                        ],
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
                        ? LoadingAnimationWidget.prograssiveDots(
                      color: flyternBackgroundWhite,
                      size: 16,
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
            isMobile: false,
            isGlobal: false,
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
            minimumDate: isDOB?DefaultAdultMinimumDate:DateTime.now(),
            maximumDate: isDOB?DefaultAdultMaximumDate:DateTime(2080),
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
