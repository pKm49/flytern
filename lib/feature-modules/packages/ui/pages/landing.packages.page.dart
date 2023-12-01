import 'package:flutter/material.dart';
import 'package:flytern/feature-modules/packages/controllers/package.controller.dart';
import 'package:flytern/feature-modules/packages/ui/components/list_card.packages.component.dart';
import 'package:flytern/feature-modules/packages/ui/components/list_card_loader.packages.component.dart';
import 'package:flytern/shared-module/constants/app_specific/route_names.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/style_params.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/widget_styles.shared.constant.dart';
import 'package:flytern/shared-module/models/general_item.dart';
import 'package:flytern/shared-module/ui/components/dropdown_selector.shared.component.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class PackageBookingLandingPage extends StatefulWidget {
  const PackageBookingLandingPage({super.key});

  @override
  State<PackageBookingLandingPage> createState() =>
      _PackageBookingLandingPageState();
}

class _PackageBookingLandingPageState extends State<PackageBookingLandingPage> {
  final packageBookingController = Get.find<PackageBookingController>();
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
          packageBookingController.getPackages( packageBookingController.pageId.value+1,
              packageBookingController.countryisocode.value);
        }
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Obx(
      () => Container(
        height: screenheight,
        width: screenwidth,
        color: flyternGrey10,
        child: Column(
          children: [
            Container(
                width: screenwidth - flyternSpaceMedium * 2,
                padding: flyternMediumPaddingHorizontal,
                margin: flyternMediumPaddingAll,
                decoration: BoxDecoration(
                  color: flyternBackgroundWhite,
                  boxShadow: flyternItemShadow,
                  borderRadius:
                      BorderRadius.circular(flyternBorderRadiusExtraSmall),
                ),
                child: DropDownSelector(
                  titleText: "select_destination".tr,
                  selected: packageBookingController.countryisocode.value,
                  items: [

                    GeneralItem(
                        id: "ALL",
                        name: "all".tr,
                        imageUrl:  ""),
                    for (var i = 0;
                        i < packageBookingController.destinations.value.length;
                        i++)
                      GeneralItem(
                          id: packageBookingController
                              .destinations.value[i].countryISOCode,
                          name: packageBookingController
                              .destinations.value[i].countryName,
                          imageUrl: packageBookingController
                              .destinations.value[i].flag),
                  ],
                  hintText: "select_destination".tr,
                  valueChanged: (newZone) {
                    packageBookingController.getPackages(1, newZone);
                  },
                )),
            Visibility(
              visible: !packageBookingController.isInitialDataLoading.value,
              child: Expanded(
                  child: Container(
                      color: flyternBackgroundWhite,
                      child: ListView.builder(
                        controller: _controller,
                        itemCount: packageBookingController.packages.length,
                        itemBuilder: (BuildContext context, int index) =>
                            Container(
                                child: Wrap(
                          children: [
                            PackageListCard(
                                imageUrl:
                                    packageBookingController.packages[index].url,
                                title:
                                    packageBookingController.packages[index].name,
                                flightName: packageBookingController
                                    .packages[index].fromTo,
                                hotelName: packageBookingController
                                    .packages[index].hotelName,
                                sponsoredBy: packageBookingController
                                    .packages[index].airline,
                                price: packageBookingController
                                    .packages[index].price,
                                currency: packageBookingController
                                    .packages[index].currency,
                                ratings: packageBookingController
                                        .packages[index].ratings,
                                packageSelected: () {
                                  packageBookingController.getPackageDetails(packageBookingController.packages[index].refID);
                                  Get.toNamed(Approute_packagesDetails);
                                }),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: flyternSpaceMedium),
                              child: Divider(),
                            ),
                          ],
                        )),
                      ))),
            ),
            Visibility(
                visible: packageBookingController.isInitialDataPageLoading.value,
                child: Container(
                  width: screenwidth,
                  color: flyternBackgroundWhite,
                  child: Center(
                      child: LoadingAnimationWidget.prograssiveDots(
                        color: flyternSecondaryColor,
                        size: 50,
                      )),
                )),
            Visibility(
              visible:  packageBookingController.isInitialDataLoading.value,
              child: Expanded(
                  child: Container(
                      color: flyternBackgroundWhite,
                      child: ListView.builder(
                        itemCount: 4,
                        itemBuilder: (BuildContext context, int index) =>
                            Container(
                                child: Wrap(
                                  children: [
                                    PackageListCardLoader( ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: flyternSpaceMedium),
                                      child: Divider(),
                                    ),
                                  ],
                                )),
                      ))),
            ),
          ],
        ),
      ),
    );
  }
}
