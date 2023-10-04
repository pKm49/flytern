import 'package:flutter/material.dart';
import 'package:flytern/shared/data/constants/app_specific/app_route_names.dart';
import 'package:flytern/shared/data/constants/ui_constants/asset_urls.dart';
import 'package:flytern/shared/data/constants/ui_constants/style_params.dart';
import 'package:flytern/shared/data/constants/ui_constants/widget_styles.dart';
import 'package:flytern/shared/services/utility-services/widget_generator.dart';
import 'package:flytern/shared/services/utility-services/widget_properties_generator.dart';
import 'package:flytern/shared/ui/components/preposticon_button.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class ProfileLandingPage extends StatefulWidget {
  const ProfileLandingPage({super.key});

  @override
  State<ProfileLandingPage> createState() => _ProfileLandingPageState();
}

class _ProfileLandingPageState extends State<ProfileLandingPage> {
  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Container(
      height: screenheight,
      width: screenwidth,
      color: flyternGrey10,
      child: Column(
        children: [
          Container(
            width: screenwidth  ,
            padding: flyternLargePaddingAll,
            margin: flyternMediumPaddingVertical,
            decoration: BoxDecoration(
              color: flyternBackgroundWhite,
            ),
            child: Row(
              children: [
                Container(
                  height: screenwidth*.2,
                  width: screenwidth*.2,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(1000),
                  ),
                  child: Image.asset(ASSETS_USER_1_SAMPLE),
                ),
                addHorizontalSpace(flyternSpaceMedium),
                Expanded(child:
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Andrew Martin",style: getHeadlineMediumStyle(context).copyWith(  color: flyternGrey80),),
                    addVerticalSpace(flyternSpaceExtraSmall),
                    Text("martin@gmail.com",style: getLabelLargeStyle(context).copyWith(color: flyternGrey40),),
                    addVerticalSpace(flyternSpaceSmall*1.5),
                    InkWell(
                        onTap: (){
                          Get.toNamed(Approute_profileViewProfile);
                        },
                        child: Text("view_profile".tr,style: getBodyMediumStyle(context).copyWith(color: flyternPrimaryColor,decoration: TextDecoration.underline))),

                  ],
                ))
              ],
            ),
          ),
          Container(
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
                    postIconData: Ionicons.chevron_forward,
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
                    postIconData: Ionicons.chevron_forward,
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
                    postIconData: Ionicons.chevron_forward,
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
                    border: '',
                    buttonTitle: "change_password".tr,
                    preIconData: Ionicons.lock_closed_outline,
                    postIconData: Ionicons.chevron_forward,
                  ),
                ),
                addVerticalSpace(flyternSpaceLarge),
              ],
            ),
          )
        ],
      ),
    );
  }
}
