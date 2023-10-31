import 'package:flutter/material.dart';
import 'package:flytern/feature-modules/package_booking/controllers/package_booking_controller.dart';
import 'package:flytern/feature-modules/package_booking/ui/components/package_list_card.dart';
import 'package:flytern/feature-modules/package_booking/ui/components/package_list_card_loader.dart';
import 'package:flytern/shared/data/constants/app_specific/app_route_names.dart';
import 'package:flytern/shared/data/constants/ui_constants/asset_urls.dart';
import 'package:flytern/shared/data/constants/ui_constants/style_params.dart';
import 'package:flytern/shared/data/constants/ui_constants/widget_styles.dart';
import 'package:flytern/shared/data/models/business_models/general_item.dart';
import 'package:flytern/shared/ui/components/dropdown_selector.dart';
import 'package:get/get.dart';

class PackageBookingLandingPage extends StatefulWidget {
  const PackageBookingLandingPage({super.key});

  @override
  State<PackageBookingLandingPage> createState() =>
      _PackageBookingLandingPageState();
}

class _PackageBookingLandingPageState extends State<PackageBookingLandingPage> {
  final packageBookingController = Get.put(PackageBookingController());

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
                  selected: null,
                  items: [
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
                  valueChanged: (newZone) {},
                )),
            Visibility(
              visible: !packageBookingController.isInitialDataLoading.value,
              child: Expanded(
                  child: Container(
                      color: flyternBackgroundWhite,
                      child: ListView.builder(
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
