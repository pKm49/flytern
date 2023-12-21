import 'package:flutter/material.dart';
import 'package:flytern/feature-modules/profile/controllers/profile.controller.dart';
import 'package:flytern/shared-module/constants/app_specific/route_names.shared.constant.dart';
import 'package:flytern/shared-module/constants/app_specific/default_values.shared.constant.dart';
 import 'package:flytern/shared-module/constants/ui_specific/style_params.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/widget_styles.shared.constant.dart';
import 'package:flytern/shared-module/services/utility-services/widget_generator.shared.service.dart';
import 'package:flytern/shared-module/services/utility-services/widget_properties_generator.shared.service.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';

class ProfileViewProfilePage extends StatefulWidget {
  const ProfileViewProfilePage({super.key});

  @override
  State<ProfileViewProfilePage> createState() => _ProfileViewProfilePageState();
}

class _ProfileViewProfilePageState extends State<ProfileViewProfilePage> {

  final profileController = Get.find<ProfileController>();

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
      body: Obx(
        ()=> Container(
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
                      child: profileController.userDetails.value.imgUrl !=""?
                      Image.network(profileController.userDetails.value.imgUrl,
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(Ionicons.person_circle,size: screenwidth*.2);
                        },)
                          :Icon(Ionicons.person_circle,size: screenwidth*.2),
                    ),
                    addHorizontalSpace(flyternSpaceMedium),
                    Expanded(child:
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${profileController.userDetails.value.firstName} ${profileController.userDetails.value.lastName}",style: getHeadlineMediumStyle(context).copyWith(  color: flyternGrey80),),

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
                    Text("${profileController.userDetails.value.firstName} ${profileController.userDetails.value.lastName}",style: getBodyMediumStyle(context).copyWith(color: flyternGrey80)),
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
                    Text("${profileController.userDetails.value.email}",style: getBodyMediumStyle(context).copyWith(color: flyternGrey80)),
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
                    Text("${profileController.userDetails.value.phoneCountryCode} ${profileController.userDetails.value.phoneNumber}",style: getBodyMediumStyle(context).copyWith(color: flyternGrey80)),
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
                    Text(getFormattedDOB(profileController.userDetails.value.dateOfBirth),style: getBodyMediumStyle(context).copyWith(color: flyternGrey80)),
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
                    Text(profileController.userDetails.value.passportNumber,style: getBodyMediumStyle(context).copyWith(color: flyternGrey80)),
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
                    Text(
                        profileController.userDetails.value.passportExpiry == DefaultInvalidDate?"":
                        getFormattedDOB(profileController.userDetails.value.passportExpiry),style: getBodyMediumStyle(context).copyWith(color: flyternGrey80)),
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
                    Text(profileController.userDetails.value.passportIssuerCountryName,style: getBodyMediumStyle(context).copyWith(color: flyternGrey80)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String getFormattedDOB(DateTime dateOfBirth) {

    if(( dateOfBirth.day == DefaultInvalidDate.day &&
        dateOfBirth.month == DefaultInvalidDate.month &&
        dateOfBirth.year == DefaultInvalidDate.year )){
      return "";
    }
    final f = DateFormat.yMMMMd('en_US');
    return f.format(dateOfBirth);
  }
}
