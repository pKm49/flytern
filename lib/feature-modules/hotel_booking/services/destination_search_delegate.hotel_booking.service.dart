import 'dart:async';

import 'package:debounce_throttle/debounce_throttle.dart';
import 'package:flutter/material.dart';
import 'package:flytern/feature-modules/hotel_booking/controllers/hotel_booking.controller.dart';
import 'package:flytern/feature-modules/hotel_booking/models/destination.hotel_booking.model.dart';
import 'package:flytern/shared-module/constants/ui_specific/style_params.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/widget_styles.shared.constant.dart';
import 'package:flytern/shared-module/services/utility-services/widget_generator.shared.service.dart';
import 'package:flytern/shared-module/services/utility-services/widget_properties_generator.shared.service.dart';
import 'package:get/get.dart'; 
import 'package:loading_animation_widget/loading_animation_widget.dart';


class HotelDestinationSearchDelegate extends SearchDelegate {
  final hotelBookingController = Get.find<HotelBookingController>();

  Completer<List<HotelDestination>> _completer = Completer();

  late final Debouncer _debouncer = Debouncer(Duration(seconds: 1),
      initialValue: '',
      onChanged: (value) {
        _completer.complete(hotelBookingController.getHotelDestinations(value) ); // call the API endpoint
      }
  );


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

    return FutureBuilder<List<HotelDestination>>(
      future: hotelBookingController.getHotelDestinations(query),
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
          if(query !=""){
            return Center(
                child: LoadingAnimationWidget.prograssiveDots(
                  color: flyternSecondaryColor,
                  size: 50,
                )
            );
          }else{
            return Container();
          }
        }
      },
    );

  }

  @override
  Widget buildSuggestions(BuildContext context) {
    _debouncer.value = query; // update the _debouncer
    _completer = Completer(); // re-create the _completer, 'cause old one might be completed already

    return FutureBuilder<List<HotelDestination>>(
      future:_completer.future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
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
          if(query !=""){
            return Center(
                child: LoadingAnimationWidget.prograssiveDots(
                  color: flyternSecondaryColor,
                  size: 50,
                )
            );
          }else{
            return Container();
          }
          print("snapshot.connectionState");
          print(snapshot.connectionState);

        }
      },
    );

  }

  bool checkSearchCondition(){
  return  hotelBookingController.hotelDestinations.value.where(
          (element) =>
              element.cityCode.toLowerCase().contains(query.toLowerCase()) ||
              element.cityName.toLowerCase().contains(query.toLowerCase())

  ).toList().isNotEmpty;
  }

}
