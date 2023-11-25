import 'package:flutter/material.dart';
import 'package:flytern/feature-modules/flight_booking/ui/components/flight_search_result_card.dart';
import 'package:flytern/feature-modules/hotel_booking/ui/components/hote_search_result_card.dart';
import 'package:flytern/feature-modules/profile/controllers/profile_controller.dart';
import 'package:flytern/shared-module/constants/ui_specific/asset_urls.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/style_params.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/widget_styles.shared.constant.dart';
import 'package:flytern/shared-module/services/utility-services/widget_generator.shared.service.dart';
import 'package:flytern/shared-module/services/utility-services/widget_properties_generator.shared.service.dart';
import 'package:flytern/shared-module/ui/components/data_capsule_card.shared.component.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class ProfileHotelBookingsList extends StatefulWidget {
  const ProfileHotelBookingsList({super.key});

  @override
  State<ProfileHotelBookingsList> createState() =>
      _ProfileHotelBookingsListState();
}

class _ProfileHotelBookingsListState extends State<ProfileHotelBookingsList> {
  final profileController = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    double screenheight = MediaQuery.of(context).size.height;
    double screenwidth = MediaQuery.of(context).size.width;

    return ListView.builder(
        itemCount: profileController.myHotelBookingResponse.length,
        itemBuilder: (context, index) => Container(
              decoration: flyternShadowedContainerSmallDecoration,
              padding: flyternMediumPaddingAll,
              margin: flyternLargePaddingAll.copyWith(
                  bottom: index== profileController.myHotelBookingResponse.length-1?flyternSpaceLarge:0
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
                              "${profileController.myHotelBookingResponse[index].currency} ${profileController.myHotelBookingResponse[index].paidAmount}",
                          theme: 1,
                        ),
                        Visibility(
                            visible: profileController
                                    .myHotelBookingResponse[index]
                                    .refundStatus !=
                                "",
                            child: addHorizontalSpace(flyternSpaceSmall)),
                        Visibility(
                          visible: profileController
                                  .myHotelBookingResponse[index].refundStatus !=
                              "",
                          child: DataCapsuleCard(
                            label: profileController
                                .myHotelBookingResponse[index].refundStatus,
                            theme: profileController
                                    .myHotelBookingResponse[index].refundStatus
                                    .contains("NON")
                                ? 2
                                : 1,
                          ),
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
                                .myHotelBookingResponse[index].hotelimageurl,
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
                                .myHotelBookingResponse[index].hotelname,
                            maxLines: 2,
                            style: getBodyMediumStyle(context).copyWith(
                                fontWeight: flyternFontWeightBold),
                          ),

                          addVerticalSpace(flyternSpaceSmall),
                          Text(profileController
                              .myHotelBookingResponse[index].address,
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
                  Visibility(
                    visible: profileController.myHotelBookingResponse[index]
                        .myHotelBookingListRecords.isNotEmpty,
                    child: Row(
                      children: [
                        for (var i = 0;
                            i <
                                (profileController.myHotelBookingResponse[index]
                                            .myHotelBookingListRecords.length >
                                        3
                                    ? 3
                                    : profileController
                                        .myHotelBookingResponse[index]
                                        .myHotelBookingListRecords
                                        .length);
                            i++)
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: i == 0
                                  ? CrossAxisAlignment.start
                                  : i == 1
                                      ? CrossAxisAlignment.center
                                      : CrossAxisAlignment.end,
                              children: [
                                Text(
                                  profileController
                                      .myHotelBookingResponse[index]
                                      .myHotelBookingListRecords[i]
                                      .title,
                                  style: getLabelLargeStyle(context).copyWith(
                                      color: flyternGrey40,
                                      fontWeight: FontWeight.w400),
                                ),
                                addVerticalSpace(flyternSpaceExtraSmall),
                                Text(
                                  profileController
                                      .myHotelBookingResponse[index]
                                      .myHotelBookingListRecords[i]
                                      .information,
                                  style: getLabelLargeStyle(context).copyWith(
                                      color: flyternGrey80,
                                      fontWeight: flyternFontWeightBold),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ));

  }
}
