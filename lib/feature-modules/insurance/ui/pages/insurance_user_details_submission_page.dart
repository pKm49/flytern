import 'package:flutter/material.dart';
import 'package:flytern/core-module/constants/theme_data.core.constant.dart';
import 'package:flytern/feature-modules/flight_booking/controllers/flight_booking_controller.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/traveller_info.dart';
import 'package:flytern/feature-modules/flight_booking/ui/components/flight_userdetails_submission_form.dart';
import 'package:flytern/feature-modules/insurance/controllers/insurance_controller.dart';
import 'package:flytern/feature-modules/insurance/data/models/insurance_traveller_info.dart';
import 'package:flytern/feature-modules/insurance/ui/components/insurance_userdetails_submission_form.dart';
import 'package:flytern/shared-module/constants/app_specific/route_names.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/style_params.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/widget_styles.shared.constant.dart';
import 'package:flytern/shared-module/services/utility-services/widget_generator.shared.service.dart';
import 'package:flytern/shared-module/services/utility-services/widget_properties_generator.shared.service.dart';
import 'package:flytern/shared-module/ui/components/contact_details_getter.shared.component.dart';
import 'package:flytern/shared-module/ui/components/sort_option_selector.shared.component.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class InsuranceUserDetailsSubmissionPage extends StatefulWidget {
  const InsuranceUserDetailsSubmissionPage({super.key});

  @override
  State<InsuranceUserDetailsSubmissionPage> createState() =>
      _InsuranceUserDetailsSubmissionPageState();
}

