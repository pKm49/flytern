import 'package:flutter/material.dart';
import 'package:flytern/feature-modules/flight_booking/ui/components/flight_search_result_card.dart';
import 'package:flytern/feature-modules/hotel_booking/ui/components/hote_search_result_card.dart';
import 'package:flytern/feature-modules/profile/controllers/profile_controller.dart';
import 'package:flytern/feature-modules/profile/data/models/business-models/my_insurance_booking.dart';
import 'package:flytern/shared-module/data/constants/ui_constants/style_params.dart';
import 'package:flytern/shared-module/data/constants/ui_constants/widget_styles.dart';
import 'package:flytern/shared-module/services/utility-services/widget_generator.dart';
import 'package:flytern/shared-module/services/utility-services/widget_properties_generator.dart';
import 'package:flytern/shared-module/ui/components/data_capsule_card.dart';
import 'package:get/get.dart';

class ProfileInsurancePurchaseList extends StatefulWidget {
  const ProfileInsurancePurchaseList({super.key});

  @override
  State<ProfileInsurancePurchaseList> createState() =>
      _ProfileInsurancePurchaseListState();
}

class _ProfileInsurancePurchaseListState
    extends State<ProfileInsurancePurchaseList> {
  final profileController = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    double screenheight = MediaQuery.of(context).size.height;
    double screenwidth = MediaQuery.of(context).size.width;

    return ListView.builder(
        itemCount: profileController.myInsuranceBookingResponse.length,
        itemBuilder: (context, index) => Container(
              decoration: flyternShadowedContainerSmallDecoration,
              padding: flyternMediumPaddingAll,
              margin: flyternLargePaddingAll.copyWith(
                  bottom: index ==
                          profileController.myInsuranceBookingResponse.length -
                              1
                      ? flyternSpaceLarge
                      : 0),
              width: screenwidth - (flyternSpaceLarge * 2),
              child: Wrap(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: flyternSpaceMedium),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        DataCapsuleCard(
                          label: getPrice(profileController
                              .myInsuranceBookingResponse[index]),
                          theme: 1,
                        ),
                        addHorizontalSpace(flyternSpaceSmall),
                        DataCapsuleCard(
                          label: getStatus(profileController
                              .myInsuranceBookingResponse[index]),
                          theme: 2,
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: profileController.myInsuranceBookingResponse[index]
                        .myInsuranceBookingListRecords.isNotEmpty,
                    child: Row(
                      children: [
                        for (var i = 0;
                            i <
                                (profileController
                                            .myInsuranceBookingResponse[index]
                                            .myInsuranceBookingListRecords
                                            .length >
                                        3
                                    ? 3
                                    : profileController
                                        .myInsuranceBookingResponse[index]
                                        .myInsuranceBookingListRecords
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
                                      .myInsuranceBookingResponse[index]
                                      .myInsuranceBookingListRecords[i]
                                      .title,
                                  style: getLabelLargeStyle(context).copyWith(
                                      color: flyternGrey40,
                                      fontWeight: FontWeight.w400),
                                ),
                                addVerticalSpace(flyternSpaceExtraSmall),
                                Text(
                                  profileController
                                      .myInsuranceBookingResponse[index]
                                      .myInsuranceBookingListRecords[i]
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
                  addVerticalSpace(flyternSpaceMedium),
                  Visibility(
                    visible: profileController.myInsuranceBookingResponse[index]
                            .myInsuranceBookingListRecords.length >
                        3,
                    child: Row(
                      children: [
                        for (var i = 0;
                            i <
                                (getSecondRowLength(profileController
                                    .myInsuranceBookingResponse[index]));
                            i++)
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: i == 0
                                  ? CrossAxisAlignment.start : CrossAxisAlignment.end,
                              children: [
                                Text(
                                  profileController
                                      .myInsuranceBookingResponse[index]
                                      .myInsuranceBookingListRecords[i+3]
                                      .title,
                                  textAlign:i == 0? TextAlign.start: TextAlign.end,
                                  style: getLabelLargeStyle(context).copyWith(
                                      color: flyternGrey40,
                                      fontWeight: FontWeight.w400),
                                ),
                                addVerticalSpace(flyternSpaceExtraSmall),
                                Text(
                                  profileController
                                      .myInsuranceBookingResponse[index]
                                      .myInsuranceBookingListRecords[i+3]
                                      .information,
                                  textAlign:i == 0? TextAlign.start: TextAlign.end,
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

  getPrice(MyInsuranceBooking myInsuranceBookingResponse) {
    String priceString = "";
    myInsuranceBookingResponse.myInsuranceBookingListRecords.forEach((element) {
      if (element.title == "Currency") {
        priceString += "${element.information} ";
      }
      if (element.title == "Paid Amount") {
        priceString += "${element.information} ";
      }
    });

    return priceString;
  }

  getStatus(MyInsuranceBooking myInsuranceBookingResponse) {
    String priceString = "";
    myInsuranceBookingResponse.myInsuranceBookingListRecords.forEach((element) {
      if (element.title == "BookingStatus") {
        priceString = element.information;
      }
    });
    return priceString;
  }

  getSecondRowLength(MyInsuranceBooking myInsuranceBookingResponse) {
    if (myInsuranceBookingResponse.myInsuranceBookingListRecords.length <= 3) {
      return 0;
    }

    if (myInsuranceBookingResponse.myInsuranceBookingListRecords.length > 3 &&
        myInsuranceBookingResponse.myInsuranceBookingListRecords.length <= 5) {
      return (myInsuranceBookingResponse.myInsuranceBookingListRecords.length -
          3);
    }

    if (myInsuranceBookingResponse.myInsuranceBookingListRecords.length > 6) {
      return 2;
    }
  }
}
