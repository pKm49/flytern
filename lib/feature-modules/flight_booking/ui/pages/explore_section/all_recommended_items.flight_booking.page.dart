import 'package:flutter/material.dart';
import 'package:flytern/feature-modules/flight_booking/controllers/flight_booking.controller.dart';
import 'package:flytern/feature-modules/flight_booking/ui/components/explore_section/recommended_item_card.flight_booking.component.dart';
import 'package:flytern/feature-modules/packages/controllers/package.controller.dart';
import 'package:flytern/shared-module/constants/app_specific/route_names.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/style_params.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/widget_styles.shared.constant.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class AllRecommendedItemsPage extends StatefulWidget {
  const AllRecommendedItemsPage({super.key});

  @override
  State<AllRecommendedItemsPage> createState() =>
      _AllRecommendedItemsPageState();
}

class _AllRecommendedItemsPageState extends State<AllRecommendedItemsPage> {

  final flightBookingController = Get.find<FlightBookingController>();
  final packageBookingController = Get.find<PackageBookingController>();
  final ScrollController _controller = ScrollController();


  @override
  void initState() {
    super.initState();
    flightBookingController.getRecommendedForyou();

    // Setup the listener.
    _controller.addListener(() {
      if (_controller.position.atEdge) {
        bool isTop = _controller.position.pixels == 0;
        if (isTop) {
         } else {
           flightBookingController.getRecommendedForyou();
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
        title: Text("recommended_for_you".tr),
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
                        flightBookingController.recommendedPackages.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: (){
                          packageBookingController.getPackageDetails(flightBookingController.recommendedPackages[index].refId);
                          Get.toNamed(Approute_packagesDetails);
                        },
                        child: Container(
                          margin: flyternLargePaddingAll.copyWith(bottom: index == (flightBookingController.recommendedPackages.length-1)?flyternSpaceLarge:0),
                          child: FlightRecommendedItemCard(
                              imageUrl: flightBookingController
                                  .recommendedPackages[index].url,
                              title: flightBookingController
                                  .recommendedPackages[index].name,
                              rating: flightBookingController
                                  .recommendedPackages[index].ratings),
                        ),
                      );
                    }),
              ),
            ),
            Visibility(
                visible: flightBookingController.isRecommendedPageLoading.value,
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
