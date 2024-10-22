import 'package:flutter/material.dart';
import 'package:flytern/feature-modules/flight_booking/models/cabin_class.flight_booking.model.dart';
import 'package:flytern/feature-modules/hotel_booking/controllers/hotel_booking.controller.dart';
import 'package:flytern/feature-modules/hotel_booking/models/destination.hotel_booking.model.dart';
import 'package:flytern/feature-modules/hotel_booking/services/destination_search_delegate.hotel_booking.service.dart';
import 'package:flytern/feature-modules/hotel_booking/services/helper.hotel_booking.service.dart';
import 'package:flytern/feature-modules/hotel_booking/ui/pages/custom_destination_search_delegate.hotel.page.dart';
 import 'package:flytern/shared-module/constants/ui_specific/asset_urls.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/style_params.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/widget_styles.shared.constant.dart';
import 'package:flytern/shared-module/models/country.dart';
import 'package:flytern/shared-module/services/utility-services/toaster_snackbar_shower.shared.service.dart';
import 'package:flytern/shared-module/services/utility-services/widget_generator.shared.service.dart';
import 'package:flytern/shared-module/services/utility-services/widget_properties_generator.shared.service.dart';
import 'package:flytern/shared-module/ui/components/booking_options_selector.shared.component.dart';
import 'package:flytern/shared-module/ui/components/country_selector.shared.component.dart';
import 'package:flytern/shared-module/ui/components/custom_date_picker.shared.component.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
 import 'package:loading_animation_widget/loading_animation_widget.dart';

class HotelBookingLandingPage extends StatefulWidget {
  const HotelBookingLandingPage({super.key});

  @override
  State<HotelBookingLandingPage> createState() =>
      _HotelBookingLandingPageState();
}

