import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flytern/feature-modules/flight_booking/controllers/flight_booking_controller.dart';
import 'package:flytern/feature-modules/flight_booking/data/constants/business_specific/flight_mode.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/business_models/flight_search_item.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/business_models/flight_search_result.dart';
import 'package:flytern/feature-modules/flight_booking/services/helper-services/flight_booking_helper_services.dart';
import 'package:flytern/feature-modules/flight_booking/ui/components/flight_booking_form.dart';
import 'package:flytern/feature-modules/flight_booking/ui/components/flight_filter_option_selector.dart';
import 'package:flytern/feature-modules/flight_booking/ui/components/flight_search_result_card.dart';
import 'package:flytern/feature-modules/flight_booking/ui/components/flight_search_result_card_loader.dart';
import 'package:flytern/feature-modules/flight_booking/ui/components/flight_type_tab.dart';
import 'package:flytern/shared/data/constants/app_specific/app_route_names.dart';
import 'package:flytern/shared/data/constants/ui_constants/asset_urls.dart';
import 'package:flytern/shared/data/constants/ui_constants/style_params.dart';
import 'package:flytern/shared/data/constants/ui_constants/widget_styles.dart';
import 'package:flytern/shared/services/utility-services/widget_generator.dart';
import 'package:flytern/shared/services/utility-services/widget_properties_generator.dart';
import 'package:flytern/shared/ui/components/filter_option_selector.dart';
import 'package:flytern/shared/ui/components/sort_option_selector.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';

class FlightMoreOptionsPage extends StatefulWidget {
  const FlightMoreOptionsPage({super.key});

  @override
  State<FlightMoreOptionsPage> createState() => _FlightMoreOptionsPageState();
}

class _FlightMoreOptionsPageState extends State<FlightMoreOptionsPage>
    with SingleTickerProviderStateMixin {
  final flightBookingController = Get.find<FlightBookingController>();


  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        title: Text( "more_options".tr),

      ),
      body: Obx(
        () => Container(
          width: screenwidth,
          height: screenheight,
          child: Column(
            children: [
              addVerticalSpace(flyternSpaceMedium),
              Container(
                width: screenwidth,
                padding: flyternLargePaddingHorizontal,
                child: Text(getSearchParamsPreview(),
                    textAlign: TextAlign.start,
                    style: getLabelLargeStyle(context).copyWith(
                        fontWeight: flyternFontWeightLight,
                        color: flyternGrey60)),
              ),
              addVerticalSpace(flyternSpaceMedium),

              Visibility(
                visible: !flightBookingController
                        .isFlightMoreOptionsResponsesLoading.value ,
                child: Expanded(
                    child: Container(
                        color: flyternGrey10,
                        child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: flightBookingController
                                .moreOptionFlights.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                  margin: const EdgeInsets.only(
                                      top: flyternSpaceMedium),
                                  child: FlightSearchResultCard(
                                    flightSearchResponse:
                                        flightBookingController
                                            .moreOptionFlights[index],
                                    onPressed: () {
                                      Get.toNamed(Approute_flightsDetails);
                                    }, onMoreOptionsPressed: () {  },
                                  ));
                            }))),
              ),
              Visibility(
                visible:  flightBookingController
                        .isFlightMoreOptionsResponsesLoading.value    ,
                child: Expanded(
                    child: Container(
                        color: flyternGrey10,
                        child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: 2,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                  margin: const EdgeInsets.only(
                                      top: flyternSpaceMedium),
                                  child: FlightSearchResultCardLoader());
                            }))),
              ),
              Container(
                height: flyternSpaceLarge,
                width: screenwidth,
                color: flyternGrey10,
              )
            ],
          ),
        ),
      ),
    );
  }

  String getSearchParamsPreview() {
    String searchParamsPreviewString = "";

    if (flightBookingController.flightSearchData.value.searchList.isNotEmpty) {
      flightBookingController.flightSearchData.value.searchList
          .forEach((element) {
        searchParamsPreviewString +=
            "${element.departure.airportCode}-${element.arrival.airportCode}${getDateString(element)} -";
      });
    }
    searchParamsPreviewString +=
        " ${flightBookingController.flightSearchData.value.mode.name}";

    if (flightBookingController.flightSearchData.value.adults > 0) {
      searchParamsPreviewString +=
          " -${flightBookingController.flightSearchData.value.adults} ${'adults'.tr}";
    }

    if (flightBookingController.flightSearchData.value.child > 0) {
      searchParamsPreviewString +=
          " -${flightBookingController.flightSearchData.value.child} ${'children'.tr}";
    }

    if (flightBookingController.flightSearchData.value.infants > 0) {
      searchParamsPreviewString +=
          " -${flightBookingController.flightSearchData.value.infants} ${'infants'.tr}";
    }

    if (flightBookingController.moreOptionFlights.isNotEmpty) {
      searchParamsPreviewString +=
      " -${flightBookingController.moreOptionFlights.value[0].finalPrc} ${flightBookingController.moreOptionFlights.value[0].currency}";
    }
    return searchParamsPreviewString;
  }

  String getFormattedDate(DateTime? dateTime) {
    if (dateTime == null) {
      return "";
    }
    final f = DateFormat('dd-MMM-yy');
    return f.format(dateTime);
  }

  getDateString(FlightSearchItem element) {
    if (element.returnDate == null) {
      return "  ${getFormattedDate(element.departureDate)}";
    }
    if (element.returnDate?.day == element.departureDate.day) {
      return "  ${getFormattedDate(element.departureDate)}";
    }
    return " ${element.departureDate.day}-${getFormattedDate(element.returnDate)}";
  }
}
