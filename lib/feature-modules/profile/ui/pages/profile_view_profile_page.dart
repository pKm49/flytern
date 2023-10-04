import 'package:flutter/material.dart';
import 'package:flytern/shared/data/constants/app_specific/app_route_names.dart';
import 'package:flytern/shared/data/constants/ui_constants/asset_urls.dart';
import 'package:flytern/shared/data/constants/ui_constants/style_params.dart';
import 'package:flytern/shared/data/constants/ui_constants/widget_styles.dart';
import 'package:flytern/shared/services/utility-services/widget_generator.dart';
import 'package:flytern/shared/services/utility-services/widget_properties_generator.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class ProfileViewProfilePage extends StatefulWidget {
  const ProfileViewProfilePage({super.key});

  @override
  State<ProfileViewProfilePage> createState() => _ProfileViewProfilePageState();
}

class _ProfileViewProfilePageState extends State<ProfileViewProfilePage> {
  @override
  Widget build(BuildContext context) {

    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text("my_profile".tr),
        elevation: 0.5,
        actions: [
          InkWell(
              onTap: (){
                Get.toNamed(Approute_profileEditProfile);
              },
              child: Icon(Ionicons.create_outline)),
          addHorizontalSpace(flyternSpaceMedium)
        ],
      ),
      body: Container(
        width: screenwidth,
        height: screenheight,
        color: flyternGrey10,
        child: ListView(
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

                    ],
                  ))
                ],
              ),
            ),
            Container(
              padding: flyternLargePaddingHorizontal.copyWith(top: flyternSpaceLarge,bottom: flyternSpaceMedium),
              color: flyternBackgroundWhite,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("full_name".tr,style: getBodyMediumStyle(context).copyWith(color: flyternGrey60)),
                  Text("Andrew Martin",style: getBodyMediumStyle(context).copyWith(color: flyternGrey80)),
                ],
              ),
            ),
            Container(
                padding: flyternLargePaddingHorizontal,
                color:flyternBackgroundWhite,
                child: Divider()),
            Container(
              padding: flyternLargePaddingHorizontal.copyWith(top: flyternSpaceMedium,bottom: flyternSpaceMedium),
              color: flyternBackgroundWhite,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("email_address".tr,style: getBodyMediumStyle(context).copyWith(color: flyternGrey60)),
                  Text("andrewmartin@gmail.com",style: getBodyMediumStyle(context).copyWith(color: flyternGrey80)),
                ],
              ),
            ),
            Container(
                padding: flyternLargePaddingHorizontal,
                color:flyternBackgroundWhite,
                child: Divider()),
            Container(
              padding: flyternLargePaddingHorizontal.copyWith(top: flyternSpaceMedium,bottom: flyternSpaceMedium),
              color: flyternBackgroundWhite,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("mobile_number".tr,style: getBodyMediumStyle(context).copyWith(color: flyternGrey60)),
                  Text("+92 321 232 2134",style: getBodyMediumStyle(context).copyWith(color: flyternGrey80)),
                ],
              ),
            ),
            Container(
                padding: flyternLargePaddingHorizontal,
                color:flyternBackgroundWhite,
                child: Divider()),
            Container(
              padding: flyternLargePaddingHorizontal.copyWith(top: flyternSpaceMedium,bottom: flyternSpaceMedium),
              color: flyternBackgroundWhite,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("dob".tr,style: getBodyMediumStyle(context).copyWith(color: flyternGrey60)),
                  Text("July 27, 1995",style: getBodyMediumStyle(context).copyWith(color: flyternGrey80)),
                ],
              ),
            ),
            Container(
                padding: flyternLargePaddingHorizontal,
                color:flyternBackgroundWhite,
                child: Divider()),
            Container(
              padding: flyternLargePaddingHorizontal.copyWith(top: flyternSpaceMedium,bottom: flyternSpaceMedium),
              color: flyternBackgroundWhite,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("passport_no".tr,style: getBodyMediumStyle(context).copyWith(color: flyternGrey60)),
                  Text("AMH321 232 2134",style: getBodyMediumStyle(context).copyWith(color: flyternGrey80)),
                ],
              ),
            ),
            Container(
                padding: flyternLargePaddingHorizontal,
                color:flyternBackgroundWhite,
                child: Divider()),
            Container(
              padding: flyternLargePaddingHorizontal.copyWith(top: flyternSpaceMedium,bottom: flyternSpaceMedium),
              color: flyternBackgroundWhite,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("passport_expiry".tr,style: getBodyMediumStyle(context).copyWith(color: flyternGrey60)),
                  Text("Aug 21, 2026",style: getBodyMediumStyle(context).copyWith(color: flyternGrey80)),
                ],
              ),
            ),
            Container(
                padding: flyternLargePaddingHorizontal,
                color:flyternBackgroundWhite,
                child: Divider()),
            Container(
              padding: flyternLargePaddingHorizontal.copyWith(top: flyternSpaceMedium,bottom: flyternSpaceLarge),
              color: flyternBackgroundWhite,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("passport_issuer_country".tr,style: getBodyMediumStyle(context).copyWith(color: flyternGrey60)),
                  Text("India",style: getBodyMediumStyle(context).copyWith(color: flyternGrey80)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
