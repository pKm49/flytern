import 'package:flutter/material.dart'; 
import 'package:flytern/feature-modules/flight_booking/data/models/business_models/traveller_info.dart';
import 'package:flytern/feature-modules/insurance/controllers/insurance_controller.dart';
import 'package:flytern/feature-modules/insurance/data/models/insurance_traveller_info.dart';
import 'package:flytern/feature-modules/profile/controllers/copax_controller.dart';
import 'package:flytern/feature-modules/profile/data/models/business-models/user-copax.dart';
import 'package:flytern/shared/controllers/shared_controller.dart';
import 'package:flytern/shared/data/constants/app_specific/default_values.dart';
import 'package:flytern/shared/data/constants/ui_constants/style_params.dart';
import 'package:flytern/shared/data/constants/ui_constants/widget_styles.dart';
import 'package:flytern/shared/data/models/business_models/country.dart';
import 'package:flytern/shared/data/models/business_models/gender.dart';
import 'package:flytern/shared/data/models/business_models/general_item.dart';
import 'package:flytern/shared/services/utility-services/form_validator.dart';
import 'package:flytern/shared/services/utility-services/widget_generator.dart';
import 'package:flytern/shared/ui/components/country_selector.dart';
import 'package:flytern/shared/ui/components/custom_date_picker.dart';
import 'package:flytern/shared/ui/components/dropdown_selector.dart';
import 'package:flytern/shared/ui/components/sort_option_selector.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class InsuranceUserDetailsSubmissionForm extends StatefulWidget  {

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
    extends State<InsuranceUserDetailsSubmissionForm> with AutomaticKeepAliveClientMixin<InsuranceUserDetailsSubmissionForm> {

   TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController passportNumberController = TextEditingController();
  TextEditingController civilIdController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController nationalityController = TextEditingController();

  Gender selectedTitle  = Gender(code: "", name: "", isDefault: false);
  Gender selectedGender  = Gender(code: "", name: "", isDefault: false);
  String selectedPassenger = "0";
  String gender = "0";
  String title = "0";
  String frequentFlyerNo = "0";
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
      countryName: "",
      countryCode: "",
      countryISOCode: "",
      countryName_Ar: "",
      flag: "",
      code: "");

  var passportIssuedCountryCode = Country(
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
                    decoration: flyternBorderedContainerSmallDecoration.copyWith(
                        color: flyternGrey10,
                        border: Border.all(color: flyternGrey10, width: .2)),
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
              padding: EdgeInsets.only(bottom: flyternSpaceMedium),
              color: flyternBackgroundWhite,
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: TextFormField(
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
                    onChanged: updateData(),

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
    gender = newGender.name;
    selectedGender = newGender;
    setState(() {
    });
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
            maximumDate: widget.insuranceBookingController.insuranceInitialData.value.maxDateOfBirth,
            minimumDate: widget.insuranceBookingController.insuranceInitialData.value.minDateOfBirth,
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
    title = newTitle.name;
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
    if (coPax.isNotEmpty) {
      selectedPassenger = newGender;

      firstNameController.text =    coPax[0].firstName;
      lastNameController.text =    coPax[0].lastName;
      passportNumberController.text =    coPax[0].passportNumber;
      final f = DateFormat('dd-MM-yyyy');
      dobController.text = f.format(coPax[0].dateOfBirth);
      dateOfBirth = coPax[0].dateOfBirth;
      final sharedController = Get.find<SharedController>();

      List<Country> nationCountry = sharedController.countries.value.where((element) =>
      element.countryISOCode == coPax[0].nationalityCode).toList();
      if(nationCountry.isNotEmpty){
        nationality = nationCountry[0];
        nationalityController.text =
        "${ nationCountry[0].countryName} (${ nationCountry[0].code})";
      }

      setState(() {});
      updateData();
    }

  }

  updateData(){
    print("updateData");
    widget.dataSubmitted(
        InsuranceTravellerInfo(
            relationshipCode:"",
            civilID: civilIdController.text,
            firstName: firstNameController.text,
            lastName: lastNameController.text,
            gender: selectedGender.code,
            dateOfBirth: dateOfBirth,
            passportNumber: passportNumberController.text,
            nationalityCode:nationality.countryISOCode, ));
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}