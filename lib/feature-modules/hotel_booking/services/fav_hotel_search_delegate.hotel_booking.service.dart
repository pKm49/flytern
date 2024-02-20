import 'dart:async';

import 'package:debounce_throttle/debounce_throttle.dart';
import 'package:flutter/material.dart';
import 'package:flytern/feature-modules/hotel_booking/controllers/hotel_booking.controller.dart';
import 'package:flytern/feature-modules/hotel_booking/models/destination.hotel_booking.model.dart';
import 'package:flytern/feature-modules/hotel_booking/models/search_response.hotel_booking.model.dart';
import 'package:flytern/feature-modules/hotel_booking/ui/components/search_result_card.hotel_booking.component.dart';
import 'package:flytern/shared-module/constants/ui_specific/style_params.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/widget_styles.shared.constant.dart';
import 'package:flytern/shared-module/services/utility-services/widget_generator.shared.service.dart';
import 'package:flytern/shared-module/services/utility-services/widget_properties_generator.shared.service.dart';
import 'package:get/get.dart'; 
import 'package:loading_animation_widget/loading_animation_widget.dart';


class FavHotelSearchDelegate extends SearchDelegate {
  final hotelBookingController = Get.find<HotelBookingController>();

  Completer<List<HotelSearchResponse>> _completer = Completer();

  late final Debouncer _debouncer = Debouncer(Duration(seconds: 1),
      initialValue: '',
      onChanged: (value) {
        _completer.complete(hotelBookingController.getFavHotels(value) ); // call the API endpoint
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

    return FutureBuilder<List<HotelSearchResponse>>(
      future: hotelBookingController.getFavHotels(query),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return ListView.builder(
            itemBuilder: (context, index) {
              return Container(
                  padding: flyternLargePaddingHorizontal,
                  decoration: BoxDecoration(
                      border: flyternDefaultBorderBottomOnly),
                  child: HotelSearchResultCard(
                    onPressed: () {
                      close(context, snapshot.data![index]);
                    },
                    hotelSearchResponse: snapshot.data![index],
                  ));
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

    return FutureBuilder<List<HotelSearchResponse>>(
      future:_completer.future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
          return ListView.builder(
            itemBuilder: (context, index) {
              return Container(
                  padding: flyternLargePaddingHorizontal,
                  decoration: BoxDecoration(
                      border: flyternDefaultBorderBottomOnly),
                  child: HotelSearchResultCard(
                    onPressed: () {
                      close(context, snapshot.data![index]);
                    },
                    hotelSearchResponse: snapshot.data![index],
                  ));
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



}
