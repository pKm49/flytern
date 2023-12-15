import 'package:flutter/material.dart';
import 'package:flytern/feature-modules/insurance/controllers/insurance.controller.dart';
import 'package:flytern/feature-modules/insurance/models/traveller_info.insurance.model.dart';
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
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class InsuranceUserDetailsSubmissionForm extends StatefulWidget {
  int index;
  InsuranceBookingController insuranceBookingController;
  final Function(InsuranceTravellerInfo travelInfo) dataSubmitted;

  InsuranceUserDetailsSubmissionForm(
      {super.key,
      required this.index,
      required this.insuranceBookingController,
      required this.dataSubmitted});

  @override
  State<InsuranceUserDetailsSubmissionForm> createState() =>
      _InsuranceUserDetailsSubmissionFormState();
}

class _InsuranceUserDetailsSubmissionFormState
    extends State<InsuranceUserDetailsSubmissionForm>
    with AutomaticKeepAliveClientMixin<InsuranceUserDetailsSubmissionForm> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController passportNumberController = TextEditingController();
  TextEditingController civilIdController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController nationalityController = TextEditingController();
  final insuranceBookingController = Get.find<InsuranceBookingController>();

  Gender selectedTitle = Gender(code: "0", name: "Title", isDefault: false);
  Gender selectedGender = Gender(code: "0", name: "Gender", isDefault: false);
  String selectedPassenger = "-1";
  String gender = "0";
  String title = "0";
  String frequentFlyerNo = "0";
  final sharedController = Get.find<SharedController>();

  DateTime dateOfBirth = DefaultInvalidDate;
  DateTime passportExpiryDate = DefaultInvalidDate;
  final GlobalKey<FormState> userDetailsForm = GlobalKey<FormState>();
  final GlobalKey<FormState> genderDropDownKey = GlobalKey<FormState>();
  final GlobalKey<FormState> titleDropDownKey = GlobalKey<FormState>();
  final GlobalKey<FormState> frequentFlyerDropDownKey = GlobalKey<FormState>();
  final GlobalKey<FormState> selectPassengerDropDownKey =
      GlobalKey<FormState>();

  final coPaxController = Get.find<CoPaxController>();

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
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        key: userDetailsForm,
        child: Wrap(
          children: [
            Visibility(
              visible: getUserCopaxes(widget.index).isNotEmpty,
              child: Container(
                  padding: EdgeInsets.only(
                      bottom: flyternSpaceMedium, top: flyternSpaceSmall),
                  color: flyternBackgroundWhite,
                  child: DropDownSelector(
                    validator: (value) => null,
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
                            id: getUserCopaxes(widget.index)[i].id.toString(),
                            name:
                                "${getUserCopaxes(widget.index)[i].firstName} ${getUserCopaxes(widget.index)[i].lastName}")
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
                    flex: 3,
                    child: TextFormField(
                        inputFormatters: [
                          FlightUserDataTextFormatter(),
                        ],
                        controller: firstNameController,
                        validator: (value) =>
                            checkIfNameFormValid(value, "first_name".tr),
                        onChanged: updateData(),
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
                    onTap: updateData(),
                    inputFormatters: [
                      FlightUserDataTextFormatter(),
                    ],
                    controller: civilIdController,
                    validator: (value) =>
                        checkIfNameFormValid(value, "civil_id".tr),
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: "enter_civil_id".tr,
                    ))),
            Container(
              padding: EdgeInsets.only(bottom: flyternSpaceMedium),
              color: flyternBackgroundWhite,
              child: TextFormField(
                  onChanged: updateData(),
                  inputFormatters: [
                    FlightUserDataTextFormatter(),
                  ],
                  controller: passportNumberController,
                  validator: (value) =>
                      checkIfNameFormValid(value, "passport_number".tr),
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: "enter_passport".tr,
                  )),
            ),
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
            maximumDate: insuranceBookingController
                .insuranceInitialData.value.maxDateOfBirth,
            minimumDate: insuranceBookingController
                .insuranceInitialData.value.minDateOfBirth,
            dateSelected: (DateTime? dateTime) {
              if (dateTime != null) {
                if (isDOB) {
                  changeDateOfBirth(dateTime);
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
                }
              }
            },
          );
        });
  }

  void changeNationality(Country country) {
    nationality = country;
    nationalityController.text = "${country.countryName} (${country.code})";
    setState(() {});
    updateData();
  }

  void changeTitle(Gender newTitle) {
    title = newTitle.code;
    selectedTitle = newTitle;
    setState(() {});
    updateData();
  }

  void changeFrequentFlyer(String yesNo) {
    frequentFlyerNo = yesNo;
    setState(() {});
    updateData();
  }

  void changeSelectedPassenger(String newGender) {
    List<UserCoPax> coPax = coPaxController.userCopaxes
        .where((p0) => p0.id.toString() == newGender)
        .toList();
    selectedPassenger = newGender;

    if (coPax.isNotEmpty) {
      firstNameController.text = coPax[0].firstName;
      lastNameController.text = coPax[0].lastName;
      passportNumberController.text = coPax[0].passportNumber;
      final f = DateFormat('dd-MM-yyyy');
      dobController.text = f.format(coPax[0].dateOfBirth);
      dateOfBirth = coPax[0].dateOfBirth;
      final sharedController = Get.find<SharedController>();
      if (coPax[0].dateOfBirth == DefaultInvalidDate) {
        dobController.text = f.format(DefaultMinimumDate);
        dateOfBirth = DefaultMinimumDate;
      } else {
        dobController.text = f.format(coPax[0].dateOfBirth);
        dateOfBirth = coPax[0].dateOfBirth;
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

      setState(() {});
      updateData();
    } else {
      dobController.text = "";
      dateOfBirth = DefaultInvalidDate;
      passportNumberController.text = "";
      nationalityController.text = "";
      nationality = Country(
          isDefault: 1,
          countryName: "",
          countryCode: "",
          countryISOCode: "",
          countryName_Ar: "",
          flag: "",
          code: "");
      gender = sharedController.genderList.isNotEmpty
          ? sharedController.genderList[0].code
          : "0";
      selectedGender = sharedController.genderList.isNotEmpty
          ? sharedController.genderList[0]
          : Gender(code: "0", name: "Gender", isDefault: false);

      firstNameController.text = "";
      lastNameController.text = "";
      title = sharedController.titleList.isNotEmpty
          ? sharedController.titleList[0].code
          : "0";
      selectedTitle = sharedController.titleList.isNotEmpty
          ? sharedController.titleList[0]
          : Gender(code: "0", name: "Title", isDefault: false);

      setState(() {});
      updateData();
    }
  }

  updateData() {
    widget.dataSubmitted(InsuranceTravellerInfo(
      selectedCopaxId: selectedPassenger,
      relationshipCode: "",
      civilID: civilIdController.text,
      firstName: firstNameController.text,
      lastName: lastNameController.text,
      gender: selectedGender.code,
      dateOfBirth: dateOfBirth,
      passportNumber: passportNumberController.text,
      nationalityCode: nationality.countryISOCode,
    ));
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  List<UserCoPax> getUserCopaxes(int index) {
    List<String> selectedUserCopaxes = widget
        .insuranceBookingController.travelInfo.value
        .map((e) => e.selectedCopaxId)
        .where((element) =>
            element !=
            widget.insuranceBookingController.travelInfo.value[index - 1]
                .selectedCopaxId)
        .toList();

    print(selectedUserCopaxes);
    List<UserCoPax> allowedCopaxes = coPaxController.userCopaxes.value
        .where(
            (element) => !selectedUserCopaxes.contains(element.id.toString()))
        .toList();

    allowedCopaxes = allowedCopaxes
        .where((element) =>
            element.dateOfBirth.isBefore(insuranceBookingController
                .insuranceInitialData.value.maxDateOfBirth) &&
            element.dateOfBirth.isAfter(insuranceBookingController
                .insuranceInitialData.value.minDateOfBirth))
        .toList();

    print(allowedCopaxes.length);

    return allowedCopaxes;
  }
}
