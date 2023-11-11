import 'package:flutter/material.dart';
import 'package:flytern/core/data/constants/ui-specific/theme_data.dart';
import 'package:flytern/feature-modules/activity_booking/controllers/activity_booking_controller.dart';
import 'package:flytern/feature-modules/activity_booking/data/models/activity_traveller_info.dart';
import 'package:flytern/feature-modules/flight_booking/controllers/flight_booking_controller.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/business_models/traveller_info.dart';
import 'package:flytern/feature-modules/flight_booking/ui/components/flight_userdetails_submission_form.dart';
import 'package:flytern/feature-modules/profile/controllers/copax_controller.dart';
import 'package:flytern/feature-modules/profile/data/models/business-models/user-copax.dart';
import 'package:flytern/shared/controllers/shared_controller.dart';
import 'package:flytern/shared/data/constants/app_specific/app_route_names.dart';
import 'package:flytern/shared/data/constants/app_specific/default_values.dart';
import 'package:flytern/shared/data/constants/ui_constants/style_params.dart';
import 'package:flytern/shared/data/constants/ui_constants/widget_styles.dart';
import 'package:flytern/shared/data/models/business_models/country.dart';
import 'package:flytern/shared/data/models/business_models/gender.dart';
import 'package:flytern/shared/data/models/business_models/general_item.dart';
import 'package:flytern/shared/services/utility-services/form_validator.dart';
import 'package:flytern/shared/services/utility-services/widget_generator.dart';
import 'package:flytern/shared/services/utility-services/widget_properties_generator.dart';
import 'package:flytern/shared/ui/components/contact_details_getter.dart';
import 'package:flytern/shared/ui/components/country_selector.dart';
import 'package:flytern/shared/ui/components/dropdown_selector.dart';
import 'package:flytern/shared/ui/components/sort_option_selector.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ActivityUserDetailsSubmissionPage extends StatefulWidget {
  const ActivityUserDetailsSubmissionPage({super.key});

  @override
  State<ActivityUserDetailsSubmissionPage> createState() =>
      _ActivityUserDetailsSubmissionPageState();
}

class _ActivityUserDetailsSubmissionPageState
    extends State<ActivityUserDetailsSubmissionPage>
    with SingleTickerProviderStateMixin {
  TextEditingController titleController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController specialRequestController = TextEditingController();
  TextEditingController nationalityController = TextEditingController();

  Gender selectedTitle = Gender(code: "", name: "", isDefault: false);
  String selectedPassenger = "0";
  String title = "1";
  DateTime dateOfBirth = DefaultInvalidDate;
  DateTime passportExpiryDate = DefaultInvalidDate;

  final GlobalKey<FormState> userDetailsForm = GlobalKey<FormState>();
  final GlobalKey<FormState> genderDropDownKey = GlobalKey<FormState>();
  final GlobalKey<FormState> titleDropDownKey = GlobalKey<FormState>();
  final GlobalKey<FormState> frequentFlyerDropDownKey = GlobalKey<FormState>();
  final GlobalKey<FormState> selectPassengerDropDownKey =
      GlobalKey<FormState>();

  dynamic argumentData = Get.arguments;
  final activityBookingController = Get.find<ActivityBookingController>();

  String mobileCntry = "";
  String mobileNumber = "";
  String email = "";
  int tabLength = 0;

  final coPaxController = Get.find<CoPaxController>();

  var nationality = Country(
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
    mobileCntry = argumentData[0]['mobileCntry'];
    mobileNumber = argumentData[0]['mobileNumber'];
    email = argumentData[0]['email'];

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Obx(
      () => Scaffold(
        appBar: AppBar(
          title: Text("submit_traveller_details".tr),
          elevation: .3,
        ),
        body: Container(
          width: screenwidth,
          height: screenheight,
          color: flyternGrey10,
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
                                border: Border.all(
                                    color: flyternGrey10, width: .2)),
                        padding: flyternMediumPaddingHorizontal.copyWith(
                            top: flyternSpaceExtraSmall,
                            bottom: flyternSpaceExtraSmall),
                        child: DropDownSelector(
                          key: selectPassengerDropDownKey,
                          titleText: "select_passenger".tr,
                          selected: selectedPassenger,
                          items: [
                            GeneralItem(
                                imageUrl: "",
                                id: "0",
                                name: "select_passenger".tr),
                            for (var i = 0;
                                i < coPaxController.userCopaxes.length;
                                i++)
                              GeneralItem(
                                  imageUrl: "",
                                  id: coPaxController.userCopaxes[i].id
                                      .toString(),
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
                  padding: flyternLargePaddingAll,
                  color: flyternBackgroundWhite,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
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
                            key: titleDropDownKey,
                            titleText: "title".tr,
                            selected: title,
                            items: [
                              GeneralItem(imageUrl: "", id: "1", name: "Mr"),
                              GeneralItem(imageUrl: "", id: "2", name: "Mrs")
                            ],
                            hintText: "title".tr,
                            valueChanged: (newGender) {
                              title = newGender;
                              if (newGender == "1") {
                                selectedTitle = Gender(
                                    code: "1", name: "Mr", isDefault: false);
                              } else {
                                selectedTitle = Gender(
                                    code: "1", name: "Mrs", isDefault: false);
                              }
                            },
                          ),
                        ),
                      ),
                      addHorizontalSpace(flyternSpaceMedium),
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
                  padding: flyternLargePaddingAll.copyWith(top: 0),
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
                  padding: flyternLargePaddingAll.copyWith(top: 0),
                  color: flyternBackgroundWhite,
                  child: TextFormField(
                      minLines: 4,
                      maxLines: 10,
                      controller: specialRequestController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: "special_request".tr,
                      )),
                ),
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
                    if(userDetailsForm.currentState!.validate()){
                      activityBookingController.setTravellerData(
                          ActivityTravellerInfo(
                              prefix: selectedTitle.name,
                              firstName: firstNameController.text,
                              lastName: lastNameController.text,
                              nationalityCode: nationality.countryISOCode,
                              specialRequest: specialRequestController.text,
                              email: email,
                              mobile: mobileNumber,
                              mobileCountryCode: mobileCntry));
                    }

                  },
                  child: activityBookingController.isSaveContactLoading.value
                      ? LoadingAnimationWidget.prograssiveDots(
                          color: flyternBackgroundWhite,
                          size: 20,
                        )
                      : Text("proceed".tr)),
            ),
          ),
        ),
      ),
    );
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
  }

  void changeSelectedPassenger(String newGender) {
    List<UserCoPax> coPax = coPaxController.userCopaxes
        .where((p0) => p0.id.toString() == newGender)
        .toList();
    if (coPax.isNotEmpty) {
      selectedPassenger = newGender;

      firstNameController.text = coPax[0].firstName;
      lastNameController.text = coPax[0].lastName;

      final sharedController = Get.find<SharedController>();

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
    }
  }
}
