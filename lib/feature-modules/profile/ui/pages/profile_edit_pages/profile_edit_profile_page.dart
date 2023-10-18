import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flytern/feature-modules/profile/controllers/profile_controller.dart';
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
import 'package:flytern/shared/ui/components/photo_selector.dart';
import 'package:get/get.dart';

class ProfileEditProfilePage extends StatefulWidget {
  const ProfileEditProfilePage({super.key});

  @override
  State<ProfileEditProfilePage> createState() => _ProfileEditProfilePageState();
}

class _ProfileEditProfilePageState extends State<ProfileEditProfilePage> {

  final profileController = Get.find<ProfileController>();
  final GlobalKey<FormState> updateProfileFormKey = GlobalKey<FormState>();
  final sharedController = Get.find<SharedController>();
  late File? profilePictureFile = File(ASSETS_NAMELOGO);

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Scaffold(
        appBar: AppBar(
          title: Text("edit_profile".tr),
          elevation: 0.5,
        ),
        body: Form(
          key: updateProfileFormKey,
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
                    margin: flyternMediumPaddingVertical,
                    decoration: BoxDecoration(
                      color: flyternBackgroundWhite,
                    ),
                    child: Row(
                      children: [
                        DottedBorder(
                          borderType: BorderType.RRect,
                          color: flyternGrey40,
                          dashPattern: [6, 6, 6, 6],
                          radius:
                              Radius.circular(flyternBorderRadiusLarge * 100),
                          strokeWidth: 1,
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(
                                flyternBorderRadiusLarge * 100)),
                            child: Container(
                              height: screenwidth * .25,
                              width: screenwidth * .25,
                              child: Center(
                                child: profileController.profilePicture.value==''?
                                Icon(Icons.camera_alt_outlined,
                                    size: screenwidth * .08,
                                    color: flyternGrey40):
                                Image.memory(
                                  base64Decode(profileController.profilePicture.value)  ,
                                  height: screenwidth *  .35,
                                  width: screenwidth * .35,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      height: screenwidth * .35,
                                      width: screenwidth * .35,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(1000),
                                      ),
                                      clipBehavior: Clip.hardEdge,
                                      child: Icon(Icons.camera_alt_outlined,
                                          size: screenwidth * .08,
                                          color: flyternGrey40),
                                    );
                                  },
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                        addHorizontalSpace(flyternSpaceMedium),
                        Expanded(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () {
                                openSourceSelector(context);
                              },
                              child: Text(
                                "upload_photo".tr,
                                style: getBodyMediumStyle(context).copyWith(
                                    color: flyternTertiaryColor,
                                    decoration: TextDecoration.underline),
                              ),
                            ),
                          ],
                        ))
                      ],
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
                                  profileController.firsNameController.value,
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
                                  profileController.lastNameController.value,
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
                            selected: profileController.gender.value,
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
                                profileController.changeGender(genders[0]);
                              }
                            },
                          ),
                        )),
                        addHorizontalSpace(flyternSpaceMedium),
                        Expanded(
                          child: TextFormField(
                              readOnly: true,
                              onTap: () {
                                showDOBPickerDialog(true);
                              },
                              controller: profileController.dobController.value,
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
                        controller:
                            profileController.nationalityController.value,
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
                            profileController.passportNumberController.value,
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
                            profileController.passportCountryController.value,
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
                          showDOBPickerDialog(false);
                        },
                        controller:
                            profileController.passportExpiryController.value,
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
                      if (updateProfileFormKey.currentState!.validate() &&
                          !profileController.isProfileSubmitting.value) {
                        FocusManager.instance.primaryFocus?.unfocus();
                        profileController.updateProfile(
                            profileController.profilePicture.value !=""?
                            profilePictureFile:null);
                      }
                    },
                    child: profileController.isProfileSubmitting.value
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
                  profileController.changeNationality(country);
                } else {
                  profileController.changePassportCountry(country);
                }
              }
            },
          );
        });
  }

  void showDOBPickerDialog(bool isDOB) {
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
            dateSelected: (DateTime? dateTime) {
              if (dateTime != null) {
                if (isDOB) {
                  profileController.changeDateOfBirth(dateTime);
                } else {
                  profileController.changePassportExpiry(dateTime);
                }
              }
            },
          );
        });
  }

  void openSourceSelector(context) {
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
          return PhotoSelector(
            photoSelected: (File? pictureFile) {
              if (pictureFile != null) {
                profilePictureFile = pictureFile;
                Uint8List imageBytes = profilePictureFile!.readAsBytesSync();
                profileController
                    .updateProfilePicture(base64Encode(imageBytes));
              }
              setState(() {});
            },
            isVideosAllowed: false,
          );
        });
  }
}
