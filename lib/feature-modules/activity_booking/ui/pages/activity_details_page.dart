import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flytern/feature-modules/activity_booking/controllers/activity_booking_controller.dart';
import 'package:flytern/feature-modules/activity_booking/data/models/activity_option.dart';
import 'package:flytern/feature-modules/activity_booking/data/models/activity_transfer_type.dart';
import 'package:flytern/feature-modules/activity_booking/ui/components/activity_option_info.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/business_models/cabin_class.dart';
import 'package:flytern/feature-modules/flight_booking/ui/components/explore_section/travel_stories_item_card.dart';
import 'package:flytern/shared/data/constants/app_specific/default_values.dart';
import 'package:flytern/shared/data/models/business_models/general_item.dart';
import 'package:flytern/shared/ui/components/booking_options_selector.dart';
import 'package:flytern/shared/ui/components/contact_details_getter.dart';
import 'package:flytern/shared/ui/components/custom_date_picker.dart';
import 'package:flytern/shared/ui/components/custom_media_carousel.dart';
import 'package:flytern/shared/ui/components/data_capsule_card.dart';
import 'package:flytern/feature-modules/flight_booking/ui/components/flight_details_addon_service_card.dart';
import 'package:flytern/feature-modules/flight_booking/ui/components/flight_details_itinerary_card.dart';
import 'package:flytern/shared/data/constants/app_specific/app_route_names.dart';
import 'package:flytern/shared/data/constants/ui_constants/asset_urls.dart';
import 'package:flytern/shared/data/constants/ui_constants/style_params.dart';
import 'package:flytern/shared/data/constants/ui_constants/widget_styles.dart';
import 'package:flytern/shared/services/utility-services/widget_generator.dart';
import 'package:flytern/shared/services/utility-services/widget_properties_generator.dart';
import 'package:flytern/shared/ui/components/dropdown_selector.dart';
import 'package:flytern/shared/ui/components/selectable_text_pill.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class ActivityDetailsPage extends StatefulWidget {
  const ActivityDetailsPage({super.key});

  @override
  State<ActivityDetailsPage> createState() => _ActivityDetailsPageState();
}

