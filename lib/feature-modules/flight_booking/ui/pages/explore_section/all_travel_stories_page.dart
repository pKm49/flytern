import 'package:flutter/material.dart';
import 'package:flytern/feature-modules/flight_booking/controllers/flight_booking_controller.dart';
import 'package:flytern/feature-modules/flight_booking/ui/components/explore_section/travel_stories_item_card.dart';
import 'package:flytern/shared-module/data/constants/app_specific/default_values.dart';
import 'package:flytern/shared-module/data/constants/ui_constants/style_params.dart';
import 'package:flytern/shared-module/data/constants/ui_constants/widget_styles.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class AllTravellStoriesPage extends StatefulWidget {
  const AllTravellStoriesPage({super.key});

  @override
  State<AllTravellStoriesPage> createState() => _AllTravellStoriesPageState();
}

class _AllTravellStoriesPageState extends State<AllTravellStoriesPage> {

  final flightBookingController = Get.find<FlightBookingController>();

  @override
  Widget build(BuildContext context) {

    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text("travel_stories".tr),
      ),
      body: Obx(
            ()=> Stack(
          children: [
            Visibility(
                visible:
                flightBookingController.isTravelStoriesLoading.value,
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
                visible:
                !flightBookingController.isTravelStoriesLoading.value,
                child: Container(
              width: screenwidth,
                height: screenheight * .9,
              child: ListView.builder(
                  itemCount: flightBookingController.travelStories.length,
                  itemBuilder: (context,i){
                return Container(
                  decoration: BoxDecoration(border:
                  i==(flightBookingController.travelStories.length-1)?null:
                  flyternDefaultBorderBottomOnly),
                  child: TravelStoriesItemCard(
                    createdOn: DefaultInvalidDate,
                    title: "",
                    status: "",
                    profilePicUrl: flightBookingController.travelStories[i].profileUrl,
                    name: flightBookingController.travelStories[i].name,
                    ratings:flightBookingController.travelStories[i].ratings,
                    description: flightBookingController.travelStories[i].shortDesc,
                    imageUrl: flightBookingController.travelStories[i].url,
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
