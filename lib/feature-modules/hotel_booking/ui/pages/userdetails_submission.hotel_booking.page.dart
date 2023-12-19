import 'package:flutter/material.dart';
import 'package:flytern/feature-modules/hotel_booking/controllers/hotel_booking.controller.dart';
import 'package:flytern/feature-modules/hotel_booking/models/traveller_info.hotel_booking.model.dart';
import 'package:flytern/feature-modules/hotel_booking/ui/components/userdetails_submission_form.hotel_booking.component.dart';
import 'package:flytern/shared-module/constants/ui_specific/style_params.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/widget_styles.shared.constant.dart';
import 'package:flytern/shared-module/services/utility-services/widget_generator.shared.service.dart';
import 'package:flytern/shared-module/services/utility-services/widget_properties_generator.shared.service.dart';
import 'package:flytern/shared-module/ui/components/data_capsule_card.shared.component.dart';
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
    hotelBookingController.updateTravellerInfo([]);
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
        body: Stack(
          children: [
            Visibility(
                visible: hotelBookingController
                    .isHotelTravellerDataSaveLoading.value,
                child: Container(
                  width: screenwidth,
                  height: screenheight * .9,
                  color: flyternGrey10,
                  child: Center(
                      child: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        alignment: WrapAlignment.center,
                        children: [
                          LoadingAnimationWidget.prograssiveDots(
                            color: flyternSecondaryColor,
                            size: 50,
                          ),
                          Padding(
                            padding: flyternLargePaddingAll,
                            child: DataCapsuleCard(
                              label: "hotel_traveller_submission_message".tr,
                              theme: 1,
                            ),
                          ),
                        ],
                      )),
                )),
            Visibility(
              visible: !hotelBookingController
                  .isHotelTravellerDataSaveLoading.value,
              child: Container(
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
                              return Container(
                                padding: flyternLargePaddingHorizontal,
                                color: flyternBackgroundWhite,
                                child: ExpansionTile(
                                  maintainState: true,
                                  initiallyExpanded: index == 0,
                                  tilePadding: EdgeInsets.zero,
                                  controller: roomsExpansionControllers[i][index],
                                  title: Text(
                                      "${roomsExpansionControllerKeys[i][index].value.toString().split("-")[0]}"),
                                  children: <Widget>[
                                    Container(
                                        padding: EdgeInsets.only(
                                            bottom: flyternSpaceLarge),
                                        color: flyternBackgroundWhite,
                                        child: HotelUserDetailsSubmissionForm(
                                          roomIndex: i,
                                          userIndex: index + 1,
                                          hotelBookingController:
                                              hotelBookingController,
                                          dataSubmitted:
                                              (HotelTravelInfo travelInfo) {
                                            updateTravellerInfor(
                                                i, index + 1, travelInfo);
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
            ),
          ],
        ),
        bottomSheet: hotelBookingController
            .isHotelTravellerDataSaveLoading.value
            ? Container(width: screenwidth, height: 60)
        :Container(
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
                    hotelBookingController.saveTravellersData(
                        hotelBookingController.travelInfo.value);
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

    hotelBookingController.hotelPretravellerData.value.rooms
        .forEach((element) {});
    int roomUserCount = 0;
    for (var i = 0;
        i < hotelBookingController.hotelPretravellerData.value.rooms.length;
        i++) {
      roomsExpansionControllers.add([]);
      roomsExpansionControllerKeys.add([]);

      print("user count for $i room");
      print(hotelBookingController.hotelPretravellerData.value.rooms[i].adults);
      print(hotelBookingController.hotelPretravellerData.value.rooms[i].childs);

      if (hotelBookingController.hotelPretravellerData.value.rooms[i].adults >
          0) {
        for (var ind = 0;
            ind <
                hotelBookingController
                    .hotelPretravellerData.value.rooms[i].adults;
            ind++) {
          roomUserCount++;
          roomsExpansionControllers[i].add(ExpansionTileController());
          roomsExpansionControllerKeys[i]
              .add(PageStorageKey("${'adult'.tr} ${ind + 1}-${i + 1}"));

          hotelBookingController.addTravellerInfo(mapHotelTravelInfo({
            "roomIndex": i,
            "typeIndex": ind + 1,
            "userIndex": roomUserCount,
            "travellerType": "Adult",
            'roomId': hotelBookingController.hotelDetails.value.rooms[i].roomid,
            'hotelOptionid':
                hotelBookingController.selectedRoomOption.value[0].roomOptionid
          }));
        }
      }

      if (hotelBookingController.hotelPretravellerData.value.rooms[i].childs >
          0) {
        for (var ind = 0;
            ind <
                hotelBookingController
                    .hotelPretravellerData.value.rooms[i].childs;
            ind++) {
          roomUserCount++;
          roomsExpansionControllers[i].add(ExpansionTileController());
          roomsExpansionControllerKeys[i]
              .add(PageStorageKey("${'child'.tr} ${ind + 1}-${i + 1}"));

          hotelBookingController.addTravellerInfo(mapHotelTravelInfo({
            "roomIndex": i,
            "typeIndex": ind + 1,
            "userIndex": roomUserCount,
            "travellerType": "Child",
            'roomId': hotelBookingController.hotelDetails.value.rooms[i].roomid,
            'hotelOptionid':
                hotelBookingController.selectedRoomOption.value[0].roomOptionid
          }));
        }
      }
      roomUserCount = 0;
    }

    hotelBookingController.travelInfo.forEach((element) {
      print("travelInfo 1");
      print(element.roomIndex);
      print(element.typeIndex);
      print(element.userIndex);
      print(element.title);
      print(element.gender);
      print(element.firstName);
      print(element.lastName);
    });
    setState(() {});
  }

  void updateTravellerInfor(
      int roomIndex, int userIndex, HotelTravelInfo newHotelTravelInfo) {

    print("updateTravellerInfor updateTravellerInfor");
    print(roomIndex);
    print(userIndex);
    print(newHotelTravelInfo.firstName);

    List<HotelTravelInfo> tempHotelTravelInfo = [];
    for (var i = 0; i < hotelBookingController.travelInfo.value.length; i++) {

      print("traveller info $i");
      print(hotelBookingController.travelInfo.value[i].roomIndex);
      print(hotelBookingController.travelInfo.value[i].userIndex);
      print(hotelBookingController.travelInfo.value[i].firstName);

      if (hotelBookingController.travelInfo.value[i].roomIndex != roomIndex ||
          hotelBookingController.travelInfo.value[i].userIndex != userIndex) {
        print("roomIndex & userIndex not equal");
        print(hotelBookingController.travelInfo.value[i].firstName);
        tempHotelTravelInfo.add(hotelBookingController.travelInfo.value[i]);
      } else {
        print("roomIndex & userIndex is equal");
        print(newHotelTravelInfo.firstName);
        tempHotelTravelInfo.add(HotelTravelInfo(
            selectedCopaxId: newHotelTravelInfo.selectedCopaxId,
            roomIndex: hotelBookingController.travelInfo.value[i].roomIndex,
            typeIndex: hotelBookingController.travelInfo.value[i].typeIndex,
            userIndex: hotelBookingController.travelInfo.value[i].userIndex,
            travellerType:
                hotelBookingController.travelInfo.value[i].travellerType,
            hotelOptionid:
                hotelBookingController.travelInfo.value[i].hotelOptionid,
            roomId: hotelBookingController.travelInfo.value[i].roomId,
            title: newHotelTravelInfo.title,
            firstName: newHotelTravelInfo.firstName,
            lastName: newHotelTravelInfo.lastName,
            gender: newHotelTravelInfo.gender));
      }

    }
    hotelBookingController.updateTravellerInfo(tempHotelTravelInfo);
  }
}
