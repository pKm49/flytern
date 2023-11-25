import 'package:flutter/material.dart';
import 'package:flytern/feature-modules/flight_booking/ui/components/flight_search_result_card.dart';
import 'package:flytern/feature-modules/hotel_booking/ui/components/hote_search_result_card.dart';
import 'package:flytern/feature-modules/package_booking/ui/components/package_list_card.dart';
import 'package:flytern/feature-modules/profile/controllers/profile_controller.dart';
import 'package:flytern/shared-module/constants/ui_specific/asset_urls.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/style_params.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/widget_styles.shared.constant.dart';
import 'package:flytern/shared-module/services/utility-services/widget_generator.shared.service.dart';
import 'package:flytern/shared-module/services/utility-services/widget_properties_generator.shared.service.dart';
import 'package:flytern/shared-module/ui/components/data_capsule_card.shared.component.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ProfilePackageBookingsList extends StatefulWidget {
  const ProfilePackageBookingsList({super.key});

  @override
  State<ProfilePackageBookingsList> createState() => _ProfilePackageBookingsListState();
}

class _ProfilePackageBookingsListState extends State<ProfilePackageBookingsList> {

  final profileController = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    double screenheight = MediaQuery.of(context).size.height;
    double screenwidth = MediaQuery.of(context).size.width;

    return ListView.builder(
        itemCount: profileController.myPackageBookingResponse.length,
        itemBuilder: (context, index) => Container(
          decoration: flyternShadowedContainerSmallDecoration,
          padding: flyternMediumPaddingAll,
          margin: flyternLargePaddingAll.copyWith(
              bottom: index== profileController.myPackageBookingResponse.length-1?flyternSpaceLarge:0
          ),
          width: screenwidth - (flyternSpaceLarge * 2),
          child: Wrap(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: flyternSpaceSmall),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    DataCapsuleCard(
                      label:
                      "${profileController.myPackageBookingResponse[index].currency} ${profileController.myPackageBookingResponse[index].price}",
                      theme: 1,
                    ),

                  ],
                ),
              ),

              Row(
                children: [
                  Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            flyternBorderRadiusExtraSmall),
                      ),
                      clipBehavior: Clip.hardEdge,
                      width: screenwidth * .2,
                      height: screenwidth * .2,
                      child: Image.network(
                        profileController
                            .myPackageBookingResponse[index].url,
                        width: screenwidth * .2,
                        height: screenwidth * .2,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(ASSETS_HOTEL_1_SAMPLE,
                              width: screenwidth * .2,
                              height: screenwidth * .2);
                        },
                      )),
                  addHorizontalSpace(flyternSpaceMedium),
                  Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            profileController
                                .myPackageBookingResponse[index].name,
                            maxLines: 2,
                            style: getBodyMediumStyle(context).copyWith(
                                fontWeight: flyternFontWeightBold),
                          ),

                          addVerticalSpace(flyternSpaceSmall),
                          Text(profileController
                              .myPackageBookingResponse[index].shortDesc !=""?
                          profileController
                              .myPackageBookingResponse[index].shortDesc :
                          profileController
                              .myPackageBookingResponse[index].fromTo !=""?
                          profileController
                              .myPackageBookingResponse[index].fromTo:
                          profileController
                              .myPackageBookingResponse[index].destinations,
                              maxLines: 2,
                              style: getBodyMediumStyle(context)),

                        ],
                      ))
                ],
              ),
              addVerticalSpace(flyternSpaceSmall),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  for (var i = 0;
                  i < (screenwidth - (screenwidth / 1.3));
                  i++)
                    Container(
                      color:
                      i % 2 == 0 ? flyternGrey40 : Colors.transparent,
                      height: 1,
                      width: 3,
                    ),
                ],
              ),
              addVerticalSpace(flyternSpaceSmall),
              Row(
                children: [

                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment:   CrossAxisAlignment.start ,
                        children: [
                          Text(
                            "status".tr,
                            style: getLabelLargeStyle(context).copyWith(
                                color: flyternGrey40,
                                fontWeight: FontWeight.w400),
                          ),
                          addVerticalSpace(flyternSpaceExtraSmall),
                          Text(
                            profileController
                                .myPackageBookingResponse[index]
                                .enquiryStatus,
                            style: getLabelLargeStyle(context).copyWith(
                                color: flyternGrey80,
                                fontWeight: flyternFontWeightBold),
                          ),
                        ],
                      ),
                    ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment:   CrossAxisAlignment.end ,
                      children: [
                        Text(
                          "enquired_on".tr,
                          style: getLabelLargeStyle(context).copyWith(
                              color: flyternGrey40,
                              fontWeight: FontWeight.w400),
                        ),
                        addVerticalSpace(flyternSpaceExtraSmall),
                        Text(
                          getFormattedDOB(profileController
                              .myPackageBookingResponse[index]
                              .enquiredOn)  ,
                          style: getLabelLargeStyle(context).copyWith(
                              color: flyternGrey80,
                              fontWeight: flyternFontWeightBold),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ));
  }

  String getFormattedDOB(DateTime dateOfBirth) {
    final f = DateFormat.yMMMMd('en_US');
    return f.format(dateOfBirth);
  }
}
