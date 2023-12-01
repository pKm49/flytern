import 'package:flutter/material.dart';
import 'package:flytern/feature-modules/hotel_booking/controllers/hotel_booking.controller.dart';
import 'package:flytern/feature-modules/hotel_booking/models/traveller_info.hotel_booking.model.dart';
import 'package:flytern/feature-modules/profile/controllers/copax.profile.controller.dart';
import 'package:flytern/feature-modules/profile/models/user-copax.profile.model.dart';
import 'package:flytern/shared-module/controllers/shared.controller.dart';
import 'package:flytern/shared-module/constants/ui_specific/style_params.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/widget_styles.shared.constant.dart';
import 'package:flytern/shared-module/models/gender.dart';
import 'package:flytern/shared-module/models/general_item.dart';
import 'package:flytern/shared-module/services/utility-services/flight_userdata_input_formatter.dart';
import 'package:flytern/shared-module/services/utility-services/form_validator.shared.service.dart';
import 'package:flytern/shared-module/services/utility-services/widget_generator.shared.service.dart';
import 'package:flytern/shared-module/ui/components/dropdown_selector.shared.component.dart';
import 'package:get/get.dart';

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
  Gender selectedTitle = Gender(code: "0", name: "Title", isDefault: false);
  Gender selectedGender = Gender(code: "0", name: "Gender", isDefault: false);
  String selectedPassenger = "0";
  String gender = "0";
  String title = "0";
  final sharedController = Get.find<SharedController>();

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
                  padding: EdgeInsets.only(top: flyternSpaceMedium),
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
              decoration: flyternBorderedContainerSmallDecoration.copyWith(
                  color: flyternGrey10,
                  border: Border.all(color: flyternGrey10, width: .2)),
              padding: flyternMediumPaddingHorizontal.copyWith(
                  top: flyternSpaceExtraSmall, bottom: flyternSpaceExtraSmall),
              margin: EdgeInsets.only(top: flyternSpaceMedium),
              child: DropDownSelector(
                key: titleDropDownKey,
                titleText: "title".tr,
                selected: title,
                items: [
                  for (var i = 0; i < sharedController.titleList.length; i++)
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
            Container(
              padding: EdgeInsets.only(top: flyternSpaceMedium),
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
                        onChanged: updateData(),
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
                        controller: lastNameController,
                        onChanged: updateData(),
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
              padding: EdgeInsets.only(top: flyternSpaceMedium),
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
                            i < sharedController.genderList.value.length;
                            i++)
                          GeneralItem(
                              imageUrl: "",
                              id: sharedController.genderList.value[i].code,
                              name: sharedController.genderList.value[i].name)
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
    gender = newGender.code;
    selectedGender = newGender;
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
    List<UserCoPax> coPax = coPaxController.userCopaxes
        .where((p0) => p0.id.toString() == newGender)
        .toList();
    selectedPassenger = newGender;
    if (coPax.isNotEmpty) {
      List<Gender> coPaxGender = sharedController.genderList.value
          .where((element) => element.code == coPax[0].gender)
          .toList();

      if (coPaxGender.isNotEmpty) {
        gender = coPaxGender[0].code;
        selectedGender = coPaxGender[0];
      }

      List<Gender> tSelectedTitle = sharedController.titleList.value
          .where((element) => element.code == coPax[0].title)
          .toList();
      if (tSelectedTitle.isNotEmpty) {
        selectedTitle = tSelectedTitle[0];
        title = tSelectedTitle[0].code;
      }
      firstNameController.text = coPax[0].firstName;
      lastNameController.text = coPax[0].lastName;

      setState(() {});
      updateData();
    } else {
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
    widget.dataSubmitted(HotelTravelInfo(
        roomIndex: -1,
        typeIndex:-1,
        userIndex: -1,
        travellerType: "",
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
