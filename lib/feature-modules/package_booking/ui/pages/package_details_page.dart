import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flytern/feature-modules/flight_booking/ui/components/flight_details_itinerary_card.dart';
import 'package:flytern/feature-modules/hotel_booking/ui/components/hote_search_result_card.dart';
import 'package:flytern/feature-modules/package_booking/controllers/package_booking_controller.dart';
import 'package:flytern/feature-modules/package_booking/ui/components/package_list_card.dart';
import 'package:flytern/shared/data/constants/app_specific/app_route_names.dart';
import 'package:flytern/shared/data/constants/ui_constants/asset_urls.dart';
import 'package:flytern/shared/data/constants/ui_constants/style_params.dart';
import 'package:flytern/shared/data/constants/ui_constants/widget_styles.dart';
import 'package:flytern/shared/services/utility-services/widget_generator.dart';
import 'package:flytern/shared/services/utility-services/widget_properties_generator.dart';
import 'package:flytern/shared/ui/components/contact_details_getter.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class PackageDetailsPage extends StatefulWidget {
  const PackageDetailsPage({super.key});

  @override
  State<PackageDetailsPage> createState() => _PackageDetailsPageState();
}

class _PackageDetailsPageState extends State<PackageDetailsPage> {

  final packageBookingController = Get.find<PackageBookingController>();

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
          child: ListView(
            children: [
              Image.network(packageBookingController.packageDetails.value.headerimage,
                  width: screenwidth ,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(ASSETS_PACKAGE_1_SAMPLE,width: screenwidth  );
                  }),
              Padding(
                padding: flyternLargePaddingAll,
                child: Text("flight_details".tr,
                    style: getBodyMediumStyle(context).copyWith(
                        color: flyternGrey80, fontWeight: flyternFontWeightBold)),
              ),
              FlightDetailsItineraryCard(),
              addVerticalSpace(flyternSpaceLarge),
              Padding(
                padding: flyternLargePaddingAll,
                child: Text("hotel_details".tr,
                    style: getBodyMediumStyle(context).copyWith(
                        color: flyternGrey80, fontWeight: flyternFontWeightBold)),
              ),
              Container(
                  padding: flyternLargePaddingVertical,
                  color: flyternBackgroundWhite,
                  child: HotelSearchResultCard()),

              Padding(
                padding: flyternLargePaddingAll,
                child: Text("insurance".tr,
                    style: getBodyMediumStyle(context).copyWith(
                        color: flyternGrey80, fontWeight: flyternFontWeightBold)),
              ),

              Container(
                padding: flyternLargePaddingHorizontal.copyWith(top: flyternSpaceLarge,bottom: flyternSpaceSmall),
                color: flyternBackgroundWhite,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("policy".tr,style: getBodyMediumStyle(context).copyWith(color: flyternGrey60)),
                    Text("COVID-19",style: getBodyMediumStyle(context).copyWith(color: flyternGrey80)),
                  ],
                ),
              ),
              Container(
                  padding: flyternLargePaddingHorizontal,
                  color:flyternBackgroundWhite,
                  child: Divider()),
              Container(
                padding: flyternLargePaddingHorizontal.copyWith(top: flyternSpaceSmall,bottom: flyternSpaceSmall),
                color: flyternBackgroundWhite,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("policy_type".tr,style: getBodyMediumStyle(context).copyWith(color: flyternGrey60)),
                    Text("Individual",style: getBodyMediumStyle(context).copyWith(color: flyternGrey80)),
                  ],
                ),
              ),
              Container(
                  padding: flyternLargePaddingHorizontal,
                  color:flyternBackgroundWhite,
                  child: Divider()),
              Container(
                padding: flyternLargePaddingHorizontal.copyWith(top: flyternSpaceSmall,bottom: flyternSpaceSmall),
                color: flyternBackgroundWhite,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("policy_plan".tr,style: getBodyMediumStyle(context).copyWith(color: flyternGrey60)),
                    Text("Silver",style: getBodyMediumStyle(context).copyWith(color: flyternGrey80)),
                  ],
                ),
              ),
              Container(
                  padding: flyternLargePaddingHorizontal,
                  color:flyternBackgroundWhite,
                  child: Divider()),
              Container(
                padding: flyternLargePaddingHorizontal.copyWith(top: flyternSpaceSmall,bottom: flyternSpaceSmall),
                color: flyternBackgroundWhite,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("policy_period".tr,style: getBodyMediumStyle(context).copyWith(color: flyternGrey60)),
                    Text("One Week",style: getBodyMediumStyle(context).copyWith(color: flyternGrey80)),
                  ],
                ),
              ),
              Container(
                  padding: flyternLargePaddingHorizontal,
                  color:flyternBackgroundWhite,
                  child: Divider()),
              Container(
                padding: flyternLargePaddingHorizontal.copyWith(top: flyternSpaceSmall,bottom: flyternSpaceLarge),
                color: flyternBackgroundWhite,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("policy_start_date".tr,style: getBodyMediumStyle(context).copyWith(color: flyternGrey60)),
                    Text("18 Apr 23",style: getBodyMediumStyle(context).copyWith(color: flyternGrey80)),
                  ],
                ),
              ),

              Padding(
                padding: flyternLargePaddingAll,
                child: Text("hotel_views".tr,
                    style: getBodyMediumStyle(context).copyWith(
                        color: flyternGrey80, fontWeight: flyternFontWeightBold)),
              ),
              Container(
                padding: flyternLargePaddingAll,
                width: screenwidth,
                height: screenwidth*.2 +(flyternSpaceLarge*2),
                color: flyternBackgroundWhite,
                child:  ListView(
                  scrollDirection: Axis.horizontal,
                  children: [

                    Container(
                        decoration: BoxDecoration(
                          borderRadius:
                          BorderRadius.circular(flyternBorderRadiusExtraSmall),

                        ),
                        clipBehavior: Clip.hardEdge,
                        width: screenwidth*.2,
                        child:  Image.asset(ASSETS_HOTEL_1_SAMPLE,width: screenwidth*.2)),
                    addHorizontalSpace(flyternSpaceMedium),
                    Container(
                        decoration: BoxDecoration(
                          borderRadius:
                          BorderRadius.circular(flyternBorderRadiusExtraSmall),

                        ),
                        clipBehavior: Clip.hardEdge,
                        width: screenwidth*.2,
                        child:  Image.asset(ASSETS_HOTEL_2_SAMPLE,width: screenwidth*.2)),

                    addHorizontalSpace(flyternSpaceMedium),
                    Container(
                        decoration: BoxDecoration(
                          borderRadius:
                          BorderRadius.circular(flyternBorderRadiusExtraSmall),

                        ),
                        clipBehavior: Clip.hardEdge,
                        width: screenwidth*.2,
                        child:  Image.asset(ASSETS_HOTEL_3_SAMPLE,width: screenwidth*.2)),
                    addHorizontalSpace(flyternSpaceMedium),
                    Container(
                        decoration: BoxDecoration(
                          borderRadius:
                          BorderRadius.circular(flyternBorderRadiusExtraSmall),

                        ),
                        clipBehavior: Clip.hardEdge,
                        width: screenwidth*.2,
                        child:  Image.asset(ASSETS_HOTEL_1_SAMPLE,width: screenwidth*.2)),
                    addHorizontalSpace(flyternSpaceMedium),
                    Container(
                        decoration: BoxDecoration(
                          borderRadius:
                          BorderRadius.circular(flyternBorderRadiusExtraSmall),

                        ),
                        clipBehavior: Clip.hardEdge,
                        width: screenwidth*.2,
                        child:  Image.asset(ASSETS_HOTEL_2_SAMPLE,width: screenwidth*.2)),

                  ],
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
                  padding: flyternLargePaddingAll,
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
                    padding: flyternLargePaddingAll,
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
                    padding: flyternLargePaddingAll,
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
        bottomSheet: Container(
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
                      Icon(Ionicons.chevron_forward,size: flyternFontSize20,)
                    ],
                  )) ,
            ),
          ),
        ),
      ),
    );
  }

  void openContactDetailsGetterBottomSheet( ) {
    showModalBottomSheet(
        useSafeArea: false,
        shape:   RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(flyternBorderRadiusSmall),
              topRight: Radius.circular(flyternBorderRadiusSmall)),
        ),
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return ContactDetailsGetter(route: Approute_packagesUserDetailsSubmission);
        });
  }
}
