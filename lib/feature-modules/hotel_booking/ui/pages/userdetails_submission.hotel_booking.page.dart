import 'package:flutter/material.dart';
import 'package:flytern/feature-modules/hotel_booking/controllers/hotel_booking.controller.dart';
import 'package:flytern/feature-modules/hotel_booking/models/traveller_info.hotel_booking.model.dart';
import 'package:flytern/feature-modules/hotel_booking/ui/components/userdetails_submission_form.hotel_booking.component.dart';
import 'package:flytern/shared-module/constants/ui_specific/style_params.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/widget_styles.shared.constant.dart';
import 'package:flytern/shared-module/services/utility-services/widget_generator.shared.service.dart';
import 'package:flytern/shared-module/services/utility-services/widget_properties_generator.shared.service.dart';
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

   final List<List<ExpansionTileController>> roomsExpansionControllers = [];
   final List<List<PageStorageKey>> roomsExpansionControllerKeys = [];

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
              Visibility(
                visible: tabLength > 1,
                child: Container(
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
                            Tab(text: "${'room'.tr}-${i + 1}"),
                        ])),
              ),
              Expanded(
                  child: TabBarView(
                    controller: tabController,
                    children: [
                      for (var i = 0; i < tabLength; i++)
                        ListView.builder(
                          itemBuilder: (context, index) {
                            return  Container(
                              padding: flyternLargePaddingHorizontal,
                              color: flyternBackgroundWhite,
                              child: ExpansionTile(
                                maintainState: true,
                                initiallyExpanded: index == 0,
                                tilePadding: EdgeInsets.zero,
                                controller: roomsExpansionControllers[i][index],
                                title: Text("${roomsExpansionControllerKeys[i][index].value.toString().split("-")[0]}"),
                                children: <Widget>[
                                  Container(
                                      padding: EdgeInsets.only(bottom: flyternSpaceLarge),
                                      color: flyternBackgroundWhite,
                                      child: HotelUserDetailsSubmissionForm(
                                        hotelBookingController: hotelBookingController,
                                        dataSubmitted: (HotelTravelInfo travelInfo) {
                                          updateTravellerInfor(i,index+1, travelInfo);
                                        },
                                      ))
                                ],
                              ),
                            );

                          },
                          itemCount: roomsExpansionControllers[i].length,
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
     hotelBookingController.saveContactInfo(mobileCntry, mobileNumber, email);
    tabLength = hotelBookingController.hotelPretravellerData.value.rooms.length;
    tabController = TabController(
        vsync: this,
        length: hotelBookingController.hotelPretravellerData.value.rooms.length,
        initialIndex: 0);

    hotelBookingController.hotelPretravellerData.value.rooms.forEach((element) {

    });
    int roomUserCount = 0;
    for (var i = 0;
        i < hotelBookingController.hotelPretravellerData.value.rooms.length;
        i++) {
      roomsExpansionControllers.add([]);
      roomsExpansionControllerKeys.add([]);

        if(hotelBookingController.hotelPretravellerData.value.rooms[i].adults>0){


          for (var ind = 0; ind < hotelBookingController.hotelPretravellerData.value.rooms[i].adults; ind++) {
           roomUserCount++;
            roomsExpansionControllers[i].add(ExpansionTileController());
           roomsExpansionControllerKeys[i].add(PageStorageKey("${'adult'.tr} ${ind+1}-${i + 1}"));

           travelInfo.add(mapHotelTravelInfo({
             "roomIndex":i,
             "typeIndex":ind+1,
             "userIndex":roomUserCount,
             "travellerType":  "Adult",
             'roomId': hotelBookingController.hotelDetails.value.rooms[0].roomid,
             'hotelOptionid':
             hotelBookingController.selectedRoomOption.value[0].roomOptionid
           }));

         }


       }

       if(hotelBookingController.hotelPretravellerData.value.rooms[i].childs>0){
         for (var ind = 0; ind < hotelBookingController.hotelPretravellerData.value.rooms[i].childs; ind++) {
           roomUserCount++;
           roomsExpansionControllers[i].add(ExpansionTileController());
           roomsExpansionControllerKeys[i].add(PageStorageKey("${'child'.tr} ${ind+1}-${i + 1}"));

           travelInfo.add(mapHotelTravelInfo({
             "roomIndex":i,
             "typeIndex":ind+1,
             "userIndex":roomUserCount,
             "travellerType":  "Child",
             'roomId': hotelBookingController.hotelDetails.value.rooms[0].roomid,
             'hotelOptionid':
             hotelBookingController.selectedRoomOption.value[0].roomOptionid
           }));
         }

       }
      roomUserCount = 0;
    }

    setState(() {});
  }

  void updateTravellerInfor(int roomIndex, int userIndex, HotelTravelInfo newHotelTravelInfo) {


    List<HotelTravelInfo> tempHotelTravelInfo = [];
    for (var i = 0; i < travelInfo.length; i++) {

      if (travelInfo[i].roomIndex != roomIndex &&
          travelInfo[i].userIndex != userIndex) {
         tempHotelTravelInfo.add(travelInfo[i]);
      } else {
         tempHotelTravelInfo.add(HotelTravelInfo(
            roomIndex: travelInfo[i].roomIndex,
            typeIndex: travelInfo[i].typeIndex,
            userIndex: travelInfo[i].userIndex,
            travellerType:  travelInfo[i].travellerType,
            hotelOptionid: travelInfo[i].hotelOptionid,
            roomId: travelInfo[i].roomId,
            title: newHotelTravelInfo.title,
            firstName: newHotelTravelInfo.firstName,
            lastName: newHotelTravelInfo.lastName,
            gender: newHotelTravelInfo.gender));
      }
    }
    travelInfo = tempHotelTravelInfo;
  }
}
