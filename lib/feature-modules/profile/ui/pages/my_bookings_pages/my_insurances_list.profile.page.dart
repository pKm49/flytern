import 'package:flutter/material.dart';
import 'package:flytern/feature-modules/insurance/controllers/insurance.controller.dart';
import 'package:flytern/feature-modules/profile/controllers/profile.controller.dart';
import 'package:flytern/feature-modules/profile/models/my_insurance.profile.model.dart';
import 'package:flytern/shared-module/constants/ui_specific/style_params.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/widget_styles.shared.constant.dart';
import 'package:flytern/shared-module/services/utility-services/widget_generator.shared.service.dart';
import 'package:flytern/shared-module/services/utility-services/widget_properties_generator.shared.service.dart';
import 'package:flytern/shared-module/ui/components/data_capsule_card.shared.component.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ProfileInsurancePurchaseList extends StatefulWidget {
  const ProfileInsurancePurchaseList({super.key});

  @override
  State<ProfileInsurancePurchaseList> createState() =>
      _ProfileInsurancePurchaseListState();
}

class _ProfileInsurancePurchaseListState
    extends State<ProfileInsurancePurchaseList> {
  final profileController = Get.find<ProfileController>();
  final insuranceBookingController = Get.find<InsuranceBookingController>();
  String currentBookingRef = "";

  @override
  Widget build(BuildContext context) {
    double screenheight = MediaQuery.of(context).size.height;
    double screenwidth = MediaQuery.of(context).size.width;

    return profileController.myInsuranceBookingResponse.isNotEmpty
        ? ListView.builder(
            itemCount: profileController.myInsuranceBookingResponse.length,
            itemBuilder: (context, index) => InkWell(
                  onTap: () {
                    insuranceBookingController.getConfirmationData(
                        profileController
                            .myInsuranceBookingResponse[index].bookingRef,
                        true);
                  },
                  child: Container(
                    decoration: flyternShadowedContainerSmallDecoration,
                    padding: flyternMediumPaddingAll,
                    margin: flyternLargePaddingAll.copyWith(
                        bottom: index ==
                                profileController
                                        .myInsuranceBookingResponse.length -
                                    1
                            ? flyternSpaceLarge
                            : 0),
                    width: screenwidth - (flyternSpaceLarge * 2),
                    child: Wrap(
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.only(bottom: flyternSpaceMedium),
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
                          visible: profileController
                              .myInsuranceBookingResponse[index]
                              .myInsuranceBookingListRecords
                              .isNotEmpty,
                          child: Row(
                            children: [
                              for (var i = 0;
                                  i <
                                      (profileController
                                                  .myInsuranceBookingResponse[
                                                      index]
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                                        style: getLabelLargeStyle(context)
                                            .copyWith(
                                                color: flyternGrey40,
                                                fontWeight: FontWeight.w400),
                                      ),
                                      addVerticalSpace(flyternSpaceExtraSmall),
                                      Text(
                                        profileController
                                            .myInsuranceBookingResponse[index]
                                            .myInsuranceBookingListRecords[i]
                                            .information,
                                        style: getLabelLargeStyle(context)
                                            .copyWith(
                                                color: flyternGrey80,
                                                fontWeight:
                                                    flyternFontWeightBold),
                                      ),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        ),
                        addVerticalSpace(flyternSpaceMedium),
                        Visibility(
                          visible: profileController
                                  .myInsuranceBookingResponse[index]
                                  .myInsuranceBookingListRecords
                                  .length >
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: i == 0
                                        ? CrossAxisAlignment.start
                                        : CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        profileController
                                            .myInsuranceBookingResponse[index]
                                            .myInsuranceBookingListRecords[
                                                i + 3]
                                            .title,
                                        textAlign: i == 0
                                            ? TextAlign.start
                                            : TextAlign.end,
                                        style: getLabelLargeStyle(context)
                                            .copyWith(
                                                color: flyternGrey40,
                                                fontWeight: FontWeight.w400),
                                      ),
                                      addVerticalSpace(flyternSpaceExtraSmall),
                                      Text(
                                        profileController
                                            .myInsuranceBookingResponse[index]
                                            .myInsuranceBookingListRecords[
                                                i + 3]
                                            .information,
                                        textAlign: i == 0
                                            ? TextAlign.start
                                            : TextAlign.end,
                                        style: getLabelLargeStyle(context)
                                            .copyWith(
                                                color: flyternGrey80,
                                                fontWeight:
                                                    flyternFontWeightBold),
                                      ),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(top: flyternSpaceSmall),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.all(Radius.circular(
                                    flyternBorderRadiusExtraSmall)),
                                child: ElevatedButton(
                                    style: ButtonStyle(
                                      padding: MaterialStateProperty.all<
                                              EdgeInsetsGeometry>(
                                          EdgeInsets.symmetric(
                                              horizontal: 0,
                                              vertical:
                                                  flyternSpaceExtraSmall)),
                                    ),
                                    onPressed: () {
                                      if (!insuranceBookingController
                                          .isInsuranceConfirmationDataLoading
                                          .value) {
                                        insuranceBookingController
                                            .getConfirmationData(
                                                profileController
                                                    .myInsuranceBookingResponse
                                                    .value[index]
                                                    .bookingRef,
                                                true)
                                            .then(
                                                (value) => {restCurrentRef()});
                                        currentBookingRef = profileController
                                            .myInsuranceBookingResponse
                                            .value[index]
                                            .bookingRef;

                                        setState(() {});
                                      }
                                    },
                                    child: (insuranceBookingController
                                                .isInsuranceConfirmationDataLoading
                                                .value &&
                                            currentBookingRef ==
                                                profileController
                                                    .myInsuranceBookingResponse
                                                    .value[index]
                                                    .bookingRef)
                                        ? LoadingAnimationWidget
                                            .prograssiveDots(
                                            color: flyternBackgroundWhite,
                                            size: 20,
                                          )
                                        : Icon(
                                            Localizations.localeOf(context)
                                                        .languageCode
                                                        .toString() ==
                                                    'ar'
                                                ? Ionicons.chevron_back
                                                : Ionicons.chevron_forward,
                                          )),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ))
        : Container(
            width: screenwidth,
            height: screenheight,
            child: Center(
              child: Center(
                child: Text("no_item".tr, style: getBodyMediumStyle(context)),
              ),
            ),
          );
  }

  restCurrentRef() {
    currentBookingRef = "";
    setState(() {});
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
