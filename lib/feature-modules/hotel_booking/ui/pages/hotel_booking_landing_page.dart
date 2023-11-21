import 'package:flutter/material.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/business_models/cabin_class.dart';
import 'package:flytern/feature-modules/hotel_booking/controllers/hotel_booking_controller.dart';
import 'package:flytern/feature-modules/hotel_booking/data/models/business_models/hotel_destination.dart';
import 'package:flytern/feature-modules/hotel_booking/services/delegates/hotel_destination_search_delegate.dart';
import 'package:flytern/feature-modules/hotel_booking/services/helper-services/hotel_booking_helper_services.dart';
import 'package:flytern/shared/data/constants/app_specific/app_route_names.dart';
import 'package:flytern/shared/data/constants/ui_constants/asset_urls.dart';
import 'package:flytern/shared/data/constants/ui_constants/style_params.dart';
import 'package:flytern/shared/data/constants/ui_constants/widget_styles.dart';
import 'package:flytern/shared/data/models/business_models/country.dart';
import 'package:flytern/shared/services/delegates/custom_search_delegate.dart';
import 'package:flytern/shared/services/utility-services/snackbar_shower.dart';
import 'package:flytern/shared/services/utility-services/widget_generator.dart';
import 'package:flytern/shared/services/utility-services/widget_properties_generator.dart';
import 'package:flytern/shared/ui/components/booking_options_selector.dart';
import 'package:flytern/shared/ui/components/country_selector.dart';
import 'package:flytern/shared/ui/components/custom_date_picker.dart';
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
  final hotelBookingController = Get.put(HotelBookingController());
  final hotelBookingHelperServices = HotelBookingHelperServices();

  @override
  void initState() {
    super.initState();
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
                      HotelDestination destination = await showSearch(
                          context: context,
                          delegate: HotelDestinationSearchDelegate());
                      hotelBookingController.setDestination(destination);
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
                                  'destination'.tr,
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
                              showCustomDatePicker(false);
                            },
                            child: Container(
                              decoration:
                                  flyternBorderedContainerSmallDecoration
                                      .copyWith(
                                          border: Border.all(
                                              color: flyternGrey20, width: .5)),
                              padding: flyternMediumPaddingAll,
                              child: Row(
                                children: [
                                  Icon(Icons.calendar_month,
                                      color: flyternSecondaryColor,
                                      size: flyternFontSize20),
                                  addHorizontalSpace(flyternSpaceSmall * 1.5),
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
                              showCustomDatePicker(true);
                            },
                            child: Container(
                              decoration:
                                  flyternBorderedContainerSmallDecoration
                                      .copyWith(
                                          border: Border.all(
                                              color: flyternGrey20, width: .5)),
                              padding: flyternMediumPaddingAll,
                              child: Row(
                                children: [
                                  Icon(Icons.calendar_month,
                                      color: flyternSecondaryColor,
                                      size: flyternFontSize20),
                                  addHorizontalSpace(flyternSpaceSmall * 1.5),
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
                  addVerticalSpace(flyternSpaceMedium),
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
                                      height: 75,
                                      decoration:
                                          flyternBorderedContainerSmallDecoration
                                              .copyWith(
                                                  border: Border.all(
                                                      color: flyternGrey20,
                                                      width: .5)),
                                      padding: flyternMediumPaddingAll,
                                      child: Row(
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
                                                  'no_of_guests'.tr,
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
                                addVerticalSpace(flyternSpaceExtraSmall * 1.5),
                                Text(
                                    hotelBookingController
                                        .nationality.value.countryName,
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
                        height: 50,
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
                                    child: Text(hotelBookingController.quickSearch[i].destinationName??""),
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

  void showCustomDatePicker(bool isCheckoutDate) {
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
            minimumDate:isCheckoutDate?hotelBookingController
                .hotelSearchData.value.checkInDate: DateTime.now(),
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
}
