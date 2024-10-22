import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flytern/feature-modules/flight_booking/controllers/flight_booking.controller.dart';
import 'package:flytern/feature-modules/flight_booking/models/traveller_info.flight_booking.model.dart';
import 'package:flytern/feature-modules/profile/controllers/copax.profile.controller.dart';
import 'package:flytern/feature-modules/profile/models/user-copax.profile.model.dart';
import 'package:flytern/shared-module/controllers/shared.controller.dart';
import 'package:flytern/shared-module/constants/app_specific/default_values.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/style_params.shared.constant.dart';
import 'package:flytern/shared-module/models/country.dart';
import 'package:flytern/shared-module/models/gender.dart';
import 'package:flytern/shared-module/models/general_item.dart';
import 'package:flytern/shared-module/services/utility-services/flight_userdata_input_formatter.dart';
import 'package:flytern/shared-module/services/utility-services/form_validator.shared.service.dart';
import 'package:flytern/shared-module/services/utility-services/widget_generator.shared.service.dart';
import 'package:flytern/shared-module/ui/components/country_selector.shared.component.dart';
import 'package:flytern/shared-module/ui/components/custom_date_picker.shared.component.dart';
import 'package:flytern/shared-module/ui/components/dropdown_selector.shared.component.dart';
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
  final coPaxController = Get.find<CoPaxController>();

  Gender selectedTitle = Gender(code: "0", name: "Title", isDefault: false);


  Gender selectedGender = Gender(code: "0", name: "Gender", isDefault: false);
  String selectedPassenger = "-1";
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
  late Timer repeater;

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
    setSetStateTimer();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    repeater.cancel();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        key: userDetailsForm,
        child: Wrap(
          children: [
            Visibility(
              visible:  getUserCopaxes(widget.index).isNotEmpty,
              child: Container(
                  padding: EdgeInsets.only(bottom: flyternSpaceMedium),
                  color: flyternBackgroundWhite,
                  child: DropDownSelector(
                    validator: (value) =>null,
                    key: selectPassengerDropDownKey,
                    titleText: "select_passenger".tr,
                    selected: selectedPassenger,
                    items: [
                      GeneralItem(
                          imageUrl: "", id: "-1", name: "select_passenger".tr),
                      for (var i = 0;
                          i < getUserCopaxes(widget.index).length;
                          i++)
                        GeneralItem(
                            imageUrl: "",
                            id:  getUserCopaxes(widget.index)[i].id.toString(),
                            name:
                                "${ getUserCopaxes(widget.index)[i].firstName} ${ getUserCopaxes(widget.index)[i].lastName}")
                    ],
                    hintText: "select_passenger".tr,
                    valueChanged: (newGender) {
                      changeSelectedPassenger(newGender);
                    },
                  )),
            ),
            Container(
              padding: EdgeInsets.only(
                  bottom: flyternSpaceMedium, top: flyternSpaceSmall),
              color: flyternBackgroundWhite,
              child: Row(
                children: [
                  Expanded(
                    child: DropDownSelector(
                      validator: (value) =>
                          checkIfDropDownFormValid(value,"0","title".tr),
                      key: titleDropDownKey,
                      titleText: "title".tr,
                      selected: title,
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
                          changeTitle(titles[0]);
                        }
                      },
                    ),
                  ),
                  addHorizontalSpace(flyternSpaceMedium),
                  Expanded(
                      child: DropDownSelector(
                        validator: (value) =>
                            checkIfDropDownFormValid(value,"0", "gender".tr),
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
                                    .code,
                                name: sharedController.genderList.value[i]
                                    . name)
                        ],
                        hintText: "gender".tr,
                        valueChanged: (newGender) {
                          List<Gender> genders = sharedController.genderList.value
                              .where((e) => e.code == newGender)
                              .toList();
                          if (genders.isNotEmpty) {
                            changeGender(genders[0]);
                          }
                        },
                      )),
                ],
              ),
            ),


            Container(
              padding: EdgeInsets.only(bottom: flyternSpaceMedium),
              color: flyternBackgroundWhite,
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
            Container(
              padding: EdgeInsets.only(bottom: flyternSpaceMedium),
              color: flyternBackgroundWhite,
              child:TextFormField(
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
                  ))
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
              child: Row(
                children: [
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
                  addHorizontalSpace(flyternSpaceMedium),
                  Expanded(
                    child:TextFormField(
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
                        )) ,
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
    gender = newGender.code;
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
            calendarViewMode: DatePickerMode.year,
            maximumDate: isDOB ? getMaximumDate() : DateTime.now().add(const Duration(days: 36500)) ,
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
    title = newTitle.code;
    selectedTitle = newTitle;
    setState(() {});
    updateData();
  }

  void changeSelectedPassenger(String newGender) {
    List<UserCoPax> coPax =  getUserCopaxes(widget.index)
        .where((p0) => p0.id.toString() == newGender)
        .toList();
    selectedPassenger = newGender;


    if (coPax.isNotEmpty) {
      List<Gender> coPaxGender = sharedController.genderList.value
          .where((element) => element.code == coPax[0].gender)
          .toList();

      gender = coPaxGender[0].code;
      selectedGender = coPaxGender[0];
      firstNameController.text = coPax[0].firstName;
      lastNameController.text = coPax[0].lastName;
      passportNumberController.text = coPax[0].passportNumber;
      final f = DateFormat('dd-MM-yyyy');

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
          .where((element) => element.code == coPax[0].title)
          .toList();
      if (tSelectedTitle.isNotEmpty) {
        selectedTitle = tSelectedTitle[0];
        title = tSelectedTitle[0].code;
      }

      setState(() {});
      updateData();
    } else {

      gender = sharedController.genderList.isNotEmpty
          ? sharedController.genderList[0].code
          : "0";
      selectedGender = sharedController.genderList.isNotEmpty
          ? sharedController.genderList[0]
          : Gender(code: "0", name: "Gender", isDefault: false);

      frequentFlyerNoController.text = "";
      passportNumberController.text = "";
      passportExpiryDateController.text = "";
      dobController.text = "";
      dateOfBirth = DefaultInvalidDate;
      passportExpiryDate = DefaultInvalidDate;
      firstNameController.text = "";
      lastNameController.text = "";
      title = sharedController.titleList.isNotEmpty
          ? sharedController.titleList[0].code
          : "0";
      selectedTitle = sharedController.titleList.isNotEmpty
          ? sharedController.titleList[0]
          : Gender(code: "0", name: "Title", isDefault: false);

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
        selectedCopaxId:selectedPassenger,
        no: widget.index,
        frequentFlyerNo: frequentFlyerNoController.value.text,
        travellerType: widget.itemTypeIndex == 0
            ? "Adult"
            : widget.itemTypeIndex == 1
                ? "Child"
                : "Infant",
        title: selectedTitle.code,
        firstName: firstNameController.value.text,
        lastName: lastNameController.value.text,
        gender: selectedGender.code,
        dateOfBirth: dateOfBirth,
        passportNumber: passportNumberController.value.text,
        nationalityCode: nationality.countryISOCode,
        passportIssuedCountryCode: passportIssuedCountryCode.countryISOCode,
        passportExpiryDate: passportExpiryDate));

  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  Future<void> setSetStateTimer() async {
    await Future.delayed(const Duration(seconds: 2));
   repeater = Timer.periodic(new Duration(seconds: 1), (timer) {
      setState(() {

      });
    });
  }

  List<UserCoPax> getUserCopaxes(int itemIndex ) {

    List<String> selectedUserCopaxes = widget.flightBookingController.travelInfo.value.map((e) => e.selectedCopaxId).where((element) =>
    element != widget.flightBookingController.travelInfo.value[itemIndex-1].selectedCopaxId).toList();

    List<UserCoPax> allowedCopaxes =  coPaxController.userCopaxes.value.where((element) =>
    !selectedUserCopaxes.contains(element.id.toString())
    ).toList();

    if(widget.flightBookingController.travelInfo.value[itemIndex-1].travellerType=="Adult"){
      allowedCopaxes = allowedCopaxes.where((element) =>
      element.dateOfBirth.isBefore(widget.flightBookingController
          .flightPretravellerData.value.adultMaxDOB)  &&
          element.dateOfBirth.isAfter(widget.flightBookingController
              .flightPretravellerData.value.adultMinDOB)
      ).toList();
    }

    if(widget.flightBookingController.travelInfo.value[itemIndex-1].travellerType=="Child"){
      allowedCopaxes = allowedCopaxes.where((element) =>
      element.dateOfBirth.isBefore(widget.flightBookingController
          .flightPretravellerData.value.childMaxDOB)  &&
          element.dateOfBirth.isAfter(widget.flightBookingController
              .flightPretravellerData.value.childMinDOB)
      ).toList();
    }

    if(widget.flightBookingController.travelInfo.value[itemIndex-1].travellerType=="Infant"){
      allowedCopaxes = allowedCopaxes.where((element) =>
      element.dateOfBirth.isBefore(widget.flightBookingController
          .flightPretravellerData.value.infantMaxDOB)  &&
          element.dateOfBirth.isAfter(widget.flightBookingController
              .flightPretravellerData.value.infantMinDOB)
      ).toList();
    }

    return allowedCopaxes;

  }



}
