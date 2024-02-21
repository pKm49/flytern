import 'dart:async';

import 'package:debounce_throttle/debounce_throttle.dart';
import 'package:flutter/material.dart';
import 'package:flytern/feature-modules/flight_booking/controllers/flight_booking.controller.dart';
import 'package:flytern/feature-modules/flight_booking/models/destination.flight_booking.model.dart';
import 'package:flytern/shared-module/constants/ui_specific/style_params.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/widget_styles.shared.constant.dart';
import 'package:flytern/shared-module/services/utility-services/widget_generator.shared.service.dart';
import 'package:flytern/shared-module/services/utility-services/widget_properties_generator.shared.service.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CustomFlightDestinationSearchDelegate extends StatefulWidget {


  final Function(FlightDestination flightDestination) destinationSelected;

  CustomFlightDestinationSearchDelegate(
      {super.key,
      required this.destinationSelected});

  @override
  State<CustomFlightDestinationSearchDelegate> createState() => _CustomFlightDestinationSearchDelegateState();
}

class _CustomFlightDestinationSearchDelegateState extends State<CustomFlightDestinationSearchDelegate> {
  TextEditingController textEditingController = TextEditingController();
  final flightBookingController = Get.find<FlightBookingController>();
  Completer<List<FlightDestination>> _completer = Completer();

  late final Debouncer _debouncer = Debouncer(Duration(seconds: 1),
      initialValue: '',
      onChanged: (value) {
        print("_debouncer called");
        print(value);
        flightBookingController.getFlightDestinations(value);
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
              hintText: 'search_destination'.tr,
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
                visible: flightBookingController.isFlightDestinationsLoading.value,
                  child: Center(
                      child: LoadingAnimationWidget.prograssiveDots(
                        color: flyternSecondaryColor,
                        size: 50,
                      )
                  ) ),
              Visibility(
                  visible: !flightBookingController.isFlightDestinationsLoading.value
                      && flightBookingController.flightDestinations.value.isNotEmpty,
                  child: ListView.builder(
                      itemCount:
                      flightBookingController.flightDestinations.length,
                      itemBuilder: (context, index) {
                      return InkWell(
                        onTap: (){
                          widget.destinationSelected( flightBookingController.flightDestinations[index]);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border(bottom: BorderSide(width: .5,color: flyternGrey40))
                          ),
                          padding: flyternLargePaddingAll,
                          child: Row(children: [
                            Image.network(flightBookingController.flightDestinations[index].flag, width: 40),
                            addHorizontalSpace(flyternSpaceMedium),
                            Expanded(
                                child: Text(
                                    "${flightBookingController.flightDestinations[index].uniqueCombination}",
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
