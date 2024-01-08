import 'package:flutter/material.dart';
import 'package:flytern/feature-modules/flight_booking/controllers/flight_booking.controller.dart';
import 'package:flytern/feature-modules/flight_booking/ui/components/explore_section/popular_package_list_card.flight_booking.component.dart';
import 'package:flytern/feature-modules/packages/controllers/package.controller.dart';
import 'package:flytern/shared-module/constants/app_specific/route_names.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/style_params.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/widget_styles.shared.constant.dart';
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
  final packageBookingController = Get.find<PackageBookingController>();


  final ScrollController _controller = ScrollController();


  @override
  void initState() {
    super.initState();

    if(flightBookingController.popularDestinations.length<6){
      flightBookingController.getPopularPackages();
    }
    // Setup the listener.
    _controller.addListener(() {
      if (_controller.position.atEdge) {
        bool isTop = _controller.position.pixels == 0;
        if (isTop) {
         } else {
           flightBookingController.getPopularPackages();
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
        title: Text("popular_destinations".tr),
      ),
      body: Obx(
          ()=> Column(
          children: [
            Expanded(
                 child: Container(
                  width: screenwidth,
                  child: ListView.builder(
                    controller: _controller,
                      itemCount:
                          flightBookingController.popularDestinations.length,
                      itemBuilder: (context, i) {
                        return InkWell(
                          onTap: (){
                            packageBookingController.getPackageDetails(flightBookingController.popularDestinations[i].refId);
                            Get.toNamed(Approute_packagesDetails);
                          },
                          child: Container(
                            decoration: BoxDecoration(border:
                            i==(flightBookingController.popularDestinations.length-1)?null:
                            flyternDefaultBorderBottomOnly),
                            child: PopularPackageListCard(
                              currency: flightBookingController.popularDestinations[i].currency,
                              imageUrl: flightBookingController.popularDestinations[i].url,
                              title: flightBookingController.popularDestinations[i].name,
                              destination: flightBookingController.popularDestinations[i].destinations,
                              rating: flightBookingController.popularDestinations[i].ratings,
                              price: flightBookingController.popularDestinations[i].price,
                            ),
                          ),
                        );
                      }),
                )),
            Visibility(
                visible: flightBookingController.isPopularDestinationsPageLoading.value,
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
