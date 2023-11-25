import 'package:flutter/material.dart';
import 'package:flytern/core-module/constants/theme_data.core.constant.dart';
import 'package:flytern/feature-modules/flight_booking/controllers/flight_booking_controller.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/business_models/traveller_info.dart';
import 'package:flytern/feature-modules/flight_booking/ui/components/flight_userdetails_submission_form.dart';
import 'package:flytern/feature-modules/hotel_booking/controllers/hotel_booking_controller.dart';
import 'package:flytern/feature-modules/hotel_booking/data/models/business_models/hotel_traveller_info.dart';
import 'package:flytern/feature-modules/hotel_booking/ui/components/hotel_userdetails_submission_form.dart';
import 'package:flytern/shared-module/data/constants/app_specific/app_route_names.dart';
import 'package:flytern/shared-module/data/constants/ui_constants/style_params.dart';
import 'package:flytern/shared-module/data/constants/ui_constants/widget_styles.dart';
import 'package:flytern/shared-module/services/utility-services/widget_generator.dart';
import 'package:flytern/shared-module/services/utility-services/widget_properties_generator.dart';
import 'package:flytern/shared-module/ui/components/contact_details_getter.dart';
import 'package:flytern/shared-module/ui/components/sort_option_selector.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class HotelUserDetailsSubmissionPage extends StatefulWidget {
  const HotelUserDetailsSubmissionPage({super.key});

  @override
  State<HotelUserDetailsSubmissionPage> createState() =>
      _HotelUserDetailsSubmissionPageState();
}

class _HotelUserDetailsSubmissionPageState
    extends State<HotelUserDetailsSubmissionPage>
    with SingleTickerProviderStateMixin {
  final List<ExpansionTileController> adultExpansionControllers = [];
  final List<PageStorageKey> adultExpansionControllerKeys = [];
  final List<ExpansionTileController> childExpansionControllers = [];
  final List<PageStorageKey> childExpansionControllerKeys = [];
  final List<ExpansionTileController> infantExpansionControllers = [];
  final List<PageStorageKey> infantExpansionControllerKeys = [];

  dynamic argumentData = Get.arguments;
  final hotelBookingController = Get.find<HotelBookingController>();
  late TabController tabController;
  List<HotelTravelInfo> travelInfo = [];

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
                          Tab(text: "${'room'.tr} ${i+1}"),
                      ])),
              Expanded(
                  child: TabBarView(
                controller: tabController,
                children: [
                  for (var i = 0; i < tabLength; i++)
                    Container(
                      padding: flyternLargePaddingHorizontal,
                      color: flyternBackgroundWhite,
                      child: HotelUserDetailsSubmissionForm(
                        hotelBookingController:
                        hotelBookingController,
                        dataSubmitted: (HotelTravelInfo travelInfo) {
                          updateTravellerInfor(i, travelInfo);
                        },
                      )
                    )
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
                    hotelBookingController.saveTravellersData(travelInfo);
                  },
                  child: hotelBookingController
                          .isHotelTravellerDataSaveLoading.value
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


  void initializeForms() {
    print("initializeForms");
    hotelBookingController.saveContactInfo(mobileCntry, mobileNumber, email);
    tabLength = hotelBookingController.hotelSearchData.value.rooms.length;
    tabController =
        TabController(vsync: this, length: hotelBookingController.hotelSearchData.value.rooms.length, initialIndex: 0);
  print("rooms length");
  print( hotelBookingController.hotelSearchData.value.rooms.length);


    for (var i = 0; i < hotelBookingController.hotelSearchData.value.rooms.length; i++) {
      travelInfo.add(mapHotelTravelInfo({
        'roomId':hotelBookingController.hotelDetails.value.rooms[i].roomid,
        'hotelOptionid':hotelBookingController.selectedRoomOption.value[i].roomOptionid
      }));
    }
    print("travelInfo.length");
    print(travelInfo.length);

    setState(() {});
  }

  void updateTravellerInfor(index, HotelTravelInfo newHotelTravelInfo) {
    print("updateTravellerInfor");
    print(index);
    print(newHotelTravelInfo.title);
    print(newHotelTravelInfo.firstName);
    print(newHotelTravelInfo.gender);
    print(travelInfo.length);
    List<HotelTravelInfo> tempHotelTravelInfo = [];
    for (var i = 0; i < travelInfo.length; i++) {
      if ((i  ) != index) {
        tempHotelTravelInfo.add(travelInfo[i]);
      } else {
        tempHotelTravelInfo.add(HotelTravelInfo(
            hotelOptionid: travelInfo[i].hotelOptionid,
            roomId: travelInfo[i].roomId,
            title: newHotelTravelInfo.title,
            firstName:  newHotelTravelInfo.firstName,
            lastName: newHotelTravelInfo.lastName,
            gender:  newHotelTravelInfo.gender));
      }
    }
    travelInfo = tempHotelTravelInfo;
  }
}
