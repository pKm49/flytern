import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flytern/feature-modules/packages/controllers/package.controller.dart';
import 'package:flytern/shared-module/constants/app_specific/route_names.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/style_params.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/widget_styles.shared.constant.dart';
import 'package:flytern/shared-module/services/utility-services/widget_generator.shared.service.dart';
import 'package:flytern/shared-module/services/utility-services/widget_properties_generator.shared.service.dart';
import 'package:flytern/shared-module/ui/components/contact_details_getter.shared.component.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class PackageDetailsPage extends StatefulWidget {
  const PackageDetailsPage({super.key});

  @override
  State<PackageDetailsPage> createState() => _PackageDetailsPageState();
}

class _PackageDetailsPageState extends State<PackageDetailsPage> {
  final packageBookingController = Get.find<PackageBookingController>();
  final List<ExpansionTileController> expansionTileControllers = [];

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Obx(
      () => Scaffold(
        appBar: AppBar(
          title: Text("package_details".tr),
          // title: Text(packageBookingController.packageDetails.value.name),
          elevation: 0.5,
        ),
        body: Container(
          width: screenwidth,
          height: screenheight,
          color: flyternGrey10,
          child: Stack(
            children: [
              Visibility(
                visible: !packageBookingController.isDetailsDataLoading.value,
                child: ListView(
                  children: [
                    Visibility(
                      visible:
                          packageBookingController.selectedImageIndex.value >
                                  -1 &&
                              getSelectedImageUrl() != "",
                      child: InkWell(
                        onTap: () {
                          Get.toNamed(Approute_imageViewer, arguments: [
                            packageBookingController
                                    .packageDetails.value.subImages[
                                packageBookingController
                                    .selectedImageIndex.value],
                            packageBookingController
                                .packageDetails.value.subImages
                          ]);
                        },
                        child: Container(
                          width: screenwidth,
                          height: screenwidth,
                          color: flyternGrey10,
                          child: Image.network(
                              packageBookingController
                                          .selectedImageIndex.value >
                                      -1
                                  ? packageBookingController
                                          .packageDetails.value.subImages[
                                      packageBookingController
                                          .selectedImageIndex.value]
                                  : "",
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: flyternGrey10,
                              height: screenwidth,
                              child: Center(
                                child: Icon(
                                  Icons.business,
                                  color: flyternGrey40,
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                    ),
                    Container(
                      padding: flyternLargePaddingAll,
                      color: flyternBackgroundWhite,
                      height: (screenwidth * .15) + (flyternSpaceMedium * 2),
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          for (var i = 0;
                              i <
                                  packageBookingController
                                      .packageDetails.value.subImages.length;
                              i++)
                            InkWell(
                              onTap: () {
                                packageBookingController.changeSelectedImage(i);
                              },
                              child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          flyternBorderRadiusExtraSmall),
                                      border: Border.all(
                                          color: i ==
                                                  packageBookingController
                                                      .selectedImageIndex.value
                                              ? flyternSecondaryColor
                                              : Colors.transparent,
                                          width: 2)),
                                  margin:
                                      EdgeInsets.only(right: flyternSpaceSmall),
                                  clipBehavior: Clip.hardEdge,
                                  height: screenwidth * .16,
                                  child: Image.network(
                                      packageBookingController
                                          .packageDetails.value.subImages[i],
                                      height: screenwidth * .2, errorBuilder:
                                          (context, error, stackTrace) {
                                    return Container(
                                      color: flyternGrey10,
                                      height: screenwidth * .2,
                                      child: Center(
                                        child: Icon(
                                          Icons.business,
                                          color: flyternGrey40,
                                        ),
                                      ),
                                    );
                                  })),
                            ),
                        ],
                      ),
                    ),
                    Container(
                      padding:
                          flyternLargePaddingAll.copyWith(bottom: 0, top: 0),
                      color: flyternBackgroundWhite,
                      child: Text(
                          packageBookingController.packageDetails.value.name,
                          style: getHeadlineMediumStyle(context).copyWith(
                              color: flyternGrey80,
                              fontWeight: flyternFontWeightBold)),
                    ),
                    Container(
                      padding: flyternLargePaddingAll.copyWith(
                          top: flyternSpaceSmall, bottom: flyternSpaceSmall),
                      color: flyternBackgroundWhite,
                      child: Text(
                          packageBookingController
                              .packageDetails.value.shortDesc,
                          style: getBodyMediumStyle(context)
                              .copyWith(color: flyternGrey60)),
                    ),
                    addVerticalSpace(1),
                    Container(
                      padding: flyternLargePaddingAll.copyWith(
                          top: flyternSpaceMedium, bottom: flyternSpaceMedium),
                      color: flyternBackgroundWhite,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${packageBookingController.packageDetails.value.currency} ${packageBookingController.packageDetails.value.price.toStringAsFixed(3)}",
                            style: getBodyMediumStyle(context).copyWith(
                                fontWeight: flyternFontWeightBold,
                                color: flyternSecondaryColor),
                          ),
                          Expanded(
                              flex: 1,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(Ionicons.star,
                                      color: flyternAccentColor,
                                      size: flyternFontSize20),
                                  addHorizontalSpace(flyternSpaceExtraSmall),
                                  Text(
                                    packageBookingController
                                        .packageDetails.value.ratings,
                                    style: getBodyMediumStyle(context)
                                        .copyWith(color: flyternGrey80),
                                  ),
                                ],
                              )),
                        ],
                      ),
                    ),
                    Padding(
                      padding: flyternLargePaddingAll,
                      child: Text("validity".tr,
                          style: getBodyMediumStyle(context).copyWith(
                              color: flyternGrey80,
                              fontWeight: flyternFontWeightBold)),
                    ),
                    Container(
                      padding: flyternLargePaddingAll,
                      color: flyternBackgroundWhite,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(Ionicons.calendar_clear_outline,
                              color: flyternGrey60),
                          addHorizontalSpace(flyternSpaceMedium),
                          Text(
                              "${getFormattedDate(packageBookingController.packageDetails.value.validFrom)} - "
                              "${getFormattedDate(packageBookingController.packageDetails.value.validTo)} ",
                              style: getBodyMediumStyle(context)
                                  .copyWith(color: flyternGrey80)),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: (packageBookingController
                          .packageDetails.value.fromTo !=
                          "" ||
                          packageBookingController
                              .packageDetails.value.airline !=
                              ""||
                          packageBookingController
                              .packageDetails.value.hotelName !=
                              ""),
                      child: Padding(
                        padding: flyternLargePaddingAll,
                        child: Text("flight_hotel_details".tr,
                            style: getBodyMediumStyle(context).copyWith(
                                color: flyternGrey80,
                                fontWeight: flyternFontWeightBold)),
                      ),
                    ),
                    Visibility(
                      visible: (packageBookingController
                                  .packageDetails.value.fromTo !=
                              "" ||
                          packageBookingController
                                  .packageDetails.value.airline !=
                              ""),
                      child: Container(
                        padding: flyternLargePaddingHorizontal.copyWith(
                            top: flyternSpaceLarge, bottom: flyternSpaceSmall),
                        color: flyternBackgroundWhite,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Ionicons.airplane_outline,
                                color: flyternGrey60),
                            addHorizontalSpace(flyternSpaceMedium),
                            Text(
                                "${packageBookingController.packageDetails.value.fromTo} "
                                "(${packageBookingController.packageDetails.value.airline})",
                                style: getBodyMediumStyle(context)
                                    .copyWith(color: flyternGrey80)),
                          ],
                        ),
                      ),
                    ),
                    Visibility(
                      visible: (packageBookingController
                          .packageDetails.value.hotelName !=
                          ""  ),
                      child: Container(
                          padding: flyternLargePaddingHorizontal,
                          color: flyternBackgroundWhite,
                          child: Divider()),
                    ),
                    Visibility(
                      visible: (packageBookingController
                          .packageDetails.value.hotelName !=
                          ""  ),
                      child: Container(
                        padding: flyternLargePaddingAll.copyWith(
                            top: flyternSpaceSmall),
                        color: flyternBackgroundWhite,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Ionicons.bed_outline, color: flyternGrey60),
                            addHorizontalSpace(flyternSpaceMedium),
                            Text(
                                packageBookingController
                                    .packageDetails.value.hotelName,
                                style: getBodyMediumStyle(context)
                                    .copyWith(color: flyternGrey80)),
                          ],
                        ),
                      ),
                    ),
                    Visibility(
                      visible: packageBookingController
                          .packageDetails.value.itinerary.isNotEmpty,
                      child: Padding(
                        padding: flyternLargePaddingAll,
                        child: Text("itinerary".tr,
                            style: getBodyMediumStyle(context).copyWith(
                                color: flyternGrey80,
                                fontWeight: flyternFontWeightBold)),
                      ),
                    ),
                    for (var ind = 0;
                        ind <
                            packageBookingController
                                .packageDetails.value.itinerary.length;
                        ind++)
                      Visibility(
                        visible: packageBookingController.packageDetails.value
                            .itinerary[ind].displayName !="" &&
                            packageBookingController.packageDetails.value
                                .itinerary[ind].content !="",
                        child: Container(
                          padding: flyternLargePaddingHorizontal,
                          decoration: BoxDecoration(
                              color: flyternBackgroundWhite,
                              border: flyternDefaultBorderBottomOnly),
                          child: Theme(
                            data: ThemeData()
                                .copyWith(dividerColor: Colors.transparent),
                            child: ExpansionTile(
                              tilePadding: EdgeInsets.zero,
                              title: Text(
                                packageBookingController.packageDetails.value
                                    .itinerary[ind].displayName,
                                style: getLabelLargeStyle(context).copyWith(
                                    fontWeight: flyternFontWeightRegular),
                              ),
                              children: <Widget>[
                                Padding(
                                  padding: flyternSmallPaddingVertical,
                                  child: Html(
                                    data: packageBookingController.packageDetails
                                        .value.itinerary[ind].content,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    Visibility(
                      visible: packageBookingController
                              .packageDetails.value.inclusion !=
                          "",
                      child: Padding(
                        padding: flyternLargePaddingAll,
                        child: Text("inclusion".tr,
                            style: getBodyMediumStyle(context).copyWith(
                                color: flyternGrey80,
                                fontWeight: flyternFontWeightBold)),
                      ),
                    ),
                    Visibility(
                      visible: packageBookingController
                              .packageDetails.value.inclusion !=
                          "",
                      child: Container(
                          padding: flyternLargePaddingAll.copyWith(
                              left: flyternSpaceMedium,
                              right: flyternSpaceMedium),
                          width: screenwidth,
                          color: flyternBackgroundWhite,
                          child: Html(
                            data: packageBookingController
                                .packageDetails.value.inclusion,
                          )),
                    ),
                    Visibility(
                      visible: packageBookingController
                              .packageDetails.value.notIncluded !=
                          "",
                      child: Padding(
                        padding: flyternLargePaddingAll,
                        child: Text("exclusion".tr,
                            style: getBodyMediumStyle(context).copyWith(
                                color: flyternGrey80,
                                fontWeight: flyternFontWeightBold)),
                      ),
                    ),
                    Visibility(
                      visible: packageBookingController
                              .packageDetails.value.notIncluded !=
                          "",
                      child: Container(
                          padding: flyternLargePaddingAll.copyWith(
                              left: flyternSpaceMedium,
                              right: flyternSpaceMedium),
                          width: screenwidth,
                          color: flyternBackgroundWhite,
                          child: Html(
                            data: packageBookingController
                                .packageDetails.value.notIncluded,
                          )),
                    ),
                    Visibility(
                      visible: packageBookingController
                              .packageDetails.value.termsConditions !=
                          "",
                      child: Padding(
                        padding: flyternLargePaddingAll,
                        child: Text("terms_n_conditions".tr,
                            style: getBodyMediumStyle(context).copyWith(
                                color: flyternGrey80,
                                fontWeight: flyternFontWeightBold)),
                      ),
                    ),
                    Visibility(
                      visible: packageBookingController
                              .packageDetails.value.termsConditions !=
                          "",
                      child: Container(
                          padding: flyternLargePaddingAll.copyWith(
                              left: flyternSpaceMedium,
                              right: flyternSpaceMedium),
                          width: screenwidth,
                          color: flyternBackgroundWhite,
                          child: Html(
                            data: packageBookingController
                                .packageDetails.value.termsConditions,
                          )),
                    ),
                    Container(
                      height: 70 + (flyternSpaceSmall * 2),
                      padding: flyternLargePaddingAll,
                    )
                  ],
                ),
              ),
              Visibility(
                  visible: packageBookingController.isDetailsDataLoading.value,
                  child: Center(
                      child: LoadingAnimationWidget.prograssiveDots(
                    color: flyternSecondaryColor,
                    size: 50,
                  )))
            ],
          ),
        ),
        bottomSheet: !packageBookingController.isDetailsDataLoading.value
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
                            Expanded(
                              child: Text(
                                "${packageBookingController.packageDetails.value.currency} "
                                "${packageBookingController.packageDetails.value.price.toStringAsFixed(3)}",
                              ),
                            ),
                            Text("select".tr),
                            addHorizontalSpace(flyternSpaceSmall),
                            Icon(
                                Localizations.localeOf(context)
                                            .languageCode
                                            .toString() ==
                                        'ar'
                                    ? Ionicons.chevron_back
                                    : Ionicons.chevron_forward,
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

  getSelectedImageUrl() {
    if (packageBookingController.packageDetails.value.subImages.isEmpty) {
      return "";
    }

    return packageBookingController.packageDetails.value
        .subImages[packageBookingController.selectedImageIndex.value];
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
          return ContactDetailsGetter(route: Approute_packagesConfirmation);
        });
  }

  String getFormattedDate(DateTime dateTime) {
    final f = DateFormat('E, dd-MMM yy');
    return f.format(dateTime);
  }
}