class _InsuranceUserDetailsSubmissionPageState
    extends State<InsuranceUserDetailsSubmissionPage>
    with SingleTickerProviderStateMixin {
  final List<ExpansionTileController> contributorExpansionControllers = [];
  final List<ExpansionTileController> spouseExpansionControllers = [];
  final List<ExpansionTileController> daughterExpansionControllers = [];
  final List<ExpansionTileController> sonExpansionControllers = [];

  dynamic argumentData = Get.arguments;
  final insuranceBookingController = Get.find<InsuranceBookingController>();
  late TabController tabController;
  List<InsuranceTravellerInfo> travelInfo = [];
  int tabLength = 1;
  String mobileCntry = "";
  String mobileNumber = "";
  String email = "";

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    mobileCntry = argumentData[0]['mobileCntry'];
    mobileNumber = argumentData[0]['mobileNumber'];
    email = argumentData[0]['email'];

    initializeForms();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery
        .of(context)
        .size
        .width;
    double screenheight = MediaQuery
        .of(context)
        .size
        .height;

    return Obx(
          () =>
          Scaffold(
            appBar: AppBar(
              title: Text("submit_user_details".tr),
              elevation: .3,
            ),
            body: Container(
              width: screenwidth,
              height: screenheight,
              color: flyternGrey10,
              child: Column(
                children: [
                  Container(
                      padding: flyternMediumPaddingHorizontal,
                      decoration: BoxDecoration(
                          border: flyternDefaultBorderBottomOnly,
                          color: flyternBackgroundWhite),
                      child: TabBar(
                          indicatorSize: TabBarIndicatorSize.tab,
                          labelPadding: EdgeInsets.zero,
                          indicatorColor: flyternSecondaryColor,
                          indicatorWeight: 2,
                          padding: EdgeInsets.zero,
                          controller: tabController,
                          labelColor: flyternSecondaryColor,
                          labelStyle: const TextStyle(
                              color: flyternSecondaryColor,
                              fontWeight: FontWeight.bold),
                          unselectedLabelColor: flyternGrey40,
                          tabs: <Tab>[
                            for (var i = 0; i < tabLength; i++)
                              Tab(text: getTabTitle(i)),
                          ])),
                  Expanded(
                      child: TabBarView(
                        controller: tabController,
                        children: [
                          for (var i = 0; i < tabLength; i++)
                            ListView.builder(
                                itemBuilder: (context, index) {
                                  return i == 0
                                      ? Container(
                                    padding: flyternLargePaddingHorizontal,
                                    color: flyternBackgroundWhite,
                                    child: ExpansionTile(
                                      maintainState: true,
                                      initiallyExpanded: index == 0,
                                      tilePadding: EdgeInsets.zero,
                                      controller:
                                      contributorExpansionControllers[index],
                                      title: Text("${'contributor'.tr} "),
                                      children: <Widget>[
                                        InsuranceUserDetailsSubmissionForm(
                                          index: getIndex(0, index),
                                          insuranceBookingController:
                                          insuranceBookingController,
                                          dataSubmitted: (InsuranceTravellerInfo
                                          travelInfo) {
                                            updateTravellerInfor(
                                                getIndex(0, index), travelInfo);
                                          },
                                        )
                                      ],
                                    ),
                                  )
                                      : i == 1
                                      ? Container(
                                    padding: flyternLargePaddingHorizontal,
                                    color: flyternBackgroundWhite,
                                    child: ExpansionTile(
                                      maintainState: true,
                                      initiallyExpanded: index == 0,
                                      tilePadding: EdgeInsets.zero,
                                      controller:
                                      spouseExpansionControllers[index],
                                      title: Text("${'spouse'.tr}"),
                                      children: <Widget>[
                                        InsuranceUserDetailsSubmissionForm(
                                          index: getIndex(1, index),
                                          insuranceBookingController:
                                          insuranceBookingController,
                                          dataSubmitted:
                                              (InsuranceTravellerInfo
                                          travelInfo) {
                                            updateTravellerInfor(
                                                getIndex(1, index),
                                                travelInfo);
                                          },
                                        )
                                      ],
                                    ),
                                  )
                                      : i == 2
                                      ? Container(
                                    padding:
                                    flyternLargePaddingHorizontal,
                                    color: flyternBackgroundWhite,
                                    child: ExpansionTile(
                                      maintainState: true,
                                      initiallyExpanded: index == 0,
                                      tilePadding: EdgeInsets.zero,
                                      controller:
                                      daughterExpansionControllers[
                                      index],
                                      title: Text(
                                          "${'daughter'.tr} ${index + 1}"),
                                      children: <Widget>[
                                        InsuranceUserDetailsSubmissionForm(
                                          index: getIndex(2, index),
                                          insuranceBookingController:
                                          insuranceBookingController,
                                          dataSubmitted:
                                              (InsuranceTravellerInfo
                                          travelInfo) {
                                            updateTravellerInfor(
                                                getIndex(2, index),
                                                travelInfo);
                                          },
                                        )
                                      ],
                                    ),
                                  )
                                      : Container(
                                    padding:
                                    flyternLargePaddingHorizontal,
                                    color: flyternBackgroundWhite,
                                    child: ExpansionTile(
                                      maintainState: true,
                                      initiallyExpanded: index == 0,
                                      tilePadding: EdgeInsets.zero,
                                      controller:
                                      sonExpansionControllers[index],
                                      title: Text(
                                          "${'son'.tr} ${index + 1}"),
                                      children: <Widget>[
                                        InsuranceUserDetailsSubmissionForm(
                                          index: getIndex(3, index),
                                          insuranceBookingController:
                                          insuranceBookingController,
                                          dataSubmitted:
                                              (InsuranceTravellerInfo
                                          travelInfo) {
                                            updateTravellerInfor(
                                                getIndex(3, index),
                                                travelInfo);
                                          },
                                        )
                                      ],
                                    ),
                                  );
                                },
                                itemCount: i == 0
                                    ? contributorExpansionControllers.length
                                    : i == 1
                                    ? spouseExpansionControllers.length
                                    : i == 2
                                    ? daughterExpansionControllers.length
                                    : sonExpansionControllers.length),

                        ],
                      )),
                  addVerticalSpace(flyternSpaceLarge * 4)
                ],
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
                      onPressed: () async {
                        FocusManager.instance.primaryFocus?.unfocus();
                        await Future.delayed(const Duration(seconds: 1));

                        insuranceBookingController.saveTravellersData(
                            travelInfo);
                      },
                      child: insuranceBookingController
                          .isInsuranceSaveTravellerLoading.value
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

  getIndex(int itemTypeIndex, int localIndex) {
    switch (itemTypeIndex) {
      case 0:
        {
          return localIndex + 1;
        }
      case 1:
        {
          return localIndex + 2;
        }
      case 2:
        {
          return insuranceBookingController.spouse.value +
              insuranceBookingController.daughter.value +
              (localIndex + 1);
        }
      case 3:
        {
          return insuranceBookingController.spouse.value +
              insuranceBookingController.daughter.value +
              insuranceBookingController.son.value +
              (localIndex + 1);
        }
    }
  }

  void initializeForms() {
    print("initializeForms");

    insuranceBookingController.saveContactInfo(
        mobileCntry, mobileNumber, email);

    int total = insuranceBookingController.contributor.value +
        insuranceBookingController.spouse.value +
        insuranceBookingController.daughter.value +
        insuranceBookingController.son.value;

    String contributorRelationshipCode = "";
    String spouseRelationshipCode = "";
    String daughterRelationshipCode = "";
    String sonRelationshipCode = "";

    for (var element in insuranceBookingController
        .insuranceInitialData.value.lstPolicyRelationship) {
      if (element.name == "Contributor") {
        contributorRelationshipCode = element.id;
      }
      if (element.name == "Spouse") {
        spouseRelationshipCode = element.id;
      }
      if (element.name == "Son") {
        daughterRelationshipCode = element.id;
      }
      if (element.name == "Daughter") {
        sonRelationshipCode = element.id;
      }
    }
    print("contributorRelationshipCode");
    print(contributorRelationshipCode);
    print("spouseRelationshipCode");
    print(spouseRelationshipCode);
    contributorExpansionControllers.add(ExpansionTileController());

    travelInfo.add(mapInsuranceTravellerInfo(
        {"relationshipCode": contributorRelationshipCode}));

    if (insuranceBookingController.spouse.value > 0) {
      tabLength++;
      spouseExpansionControllers.add(ExpansionTileController());

      travelInfo.add(mapInsuranceTravellerInfo(
          {"relationshipCode": spouseRelationshipCode}));
    }

    if (insuranceBookingController.daughter.value > 0) {
      tabLength++;
      for (var i = 0; i < insuranceBookingController.daughter.value; i++) {
        daughterExpansionControllers.add(ExpansionTileController());

        travelInfo.add(mapInsuranceTravellerInfo(
            {"relationshipCode": daughterRelationshipCode}));
      }
    }

    if (insuranceBookingController.son.value > 0) {
      tabLength++;
      for (var i = 0; i < insuranceBookingController.son.value; i++) {
        sonExpansionControllers.add(ExpansionTileController());
        travelInfo.add(mapInsuranceTravellerInfo(
            {"relationshipCode": sonRelationshipCode}));
      }
    }

    tabController =
        TabController(vsync: this, length: tabLength, initialIndex: 0);

    print("travelInfo length");
    print(travelInfo.length);
    for (var i = 0; i < travelInfo.length; i++) {
      print("travelInfo $i");
      print(travelInfo[i].toJson());
    }
    setState(() {});
  }

  void updateTravellerInfor(index, InsuranceTravellerInfo newTravelInfo) {
    print("updateTravellerInfor");
    print(index);
    print(newTravelInfo.relationshipCode);
    print(newTravelInfo.firstName);
    print(newTravelInfo.gender);
    print(travelInfo.length);
    List<InsuranceTravellerInfo> tempTravelInfo = [];
    for (var i = 0; i < travelInfo.length; i++) {
      if ((i + 1) != index) {
        tempTravelInfo.add(travelInfo[i]);
      } else {

        tempTravelInfo.add(InsuranceTravellerInfo(
            relationshipCode: travelInfo[i].relationshipCode,
            firstName: newTravelInfo.firstName,
            lastName: newTravelInfo.lastName,
            gender: newTravelInfo.gender,
            dateOfBirth: newTravelInfo.dateOfBirth,
            passportNumber: newTravelInfo.passportNumber,
            nationalityCode: newTravelInfo.nationalityCode,
            civilID: newTravelInfo.civilID));
      }
    }
    travelInfo = tempTravelInfo;
  }

  getTabTitle(int i) {
    if (i == 0) {
      return "${'contributor'.tr}";
    }
    if (i == 1) {
      if (insuranceBookingController.spouse.value > 0) {
        return "${'spouse'.tr}";
      }
      if (insuranceBookingController.daughter.value > 0) {
        return "${'daughter'.tr}";
      }
      if (insuranceBookingController.son.value > 0) {
        return "${'son'.tr}";
      }
    }
    if (i == 2) {
      if (insuranceBookingController.daughter.value > 0) {
        return "${'daughter'.tr}";
      }
      if (insuranceBookingController.son.value > 0) {
        return "${'son'.tr}";
      }
    }
    if (i == 3) {
      if (insuranceBookingController.son.value > 0) {
        return "${'son'.tr}";
      }
    }
  }

}
