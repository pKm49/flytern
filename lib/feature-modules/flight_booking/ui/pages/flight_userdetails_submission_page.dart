import 'package:flutter/material.dart';
import 'package:flytern/core-module/constants/theme_data.core.constant.dart';
import 'package:flytern/feature-modules/flight_booking/controllers/flight_booking_controller.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/traveller_info.dart';
import 'package:flytern/feature-modules/flight_booking/ui/components/flight_userdetails_submission_form.dart';
import 'package:flytern/shared-module/constants/app_specific/route_names.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/style_params.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/widget_styles.shared.constant.dart';
import 'package:flytern/shared-module/services/utility-services/widget_generator.shared.service.dart';
import 'package:flytern/shared-module/services/utility-services/widget_properties_generator.shared.service.dart';
import 'package:flytern/shared-module/ui/components/contact_details_getter.shared.component.dart';
import 'package:flytern/shared-module/ui/components/sort_option_selector.shared.component.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class FlightUserDetailsSubmissionPage extends StatefulWidget {
  const FlightUserDetailsSubmissionPage({super.key});

  @override
  State<FlightUserDetailsSubmissionPage> createState() =>
      _FlightUserDetailsSubmissionPageState();
}

class _FlightUserDetailsSubmissionPageState
    extends State<FlightUserDetailsSubmissionPage>
    with SingleTickerProviderStateMixin {
  final List<ExpansionTileController> adultExpansionControllers = [];
  final List<PageStorageKey> adultExpansionControllerKeys = [];
  final List<ExpansionTileController> childExpansionControllers = [];
  final List<PageStorageKey> childExpansionControllerKeys = [];
  final List<ExpansionTileController> infantExpansionControllers = [];
  final List<PageStorageKey> infantExpansionControllerKeys = [];

  dynamic argumentData = Get.arguments;
  final flightBookingController = Get.find<FlightBookingController>();
  late TabController tabController;
  List<TravelInfo> travelInfo = [];

  String mobileCntry = "";
  String mobileNumber = "";
  String email = "";
  int tabLength = 0;

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
                          Tab(
                              text: i == 0
                                  ? "${'adults'.tr} (${adultExpansionControllers.length})"
                                  : i == 1
                                      ? "${'children'.tr} (${childExpansionControllers.length})"
                                      : "${'infants'.tr} (${infantExpansionControllers.length})"),
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
                                  controller: adultExpansionControllers[index],
                                  title: Text("${'adult'.tr} ${index + 1}"),
                                  children: <Widget>[
                                    FlightUserDetailsSubmissionForm(
                                      index: getIndex(0, index),
                                      itemTypeIndex: 0,
                                      flightBookingController:
                                          flightBookingController,
                                      dataSubmitted: (TravelInfo travelInfo) {
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
                                          childExpansionControllers[index],
                                      title: Text("${'child'.tr} ${index + 1}"),
                                      children: <Widget>[
                                        FlightUserDetailsSubmissionForm(
                                          index: getIndex(1, index),
                                          itemTypeIndex: 1,
                                          flightBookingController:
                                              flightBookingController,
                                          dataSubmitted:
                                              (TravelInfo travelInfo) {
                                            updateTravellerInfor(
                                                getIndex(1, index), travelInfo);
                                          },
                                        )
                                      ],
                                    ),
                                  )
                                : Container(
                                    padding: flyternLargePaddingHorizontal,
                                    color: flyternBackgroundWhite,
                                    child: ExpansionTile(
                                      maintainState: true,
                                      initiallyExpanded: index == 0,
                                      tilePadding: EdgeInsets.zero,
                                      controller:
                                          infantExpansionControllers[index],
                                      title:
                                          Text("${'infant'.tr} ${index + 1}"),
                                      children: <Widget>[
                                        FlightUserDetailsSubmissionForm(
                                          index: getIndex(2, index),
                                          itemTypeIndex: 2,
                                          flightBookingController:
                                              flightBookingController,
                                          dataSubmitted:
                                              (TravelInfo travelInfo) {
                                            updateTravellerInfor(
                                                getIndex(2, index), travelInfo);
                                          },
                                        )
                                      ],
                                    ),
                                  );
                      },
                      itemCount: i == 0
                          ? adultExpansionControllers.length
                          : i == 1
                              ? childExpansionControllers.length
                              : infantExpansionControllers.length,
                    ),
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
                  onPressed: () {
                    flightBookingController.saveTravellersData(travelInfo);
                  },
                  child: flightBookingController
                          .isFlightTravellerDataSaveLoading.value
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
          return flightBookingController.flightPretravellerData.value.adult +
              (localIndex + 1);
        }
      case 2:
        {
          return flightBookingController.flightPretravellerData.value.adult +
              flightBookingController.flightPretravellerData.value.child +
              (localIndex + 1);
        }
    }
  }

  void initializeForms() {
    print("initializeForms");
    print(flightBookingController.flightPretravellerData.value.adult);
    print(flightBookingController.flightPretravellerData.value.child);
    print(flightBookingController.flightPretravellerData.value.infant);
    flightBookingController.saveContactInfo(mobileCntry, mobileNumber, email);

    int total = flightBookingController.flightPretravellerData.value.adult +
        flightBookingController.flightPretravellerData.value.child +
        flightBookingController.flightPretravellerData.value.infant;

    if (flightBookingController.flightPretravellerData.value.adult > 0) {
      tabLength++;
      for (var i = 0;
          i < flightBookingController.flightPretravellerData.value.adult;
          i++) {
        adultExpansionControllers.add(ExpansionTileController());
        adultExpansionControllerKeys.add(PageStorageKey("adult$i"));
      }
    }

    if (flightBookingController.flightPretravellerData.value.child > 0) {
      tabLength++;
      for (var i = 0;
          i < flightBookingController.flightPretravellerData.value.child;
          i++) {
        childExpansionControllers.add(ExpansionTileController());
        childExpansionControllerKeys.add(PageStorageKey("child$i"));
      }
    }

    if (flightBookingController.flightPretravellerData.value.infant > 0) {
      tabLength++;
      for (var i = 0;
          i < flightBookingController.flightPretravellerData.value.infant;
          i++) {
        infantExpansionControllers.add(ExpansionTileController());
        infantExpansionControllerKeys.add(PageStorageKey("infant$i"));
      }
    }

    tabController =
        TabController(vsync: this, length: tabLength, initialIndex: 0);

    for (var i = 0; i < total; i++) {
      print(" add default travelInfo");
      print(i);
      print(total);
      print(flightBookingController.flightPretravellerData.value.adult);
      print(flightBookingController.flightPretravellerData.value.child);
      print(flightBookingController.flightPretravellerData.value.infant);
      travelInfo.add(mapTravelInfo({
        "no": i + 1,
        "travellerType": ((i + 1) <=
                flightBookingController.flightPretravellerData.value.adult)
            ? "Adult"
            : ((i + 1) >
                        flightBookingController
                            .flightPretravellerData.value.adult &&
                    (i + 1) <=
                        (flightBookingController
                                .flightPretravellerData.value.child +
                            flightBookingController
                                .flightPretravellerData.value.adult))
                ? "Child"
                : "Infant"
      }));
    }

    setState(() {});
  }

  void updateTravellerInfor(index, TravelInfo newTravelInfo) {
    print("updateTravellerInfor");
    print(index);
    print(newTravelInfo.title);
    print(newTravelInfo.firstName);
    print(newTravelInfo.gender);
    print(travelInfo.length);
    List<TravelInfo> tempTravelInfo = [];
    for (var i = 0; i < travelInfo.length; i++) {
      if ((i + 1) != index) {
        tempTravelInfo.add(travelInfo[i]);
      } else {
        tempTravelInfo.add(newTravelInfo);
      }
    }
    travelInfo = tempTravelInfo;
  }
}
