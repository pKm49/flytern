import 'package:flutter/material.dart';
import 'package:flytern/feature-modules/flight_booking/controllers/flight_booking.controller.dart';
import 'package:flytern/shared-module/models/sorting_dcs.dart';
import 'package:flytern/feature-modules/flight_booking/models/traveller_info.flight_booking.model.dart';
import 'package:flytern/feature-modules/profile/controllers/copax.profile.controller.dart';
import 'package:flytern/feature-modules/profile/models/user-copax.profile.model.dart';
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
import 'package:flytern/shared-module/ui/components/country_selector.shared.component.dart';
import 'package:flytern/shared-module/ui/components/custom_date_picker.shared.component.dart';
import 'package:flytern/shared-module/ui/components/dropdown_selector.shared.component.dart';
import 'package:flytern/shared-module/ui/components/sort_option_selector.shared.component.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class FlightUserDetailsSubmissionForm extends StatefulWidget {
  int index;
  int itemTypeIndex;
  FlightBookingController flightBookingController;
  final Function(TravelInfo travelInfo) dataSubmitted;

  FlightUserDetailsSubmissionForm(
      {super.key,
      required this.itemTypeIndex,
      required this.index,
      required this.flightBookingController,
      required this.dataSubmitted});

  @override
  State<FlightUserDetailsSubmissionForm> createState() =>
      _FlightUserDetailsSubmissionFormState();
}

