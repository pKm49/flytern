import 'package:flutter/material.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/business_models/cabin_class.dart';
import 'package:flytern/feature-modules/hotel_booking/controllers/hotel_booking_controller.dart';
import 'package:flytern/feature-modules/hotel_booking/services/delegates/hotel_destination_search_delegate.dart';
import 'package:flytern/feature-modules/hotel_booking/services/helper-services/hotel_booking_helper_services.dart';
import 'package:flytern/shared/data/constants/app_specific/app_route_names.dart';
import 'package:flytern/shared/data/constants/ui_constants/asset_urls.dart';
import 'package:flytern/shared/data/constants/ui_constants/style_params.dart';
import 'package:flytern/shared/data/constants/ui_constants/widget_styles.dart';
import 'package:flytern/shared/services/delegates/custom_search_delegate.dart';
import 'package:flytern/shared/services/utility-services/widget_generator.dart';
import 'package:flytern/shared/services/utility-services/widget_properties_generator.dart';
import 'package:flytern/shared/ui/components/booking_options_selector.dart';
import 'package:flytern/shared/ui/components/custom_date_picker.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';

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
      ()=> Container(
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
                    onTap: (){
                      showSearch(context: context, delegate: HotelDestinationSearchDelegate());
                    },
                    child: Container(
                      decoration: flyternBorderedContainerSmallDecoration.copyWith(
                          border: Border.all(color: flyternGrey20, width: .5)),
                      padding: flyternMediumPaddingAll,
                      child: Row(
                        children: [
                          Icon(Ionicons.location_outline,
                              color: flyternSecondaryColor,size: flyternFontSize20),
                          addHorizontalSpace(flyternSpaceSmall*1.5),
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
                                      fontWeight: FontWeight.  w400),
                                ),
                                addVerticalSpace(flyternSpaceExtraSmall*1.5),
                                Text(hotelBookingController.selectedDestination.value.cityName,
                                    style: getLabelLargeStyle(context)
                                        .copyWith(color: flyternGrey80, )),
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
                            onTap: (){
                              showCustomDatePicker();
                            },
                            child: Container(
                              decoration: flyternBorderedContainerSmallDecoration.copyWith(
                                  border: Border.all(color: flyternGrey20, width: .5)),
                              padding: flyternMediumPaddingAll,
                              child: Row(
                                children: [
                                  Icon(Icons.calendar_month,
                                      color: flyternSecondaryColor,size: flyternFontSize20),
                                  addHorizontalSpace(flyternSpaceSmall*1.5),
                                  Expanded(
                                    flex: 1,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'checkin'.tr,
                                          style: getLabelLargeStyle(context).copyWith(
                                              color: flyternGrey40,
                                              fontWeight: FontWeight.  w400),
                                        ),
                                        addVerticalSpace(flyternSpaceExtraSmall*1.5),
                                        Text(DateFormat.yMMMd('en_US').format(hotelBookingController.hotelSearchData.value.checkInDate),
                                            style: getLabelLargeStyle(context)
                                                .copyWith(color: flyternGrey80, )),
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
                            onTap: (){
                              showCustomDatePicker();
                            },
                            child: Container(
                              decoration: flyternBorderedContainerSmallDecoration.copyWith(
                                  border: Border.all(color: flyternGrey20, width: .5)),
                              padding: flyternMediumPaddingAll ,
                              child: Row(
                                children: [
                                  Icon(Icons.calendar_month,
                                      color: flyternSecondaryColor,size: flyternFontSize20),
                                  addHorizontalSpace(flyternSpaceSmall*1.5),
                                  Expanded(
                                    flex: 1,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'checkout'.tr,
                                          style: getLabelLargeStyle(context).copyWith(
                                              color: flyternGrey40,
                                              fontWeight: FontWeight.  w400),
                                        ),
                                        addVerticalSpace(flyternSpaceExtraSmall*1.5),
                                        Text(DateFormat.yMMMd('en_US').format(hotelBookingController.hotelSearchData.value.checkOutDate),
                                            style: getLabelLargeStyle(context)
                                                .copyWith( color: flyternGrey80)),
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
                    decoration: flyternBorderedContainerSmallDecoration.copyWith(
                        border: Border.all(color: flyternGrey20, width: .5)),
                    padding: flyternMediumPaddingAll,
                    child: Row(
                      children: [
                        Icon(Ionicons.bed_outline,
                            color: flyternSecondaryColor,size: flyternFontSize20),
                        addHorizontalSpace(flyternSpaceSmall*1.5),
                        Expanded(
                          flex: 1,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'no_of_rooms'.tr,
                                style: getLabelLargeStyle(context).copyWith(
                                    color: flyternGrey40,
                                    fontWeight: FontWeight.  w400),
                              ),
                              addVerticalSpace(flyternSpaceExtraSmall*1.5),
                              Text(hotelBookingHelperServices.getPassengerCabinData(hotelBookingController.hotelSearchData.value, 0),
                                  style: getLabelLargeStyle(context)
                                      .copyWith(color: flyternGrey80, )),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  addVerticalSpace(flyternSpaceMedium),
                  InkWell(
                    onTap: (){
                      openHotelOptionsSelector();
                    },
                    child: Container(
                      decoration: flyternBorderedContainerSmallDecoration.copyWith(
                          border: Border.all(color: flyternGrey20, width: .5)),
                      padding: flyternMediumPaddingAll ,
                      child: Row(
                        children: [
                          Icon(Ionicons.person_outline,
                              color: flyternSecondaryColor,size: flyternFontSize20),
                          addHorizontalSpace(flyternSpaceSmall*1.5),
                          Expanded(
                            flex: 1,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'users'.tr,
                                  style: getLabelLargeStyle(context).copyWith(
                                      color: flyternGrey40,
                                      fontWeight: FontWeight.  w400),
                                ),
                                addVerticalSpace(flyternSpaceExtraSmall*1.5),
                                Text('1 Adult',
                                    style: getLabelLargeStyle(context)
                                        .copyWith( color: flyternGrey80)),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  addVerticalSpace(flyternSpaceMedium),

                  InkWell(
                    onTap: (){

                    },
                    child: Container(
                      decoration: flyternBorderedContainerSmallDecoration.copyWith(
                          border: Border.all(color: flyternGrey20, width: .5)),
                      padding: flyternMediumPaddingAll,
                      child: Row(
                        children: [
                          Icon(Icons.flag_outlined,
                              color: flyternSecondaryColor,size: flyternFontSize20),
                          addHorizontalSpace(flyternSpaceSmall*1.5),
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
                                      fontWeight: FontWeight.  w400),
                                ),
                                addVerticalSpace(flyternSpaceExtraSmall*1.5),
                                Text('Indian',
                                    style: getLabelLargeStyle(context)
                                        .copyWith( color: flyternGrey80, )),
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
                    child: ElevatedButton(style: getElevatedButtonStyle(context),
                        onPressed: ()   {
                          Get.toNamed(Approute_hotelsSearchResult);
                        }, child: Text("search_hotels".tr )),
                  ),

                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void showCustomDatePicker( ) {
    showModalBottomSheet(
        useSafeArea: false,
        shape:   RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(flyternBorderRadiusSmall),
              topRight: Radius.circular(flyternBorderRadiusSmall)),
        ),
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) {
          return CustomDatePicker(
            selectedDate: DateTime.now(),
            dateSelected: (DateTime? dateTime){

            },
          );
        });

  }
  void openHotelOptionsSelector( ) {
    showModalBottomSheet(
        useSafeArea: false,
        shape:   RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(flyternBorderRadiusSmall),
              topRight: Radius.circular(flyternBorderRadiusSmall)),
        ),
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) {
          return BookingOptionsSelector(
            selectedAdultCount: 1,
            selectedChildCount: 1,
            selectedInfantCount: 1,
            dataSubmitted: (int adultCount, int childCount, int infantCount, List<CabinClass> cabinClasses) {

            },
            bookingServiceNumber: 2,
            cabinClasses:[],
            selectedCabinClasses:  [],

          );
        });

  }

}