class _HotelBookingLandingPageState extends State<HotelBookingLandingPage>
    with SingleTickerProviderStateMixin {
  final hotelBookingController = Get.find<HotelBookingController>();
  final hotelBookingHelperServices = HotelBookingHelperServices();

  @override
  void initState() {
    super.initState();
    // hotelBookingController.resetDestinationAndNationality();

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
      () => Container(
        height: screenheight,
        width: screenwidth,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(ASSETS_HOTELS_BG),
            fit: BoxFit.cover,
          ),
        ),
        child: ListView(
          children: [
            Container(
              margin: EdgeInsets.all(flyternSpaceLarge),
              width: screenwidth - (flyternSpaceLarge * 2),
              decoration: flyternShadowedContainerSmallDecoration,
              padding: flyternMediumPaddingAll,
              child: Wrap(
                children: [
                  InkWell(
                    onTap: () async {
                      // HotelDestination destination = await showSearch(
                      //     context: context,
                      //     delegate: HotelDestinationSearchDelegate());
                      // hotelBookingController.setDestination(destination);
                      showDestinationGetterInput();
                    },
                    child: Container(
                      decoration:
                          flyternBorderedContainerSmallDecoration.copyWith(
                              border:
                                  Border.all(color: flyternGrey20, width: .5)),
                      padding: flyternMediumPaddingAll,
                      child: Row(
                        children: [
                          Icon(Ionicons.location_outline,
                              color: flyternSecondaryColor,
                              size: flyternFontSize20),
                          addHorizontalSpace(flyternSpaceSmall * 1.5),
                          Expanded(
                            flex: 1,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'hotel_destination_hint'.tr,
                                  style: getLabelLargeStyle(context).copyWith(
                                      color: flyternGrey40,
                                      fontWeight: FontWeight.w400),
                                ),
                                addVerticalSpace(flyternSpaceExtraSmall * 1.5),
                                Text(
                                    "${hotelBookingController.selectedDestination.value.uniqueCombination} ",
                                    style: getLabelLargeStyle(context).copyWith(
                                      color: flyternGrey80,
                                    )),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  addVerticalSpace(flyternSpaceMedium),
                  Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: () {
                              showCustomDatePicker(false,'checkin'.tr);
                            },
                            child: Container(
                              decoration:
                                  flyternBorderedContainerSmallDecoration
                                      .copyWith(
                                          border: Border.all(
                                              color: flyternGrey20, width: .5)),
                              padding: flyternSmallPaddingAll,
                              child: Row(
                                children: [
                                  Icon(Icons.calendar_month,
                                      color: flyternSecondaryColor,
                                      size: flyternFontSize20),
                                  addHorizontalSpace(flyternSpaceSmall),
                                  Expanded(
                                    flex: 1,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'checkin'.tr,
                                          style: getLabelLargeStyle(context)
                                              .copyWith(
                                                  color: flyternGrey40,
                                                  fontWeight: FontWeight.w400),
                                        ),
                                        addVerticalSpace(
                                            flyternSpaceExtraSmall * 1.5),
                                        Text(
                                            DateFormat.yMMMd('en_US').format(
                                                hotelBookingController
                                                    .hotelSearchData
                                                    .value
                                                    .checkInDate),
                                            style: getLabelLargeStyle(context)
                                                .copyWith(
                                              color: flyternGrey80,
                                            )),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )),
                      addHorizontalSpace(flyternSpaceSmall),
                      Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: () {
                              showCustomDatePicker(true,'checkout'.tr);
                            },
                            child: Container(
                              decoration:
                                  flyternBorderedContainerSmallDecoration
                                      .copyWith(
                                          border: Border.all(
                                              color: flyternGrey20, width: .5)),
                              padding: flyternSmallPaddingAll,
                              child: Row(
                                children: [
                                  Icon(Icons.calendar_month,
                                      color: flyternSecondaryColor,
                                      size: flyternFontSize20),
                                  addHorizontalSpace(flyternSpaceSmall ),
                                  Expanded(
                                    flex: 1,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'checkout'.tr,
                                          style: getLabelLargeStyle(context)
                                              .copyWith(
                                                  color: flyternGrey40,
                                                  fontWeight: FontWeight.w400),
                                        ),
                                        addVerticalSpace(
                                            flyternSpaceExtraSmall * 1.5),
                                        Text(
                                            DateFormat.yMMMd('en_US').format(
                                                hotelBookingController
                                                    .hotelSearchData
                                                    .value
                                                    .checkOutDate),
                                            style: getLabelLargeStyle(context)
                                                .copyWith(
                                                    color: flyternGrey80)),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )),
                    ],
                  ),
                  Padding(
                    padding: flyternSmallPaddingVertical,
                    child: Text(getDuration(),style: getBodyMediumStyle(context).copyWith(color: flyternSecondaryColor),),
                  ),
                   Container(
                    height: hotelBookingController
                                .hotelSearchData.value.rooms.length ==
                            1
                        ? 80
                        : ((hotelBookingController
                                        .hotelSearchData.value.rooms.length -
                                    1) *
                                120) +
                            80,
                    child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: hotelBookingController
                            .hotelSearchData.value.rooms.length,
                        itemBuilder: (context, index) => Container(
                              height: index != 0 ? 120 : 80,
                              width: screenwidth,
                              child: Column(
                                children: [
                                  Visibility(
                                    visible: index != 0,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: flyternSpaceSmall,
                                          bottom: flyternSpaceSmall),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              hotelBookingController
                                                  .updateHotelRoomCount(index);
                                            },
                                            child: Text(
                                              "remove".tr,
                                              style: getLabelLargeStyle(context)
                                                  .copyWith(
                                                      color: flyternGuideRed,
                                                      decoration: TextDecoration
                                                          .underline),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      openHotelOptionsSelector(index);
                                    },
                                    child: Container(
                                      height: 80,
                                      decoration:
                                          flyternBorderedContainerSmallDecoration
                                              .copyWith(
                                                  border: Border.all(
                                                      color: flyternGrey20,
                                                      width: .5)),
                                      padding: flyternMediumPaddingAll.copyWith(top: flyternSpaceSmall,bottom: flyternSpaceSmall),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          const Icon(Ionicons.bed_outline,
                                              color: flyternSecondaryColor,
                                              size: flyternFontSize20),
                                          addHorizontalSpace(
                                              flyternSpaceSmall * 1.5),
                                          Expanded(
                                            flex: 1,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  getNumberOfGuestsTitle(index),
                                                  style: getLabelLargeStyle(
                                                          context)
                                                      .copyWith(
                                                          color: flyternGrey40,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                ),
                                                addVerticalSpace(
                                                    flyternSpaceExtraSmall *
                                                        1.5),
                                                Text(
                                                    hotelBookingHelperServices
                                                        .getPassengerCabinData(
                                                            hotelBookingController
                                                                .hotelSearchData
                                                                .value,
                                                            index),
                                                    style: getLabelLargeStyle(
                                                            context)
                                                        .copyWith(
                                                      color: flyternGrey80,
                                                    )),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )),
                  ),
                  addVerticalSpace(flyternSpaceMedium),
                  SizedBox(
                    width: double.infinity,
                    child: InkWell(
                      onTap: () {
                        hotelBookingController.updateHotelRoomCount(-1);
                      },
                      child: Container(
                        decoration:
                            flyternBorderedContainerSmallDecoration.copyWith(
                                border: Border.all(
                                    color: flyternSecondaryColor, width: .5)),
                        padding: flyternMediumPaddingAll,
                        child: Center(
                            child: Text("+ " + "add_another_room".tr,
                                style: getBodyMediumStyle(context)
                                    .copyWith(color: flyternSecondaryColor))),
                      ),
                    ),
                  ),
                  addVerticalSpace(flyternSpaceMedium),
                  InkWell(
                    onTap: () {
                      openCountrySelector();
                    },
                    child: Container(
                      decoration:
                          flyternBorderedContainerSmallDecoration.copyWith(
                              border:
                                  Border.all(color: flyternGrey20, width: .5)),
                      padding: flyternMediumPaddingAll,
                      child: Row(
                        children: [
                          Icon(Icons.flag_outlined,
                              color: flyternSecondaryColor,
                              size: flyternFontSize20),
                          addHorizontalSpace(flyternSpaceSmall * 1.5),
                          Expanded(
                            flex: 1,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'nationality'.tr,
                                  style: getLabelLargeStyle(context).copyWith(
                                      color: flyternGrey40,
                                      fontWeight: FontWeight.w400),
                                ),

                                  Visibility(
                                      visible: hotelBookingController
                                          .nationality.value.countryName !=
                                          "select_nationality".tr,
                                    child: addVerticalSpace(flyternSpaceExtraSmall * 1.5)),
                                Visibility(
                                  visible: hotelBookingController
                                      .nationality.value.countryName !=
                                      "select_nationality".tr,
                                  child: Text(
                                      hotelBookingController
                                          .nationality.value.countryName,
                                      style: getLabelLargeStyle(context).copyWith(
                                        color:flyternGrey80,
                                      )),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  addVerticalSpace(flyternSpaceMedium),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        style: getElevatedButtonStyle(context),
                        onPressed: () {

                          if (hotelBookingController.selectedDestination.value
                                      .uniqueCombination !=
                                  "select_destination".tr &&
                              hotelBookingController
                                      .nationality.value.countryName !=
                                  "select_nationality".tr) {

                            hotelBookingController.getSearchResults(true);
                          } else {

                            if (hotelBookingController.selectedDestination.value
                                .uniqueCombination ==
                                "select_destination".tr &&
                                hotelBookingController
                                    .nationality.value.countryName ==
                                    "select_nationality".tr) {


                              showSnackbar(context,
                                  "hotel_form_validation_message".tr, "error");
                            }else
                            if (hotelBookingController.selectedDestination.value
                                .uniqueCombination ==
                                "select_destination".tr  ) {


                              showSnackbar(context,
                                  "hotel_form_validation_message_2".tr, "error");
                            }else
                            if (hotelBookingController
                                .nationality.value.countryName ==
                                "select_nationality".tr) {


                              showSnackbar(context,
                                  "hotel_form_validation_message_3".tr, "error");
                            }


                          }
                        },
                        //isHotelSearchResponsesLoading
                        child: hotelBookingController
                                .isHotelSearchResponsesLoading.value
                            ? LoadingAnimationWidget.prograssiveDots(
                                color: flyternBackgroundWhite,
                                size: 16,
                              )
                            : Text("search_hotels".tr)),
                  ),

                  Visibility(
                    visible:
                    !hotelBookingController.isInitialDataLoading.value &&
                        hotelBookingController.quickSearch.isNotEmpty,
                    child: Padding(
                        padding: EdgeInsets.only(top: flyternSpaceLarge,bottom: flyternSpaceMedium),
                        child: Row(
                          children: [
                            Icon(Ionicons.time_outline,
                                size: flyternFontSize20,
                                color: flyternSecondaryColor),
                            addHorizontalSpace(flyternSpaceSmall),

                            Text("recent_searches".tr,
                                style: getBodyMediumStyle(context)
                                    .copyWith(fontWeight: flyternFontWeightBold)),
                          ],
                        )),
                  ),
                  Visibility(
                    visible:
                    !hotelBookingController.isInitialDataLoading.value &&
                        hotelBookingController.quickSearch.isNotEmpty,
                    child: Container(
                        margin: EdgeInsets.only(bottom: flyternSpaceMedium),
                        width: double.infinity,
                        child: Wrap(
                          direction: Axis.horizontal,
                          children: [
                            for(var i=0;i<hotelBookingController.quickSearch.length;i++)
                              InkWell(
                                  onTap: () {
                                    hotelBookingController.getQuickSearchResult(
                                        hotelBookingController.quickSearch[i]);
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(right: flyternSpaceSmall,bottom: flyternSpaceSmall),
                                    padding: flyternExtraSmallPaddingAll.copyWith(
                                        left: flyternSpaceSmall,right: flyternSpaceSmall
                                    ),
                                    decoration:flyternBorderedContainerSmallDecoration.
                                    copyWith(border: Border.all(color: flyternTertiaryColor, width: .2)),
                                    child: Text(hotelBookingController.quickSearch[i].destination??""),
                                  )
                              )
                          ],
                        )),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void openCountrySelector() {
    showModalBottomSheet(
        useSafeArea: false,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(flyternBorderRadiusSmall),
              topRight: Radius.circular(flyternBorderRadiusSmall)),
        ),
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return CountrySelector(
            isMobile:false,
            isGlobal: false,
            countrySelected: (Country? country) {
              if (country != null) {
                hotelBookingController.updateNationality(country);
              }
            },
          );
        });
    // Get.bottomSheet(
    //     Container(
    //       child:  SharedTermsConditionsPage(),
    //       height: 1000
    //     ),
    //
    //   backgroundColor: flyternBackgroundWhite,
    //   elevation: 0,
    //   shape: RoundedRectangleBorder(
    //     borderRadius: BorderRadius.circular(10),
    //   ),
    // );
  }

  void showDestinationGetterInput( ) {
    showModalBottomSheet(
        useSafeArea: true,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (BuildContext context,
              StateSetter setModalState /*You can rename this!*/) {
            return CustomHotelDestinationSearchDelegate(

                destinationSelected: (HotelDestination hotelDestination) {
                  hotelBookingController.setDestination(hotelDestination);

                  Navigator.pop(context);
                });
          });
        });
  }

  void showCustomDatePicker(bool isCheckoutDate, String title) {
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
            isSingleTapSubmission:true,
              title:title ,
            minimumDate:isCheckoutDate?hotelBookingController
                .hotelSearchData.value.checkInDate.add(Duration(days: 1)): DateTime.now(),
            maximumDate:isCheckoutDate?hotelBookingController
                .hotelSearchData.value.checkInDate.add(Duration(days: 365))
                : DateTime.now().add(Duration(days: 365)),
            selectedDate: isCheckoutDate
                ? hotelBookingController.hotelSearchData.value.checkOutDate
                : hotelBookingController.hotelSearchData.value.checkInDate,
            dateSelected: (DateTime? dateTime) {
              if (dateTime != null) {
                hotelBookingController.changeDate(isCheckoutDate, dateTime);
              }
            },
          );
        });
  }

  void openHotelOptionsSelector(int index) {
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
          return BookingOptionsSelector(
              selectedAdultCount: hotelBookingController
                  .hotelSearchData.value.rooms[index].adults,
              selectedChildCount: hotelBookingController
                  .hotelSearchData.value.rooms[index].childs,
              selectedInfantCount: 0,
              dataSubmitted: (int adultCount, int childCount, int infantCount,
                  List<CabinClass> cabinClasses, List<int> childAges) {
                hotelBookingController.updatePassengerCount(
                    index, adultCount, childCount, childAges);
                Navigator.pop(context);
              },
              bookingServiceNumber: 2,
              cabinClasses: [],
              selectedCabinClasses: [],
              childAges: hotelBookingController
                  .hotelSearchData.value.rooms[index].childAges);
        });
  }

  String getDuration() {
    num durationDays = hotelBookingController.hotelSearchData.value.checkOutDate.difference(
        hotelBookingController.hotelSearchData.value.checkInDate
    ).inDays;

    if(durationDays == 1){
      return "single_night".tr;
    }

   return "night_count".tr.replaceAll("1", durationDays.toString());
  }

  String getNumberOfGuestsTitle(int index) {

    return "${'room'.tr} ${index + 1} : ${'no_of_guests'.tr} ";
  }
}
