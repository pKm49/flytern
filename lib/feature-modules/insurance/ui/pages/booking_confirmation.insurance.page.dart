import 'package:flutter/material.dart';
   import 'package:flytern/feature-modules/insurance/controllers/insurance.controller.dart';
import 'package:flytern/shared-module/services/booking_info_helper.dart';
import 'package:flytern/shared-module/ui/components/data_capsule_card.shared.component.dart'; 
import 'package:flytern/shared-module/constants/ui_specific/style_params.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/widget_styles.shared.constant.dart';
import 'package:flytern/shared-module/services/utility-services/widget_generator.shared.service.dart';
import 'package:flytern/shared-module/services/utility-services/widget_properties_generator.shared.service.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class InsuranceBookingConfirmationPage extends StatefulWidget {
  const InsuranceBookingConfirmationPage({super.key});

  @override
  State<InsuranceBookingConfirmationPage> createState() => _InsuranceBookingConfirmationPageState();
}

class _InsuranceBookingConfirmationPageState extends State<InsuranceBookingConfirmationPage> {

  final insuranceBookingController = Get.find<InsuranceBookingController>();

  String mode = "view";
  dynamic argumentData = Get.arguments;

  @override
  void initState() {
    // TODO: implement initState
    mode = argumentData[0]['mode'];
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {

    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return WillPopScope(
      onWillPop: () async {
        if (mode == "view") {
          return false;
        } else {
          return true;
        }
      },
      child: Obx(
          ()=> Scaffold(
            appBar: AppBar(
                title: Padding(
                  padding: EdgeInsets.only(
                      left: (mode == "edit" ? 0 : (flyternSpaceLarge))),
                  child: Text(mode == "view"
                      ? 'booking_confirmation'.tr
                      : 'booking_details'.tr),
                ),
                elevation: 0.5,
                automaticallyImplyLeading: mode == "edit" ? true : false),
          body: Stack(
            children: [
              Visibility(
                  visible: insuranceBookingController
                      .isInsuranceConfirmationDataLoading.value,
                  child: Container(
                    width: screenwidth,
                    height: screenheight * .8,
                    color: flyternGrey10,
                    child: Center(
                        child: LoadingAnimationWidget.prograssiveDots(
                          color: flyternSecondaryColor,
                          size: 50,
                        )),
                  )),

              Visibility(
                visible: !insuranceBookingController
                    .isInsuranceConfirmationDataLoading.value,
                child: Container(
                  width: screenwidth,
                  height: screenheight,
                  color: flyternGrey10,
                  child: ListView(
                    children: [

                      Visibility(
                        visible:insuranceBookingController.alert.isEmpty
                             &&
                            getBookingInfoGroupLength(
                                insuranceBookingController.bookingInfo)==
                                0  ,
                        child: Container(
                          padding: flyternMediumPaddingAll,
                          margin: flyternLargePaddingAll.copyWith(
                              bottom: flyternSpaceMedium),
                          decoration: BoxDecoration(
                            color: flyternPrimaryColorBg,
                            borderRadius: BorderRadius.circular(
                                flyternBorderRadiusExtraSmall),
                          ),
                          child: Text("couldnt_find_booking".tr),
                        ),
                      ),


                      addVerticalSpace(flyternSpaceLarge),
                      Visibility(
                          visible: mode == "view",
                          child: addVerticalSpace(flyternSpaceLarge)),
                      Visibility(
                        visible: mode == "view",
                        child: Text(
                            getPaymentInfo(insuranceBookingController.paymentInfo,
                                "ThankyouMsg"),
                            textAlign: TextAlign.center,
                            style: getHeadlineLargeStyle(context).copyWith(
                                color: flyternGuideGreen,
                                fontWeight: flyternFontWeightBold)),
                      ),
                      Visibility(
                        visible: mode == "view",
                        child: Image.network(
                          getPaymentInfo(insuranceBookingController.paymentInfo,
                              "ConfirmIcon"),
                          width: screenwidth * .4,
                          height: screenwidth * .4,
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(Ionicons.checkmark_circle_outline,
                                size: screenwidth * .4,
                                color: flyternGuideGreen);
                          },
                        ),
                      ),
                      Visibility(
                        visible: mode == "view",
                        child: Text(
                            getPaymentInfo(insuranceBookingController.paymentInfo,
                                "ConfirmMsg"),
                            textAlign: TextAlign.center,
                            style: getHeadlineLargeStyle(context).copyWith(
                                color: flyternGuideGreen,
                                fontWeight: flyternFontWeightBold)),
                      ),
                      Visibility(
                          visible: mode == "view",
                          child: addVerticalSpace(flyternSpaceLarge * 2)),
                      Container(
                        padding: flyternLargePaddingHorizontal.copyWith(top: flyternSpaceLarge,bottom: flyternSpaceSmall),
                        color: flyternBackgroundWhite,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(getPaymentTitle(insuranceBookingController.paymentInfo, "BookingID"),style: getBodyMediumStyle(context).copyWith(color: flyternGrey60)),
                            Text(getPaymentInfo(insuranceBookingController.paymentInfo,"BookingID"),
                                style: getBodyMediumStyle(context).copyWith(
                                    fontWeight: flyternFontWeightRegular)),
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
                            Text(getPaymentTitle(insuranceBookingController.paymentInfo, "PaymentStatus"),style: getBodyMediumStyle(context).copyWith(color: flyternGrey60)),
                            Text(getPaymentInfo(insuranceBookingController.paymentInfo,"PaymentStatus"),
                                style: getBodyMediumStyle(context).copyWith(
                                    fontWeight: flyternFontWeightRegular)),
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
                            Text(getPaymentTitle(insuranceBookingController.paymentInfo, "PaymentMethod"),style: getBodyMediumStyle(context).copyWith(color: flyternGrey60)),
                            Expanded(child: Container()),
                            Container(
                                decoration:
                                flyternBorderedContainerSmallDecoration,
                                clipBehavior: Clip.hardEdge,
                                width: screenwidth * .1,
                                height: screenwidth * .1,
                                child: Center(
                                    child: Image.network(
                                      getPaymentInfo(insuranceBookingController.paymentInfo,"PaymentMethodIcon"),
                                      width: screenwidth * .08,
                                      height: screenwidth * .08,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return Container(
                                            width: screenwidth * .08,
                                            height: screenwidth * .08);
                                      },
                                    ))),
                            addHorizontalSpace(flyternSpaceMedium),
                            Text(getPaymentInfo(insuranceBookingController.paymentInfo,"PaymentMethod"),
                                style: getBodyMediumStyle(context).copyWith(
                                    fontWeight: flyternFontWeightRegular)),
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
                            Text(getPaymentTitle(insuranceBookingController.paymentInfo, "FinalBookingAmount"),style: getBodyMediumStyle(context).copyWith(color: flyternGrey60)),

                            Text(getPaymentInfo(insuranceBookingController.paymentInfo,"FinalBookingAmount"),
                                style: getBodyMediumStyle(context).copyWith(
                                    fontWeight: flyternFontWeightRegular)),
                          ],
                        ),
                      ),
                      Visibility(
                        visible: insuranceBookingController.isIssued.value,
                        child: InkWell(
                          onTap: (){
                            _launchUrl(insuranceBookingController.pdfLink.value);
                          },
                          child: Container(
                            padding: flyternLargePaddingHorizontal.copyWith(top: flyternSpaceSmall,bottom: flyternSpaceLarge),
                            color: flyternBackgroundWhite,
                            child:  Text("get_eticket_insurance".tr,
                                style: getBodyMediumStyle(context).copyWith(
                                    decoration: TextDecoration.underline,
                                    color: flyternTertiaryColor)),
                          ),
                        ),
                      ),

                      
                      for (var i = 0;
                      i < insuranceBookingController.alert.length;
                      i++)
                        Container(
                          padding: flyternLargePaddingAll.copyWith(bottom: 0),
                          child: DataCapsuleCard(
                            label: insuranceBookingController.alert[i],
                            theme: 1,
                          ),
                        ),

                      for (var i = 0;
                      i <
                          getBookingInfoGroupLength(
                              insuranceBookingController.bookingInfo);
                      i++)
                        Wrap(
                          children: [
                            Padding(
                              padding: flyternLargePaddingAll,
                              child: Text(
                                  getBookingInfoGroupName(
                                      insuranceBookingController.bookingInfo, i),
                                  style: getBodyMediumStyle(context).copyWith(
                                      color: flyternGrey80,
                                      fontWeight: flyternFontWeightBold)),
                            ),
                            Container(
                              child: Wrap(
                                children: [
                                  for (var ind = 0;
                                  ind <
                                      getBookingInfoGroupSize(
                                          insuranceBookingController
                                              .bookingInfo,
                                          i);
                                  ind++)
                                    getBookingInfoTitle(
                                        insuranceBookingController
                                            .bookingInfo,
                                        i,
                                        ind) !=
                                        "DIVIDER"
                                        ? Container(
                                      padding: flyternLargePaddingHorizontal.copyWith(
                                          top: ind == 0
                                              ? flyternSpaceLarge
                                              : flyternSpaceMedium,
                                          bottom: ind ==
                                              getBookingInfoGroupSize(
                                                  insuranceBookingController
                                                      .bookingInfo,
                                                  i) -
                                                  1
                                              ? flyternSpaceLarge
                                              : flyternSpaceMedium),
                                      decoration: BoxDecoration(
                                          color: flyternBackgroundWhite,
                                          border: Border(
                                            bottom: BorderSide(
                                              color: ind ==
                                                  getBookingInfoGroupSize(
                                                      insuranceBookingController
                                                          .bookingInfo,
                                                      i) -
                                                      1
                                                  ? Colors.transparent
                                                  : flyternGrey20,
                                              width: 0.5,
                                            ),
                                          )),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment
                                            .spaceBetween,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              getBookingInfoTitle(
                                                  insuranceBookingController
                                                      .bookingInfo,
                                                  i,
                                                  ind),
                                              style: getBodyMediumStyle(
                                                  context)
                                                  .copyWith(
                                                  color:
                                                  flyternGrey60)),
                                          addHorizontalSpace(
                                              flyternSpaceLarge),
                                          Expanded(
                                            child: Text(
                                                getBookingInfoValue(
                                                    insuranceBookingController
                                                        .bookingInfo,
                                                    i,
                                                    ind),
                                                maxLines: 2,
                                                textAlign: TextAlign.end,
                                                style: getBodyMediumStyle(
                                                    context)
                                                    .copyWith(
                                                    color:
                                                    flyternGrey80)),
                                          ),
                                        ],
                                      ),
                                    )
                                        : ind !=
                                        getBookingInfoGroupSize(
                                            insuranceBookingController
                                                .bookingInfo,
                                            i) -
                                            1
                                        ? Container(
                                        color: flyternBackgroundWhite,
                                        child: const Divider(
                                            color: flyternTertiaryColor,
                                            height: 3, thickness: 1))
                                        : Container(),
                                ],
                              ),
                            )
                          ],
                        ),

                      Container(
                        height: 70 + (flyternSpaceSmall * 2),
                        padding: flyternLargePaddingAll,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          bottomSheet: mode == "edit"
              ? Container(
            width: screenwidth,
            height: 0,
          )
              :  Container(
            width: screenwidth,
            color: flyternBackgroundWhite,
            height: 60+(flyternSpaceSmall*2),
            padding: flyternLargePaddingAll.copyWith(top: flyternSpaceSmall,bottom: flyternSpaceSmall),
            child: Center(
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(style: getElevatedButtonStyle(context),
                    onPressed: () {
                      mode == "edit"
                          ? Navigator.pop(context)
                          : insuranceBookingController
                          .resetAndNavigateToHome();
                    },
                    child:Text( "continue".tr )),
              ),
            ),
          ),
        ),
      ),
    );
  }

  getAge(DateTime dateOfBirth) {
    return "${DateTime.now().year - dateOfBirth.year} years";
  }

  Future<void> _launchUrl(String urlString) async {
    final Uri _url = Uri.parse(urlString);

    if (!await launchUrl(_url)) {
     }
  }

  String getFormattedDOB(DateTime dateOfBirth) {
    final f = DateFormat.yMMMMd('en_US');
    return f.format(dateOfBirth);
  }

}
