import 'package:flutter/material.dart';
import 'package:flytern/feature-modules/profile/controllers/profile.controller.dart';
import 'package:flytern/shared-module/constants/ui_specific/asset_urls.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/style_params.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/widget_styles.shared.constant.dart';
import 'package:flytern/shared-module/services/utility-services/widget_generator.shared.service.dart';
import 'package:flytern/shared-module/services/utility-services/widget_properties_generator.shared.service.dart';
import 'package:flytern/shared-module/ui/components/data_capsule_card.shared.component.dart';
import 'package:get/get.dart';

class ProfileFlightBookingsList extends StatefulWidget {
  const ProfileFlightBookingsList({super.key});

  @override
  State<ProfileFlightBookingsList> createState() =>
      _ProfileFlightBookingsListState();
}

class _ProfileFlightBookingsListState extends State<ProfileFlightBookingsList> {
  final profileController = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    double screenheight = MediaQuery.of(context).size.height;
    double screenwidth = MediaQuery.of(context).size.width;

    return ListView.builder(
        itemCount: profileController.myFlightBookingResponse.length,
        itemBuilder: (context, index) => Container(
              decoration: flyternShadowedContainerSmallDecoration,
              padding: flyternMediumPaddingAll,
              margin: flyternLargePaddingAll.copyWith(bottom: index== profileController.myFlightBookingResponse.length-1?flyternSpaceLarge:0),
              width: screenwidth - (flyternSpaceLarge * 2),
              child: Wrap(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: flyternSpaceSmall),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.all(
                              Radius.circular(flyternBorderRadiusExtraSmall)),
                          child: Image.network(
                              profileController
                                  .myFlightBookingResponse[index].airlineImgUrl,
                              height: 30,
                              errorBuilder: (context, error, stackTrace) {
                            return Container(
                              height: 20,
                              width: screenwidth * .2,
                            );
                          }),
                        ),
                        Expanded(child: Container()),
                        DataCapsuleCard(
                          label:
                              "${profileController.myFlightBookingResponse[index].currency} ${profileController.myFlightBookingResponse[index].paidAmount}",
                          theme: 1,
                        ),
                        Visibility(
                            visible: profileController
                                    .myFlightBookingResponse[index]
                                    .refundStatus !=
                                "",
                            child: addHorizontalSpace(flyternSpaceSmall)),
                        Visibility(
                          visible: profileController
                                  .myFlightBookingResponse[index]
                                  .refundStatus !=
                              "",
                          child: DataCapsuleCard(
                            label: profileController
                                .myFlightBookingResponse[index].refundStatus,
                            theme: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                  for (var i = 0;
                      i <
                          profileController.myFlightBookingResponse[index]
                              .myFlightBookingListflights.length;
                      i++)
                    Container(
                      margin: EdgeInsets.only(bottom: flyternSpaceSmall,top: flyternSpaceSmall),
                      padding: EdgeInsets.only(bottom: flyternSpaceMedium),
                      decoration: BoxDecoration(
                        border:i!= profileController.myFlightBookingResponse[index]
                            .myFlightBookingListflights.length-1?flyternDefaultBorderBottomOnly:null
                      ),
                      width: screenwidth -
                          ((flyternSpaceLarge * 2) + (flyternSpaceMedium * 2)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    getTopLabel(profileController
                                        .myFlightBookingResponse[index]
                                        .myFlightBookingListflights[i]
                                        .deptAirportDtl),
                                    style: getLabelLargeStyle(context).copyWith(
                                        color: flyternGrey40,
                                        fontWeight: FontWeight.  w400),
                                  ),
                                  addVerticalSpace(flyternSpaceExtraSmall),
                                  Text(profileController
                                      .myFlightBookingResponse[index]
                                      .myFlightBookingListflights[i]
                                      .deptAirport,
                                      style: getHeadlineLargeStyle(context)
                                          .copyWith(fontSize: flyternFontSize24 * 1.5)),
                                  addVerticalSpace(flyternSpaceExtraSmall),
                                  Text(profileController
                                      .myFlightBookingResponse[index]
                                      .myFlightBookingListflights[i]
                                      .depDate,maxLines: 2,textAlign: TextAlign.start),
                                ],
                              )),
                          Padding(
                            padding: flyternSmallPaddingHorizontal,
                            child: Image.asset(
                              ASSETS_FLIGHT_CHART_ICON,
                              width: screenwidth * .3,
                            ),
                          ),
                          Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    getTopLabel(profileController
                                        .myFlightBookingResponse[index]
                                        .myFlightBookingListflights[i]
                                        .deptAirportDtl),
                                    style: getLabelLargeStyle(context).copyWith(
                                        color: flyternGrey40,
                                        fontWeight: FontWeight.  w400),
                                  ),
                                  addVerticalSpace(flyternSpaceExtraSmall),
                                  Text(profileController
                                      .myFlightBookingResponse[index]
                                      .myFlightBookingListflights[i]
                                      .deptAirport,
                                      style: getHeadlineLargeStyle(context)
                                          .copyWith(fontSize: flyternFontSize24 * 1.5)),
                                  addVerticalSpace(flyternSpaceExtraSmall),
                                  Text(profileController
                                      .myFlightBookingResponse[index]
                                      .myFlightBookingListflights[i]
                                      .depDate,maxLines: 2,textAlign: TextAlign.end),
                                ],
                              ))
                        ],
                      ),
                    ),
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
                  addVerticalSpace(flyternSpaceMedium),
                  Visibility(
                    visible: profileController.myFlightBookingResponse[index]
                            .myFlightBookingListRecords.length <
                        4,
                    child: Row(
                      children: [
                        for (var i = 0;
                            i <
                                profileController.myFlightBookingResponse[index]
                                    .myFlightBookingListRecords.length;
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
                                      .myFlightBookingResponse[index]
                                      .myFlightBookingListRecords[i]
                                      .title,
                                  style: getLabelLargeStyle(context).copyWith(
                                      color: flyternGrey40,
                                      fontWeight: FontWeight.w400),
                                ),
                                addVerticalSpace(flyternSpaceExtraSmall),
                                Text(
                                  profileController
                                      .myFlightBookingResponse[index]
                                      .myFlightBookingListRecords[i]
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
    // ListView.builder(
    //   children: [
    //     // addVerticalSpace(flyternSpaceLarge),
    //     // FlightSearchResultCard(
    //     // flightSearchResponses:,
    //     //   onPressed: (){
    //     //     Get.toNamed(Approute_flightsConfirmation,arguments: [
    //     //         {"mode": "edit"}
    //     //         ] );
    //     //   },
    //     // ),
    //     // addVerticalSpace(flyternSpaceLarge),
    //     // FlightSearchResultCard(
    //     //   onPressed: (){
    //     //     Get.toNamed(Approute_flightsConfirmation,arguments: [
    //     //       {"mode": "edit"}
    //     //     ] );
    //     //   },
    //     // ),
    //   ],
    // );
  }

  getTopLabel(String toCountry) {
    if (toCountry.split(",").toList().length > 1) {
      return toCountry.split(",").toList()[1];
    }
    if (toCountry.split(",").toList().length == 1) {
      return toCountry.split(",").toList()[0];
    }
    return toCountry;
  }
}