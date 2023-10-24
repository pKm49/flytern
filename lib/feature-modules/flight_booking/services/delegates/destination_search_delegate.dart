import 'package:flutter/material.dart';
import 'package:flytern/feature-modules/flight_booking/controllers/flight_booking_controller.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/business_models/flight_destination.dart';
import 'package:flytern/shared/data/constants/ui_constants/style_params.dart';
import 'package:flytern/shared/data/constants/ui_constants/widget_styles.dart';
import 'package:flytern/shared/services/utility-services/widget_generator.dart';
import 'package:flytern/shared/services/utility-services/widget_properties_generator.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class DestinationSearchDelegate extends SearchDelegate {

  final flightBookingController = Get.find<FlightBookingController>();

  @override
  List<Widget>? buildActions(BuildContext context) {

    return [
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {

    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back));

  }

  @override
  Widget buildResults(BuildContext context) {

    return FutureBuilder<List<FlightDestination>>(
      future: flightBookingController.getFlightDestinations(query),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return ListView.builder(
            itemBuilder: (context, index) {
              return InkWell(
                onTap: (){
                  close(context, snapshot.data![index]);
                },
                child: Container(
                  decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(width: .5,color: flyternGrey40))
                  ),
                  padding: flyternLargePaddingAll,
                  child: Row(children: [
                    Image.network(snapshot.data![index].flag, width: 40),
                    addHorizontalSpace(flyternSpaceMedium),
                    Expanded(
                        child: Text(
                            "${snapshot.data![index].uniqueCombination}",
                            maxLines: 2,
                            style: getBodyMediumStyle(context))),
                  ],),
                ),
              );
            },
            itemCount: snapshot.data?.length,
          );
        } else {
          return Center(
            child: CircularProgressIndicator(
              color: flyternSecondaryColor,
            ),
          );
        }
      },
    );

  }

  @override
  Widget buildSuggestions(BuildContext context) {

    return FutureBuilder<List<FlightDestination>>(
      future: flightBookingController.getFlightDestinations(query),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return ListView.builder(
            itemBuilder: (context, index) {
              return InkWell(
                onTap: (){
                  close(context, snapshot.data![index]);
                },
                child: Container(
                  decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(width: .5,color: flyternGrey40))
                  ),
                  padding: flyternLargePaddingAll,
                  child: Row(children: [
                    Image.network(snapshot.data![index].flag, width: 40),
                    addHorizontalSpace(flyternSpaceMedium),
                    Expanded(
                        child: Text(
                            "${snapshot.data![index].uniqueCombination}",
                            maxLines: 2,
                            style: getBodyMediumStyle(context))),
                  ],),
                ),
              );
            },
            itemCount: snapshot.data?.length,
          );
        } else {
          return Center(
            child: CircularProgressIndicator(
              color: flyternSecondaryColor,
            ),
          );
        }
      },
    );

  }

  bool checkSearchCondition(){
  return  flightBookingController.flightDestinations.value.where(
          (element) =>
              element.airportCode.toLowerCase().contains(query.toLowerCase()) ||
              element.airportName.toLowerCase().contains(query.toLowerCase())

  ).toList().isNotEmpty;
  }

}
