import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flytern/feature-modules/flight_booking/ui/components/flight_details_itinerary_card.dart';
import 'package:flytern/feature-modules/hotel_booking/ui/components/hote_search_result_card.dart';
import 'package:flytern/feature-modules/package_booking/controllers/package_booking_controller.dart';
import 'package:flytern/feature-modules/package_booking/data/models/package_details.dart';
import 'package:flytern/feature-modules/package_booking/ui/components/package_list_card.dart';
import 'package:flytern/shared-module/constants/app_specific/route_names.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/asset_urls.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/style_params.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/widget_styles.shared.constant.dart';
import 'package:flytern/shared-module/services/utility-services/widget_generator.shared.service.dart';
import 'package:flytern/shared-module/services/utility-services/widget_properties_generator.shared.service.dart';
import 'package:flytern/shared-module/ui/components/contact_details_getter.shared.component.dart';
import 'package:flytern/shared-module/ui/components/custom_media_carousel.shared.component.dart';
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
      ()=> Scaffold(
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
                    CustomMediaCarousel(
                      medias: packageBookingController.packageDetails.value.subImages,
                    ),
                    Container(
                      padding: flyternLargePaddingAll.copyWith(bottom: 0,top: 0),
                      color: flyternBackgroundWhite,
                      child: Text(packageBookingController.packageDetails.value.name,
                          style: getHeadlineMediumStyle(context).copyWith(
                              color: flyternGrey80, fontWeight: flyternFontWeightBold)),
                    ),
                    Container(
                      padding: flyternLargePaddingAll.copyWith(top: flyternSpaceSmall,bottom: flyternSpaceSmall ),
                      color: flyternBackgroundWhite,
                      child: Text(packageBookingController.packageDetails.value.shortDesc,
                          style: getBodyMediumStyle(context).copyWith(
                              color: flyternGrey60 )),
                    ),
                    addVerticalSpace(1),
                    Container(
                      padding: flyternLargePaddingAll.copyWith(top: flyternSpaceMedium,bottom: flyternSpaceMedium),
                      color: flyternBackgroundWhite,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("${packageBookingController.packageDetails.value.currency} ${
                              packageBookingController.packageDetails.value.price}",style: getBodyMediumStyle(context).copyWith(fontWeight: flyternFontWeightBold, color: flyternSecondaryColor),),
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
                                    packageBookingController.packageDetails.value.ratings ,
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
                              color: flyternGrey80, fontWeight: flyternFontWeightBold)),
                    ),
                    Container(
                      padding: flyternLargePaddingAll,
                      color: flyternBackgroundWhite,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(Ionicons.calendar_clear_outline,color: flyternGrey60),
                          addHorizontalSpace(flyternSpaceMedium),
                          Text("${getFormattedDate(packageBookingController.packageDetails.value.validFrom)} - "
                              "${getFormattedDate(packageBookingController.packageDetails.value.validTo)} ",style: getBodyMediumStyle(context).copyWith(color: flyternGrey80)),
                        ],
                      ),
                    ),

                    Padding(
                      padding: flyternLargePaddingAll,
                      child: Text("flight_hotel_details".tr,
                          style: getBodyMediumStyle(context).copyWith(
                              color: flyternGrey80, fontWeight: flyternFontWeightBold)),
                    ),
                    Container(
                      padding: flyternLargePaddingHorizontal.copyWith(top: flyternSpaceLarge,bottom: flyternSpaceSmall),
                      color: flyternBackgroundWhite,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                           Icon(Ionicons.airplane_outline,color: flyternGrey60),
                          addHorizontalSpace(flyternSpaceMedium),
                          Text("${packageBookingController.packageDetails.value.fromTo} "
                              "(${packageBookingController.packageDetails.value.airline})",style: getBodyMediumStyle(context).copyWith(color: flyternGrey80)),
                        ],
                      ),
                    ),
                    Container(
                        padding: flyternLargePaddingHorizontal,
                        color:flyternBackgroundWhite,
                        child: Divider()),
                    Container(
                      padding: flyternLargePaddingAll.copyWith(top: flyternSpaceSmall ),
                      color: flyternBackgroundWhite,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(Ionicons.bed_outline,color: flyternGrey60),
                          addHorizontalSpace(flyternSpaceMedium),
                          Text(packageBookingController.packageDetails.value.hotelName,style: getBodyMediumStyle(context).copyWith(color: flyternGrey80)),
                        ],
                      ),
                    ),

                    Visibility(
                      visible: packageBookingController.packageDetails.value.itinerary.isNotEmpty,
                      child: Padding(
                        padding: flyternLargePaddingAll,
                        child: Text("itinerary".tr,
                            style: getBodyMediumStyle(context).copyWith(
                                color: flyternGrey80, fontWeight: flyternFontWeightBold)),
                      ),
                    ),
                    for(var ind=0;ind<packageBookingController.packageDetails.value.itinerary.length;ind++)
                    Container(
                      padding: flyternLargePaddingHorizontal,
                      decoration: BoxDecoration(
                          color:flyternBackgroundWhite,
                        border: flyternDefaultBorderBottomOnly
                      ),
                      child: Theme(
                        data: ThemeData().copyWith(dividerColor: Colors.transparent),
                        child: ExpansionTile(
                          tilePadding: EdgeInsets.zero,
                          title:   Text(
                            packageBookingController.packageDetails.value.itinerary[ind].displayName,
                            style: getLabelLargeStyle(context).copyWith(fontWeight: flyternFontWeightRegular),
                          ),
                          children: <Widget>[
                            Padding(
                              padding: flyternSmallPaddingVertical,
                              child: Html(
                                data: packageBookingController.packageDetails.value.itinerary[ind].content,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    Visibility(
                      visible: packageBookingController.packageDetails.value.inclusion!="",
                      child: Padding(
                        padding: flyternLargePaddingAll,
                        child: Text("inclusion".tr,
                            style: getBodyMediumStyle(context).copyWith(
                                color: flyternGrey80, fontWeight: flyternFontWeightBold)),
                      ),
                    ),
                    Visibility(
                      visible: packageBookingController.packageDetails.value.inclusion!="",
                      child: Container(
                        padding: flyternLargePaddingAll.copyWith(left: flyternSpaceMedium,right: flyternSpaceMedium),
                        width: screenwidth,
                        color: flyternBackgroundWhite,
                        child:  Html(
                          data: packageBookingController.packageDetails.value.inclusion,
                        )
                      ),
                    ),
                    Visibility(
                      visible: packageBookingController.packageDetails.value.notIncluded!="",
                      child: Padding(
                        padding: flyternLargePaddingAll,
                        child: Text("exclusion".tr,
                            style: getBodyMediumStyle(context).copyWith(
                                color: flyternGrey80, fontWeight: flyternFontWeightBold)),
                      ),
                    ),
                    Visibility(
                      visible: packageBookingController.packageDetails.value.notIncluded!="",
                      child: Container(
                          padding: flyternLargePaddingAll.copyWith(left: flyternSpaceMedium,right: flyternSpaceMedium),
                          width: screenwidth,
                          color: flyternBackgroundWhite,
                          child:   Html(
                            data: packageBookingController.packageDetails.value.notIncluded,
                          )
                      ),
                    ),
                    Visibility(
                      visible: packageBookingController.packageDetails.value.termsConditions!="",
                      child: Padding(
                        padding: flyternLargePaddingAll,
                        child: Text("terms_n_conditions".tr,
                            style: getBodyMediumStyle(context).copyWith(
                                color: flyternGrey80, fontWeight: flyternFontWeightBold)),
                      ),
                    ),
                    Visibility(
                      visible: packageBookingController.packageDetails.value.termsConditions!="",
                      child: Container(
                          padding: flyternLargePaddingAll.copyWith(left: flyternSpaceMedium,right: flyternSpaceMedium),
                          width: screenwidth,
                          color: flyternBackgroundWhite,
                          child:   Html(
                            data: packageBookingController.packageDetails.value.termsConditions,
                          )
                      ),
                    ),
                    Container(
                      height: 70+(flyternSpaceSmall*2),
                      padding: flyternLargePaddingAll,
                    )

                  ],
                ),
              ),
              Visibility(
                  visible:  packageBookingController.isDetailsDataLoading.value,
                  child: Center(
                  child: LoadingAnimationWidget.prograssiveDots(
                    color: flyternSecondaryColor,
                    size: 50,
                  )
              ))
            ],
          ),
        ),
        bottomSheet:!packageBookingController.isDetailsDataLoading.value? Container(
          width: screenwidth,
          color: flyternBackgroundWhite,
          height: 60 + (flyternSpaceSmall * 2),
          padding: flyternLargePaddingAll.copyWith(
              top: flyternSpaceSmall, bottom: flyternSpaceSmall),
          child: Center(
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(style: getElevatedButtonStyle(context),
                  onPressed: () {
                    openContactDetailsGetterBottomSheet();
                  },
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          "${packageBookingController.packageDetails.value.currency} "
                              "${packageBookingController.packageDetails.value.price}",
                        ),
                      ),
                      Text("select".tr),
                      addHorizontalSpace(flyternSpaceSmall),
                      Icon(Ionicons.chevron_forward,size: flyternFontSize20)
                    ],
                  )) ,
            ),
          ),
        ):Container( width: screenwidth, height: 60 + (flyternSpaceSmall * 2)),
      ),
    );
  }

  void openContactDetailsGetterBottomSheet() {
    showModalBottomSheet(
        useSafeArea: false,
        shape:   RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(flyternBorderRadiusSmall),
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
