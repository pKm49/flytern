import 'package:flutter/material.dart';
import 'package:flytern/feature-modules/activity_booking/ui/components/list_card.activity_booking.component.dart';
import 'package:flytern/feature-modules/flight_booking/ui/components/flight_airport_lable_card.dart';
import 'package:flytern/feature-modules/flight_booking/ui/components/flight_booking_summary_card.dart';
import 'package:flytern/feature-modules/package_booking/controllers/package_booking_controller.dart';
import 'package:flytern/shared-module/ui/components/data_capsule_card.shared.component.dart';
import 'package:flytern/shared-module/ui/components/user_details_card.shared.component.dart';
import 'package:flytern/feature-modules/hotel_booking/ui/components/hote_search_result_card.dart';
import 'package:flytern/shared-module/constants/app_specific/route_names.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/asset_urls.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/style_params.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/widget_styles.shared.constant.dart';
import 'package:flytern/shared-module/services/utility-services/widget_generator.shared.service.dart';
import 'package:flytern/shared-module/services/utility-services/widget_properties_generator.shared.service.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class PackageBookingConfirmationPage extends StatefulWidget {
  const PackageBookingConfirmationPage({super.key});

  @override
  State<PackageBookingConfirmationPage> createState() => _PackageBookingConfirmationPageState();
}

class _PackageBookingConfirmationPageState extends State<PackageBookingConfirmationPage> {

  final packageBookingController = Get.find<PackageBookingController>();
  String mobileCntry = "";
  String mobileNumber = "";
  String email = "";
  dynamic argumentData = Get.arguments;

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    mobileCntry = argumentData[0]['mobileCntry'];
    mobileNumber = argumentData[0]['mobileNumber'];
    email = argumentData[0]['email'];

    saveData();
  }

  @override
  Widget build(BuildContext context) {

    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Obx(
      ()=> Scaffold(
        appBar: AppBar(
          title: Text('confirmation'.tr),
          elevation: 0.5,
        ),
        body: Stack(
          children: [
            Visibility(
              visible: !packageBookingController.isSaveContactLoading.value,

              child: Container(
                width: screenwidth,
                height: screenheight,
                color: flyternGrey10,
                child: ListView(
                  children: [

                    Container(
                      width: screenwidth,
                      height: screenwidth*.6,
                      child: Center(
                        child: Column(
                          children: [
                            Icon(Ionicons.checkmark_circle_outline,size: screenwidth*.4,color: flyternGuideGreen),
                            Padding(
                              padding: EdgeInsets.only(top: flyternSpaceLarge),
                              child: Text(
                                  packageBookingController.bookingRef.value !=""?
                                  "success".tr:"failed".tr,
                                  textAlign: TextAlign.center,
                                  style: getHeadlineLargeStyle(context).copyWith(
                                      color: flyternGuideGreen, fontWeight: flyternFontWeightBold)),
                            ),
                          ],
                        ),
                      ),
                    ),

                    addVerticalSpace(flyternSpaceLarge),

                    Container(
                      padding: flyternLargePaddingHorizontal.copyWith(
                          top: flyternSpaceLarge,bottom: flyternSpaceLarge),
                      color: flyternBackgroundWhite,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("reference_id".tr,style: getBodyMediumStyle(context).copyWith(color: flyternGrey60)),
                          Text(packageBookingController.bookingRef.value,style: getBodyMediumStyle(context).copyWith(color: flyternGrey80)),
                        ],
                      ),
                    ),

                    Container(
                      padding: flyternLargePaddingHorizontal.copyWith(top: flyternSpaceSmall,bottom: flyternSpaceLarge),
                      color: flyternBackgroundWhite,
                      child: DataCapsuleCard(
                        label: packageBookingController.bookingRef.value !=""?
                        "enquiry_success_message".tr
                        : "something_went_wrong".tr,
                        theme:packageBookingController.bookingRef.value !=""?1: 2,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Visibility(
                visible:  packageBookingController.isSaveContactLoading.value,
                child: Center(
                    child: LoadingAnimationWidget.prograssiveDots(
                      color: flyternSecondaryColor,
                      size: 50,
                    )
                ))
          ],
        ),
        bottomSheet:packageBookingController.isSaveContactLoading.value?
        Container(
          width: screenwidth,
          height: 10,
        ):
        Container(
          width: screenwidth,
          color: flyternBackgroundWhite,
          height: 60+(flyternSpaceSmall*2),
          padding: flyternLargePaddingAll.copyWith(top: flyternSpaceSmall,bottom: flyternSpaceSmall),
          child: Center(
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(style: getElevatedButtonStyle(context),
                  onPressed: () {
                packageBookingController.resetAndNavigateToHome();
                  },
                  child:Text("continue".tr )),
            ),
          ),
        ),
      ),
    );
  }

  void saveData() {
    packageBookingController.saveContactInfo(mobileCntry, mobileNumber, email);
  }
}
