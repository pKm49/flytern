import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flytern/feature-modules/profile/controllers/profile.controller.dart';
import 'package:flytern/shared-module/constants/app_specific/route_names.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/style_params.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/widget_styles.shared.constant.dart';
import 'package:flytern/shared-module/controllers/shared.controller.dart';
import 'package:flytern/shared-module/services/utility-services/widget_generator.shared.service.dart';
import 'package:flytern/shared-module/services/utility-services/widget_properties_generator.shared.service.dart';
import 'package:flytern/shared-module/ui/components/confirm_dialogue.shared.component.dart';
import 'package:flytern/shared-module/ui/components/preposticon_button.shared.component.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class ProfileLandingPage extends StatefulWidget {
  const ProfileLandingPage({super.key});

  @override
  State<ProfileLandingPage> createState() => _ProfileLandingPageState();
}

class _ProfileLandingPageState extends State<ProfileLandingPage> {
  final profileController = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Container(
      height: screenheight,
      width: screenwidth,
      color: flyternGrey10,
      child: Obx(
        () => ListView(
          children: [
            Visibility(
              visible: profileController.userDetails.value.email != "",
              child: Container(
                width: screenwidth,
                padding: flyternLargePaddingAll,
                margin: flyternMediumPaddingVertical,
                decoration: BoxDecoration(
                  color: flyternBackgroundWhite,
                ),
                child: Row(
                  children: [
                    Container(
                      height: screenwidth * .22,
                      width: screenwidth * .22,
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(1000),
                      ),
                      child: profileController.userDetails.value.imgUrl != ""
                          ? Image.network(
                              profileController.userDetails.value.imgUrl,
                              errorBuilder: (context, error, stackTrace) {
                                return Icon(Ionicons.person_circle,
                                    size: screenwidth * .2);
                              },
                            )
                          : Icon(Ionicons.person_circle,
                              size: screenwidth * .2),
                    ),
                    addHorizontalSpace(flyternSpaceMedium),
                    Expanded(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${profileController.userDetails.value.firstName} ${profileController.userDetails.value.lastName}",
                          style: getHeadlineMediumStyle(context)
                              .copyWith(color: flyternGrey80),
                        ),
                        addVerticalSpace(flyternSpaceExtraSmall),
                        Text(
                          "${profileController.userDetails.value.email}",
                          style: getLabelLargeStyle(context)
                              .copyWith(color: flyternGrey40),
                        ),
                        addVerticalSpace(flyternSpaceSmall * 1.5),
                        InkWell(
                            onTap: () {
                              Get.toNamed(Approute_profileViewProfile);
                            },
                            child: Text("view_profile".tr,
                                style: getBodyMediumStyle(context).copyWith(
                                    color: flyternPrimaryColor,
                                    decoration: TextDecoration.underline))),
                      ],
                    ))
                  ],
                ),
              ),
            ),
            Visibility(
              visible: profileController.userDetails.value.email != "",
              child: Container(
                color: flyternBackgroundWhite,
                padding: flyternLargePaddingHorizontal,
                child: Wrap(
                  children: [
                    addVerticalSpace(flyternSpaceLarge),
                    SizedBox(
                      width: double.infinity,
                      child: PrePostIconButton(
                        specialColor: 0,
                        onPressed: () {
                          Get.toNamed(Approute_profileMyBookings);
                        },
                        theme: 'dark',
                        border: 'bottom',
                        buttonTitle: "my_bookings".tr,
                        preIconData: Ionicons.list_outline,
                        postIconData:Localizations.localeOf(context)
                            .languageCode
                            .toString() ==
                            'ar'? Ionicons.chevron_back :Ionicons.chevron_forward,
                      ),
                    ),
                    addVerticalSpace(flyternSpaceSmall),
                    SizedBox(
                      width: double.infinity,
                      child: PrePostIconButton(
                        specialColor: 0,
                        onPressed: () {
                          Get.toNamed(Approute_profileMyTravelStories);
                        },
                        theme: 'dark',
                        border: 'bottom',
                        buttonTitle: "my_travel_stories".tr,
                        preIconData: Ionicons.reader_outline,
                        postIconData:Localizations.localeOf(context)
                            .languageCode
                            .toString() ==
                            'ar'? Ionicons.chevron_back :Ionicons.chevron_forward,
                      ),
                    ),
                    addVerticalSpace(flyternSpaceSmall),
                    SizedBox(
                      width: double.infinity,
                      child: PrePostIconButton(
                        specialColor: 0,
                        onPressed: () {
                          Get.toNamed(Approute_profileMyCopassenger);
                        },
                        theme: 'dark',
                        border: 'bottom',
                        buttonTitle: "co_passengers".tr,
                        preIconData: Ionicons.people_outline,
                        postIconData:Localizations.localeOf(context)
                            .languageCode
                            .toString() ==
                            'ar'? Ionicons.chevron_back :Ionicons.chevron_forward,
                      ),
                    ),
                    addVerticalSpace(flyternSpaceSmall),
                    SizedBox(
                      width: double.infinity,
                      child: PrePostIconButton(
                        specialColor: 0,
                        onPressed: () {
                          Get.toNamed(Approute_profileEditMobile);
                        },
                        theme: 'dark',
                        border: 'bottom',
                        buttonTitle: "change_mobile".tr,
                        preIconData: Ionicons.call_outline,
                        postIconData:Localizations.localeOf(context)
                            .languageCode
                            .toString() ==
                            'ar'? Ionicons.chevron_back :Ionicons.chevron_forward,
                      ),
                    ),
                    addVerticalSpace(flyternSpaceSmall),
                    SizedBox(
                      width: double.infinity,
                      child: PrePostIconButton(
                        specialColor: 0,
                        onPressed: () {
                          Get.toNamed(Approute_profileEditEmail);
                        },
                        theme: 'dark',
                        border: 'bottom',
                        buttonTitle: "change_email".tr,
                        preIconData: Ionicons.mail_outline,
                        postIconData:Localizations.localeOf(context)
                            .languageCode
                            .toString() ==
                            'ar'? Ionicons.chevron_back :Ionicons.chevron_forward,
                      ),
                    ),
                    addVerticalSpace(flyternSpaceSmall),
                    SizedBox(
                      width: double.infinity,
                      child: PrePostIconButton(
                        specialColor: 0,
                        onPressed: () {
                          Get.toNamed(Approute_profileEditProfile);
                        },
                        theme: 'dark',
                        border: 'bottom',
                        buttonTitle: "edit_profile".tr,
                        preIconData: Ionicons.create_outline,
                        postIconData:Localizations.localeOf(context)
                            .languageCode
                            .toString() ==
                            'ar'? Ionicons.chevron_back :Ionicons.chevron_forward,
                      ),
                    ),
                    addVerticalSpace(flyternSpaceSmall),
                    SizedBox(
                      width: double.infinity,
                      child: PrePostIconButton(
                        specialColor: 0,
                        onPressed: () {
                          Get.toNamed(Approute_profileResetPassword);
                        },
                        theme: 'dark',
                        border: 'bottom',
                        buttonTitle: "change_password".tr,
                        preIconData: Ionicons.lock_closed_outline,
                        postIconData:Localizations.localeOf(context)
                            .languageCode
                            .toString() ==
                            'ar'? Ionicons.chevron_back :Ionicons.chevron_forward,
                      ),
                    ),
                    addVerticalSpace(flyternSpaceSmall),
                    Visibility(
                      visible: profileController.userDetails.value.email != "",
                      child: SizedBox(
                        width: double.infinity,
                        child: PrePostIconButton(
                          specialColor: 1,
                          onPressed: () {
                            showConfirmDialog();
                          },
                          theme: 'dark',
                          border: '',
                          buttonTitle: "logout".tr,
                          preIconData: Ionicons.log_out_outline,
                          postIconData:Localizations.localeOf(context)
                              .languageCode
                              .toString() ==
                              'ar'? Ionicons.chevron_back :Ionicons.chevron_forward,
                        ),
                      ),
                    ),

                  ],
                ),
              ),
            ),
             Visibility(
              visible: profileController.userDetails.value.email != "",
              child: SizedBox(
                width: double.infinity,
                child: Container(
                  color: flyternTertiaryColor,
                  padding: flyternMediumPaddingHorizontal,
                  child: PrePostIconButton(
                    specialColor: 2,
                    onPressed: () {
                      showDeleteConfirmationDialogue();
                    },
                    theme: 'dark',
                    border: '',
                    buttonTitle: "delete_account".tr,
                    preIconData: Ionicons.trash_bin_outline,
                    postIconData:Localizations.localeOf(context)
                        .languageCode
                        .toString() ==
                        'ar'? Ionicons.chevron_back :Ionicons.chevron_forward,
                  ),
                ),
              ),
            ),
            Visibility(
                visible: profileController.userDetails.value.email == "",
                child: Container(
                  padding: flyternLargePaddingAll,
                  color: flyternBackgroundWhite,
                  margin: flyternLargePaddingVertical,
                  height: screenheight * .25,
                  width: screenwidth,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("sign_in_message".tr,
                          style: getHeadlineMediumStyle(context),
                          textAlign: TextAlign.center),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              child: Text("sign_in".tr),
                              onPressed: () async {
                                Get.toNamed(Approute_login, arguments: [true]);
                              },
                              style: getElevatedButtonStyle(context).copyWith(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          flyternSecondaryColor)),
                            ),
                          ),
                          SizedBox(
                            height: flyternSpaceMedium,
                            width: 20,
                          ),
                          Expanded(
                            child: ElevatedButton(
                                style: getElevatedButtonStyle(context),
                                onPressed: () async {
                                  Get.toNamed(Approute_registerPersonalData);
                                },
                                child: Text("create_account".tr)),
                          ),
                        ],
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }

  void showDeleteConfirmationDialogue() async {
    BuildContext context = Get.context!;

    final dialogTitleWidget = Text('account_delete_title'.tr,style: getHeadlineMediumStyle(context).copyWith(color: flyternGrey80,fontWeight: flyternFontWeightBold));
    final dialogTextWidget = Text( 'account_delete_content'.tr,style: getBodyMediumStyle(context),
    );

    final updateButtonTextWidget = Text('yes'.tr);
    final updateButtonCancelTextWidget = Text('no'.tr);

    updateAction() {
      Navigator.pop(context);
       profileController.deleteAccount();
    }

    List<Widget> actions = [

      TextButton(onPressed: (){
        Navigator.pop(context);
      }, child: updateButtonCancelTextWidget),

      Platform.isAndroid
          ?  ElevatedButton(
          onPressed:updateAction,
          style: getElevatedButtonStyle(context).copyWith(padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
              EdgeInsets.symmetric(
                  horizontal: flyternSpaceLarge,
                  vertical: flyternSpaceSmall))),
          child:  updateButtonTextWidget)
          : CupertinoDialogAction(
        onPressed: updateAction,
        child: updateButtonTextWidget,
      ),
    ];

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return WillPopScope(
            child: Platform.isAndroid
                ? AlertDialog(
              title: dialogTitleWidget,
              content: dialogTextWidget,
              actions: actions,
            )
                : CupertinoAlertDialog(
              title: dialogTitleWidget,
              content: dialogTextWidget,
              actions: actions,
            ),
            onWillPop: () => Future.value(false));
      },
    );

  }


  showConfirmDialog() async {
    showDialog(
      context: context,
      builder: (_) => ConfirmDialogue(
          onClick: () async {
            final sharedController = Get.find<SharedController>();
            sharedController.handleLogout();
          },
          titleKey: 'logout'.tr + " ?",
          subtitleKey: 'logout_confirm'.tr),
    );
  }
}