class _ActivityDetailsPageState extends State<ActivityDetailsPage> {
  final activityBookingController = Get.put(ActivityBookingController());

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Obx(
      () => Scaffold(
        appBar: AppBar(
          title: Text("activity_details".tr),
          elevation: 0.5,
        ),
        body: Stack(
          children: [
            Visibility(
              visible: !activityBookingController.isDetailsDataLoading.value,
              child: Container(
                width: screenwidth,
                height: screenheight,
                color: flyternGrey10,
                child: ListView(
                  children: [
                    CustomMediaCarousel(
                      medias: activityBookingController
                          .activityDetails.value.subImages,
                    ),
                    Container(
                      padding:
                          flyternLargePaddingAll.copyWith(bottom: 0, top: 0),
                      color: flyternBackgroundWhite,
                      child: Text(
                          activityBookingController
                              .activityDetails.value.tourName,
                          style: getHeadlineMediumStyle(context).copyWith(
                              color: flyternGrey80,
                              fontWeight: flyternFontWeightBold)),
                    ),
                    Container(
                        padding: flyternLargePaddingAll.copyWith(
                            top: flyternSpaceMedium, bottom: 0),
                        color: flyternBackgroundWhite,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Ionicons.star,
                                color: flyternAccentColor,
                                size: flyternFontSize20),
                            addHorizontalSpace(flyternSpaceExtraSmall),
                            Text(
                              "${activityBookingController.activityDetails.value.rating} (${activityBookingController.activityDetails.value.reviewCount})",
                              style: getBodyMediumStyle(context)
                                  .copyWith(color: flyternGrey80),
                            ),
                          ],
                        )),
                    Container(
                        padding: flyternMediumPaddingAll,
                        color: flyternBackgroundWhite,
                        child: Html(
                          data: activityBookingController
                              .activityDetails.value.tourShortDescription,
                        )),
                    addVerticalSpace(1),
                    Container(
                      padding: flyternLargePaddingAll.copyWith(
                          top: flyternSpaceMedium, bottom: flyternSpaceMedium),
                      color: flyternBackgroundWhite,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              flex: 1,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(Ionicons.location_outline,
                                      color: flyternGrey40,
                                      size: flyternFontSize20),
                                  addHorizontalSpace(flyternSpaceExtraSmall),
                                  Text(
                                    "${activityBookingController.activityDetails.value.cityName}",
                                    style: getBodyMediumStyle(context)
                                        .copyWith(color: flyternGrey80),
                                  ),
                                ],
                              )),
                          Expanded(
                              flex: 1,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      _launchUrl(activityBookingController
                                          .activityDetails.value.googleMapUrl);
                                    },
                                    child: Text("view_in_map".tr,
                                        style: getBodyMediumStyle(context)
                                            .copyWith(
                                                decoration:
                                                    TextDecoration.underline,
                                                color: flyternTertiaryColor)),
                                  ),
                                ],
                              )),
                        ],
                      ),
                    ),
                    Container(
                      padding: flyternLargePaddingAll.copyWith(
                          top: flyternSpaceMedium, bottom: flyternSpaceLarge),
                      color: flyternBackgroundWhite,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Ionicons.time_outline,
                              color: flyternGrey40, size: flyternFontSize20),
                          addHorizontalSpace(flyternSpaceExtraSmall),
                          Text(
                            "${activityBookingController.activityDetails.value.duration}",
                            style: getBodyMediumStyle(context)
                                .copyWith(color: flyternGrey80),
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: activityBookingController
                              .activityOptions.isNotEmpty &&
                          activityBookingController
                              .activityTransferTypes.isNotEmpty,
                      child: Padding(
                        padding: flyternLargePaddingAll,
                        child: Text("options".tr,
                            style: getBodyMediumStyle(context).copyWith(
                                color: flyternGrey80,
                                fontWeight: flyternFontWeightBold)),
                      ),
                    ),
                    Visibility(
                      visible: activityBookingController
                              .activityOptions.isNotEmpty &&
                          activityBookingController
                              .activityTransferTypes.isNotEmpty,
                      child: Container(
                        color: flyternBackgroundWhite,
                        padding: flyternLargePaddingAll.copyWith(bottom: 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                showActivityOption(activityBookingController
                                    .selectedActivityOption.value);
                              },
                              child: Text("info".tr,
                                  style: getBodyMediumStyle(context).copyWith(
                                      decoration: TextDecoration.underline,
                                      color: flyternTertiaryColor)),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Visibility(
                      visible: activityBookingController
                              .activityOptions.isNotEmpty &&
                          activityBookingController
                              .activityTransferTypes.isNotEmpty,
                      child: Container(
                        padding: flyternLargePaddingHorizontal,
                        decoration:
                            BoxDecoration(color: flyternBackgroundWhite),
                        child: Container(
                          width: screenwidth - flyternSpaceMedium * 2,
                          padding: flyternMediumPaddingHorizontal,
                          margin: flyternLargePaddingVertical,
                          decoration: BoxDecoration(
                            color: flyternBackgroundWhite,
                            border: flyternDefaultBorderAll,
                            borderRadius: BorderRadius.circular(
                                flyternBorderRadiusExtraSmall),
                          ),
                          child: DropDownSelector(
                            titleText: "select_tour_option".tr,
                            selected: activityBookingController
                                        .selectedActivityOption
                                        .value
                                        .tourOptionId !=
                                    ""
                                ? activityBookingController
                                    .selectedActivityOption.value.tourOptionId
                                : null,
                            items: [
                              for (var ind = 0;
                                  ind <
                                      activityBookingController
                                          .activityOptions.value.length;
                                  ind++)
                                GeneralItem(
                                    id: activityBookingController
                                        .activityOptions
                                        .value[ind]
                                        .tourOptionId,
                                    name: activityBookingController
                                        .activityOptions.value[ind].optionName,
                                    imageUrl: ""),
                            ],
                            hintText: "select_tour_option".tr,
                            valueChanged: (newZone) {
                              List<ActivityOption> selectedActivityOption =
                                  activityBookingController
                                      .activityOptions.value
                                      .where((element) =>
                                          element.tourOptionId == newZone)
                                      .toList();
                              if (selectedActivityOption.isNotEmpty) {
                                print("selectedActivityOption.isNotEmpty");
                                activityBookingController
                                    .changeSelectedActivityOption(
                                        selectedActivityOption[0]);
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: activityBookingController
                              .activityOptions.isNotEmpty &&
                          activityBookingController
                              .activityTransferTypes.isNotEmpty,
                      child: Container(
                        padding: flyternLargePaddingHorizontal,
                        decoration:
                            BoxDecoration(color: flyternBackgroundWhite),
                        child: Container(
                          width: screenwidth - flyternSpaceMedium * 2,
                          padding: flyternMediumPaddingHorizontal,
                          margin: flyternLargePaddingVertical.copyWith(top: 0),
                          decoration: BoxDecoration(
                            color: flyternBackgroundWhite,
                            border: flyternDefaultBorderAll,
                            borderRadius: BorderRadius.circular(
                                flyternBorderRadiusExtraSmall),
                          ),
                          child: DropDownSelector(
                            titleText: "select_transfer_type".tr,
                            selected: activityBookingController
                                        .selectedActivityTransferType
                                        .value
                                        .transferId !=
                                    ""
                                ? activityBookingController
                                    .selectedActivityTransferType
                                    .value
                                    .transferId
                                : null,
                            items: [
                              for (var ind = 0;
                                  ind <
                                      activityBookingController
                                          .activityTransferTypes.value.length;
                                  ind++)
                                GeneralItem(
                                    id: activityBookingController
                                        .activityTransferTypes
                                        .value[ind]
                                        .transferId,
                                    name: activityBookingController
                                        .activityTransferTypes
                                        .value[ind]
                                        .transferName,
                                    imageUrl: ""),
                            ],
                            hintText: "select_transfer_type".tr,
                            valueChanged: (newZone) {
                              List<ActivityTransferType>
                                  selectedActivityTransferType =
                                  activityBookingController
                                      .activityTransferTypes.value
                                      .where((element) =>
                                          element.transferId == newZone)
                                      .toList();
                              if (selectedActivityTransferType.isNotEmpty) {
                                print("selectedActivityOption.isNotEmpty");
                                activityBookingController
                                    .changeSelectedActivityTransferType(
                                        selectedActivityTransferType[0]);
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: activityBookingController
                              .activityOptions.isNotEmpty &&
                          activityBookingController
                              .activityTransferTypes.isNotEmpty,
                      child: Container(
                        padding: flyternLargePaddingHorizontal,
                        decoration:
                            BoxDecoration(color: flyternBackgroundWhite),
                        child: Container(
                          width: screenwidth - flyternSpaceMedium * 2,
                          margin: flyternLargePaddingVertical.copyWith(top: 0),
                          decoration: BoxDecoration(
                            color: flyternBackgroundWhite,
                            borderRadius: BorderRadius.circular(
                                flyternBorderRadiusExtraSmall),
                          ),
                          child: InkWell(
                            onTap: () {
                              openFlightOptionsSelector();
                            },
                            child: Container(
                              decoration:
                                  flyternBorderedContainerSmallDecoration
                                      .copyWith(
                                          border: Border.all(
                                              color: flyternGrey20, width: .5)),
                              padding: flyternMediumPaddingAll,
                              child: Row(
                                children: [
                                  Icon(Ionicons.person_outline,
                                      color: flyternSecondaryColor,
                                      size: flyternFontSize20),
                                  addHorizontalSpace(flyternSpaceSmall * 1.5),
                                  Expanded(
                                    flex: 1,
                                    child: Text(getPassengerCount(),
                                        style: getLabelLargeStyle(context)
                                            .copyWith(
                                          color: flyternGrey80,
                                        )),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: activityBookingController
                              .activityOptions.isNotEmpty &&
                          activityBookingController
                              .activityTransferTypes.isNotEmpty,
                      child: Container(
                        padding: flyternLargePaddingHorizontal,
                        decoration:
                            BoxDecoration(color: flyternBackgroundWhite),
                        child: Container(
                          width: screenwidth - flyternSpaceMedium * 2,
                          margin: flyternLargePaddingVertical.copyWith(top: 0),
                          decoration: BoxDecoration(
                            color: flyternBackgroundWhite,
                            borderRadius: BorderRadius.circular(
                                flyternBorderRadiusExtraSmall),
                          ),
                          child: InkWell(
                            onTap: () {
                              showCustomDatePicker(
                                  activityBookingController.travelDate.value);
                            },
                            child: Container(
                              decoration:
                                  flyternBorderedContainerSmallDecoration
                                      .copyWith(
                                          border: Border.all(
                                              color: flyternGrey20, width: .5)),
                              padding: flyternMediumPaddingAll,
                              child: Row(
                                children: [
                                  Icon(Ionicons.calendar_clear_outline,
                                      color: flyternSecondaryColor,
                                      size: flyternFontSize20),
                                  addHorizontalSpace(flyternSpaceSmall * 1.5),
                                  Expanded(
                                    flex: 1,
                                    child: Text(
                                        getTravelDate(activityBookingController
                                            .travelDate.value),
                                        style: getLabelLargeStyle(context)
                                            .copyWith(
                                          color: flyternGrey80,
                                        )),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: activityBookingController
                              .activityTimingOptions.isNotEmpty &&
                          activityBookingController
                              .selectedActivityTransferType.value.isSlot,
                      child: Container(
                        padding: flyternLargePaddingHorizontal.copyWith(bottom: flyternSpaceLarge),
                        decoration:
                            BoxDecoration(color: flyternBackgroundWhite),
                        child: Wrap(
                          children: [
                            for (var i = 0;
                                i <
                                    (activityBookingController
                                            .activityTimingOptions.isNotEmpty
                                        ? activityBookingController
                                            .activityTimingOptions.length
                                        : 0);
                                i++)
                              Padding(
                                padding: const EdgeInsets.only(
                                    right: flyternSpaceSmall,
                                    bottom: flyternSpaceSmall),
                                child: SelectableTilePill(
                                  onPressed: () {
                                    activityBookingController.changeActivityTime(activityBookingController.activityTimingOptions[i]);
                                  },
                                  label:
                                      '${activityBookingController.activityTimingOptions[i].timeSlot}',
                                  isSelected: activityBookingController
                                          .selectedActivityTime
                                          .value
                                          .timeSlotId ==
                                      activityBookingController
                                          .activityTimingOptions[i].timeSlotId,
                                  themeNumber: 2,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                    Visibility(
                      visible: activityBookingController
                              .activityOptions.isNotEmpty &&
                          activityBookingController
                              .activityTransferTypes.isNotEmpty,
                      child: Container(
                        padding: flyternLargePaddingHorizontal.copyWith(
                            top: flyternSpaceSmall, bottom: flyternSpaceLarge),
                        color: flyternBackgroundWhite,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("base_fare".tr,
                                style: getBodyMediumStyle(context)
                                    .copyWith(color: flyternGrey80)),
                            !activityBookingController.isPriceDataLoading.value
                                ? Text(
                                    "${activityBookingController.selectedActivityTransferType.value.currency}"
                                    " ${activityBookingController.selectedActivityTransferType.value.finalAmount}",
                                    style: getBodyMediumStyle(context).copyWith(
                                        color: flyternGrey80,
                                        fontWeight: flyternFontWeightBold))
                                : LoadingAnimationWidget.prograssiveDots(
                                    color: flyternSecondaryColor,
                                    size: 20,
                                  ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: flyternLargePaddingAll,
                      child: Text("description".tr,
                          style: getBodyMediumStyle(context).copyWith(
                              color: flyternGrey80,
                              fontWeight: flyternFontWeightBold)),
                    ),
                    Container(
                      padding: flyternLargePaddingAll,
                      color: flyternBackgroundWhite,
                      child: Html(
                        data: activityBookingController
                            .activityDetails.value.tourDescription,
                      ),
                    ),
                    Padding(
                      padding: flyternLargePaddingAll,
                      child: Text("what_is_in_this".tr,
                          style: getBodyMediumStyle(context).copyWith(
                              color: flyternGrey80,
                              fontWeight: flyternFontWeightBold)),
                    ),
                    Container(
                      padding: flyternLargePaddingAll.copyWith(left: 0),
                      color: flyternBackgroundWhite,
                      child: Html(
                        data: activityBookingController
                            .activityDetails.value.whatsInThisTour,
                      ),
                    ),
                    Padding(
                      padding: flyternLargePaddingAll,
                      child: Text("itinerary".tr,
                          style: getBodyMediumStyle(context).copyWith(
                              color: flyternGrey80,
                              fontWeight: flyternFontWeightBold)),
                    ),
                    Container(
                      padding: flyternLargePaddingAll.copyWith(left: 0),
                      color: flyternBackgroundWhite,
                      child: Html(
                        data: activityBookingController
                            .activityDetails.value.itenararyDescription,
                      ),
                    ),
                    Padding(
                      padding: flyternLargePaddingAll,
                      child: Text("inclusion".tr,
                          style: getBodyMediumStyle(context).copyWith(
                              color: flyternGrey80,
                              fontWeight: flyternFontWeightBold)),
                    ),
                    Container(
                      padding: flyternLargePaddingAll,
                      color: flyternBackgroundWhite,
                      child: Html(
                        data: activityBookingController
                            .activityDetails.value.tourInclusion,
                      ),
                    ),
                    Padding(
                      padding: flyternLargePaddingAll,
                      child: Text("exclusion".tr,
                          style: getBodyMediumStyle(context).copyWith(
                              color: flyternGrey80,
                              fontWeight: flyternFontWeightBold)),
                    ),
                    Container(
                      padding: flyternLargePaddingAll,
                      color: flyternBackgroundWhite,
                      child: Html(
                        data: activityBookingController
                            .activityDetails.value.tourExclusion,
                      ),
                    ),
                    Padding(
                      padding: flyternLargePaddingAll,
                      child: Text("terms_n_conditions".tr,
                          style: getBodyMediumStyle(context).copyWith(
                              color: flyternGrey80,
                              fontWeight: flyternFontWeightBold)),
                    ),
                    Container(
                      padding: flyternLargePaddingAll.copyWith(left: 0),
                      color: flyternBackgroundWhite,
                      child: Html(
                        data: activityBookingController
                            .activityDetails.value.termsAndConditions,
                      ),
                    ),
                    Padding(
                      padding: flyternLargePaddingAll,
                      child: Text("cancellation_policy".tr,
                          style: getBodyMediumStyle(context).copyWith(
                              color: flyternGrey80,
                              fontWeight: flyternFontWeightBold)),
                    ),
                    Container(
                      padding: flyternLargePaddingAll,
                      color: flyternBackgroundWhite,
                      child: Html(
                        data: activityBookingController.activityDetails.value
                            .cancellationPolicyDescription,
                      ),
                    ),
                    Visibility(
                      visible: activityBookingController.activityDetails.value
                              .childCancellationPolicyDescription !=
                          "",
                      child: Container(
                        padding: flyternLargePaddingAll,
                        color: flyternBackgroundWhite,
                        child: Html(
                          data: activityBookingController.activityDetails.value
                              .childCancellationPolicyDescription,
                        ),
                      ),
                    ),
                    Padding(
                      padding: flyternLargePaddingAll,
                      child: Text("faq".tr,
                          style: getBodyMediumStyle(context).copyWith(
                              color: flyternGrey80,
                              fontWeight: flyternFontWeightBold)),
                    ),
                    Container(
                      padding: flyternLargePaddingAll,
                      color: flyternBackgroundWhite,
                      child: Html(
                        data: activityBookingController
                            .activityDetails.value.faqDetails,
                      ),
                    ),
                    Container(
                      height: 70 + (flyternSpaceSmall * 2),
                      padding: flyternLargePaddingAll,
                    )
                  ],
                ),
              ),
            ),
            Visibility(
                visible: activityBookingController.isDetailsDataLoading.value,
                child: Center(
                    child: LoadingAnimationWidget.prograssiveDots(
                  color: flyternSecondaryColor,
                  size: 50,
                )))
          ],
        ),
        bottomSheet: !activityBookingController.isDetailsDataLoading.value
            ? Container(
                width: screenwidth,
                color: flyternBackgroundWhite,
                height: 60 + (flyternSpaceSmall * 2),
                padding: flyternLargePaddingAll.copyWith(
                    top: flyternSpaceSmall, bottom: flyternSpaceSmall),
                child: Center(
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        style: getElevatedButtonStyle(context),
                        onPressed: () {
                          openContactDetailsGetterBottomSheet();
                        },
                        child: Row(
                          children: [
                            Visibility(
                              visible: !activityBookingController
                                  .isPriceDataLoading.value,
                              child: Expanded(
                                  child: Text(
                                      "${activityBookingController.selectedActivityTransferType.value.currency}"
                                      " ${activityBookingController.selectedActivityTransferType.value.finalAmount}")),
                            ),
                            Visibility(
                              visible: activityBookingController
                                  .isPriceDataLoading.value,
                              child: LoadingAnimationWidget.prograssiveDots(
                                color: flyternBackgroundWhite,
                                size: 20,
                              ),
                            ),
                            Visibility(
                                visible: activityBookingController
                                    .isPriceDataLoading.value,
                                child: Expanded(
                                  child: Container(),
                                )),
                            Text("select".tr),
                            addHorizontalSpace(flyternSpaceSmall),
                            Icon(Ionicons.chevron_forward,
                                size: flyternFontSize20)
                          ],
                        )),
                  ),
                ),
              )
            : Container(
                width: screenwidth, height: 60 + (flyternSpaceSmall * 2)),
      ),
    );
  }

  void openContactDetailsGetterBottomSheet() {
    showModalBottomSheet(
        useSafeArea: false,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(flyternBorderRadiusSmall),
              topRight: Radius.circular(flyternBorderRadiusSmall)),
        ),
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return ContactDetailsGetter(route: Approute_activitiesUserDataSubmission);
        });
  }

  Future<void> _launchUrl(String urlString) async {
    final Uri _url = Uri.parse(urlString);

    if (!await launchUrl(_url)) {
      print('Could not launch $_url');
    }
  }

  String getPassengerCount() {
    String returnString = "";

    if (activityBookingController.noOfAdult.value == 0 &&
        activityBookingController.noOfChildren.value == 0 &&
        activityBookingController.noOfInfant.value == 0) {
      return "select_travellers".tr;
    } else {
      if (activityBookingController.noOfAdult.value != 0) {
        returnString +=
            "${activityBookingController.noOfAdult.value} ${'adults'.tr}";
      }

      if (activityBookingController.noOfChildren.value != 0) {
        returnString +=
            ", ${activityBookingController.noOfChildren.value} ${'children'.tr}";
      }

      if (activityBookingController.noOfInfant.value != 0) {
        returnString +=
            ", ${activityBookingController.noOfInfant.value} ${'infants'.tr}";
      }

      return returnString;
    }
  }

  void showActivityOption(ActivityOption activityOption) {
    showModalBottomSheet(
        useSafeArea: false,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(flyternBorderRadiusLarge),
              topRight: Radius.circular(flyternBorderRadiusLarge)),
        ),
        isScrollControlled: true,
        backgroundColor: flyternBackgroundWhite,
        context: context,
        builder: (context) {
          return ActivityOptionInfo(
            activityOption: activityOption,
          );
        });
  }

  void openFlightOptionsSelector() {
    showModalBottomSheet(
        useSafeArea: false,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(flyternBorderRadiusSmall),
              topRight: Radius.circular(flyternBorderRadiusSmall)),
        ),
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) {
          return BookingOptionsSelector(
              selectedAdultCount: activityBookingController.noOfAdult.value,
              selectedChildCount: activityBookingController.noOfChildren.value,
              selectedInfantCount: activityBookingController.noOfInfant.value,
              dataSubmitted: (int adultCount, int childCount, int infantCount,
                  List<CabinClass> cabinClasses, List<int> childAges) {
                activityBookingController.updatePassengerCount(
                    adultCount, childCount, infantCount);
                Navigator.pop(context);
              },
              bookingServiceNumber: 3,
              cabinClasses: [],
              childAges:[],
              selectedCabinClasses: []);
        });
  }

  String getTravelDate(DateTime travelDate) {
    if (travelDate != DefaultInvalidDate) {
      return DateFormat.yMMMMd().format(travelDate);
    } else {
      return "select_date".tr;
    }
  }

  void showCustomDatePicker(DateTime currentDateTime) {
    showModalBottomSheet(
        useSafeArea: false,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(flyternBorderRadiusSmall),
              topRight: Radius.circular(flyternBorderRadiusSmall)),
        ),
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) {
          return CustomDatePicker(
            selectedDate: currentDateTime,
            minimumDate: DateTime.now(),
            maximumDate: DateTime.now().add(Duration(days: 365)),
            dateSelected: (DateTime? dateTime) {
              if (dateTime != null && dateTime.isAfter(DateTime.now())) {
                activityBookingController.changeTravelDate(dateTime);
              }
            },
          );
        });
  }

}
