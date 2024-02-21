import 'dart:async';

import 'package:debounce_throttle/debounce_throttle.dart';
import 'package:flutter/material.dart';
import 'package:flytern/feature-modules/flight_booking/controllers/flight_booking.controller.dart';
import 'package:flytern/feature-modules/flight_booking/models/destination.flight_booking.model.dart';
import 'package:flytern/feature-modules/hotel_booking/controllers/hotel_booking.controller.dart';
import 'package:flytern/feature-modules/hotel_booking/models/destination.hotel_booking.model.dart';
import 'package:flytern/shared-module/constants/ui_specific/style_params.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/widget_styles.shared.constant.dart';
import 'package:flytern/shared-module/services/utility-services/widget_generator.shared.service.dart';
import 'package:flytern/shared-module/services/utility-services/widget_properties_generator.shared.service.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CustomHotelDestinationSearchDelegate extends StatefulWidget {


  final Function(HotelDestination hotelDestination) destinationSelected;

  CustomHotelDestinationSearchDelegate(
      {super.key,
      required this.destinationSelected});

  @override
  State<CustomHotelDestinationSearchDelegate> createState() => _CustomHotelDestinationSearchDelegateState();
}

class _CustomHotelDestinationSearchDelegateState extends State<CustomHotelDestinationSearchDelegate> {
  TextEditingController textEditingController = TextEditingController();
  final hotelBookingController = Get.find<HotelBookingController>();
  Completer<List<FlightDestination>> _completer = Completer();

  late final Debouncer _debouncer = Debouncer(Duration(seconds: 1),
      initialValue: '',
      onChanged: (value) {
        print("_debouncer called");
        print(value);
        hotelBookingController.getHotelDestinations(value);
      }
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    textEditingController.text = "";
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        title: TextFormField(
            autofocus: true,
            onChanged: (String s) {
              // widget.destinationSelected( );
              _debouncer.value = s;
            },
            controller: textEditingController,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              fillColor: flyternBackgroundWhite,
              hintText: 'hotel_destination_hint'.tr,
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              focusedErrorBorder: InputBorder.none,
            )),
        actions: [
          InkWell(
              onTap: () {
                textEditingController.text = "";
                setState(() {});
              },
              child: Icon(Ionicons.close)),
          addHorizontalSpace(flyternSpaceSmall)
        ],
      ),
      body: Obx(
        ()=> Container(
          child: Stack(
            children: [
              Visibility(
                visible: hotelBookingController.isHotelDestinationsLoading.value,
                  child: Center(
                      child: LoadingAnimationWidget.prograssiveDots(
                        color: flyternSecondaryColor,
                        size: 50,
                      )
                  ) ),
              Visibility(
                  visible: !hotelBookingController.isHotelDestinationsLoading.value
                      && hotelBookingController.hotelDestinations.value.isNotEmpty,
                  child: ListView.builder(
                      itemCount:
                      hotelBookingController.hotelDestinations.length,
                      itemBuilder: (context, index) {
                      return InkWell(
                        onTap: (){
                          widget.destinationSelected( hotelBookingController.hotelDestinations[index]);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border(bottom: BorderSide(width: .5,color: flyternGrey40))
                          ),
                          padding: flyternLargePaddingAll,
                          child: Row(children: [
                            Image.network(hotelBookingController.hotelDestinations[index].flag, width: 40),
                            addHorizontalSpace(flyternSpaceMedium),
                            Expanded(
                                child: Text(
                                    "${hotelBookingController.hotelDestinations[index].uniqueCombination}",
                                    maxLines: 2,
                                    style: getBodyMediumStyle(context))),
                          ],),
                        ),
                      );
                    }
                  ) )
            ],
          ),
        ),
      ),
    );
  }
}