class _FlightUserDetailsSubmissionFormState
    extends State<FlightUserDetailsSubmissionForm>
    with AutomaticKeepAliveClientMixin<FlightUserDetailsSubmissionForm> {
  TextEditingController frequentFlyerNoController = TextEditingController();
  TextEditingController travellerTypeController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController passportNumberController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController passportExpiryDateController = TextEditingController();
  TextEditingController nationalityController = TextEditingController();
  TextEditingController passportIssuedCountryController =
      TextEditingController();

  Gender selectedTitle = Gender(code: "0", name: "Title", isDefault: false);

  Gender selectedGender = Gender(code: "Gender", name: "0", isDefault: false);
  String selectedPassenger = "0";
  String gender = "0";
  String title = "0";
  DateTime dateOfBirth = DefaultInvalidDate;
  DateTime passportExpiryDate = DefaultInvalidDate;
  final GlobalKey<FormState> userDetailsForm = GlobalKey<FormState>();
  final GlobalKey<FormState> genderDropDownKey = GlobalKey<FormState>();
  final GlobalKey<FormState> titleDropDownKey = GlobalKey<FormState>();
  final GlobalKey<FormState> frequentFlyerDropDownKey = GlobalKey<FormState>();
  final GlobalKey<FormState> selectPassengerDropDownKey =
      GlobalKey<FormState>();

  final coPaxController = Get.find<CoPaxController>();
  final sharedController = Get.find<SharedController>();

  var nationality = Country(
      isDefault: 1,
      countryName: "",
      countryCode: "",
      countryISOCode: "",
      countryName_Ar: "",
      flag: "",
      code: "");

  var passportIssuedCountryCode = Country(
      isDefault: 1,
      countryName: "",
      countryCode: "",
      countryISOCode: "",
      countryName_Ar: "",
      flag: "",
      code: "");

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("widget.index");
    print(widget.index);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        key: userDetailsForm,
        child: Wrap(
          children: [
            Visibility(
              visible: coPaxController.userCopaxes.isNotEmpty,
              child: Container(
                  padding: EdgeInsets.only(bottom: flyternSpaceMedium),
                  color: flyternBackgroundWhite,
                  child: Container(
                    decoration:
                        flyternBorderedContainerSmallDecoration.copyWith(
                            color: flyternGrey10,
                            border:
                                Border.all(color: flyternGrey10, width: .2)),
                    padding: flyternMediumPaddingHorizontal.copyWith(
                        top: flyternSpaceExtraSmall,
                        bottom: flyternSpaceExtraSmall),
                    child: DropDownSelector(
                      key: selectPassengerDropDownKey,
                      titleText: "select_passenger".tr,
                      selected: selectedPassenger,
                      items: [
                        GeneralItem(
                            imageUrl: "", id: "0", name: "select_passenger".tr),
                        for (var i = 0;
                            i < coPaxController.userCopaxes.length;
                            i++)
                          GeneralItem(
                              imageUrl: "",
                              id: coPaxController.userCopaxes[i].id.toString(),
                              name:
                                  "${coPaxController.userCopaxes[i].firstName} ${coPaxController.userCopaxes[i].lastName}")
                      ],
                      hintText: "select_passenger".tr,
                      valueChanged: (newGender) {
                        changeSelectedPassenger(newGender);
                      },
                    ),
                  )),
            ),
            Container(
              padding: EdgeInsets.only(
                  bottom: flyternSpaceMedium, top: flyternSpaceSmall),
              color: flyternBackgroundWhite,
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      decoration:
                          flyternBorderedContainerSmallDecoration.copyWith(
                              color: flyternGrey10,
                              border:
                                  Border.all(color: flyternGrey10, width: .2)),
                      padding: flyternMediumPaddingHorizontal.copyWith(
                          top: flyternSpaceExtraSmall,
                          bottom: flyternSpaceExtraSmall),
                      child: DropDownSelector(
                        key: titleDropDownKey,
                        titleText: "title".tr,
                        selected: title,
                        items: [ for (var i = 0;
                        i < sharedController.titleList.length;
                        i++)
                          GeneralItem(
                              imageUrl: "",
                              id: sharedController.titleList[i].name,
                              name: sharedController.titleList[i].code),
                        ],
                        hintText: "title".tr,
                        valueChanged: (newGender) {
                          List<Gender> titles = sharedController.titleList
                              .where((e) => e.code == newGender)
                              .toList();
                          if (titles.isNotEmpty) {
                            changeTitle(titles[0]);
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
                        onChanged: updateData(),
                        controller: firstNameController,
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
                        onChanged: updateData(),
                        controller: lastNameController,
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
              padding: EdgeInsets.only(bottom: flyternSpaceMedium),
              color: flyternBackgroundWhite,
              child: Row(
                children: [
                  Expanded(
                      child: Container(
                    decoration:
                        flyternBorderedContainerSmallDecoration.copyWith(
                            color: flyternGrey10,
                            border:
                                Border.all(color: flyternGrey10, width: .2)),
                    padding: flyternMediumPaddingHorizontal.copyWith(
                        top: flyternSpaceExtraSmall,
                        bottom: flyternSpaceExtraSmall),
                    child: DropDownSelector(
                      key: genderDropDownKey,
                      titleText: "gender".tr,
                      selected: gender,
                      items: [
                        for (var i = 0;
                            i <
                                sharedController.genderList.value
                                    .length;
                            i++)
                          GeneralItem(
                              imageUrl: "",
                              id: sharedController.genderList.value[i]
                                  .name,
                              name: sharedController.genderList.value[i]
                                  .code)
                      ],
                      hintText: "gender".tr,
                      valueChanged: (newGender) {
                        List<Gender> genders = sharedController.genderList.value
                            .where((e) => e.name == newGender)
                            .toList();
                        if (genders.isNotEmpty) {
                          changeGender(genders[0]);
                        }
                      },
                    ),
                  )),
                  addHorizontalSpace(flyternSpaceMedium),
                  Expanded(
                    child: TextFormField(
                        readOnly: true,
                        onTap: () {
                          showDOBPickerDialog(true, dateOfBirth);
                        },
                        controller: dobController,
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
              padding: EdgeInsets.only(bottom: flyternSpaceMedium),
              color: flyternBackgroundWhite,
              child: TextFormField(
                  readOnly: true,
                  onTap: () {
                    openCountrySelector(true);
                  },
                  controller: nationalityController,
                  validator: (value) =>
                      checkIfNameFormValid(value, "nationality".tr),
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    labelText: "enter_nationality".tr,
                  )),
            ),
            Container(
              padding: EdgeInsets.only(bottom: flyternSpaceMedium),
              color: flyternBackgroundWhite,
              child: TextFormField(
                  inputFormatters: [
                    FlightUserDataTextFormatter(),
                  ],
                  onChanged: updateData(),
                  controller: passportNumberController,
                  validator: (value) =>
                      checkIfNameFormValid(value, "passport_number".tr),
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: "enter_passport".tr,
                  )),
            ),
            Container(
                padding: EdgeInsets.only(bottom: flyternSpaceMedium),
                color: flyternBackgroundWhite,
                child: Row(
                  children: [
                    Expanded(
                        child: TextFormField(
                            readOnly: true,
                            onTap: () {
                              openCountrySelector(false);
                            },
                            controller: passportIssuedCountryController,
                            validator: (value) => checkIfNameFormValid(
                                value, "enter_passport_country".tr),
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              labelText: "enter_passport_country".tr,
                            ))),
                    addHorizontalSpace(flyternSpaceMedium),
                    Expanded(
                      child: TextFormField(
                          readOnly: true,
                          onTap: () {
                            showDOBPickerDialog(false, passportExpiryDate);
                          },
                          controller: passportExpiryDateController,
                          validator: (value) => checkIfNameFormValid(
                              value, "enter_passport_expiry".tr),
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            hintText: "DD-MM-YY",
                            labelText: "enter_passport_expiry".tr,
                          )),
                    ),
                  ],
                )),
            Container(
                padding: EdgeInsets.only(bottom: flyternSpaceMedium),
                color: flyternBackgroundWhite,
                child: TextFormField(
                    onChanged: updateData(),
                    inputFormatters: [
                      FlightUserDataTextFormatter(),
                    ],
                    controller: frequentFlyerNoController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: "enter_frequent_flyer".tr,
                    ))),
          ],
        ),
      ),
    );
  }

  void changeGender(Gender newGender) {
    gender = newGender.name;
    selectedGender = newGender;
    setState(() {});
    updateData();
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
            maximumDate: isDOB ? getMaximumDate() : DateTime(2100, 1, 1),
            minimumDate: isDOB
                ? getMinimumDate()
                : DateTime.now().add(const Duration(days: 1)),
            dateSelected: (DateTime? dateTime) {
              if (dateTime != null) {
                if (isDOB) {
                  changeDateOfBirth(dateTime);
                } else {
                  changePassportExpiry(dateTime);
                }
              }
            },
          );
        });
  }

  void changeDateOfBirth(DateTime dateTime) {
    dateOfBirth = dateTime;
    final f = DateFormat('dd-MM-yyyy');
    dobController.text = f.format(dateTime);
    setState(() {});
    updateData();
  }

  void changePassportExpiry(DateTime dateTime) {
    passportExpiryDate = dateTime;
    final f = DateFormat('dd-MM-yyyy');
    passportExpiryDateController.text = f.format(dateTime);
    setState(() {});
    updateData();
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
                  changeNationality(country);
                } else {
                  changePassportCountry(country);
                }
              }
            },
          );
        });
  }

  void changeNationality(Country country) {
    nationality = country;
    nationalityController.text =
        "${country.countryName} (${country.countryCode})";
    setState(() {});
    updateData();
  }

  void changePassportCountry(Country country) {
    passportIssuedCountryCode = country;
    passportIssuedCountryController.text =
        "${country.countryName} (${country.countryCode})";
    setState(() {});
    updateData();
  }

  void changeTitle(Gender newTitle) {
    title = newTitle.name;
    selectedTitle = newTitle;
    setState(() {});
    updateData();
  }

  void changeSelectedPassenger(String newGender) {
    List<UserCoPax> coPax = coPaxController.userCopaxes
        .where((p0) => p0.id.toString() == newGender)
        .toList();
    selectedPassenger = newGender;

    if (coPax.isNotEmpty) {
      List<Gender> coPaxGender = sharedController.genderList.value
          .where((element) => element.name == coPax[0].gender)
          .toList();

      gender = coPaxGender[0].name;
      selectedGender = coPaxGender[0];
      firstNameController.text = coPax[0].firstName;
      lastNameController.text = coPax[0].lastName;
      passportNumberController.text = coPax[0].passportNumber;
      final f = DateFormat('dd-MM-yyyy');
      print("copax dotb");
      print(coPax[0].dateOfBirth);
      if (coPax[0].dateOfBirth == DefaultInvalidDate) {
        dobController.text = f.format(getMinimumDate());
        dateOfBirth = getMinimumDate();
      } else {
        dobController.text = f.format(coPax[0].dateOfBirth);
        dateOfBirth = coPax[0].dateOfBirth;
      }

      passportExpiryDateController.text = f.format(coPax[0].passportExp);
      passportExpiryDate = coPax[0].passportExp;
      List<Country> passCountry = sharedController.countries.value
          .where((element) =>
              element.countryISOCode == coPax[0].passportIssuedCountryCode)
          .toList();
      if (passCountry.isNotEmpty) {
        passportIssuedCountryCode = passCountry[0];
        passportIssuedCountryController.text =
            "${passCountry[0].countryName} (${passCountry[0].code})";
      }

      List<Country> nationCountry = sharedController.countries.value
          .where(
              (element) => element.countryISOCode == coPax[0].nationalityCode)
          .toList();
      if (nationCountry.isNotEmpty) {
        nationality = nationCountry[0];
        nationalityController.text =
            "${nationCountry[0].countryName} (${nationCountry[0].code})";
      }

      List<Gender> tSelectedTitle = sharedController.titleList.value
          .where((element) => element.name == coPax[0].title)
          .toList();
      if (tSelectedTitle.isNotEmpty) {
        selectedTitle = tSelectedTitle[0];
        title = tSelectedTitle[0].code;
      }

      setState(() {});
      updateData();
    } else {

      gender = sharedController.genderList.isNotEmpty
          ? sharedController.genderList[0].name
          : "0";
      selectedGender = sharedController.genderList.isNotEmpty
          ? sharedController.genderList[0]
          : Gender(code: "Gender", name: "0", isDefault: false);

      frequentFlyerNoController.text = "";
      passportNumberController.text = "";
      passportExpiryDateController.text = "";
      dobController.text = "";
      dateOfBirth = DefaultInvalidDate;
      passportExpiryDate = DefaultInvalidDate;
      firstNameController.text = "";
      lastNameController.text = "";
      title = sharedController.titleList.isNotEmpty
          ? sharedController.titleList[0].name
          : "0";
      selectedTitle = sharedController.titleList.isNotEmpty
          ? sharedController.titleList[0]
          : Gender(code: "Title", name: "0", isDefault: false);

      passportIssuedCountryController.text = "";
      passportIssuedCountryCode = Country(
          isDefault: 1,
          countryName: "",
          countryCode: "",
          countryISOCode: "",
          countryName_Ar: "",
          flag: "",
          code: "");

      nationalityController.text = "";
      nationality = Country(
          isDefault: 1,
          countryName: "",
          countryCode: "",
          countryISOCode: "",
          countryName_Ar: "",
          flag: "",
          code: "");

      setState(() {});
      updateData();
    }
  }

  getMaximumDate() {
    switch (widget.itemTypeIndex) {
      case 0:
        {
          return widget
              .flightBookingController.flightPretravellerData.value.adultMaxDOB;
        }
      case 1:
        {
          return widget
              .flightBookingController.flightPretravellerData.value.childMaxDOB;
        }
      case 2:
        {
          return widget.flightBookingController.flightPretravellerData.value
              .infantMaxDOB;
        }
      default:
        {
          return widget
              .flightBookingController.flightPretravellerData.value.adultMaxDOB;
        }
    }
  }

  getMinimumDate() {
    switch (widget.itemTypeIndex) {
      case 0:
        {
          return widget
              .flightBookingController.flightPretravellerData.value.adultMinDOB;
        }
      case 1:
        {
          return widget
              .flightBookingController.flightPretravellerData.value.childMinDOB;
        }
      case 2:
        {
          return widget.flightBookingController.flightPretravellerData.value
              .infantMinDOB;
        }
      default:
        {
          return widget
              .flightBookingController.flightPretravellerData.value.adultMinDOB;
        }
    }
  }

  updateData() {
    widget.dataSubmitted(TravelInfo(
        no: widget.index,
        frequentFlyerNo: frequentFlyerNoController.value.text,
        travellerType: widget.itemTypeIndex == 0
            ? "Adult"
            : widget.itemTypeIndex == 1
                ? "Child"
                : "Infant",
        title: selectedTitle.code,
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        gender: selectedGender.code,
        dateOfBirth: dateOfBirth,
        passportNumber: passportNumberController.text,
        nationalityCode: nationality.countryISOCode,
        passportIssuedCountryCode: passportIssuedCountryCode.countryISOCode,
        passportExpiryDate: passportExpiryDate));
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
