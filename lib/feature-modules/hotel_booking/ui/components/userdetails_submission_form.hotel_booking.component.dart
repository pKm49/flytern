import 'package:flutter/material.dart';
import 'package:flytern/feature-modules/flight_booking/controllers/flight_booking.controller.dart';
import 'package:flytern/feature-modules/hotel_booking/controllers/hotel_booking.controller.dart';
import 'package:flytern/feature-modules/hotel_booking/models/traveller_info.hotel_booking.model.dart';
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
import 'package:flytern/shared-module/services/utility-services/form_validator.shared.service.dart';
import 'package:flytern/shared-module/services/utility-services/widget_generator.shared.service.dart';
import 'package:flytern/shared-module/ui/components/country_selector.shared.component.dart';
import 'package:flytern/shared-module/ui/components/custom_date_picker.shared.component.dart';
import 'package:flytern/shared-module/ui/components/dropdown_selector.shared.component.dart';
import 'package:flytern/shared-module/ui/components/sort_option_selector.shared.component.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HotelUserDetailsSubmissionForm extends StatefulWidget {

  HotelBookingController hotelBookingController;
  final Function(HotelTravelInfo travelInfo) dataSubmitted;

  HotelUserDetailsSubmissionForm(
      {super.key,
      required this.hotelBookingController,
      required this.dataSubmitted});

  @override
  State<HotelUserDetailsSubmissionForm> createState() =>
      _HotelUserDetailsSubmissionFormState();
}

class _HotelUserDetailsSubmissionFormState
    extends State<HotelUserDetailsSubmissionForm>
    with AutomaticKeepAliveClientMixin<HotelUserDetailsSubmissionForm> {

  TextEditingController travellerTypeController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  Gender selectedTitle = Gender(code: "", name: "", isDefault: false);
  Gender selectedGender = Gender(code: "", name: "", isDefault: false);
  String selectedPassenger = "0";
  String gender = "0";
  String title = "0";

  final GlobalKey<FormState> userDetailsForm = GlobalKey<FormState>();
  final GlobalKey<FormState> genderDropDownKey = GlobalKey<FormState>();
  final GlobalKey<FormState> titleDropDownKey = GlobalKey<FormState>();
  final GlobalKey<FormState> selectPassengerDropDownKey =
      GlobalKey<FormState>();

  final coPaxController = Get.find<CoPaxController>();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("widget.index");
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
              decoration:
              flyternBorderedContainerSmallDecoration.copyWith(
                  color: flyternGrey10,
                  border:
                  Border.all(color: flyternGrey10, width: .2)),
              padding: flyternMediumPaddingHorizontal.copyWith(
                  top: flyternSpaceExtraSmall,
                  bottom: flyternSpaceExtraSmall),
              margin: EdgeInsets.only(top: flyternSpaceMedium),
              child: DropDownSelector(
                key: titleDropDownKey,
                titleText: "title".tr,
                selected: title,
                items: [
                  for (var i = 0;
                  i <
                      widget
                          .hotelBookingController
                          .hotelPretravellerData
                          .value
                          .titleList
                          .length;
                  i++)
                    GeneralItem(
                        imageUrl: "",
                        id: widget
                            .hotelBookingController
                            .hotelPretravellerData
                            .value
                            .titleList[i]
                            .name,
                        name: widget
                            .hotelBookingController
                            .hotelPretravellerData
                            .value
                            .titleList[i]
                            .code)
                ],
                hintText: "title".tr,
                valueChanged: (newGender) {
                  List<Gender> titles = widget.hotelBookingController
                      .hotelPretravellerData.value.titleList
                      .where((e) => e.code == newGender)
                      .toList();
                  if (titles.isNotEmpty) {
                    changeTitle(titles[0]);
                  }
                },
              ),
            ),
            Container(
              padding: EdgeInsets.only(bottom: flyternSpaceMedium,top: flyternSpaceMedium),
              color: flyternBackgroundWhite,
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: TextFormField(
                        controller: firstNameController,
                        onChanged:     updateData(),
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
                        onChanged:     updateData(),
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
                                widget
                                    .hotelBookingController
                                    .hotelPretravellerData
                                    .value
                                    .genderList
                                    .length;
                            i++)
                          GeneralItem(
                              imageUrl: "",
                              id: widget
                                  .hotelBookingController
                                  .hotelPretravellerData
                                  .value
                                  .genderList[i]
                                  .name,
                              name: widget
                                  .hotelBookingController
                                  .hotelPretravellerData
                                  .value
                                  .genderList[i]
                                  .code)
                      ],
                      hintText: "gender".tr,
                      valueChanged: (newGender) {
                        List<Gender> genders = widget.hotelBookingController
                            .hotelPretravellerData.value.genderList
                            .where((e) => e.name == newGender)
                            .toList();
                        if (genders.isNotEmpty) {
                          changeGender(genders[0]);
                        }
                      },
                    ),
                  )),

                ],
              ),
            ),

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
    if (coPax.isNotEmpty) {
      selectedPassenger = newGender;

      List<Gender> coPaxGender = widget
          .hotelBookingController.hotelPretravellerData.value.genderList
          .where((element) => element.name == coPax[0].gender)
          .toList();

      gender = coPaxGender[0].name;
      selectedGender = coPaxGender[0];
      firstNameController.text = coPax[0].firstName;
      lastNameController.text = coPax[0].lastName;

      final sharedController = Get.find<SharedController>();


      setState(() {});
      updateData();
    }
  }


  updateData() {
    widget.dataSubmitted(HotelTravelInfo(
        title: selectedTitle.code,
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        gender: selectedGender.code,
        hotelOptionid: 1,
        roomId: 1));
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
