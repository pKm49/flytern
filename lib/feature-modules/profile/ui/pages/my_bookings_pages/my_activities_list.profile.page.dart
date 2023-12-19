import 'package:flutter/material.dart';
import 'package:flytern/feature-modules/activity_booking/controllers/activity_booking.controller.dart';
import 'package:flytern/feature-modules/profile/controllers/profile.controller.dart';
import 'package:flytern/shared-module/constants/ui_specific/asset_urls.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/style_params.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/widget_styles.shared.constant.dart';
import 'package:flytern/shared-module/services/utility-services/widget_generator.shared.service.dart';
import 'package:flytern/shared-module/services/utility-services/widget_properties_generator.shared.service.dart';
import 'package:flytern/shared-module/ui/components/data_capsule_card.shared.component.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ProfileActivityBookingsList extends StatefulWidget {
  const ProfileActivityBookingsList({super.key});

  @override
  State<ProfileActivityBookingsList> createState() =>
      _ProfileActivityBookingsListState();
}

class _ProfileActivityBookingsListState
    extends State<ProfileActivityBookingsList> {
  final profileController = Get.find<ProfileController>();
  final activityBookingController = Get.find<ActivityBookingController>();
  String currentBookingRef = "";

  @override
  Widget build(BuildContext context) {
    double screenheight = MediaQuery.of(context).size.height;
    double screenwidth = MediaQuery.of(context).size.width;
    return profileController.myActivityBookingResponse.isNotEmpty?  ListView.builder(
          itemCount: profileController.myActivityBookingResponse.length,
          itemBuilder: (context, index) => Container(
                decoration: flyternShadowedContainerSmallDecoration,
                padding: flyternMediumPaddingAll,
                margin: flyternLargePaddingAll.copyWith(
                    bottom: index ==
                            profileController.myActivityBookingResponse.length - 1
                        ? flyternSpaceLarge
                        : 0),
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
                                "${profileController.myActivityBookingResponse[index].bookingStatus}",
                            theme: 1,
                          ),
                          addHorizontalSpace(flyternSpaceSmall),
                          DataCapsuleCard(
                            label:
                                "${profileController.myActivityBookingResponse[index].tmSaleCurrency}"
                                " ${profileController.myActivityBookingResponse[index].grossSellingPrice}",
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
                                  .myActivityBookingResponse[index].hotelImageUrl,
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
                                  .myActivityBookingResponse[index].eventName,
                              maxLines: 2,
                              style: getBodyMediumStyle(context)
                                  .copyWith(fontWeight: flyternFontWeightBold),
                            ),
                            addVerticalSpace(flyternSpaceSmall),
                            Text(
                                profileController
                                    .myActivityBookingResponse[index].address,
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "date".tr,
                                style: getLabelLargeStyle(context).copyWith(
                                    color: flyternGrey40,
                                    fontWeight: FontWeight.w400),
                              ),
                              addVerticalSpace(flyternSpaceExtraSmall),
                              Text(
                                getFormattedDOB(profileController
                                    .myActivityBookingResponse[index].eventDate),
                                style: getLabelLargeStyle(context).copyWith(
                                    color: flyternGrey80,
                                    fontWeight: flyternFontWeightBold),
                              ),
                            ],
                          ),
                        ),
                        Expanded(child: Container()),
                        ClipRRect(
                          borderRadius: BorderRadius.all(
                              Radius.circular(flyternBorderRadiusExtraSmall)),
                          child: ElevatedButton(
                              style: ButtonStyle(
                                padding:
                                    MaterialStateProperty.all<EdgeInsetsGeometry>(
                                        EdgeInsets.symmetric(
                                            horizontal: 0,
                                            vertical: flyternSpaceExtraSmall)),
                              ),
                              onPressed: () {
                                if(!activityBookingController
                                    .isActivityConfirmationDataLoading
                                    .value){

                                  activityBookingController.getConfirmationData(
                                      profileController.myActivityBookingResponse
                                          .value[index].travelmateID,
                                      true).then((value) => {
                                   restCurrentRef()
                                  });
                                  currentBookingRef = profileController.myActivityBookingResponse
                                      .value[index].travelmateID;

                                  setState(() {
                                  });

                                }

                              },
                              child: (activityBookingController
                                          .isActivityConfirmationDataLoading
                                          .value &&
                                      currentBookingRef  == profileController.myActivityBookingResponse
                                          .value[index].travelmateID)
                                  ? LoadingAnimationWidget.prograssiveDots(
                                      color: flyternBackgroundWhite,
                                      size: 20,
                                    )
                                  : Icon(Localizations.localeOf(context)
                                  .languageCode
                                  .toString() ==
                                  'ar'? Ionicons.chevron_back :Ionicons.chevron_forward, )),
                        ),
                      ],
                    )
                  ],
                ),
              )):
    Container(
      width: screenwidth,
      height: screenheight,
      child: Center(
        child:  Center(
          child:
          Text("no_item".tr, style: getBodyMediumStyle(context)),
        ),
      ),
    );
  }

  String getFormattedDOB(DateTime dateOfBirth) {
    final f = DateFormat.yMMMMd('en_US');
    return f.format(dateOfBirth);
  }

  restCurrentRef() {
    currentBookingRef="";
    setState(() {
    });
  }
}
