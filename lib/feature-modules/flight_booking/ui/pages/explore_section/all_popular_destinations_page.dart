import 'package:flutter/material.dart';
import 'package:flytern/feature-modules/flight_booking/controllers/flight_booking_controller.dart';
import 'package:flytern/feature-modules/flight_booking/ui/components/explore_section/popular_package_list_card.dart';
import 'package:flytern/feature-modules/flight_booking/ui/components/explore_section/recommended_item_card.dart';
import 'package:flytern/feature-modules/flight_booking/ui/components/explore_section/travel_stories_item_card.dart';
import 'package:flytern/shared/data/constants/app_specific/default_values.dart';
import 'package:flytern/shared/data/constants/ui_constants/style_params.dart';
import 'package:flytern/shared/data/constants/ui_constants/widget_styles.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class AllPopularDestinationsPage extends StatefulWidget {
  const AllPopularDestinationsPage({super.key});

  @override
  State<AllPopularDestinationsPage> createState() =>
      _AllPopularDestinationsPageState();
}

class _AllPopularDestinationsPageState extends State<AllPopularDestinationsPage> {
  final flightBookingController = Get.find<FlightBookingController>();

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text("popular_destinations".tr),
      ),
      body: Obx(
          ()=> Stack(
          children: [
            Visibility(
                visible: flightBookingController.isPopularDestinationsLoading.value,
                child: Container(
                  width: screenwidth,
                  height: screenheight * .9,
                  color: flyternGrey10,
                  child: Center(
                      child: LoadingAnimationWidget.prograssiveDots(
                    color: flyternSecondaryColor,
                    size: 50,
                  )),
                )),
            Visibility(
                visible: !flightBookingController.isPopularDestinationsLoading.value,
                child: Container(
                  width: screenwidth,
                  height: screenheight * .9,
                  child: ListView.builder(
                      itemCount:
                          flightBookingController.popularDestinations.length,
                      itemBuilder: (context, i) {
                        return Container(
                          decoration: BoxDecoration(border:
                          i==(flightBookingController.popularDestinations.length-1)?null:
                          flyternDefaultBorderBottomOnly),
                          child: PopularPackageListCard(
                            imageUrl: flightBookingController.popularDestinations[i].url,
                            title: flightBookingController.popularDestinations[i].name,
                            destination: flightBookingController.popularDestinations[i].destinations,
                            rating: flightBookingController.popularDestinations[i].ratings,
                            price: flightBookingController.popularDestinations[i].price,
                          ),
                        );
                      }),
                ))
          ],
        ),
      ),
    );
  }
}