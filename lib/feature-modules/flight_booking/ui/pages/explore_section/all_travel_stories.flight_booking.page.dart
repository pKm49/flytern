import 'package:flutter/material.dart';
import 'package:flytern/feature-modules/flight_booking/controllers/flight_booking.controller.dart';
import 'package:flytern/feature-modules/flight_booking/ui/components/explore_section/travel_stories_item_card.flight_booking.component.dart';
import 'package:flytern/shared-module/constants/app_specific/default_values.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/style_params.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/widget_styles.shared.constant.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class AllTravellStoriesPage extends StatefulWidget {
  const AllTravellStoriesPage({super.key});

  @override
  State<AllTravellStoriesPage> createState() => _AllTravellStoriesPageState();
}

class _AllTravellStoriesPageState extends State<AllTravellStoriesPage> {

  final flightBookingController = Get.find<FlightBookingController>();


  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();

    // Setup the listener.
    _controller.addListener(() {
      if (_controller.position.atEdge) {
        bool isTop = _controller.position.pixels == 0;
        if (isTop) {
          print('At the top');
        } else {
          print('At the bottom');
          flightBookingController.getTravelStories();
        }
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();

  }

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

            Expanded(
                child: Container(
              width: screenwidth,
              child: ListView.builder(
                  controller: _controller,

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
            )),
            Visibility(
                visible: flightBookingController.isTravelStoriesPageLoading.value,
                child: Container(
                  width: screenwidth,
                  color: flyternGrey10,
                  child: Center(
                      child: LoadingAnimationWidget.prograssiveDots(
                        color: flyternSecondaryColor,
                        size: 50,
                      )),
                )),
          ],
        ),
      ),
    );
  }
}
