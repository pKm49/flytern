import 'package:flutter/material.dart';
import 'package:flytern/shared/ui/components/user_details_card.dart';
import 'package:flytern/shared/data/constants/app_specific/app_route_names.dart';
import 'package:flytern/shared/data/constants/ui_constants/style_params.dart';
import 'package:flytern/shared/data/constants/ui_constants/widget_styles.dart';
import 'package:flytern/shared/services/utility-services/widget_properties_generator.dart';
import 'package:get/get.dart';

class ProfileMyCoPassengersPage extends StatefulWidget {
  const ProfileMyCoPassengersPage({super.key});

  @override
  State<ProfileMyCoPassengersPage> createState() =>
      _ProfileMyCoPassengersPageState();
}

class _ProfileMyCoPassengersPageState extends State<ProfileMyCoPassengersPage> {
  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text('co_passengers'.tr),
        elevation: 0.5,
      ),
      body: Container(
        width: screenwidth,
        height: screenheight,
        color: flyternGrey10,
        child: ListView(
          children: [
            Padding(
              padding: flyternLargePaddingAll,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    child: Text("add_co_passenger".tr,
                        style: getBodyMediumStyle(context).copyWith(
                            decoration: TextDecoration.underline,
                            color: flyternTertiaryColor)),
                    onTap: () {
                      Get.toNamed(Approute_profileAuditCopassenger);
                    },
                  ),
                ],
              ),
            ),
            Container(
              width: screenwidth,
              height: flyternSpaceSmall,
              color: flyternBackgroundWhite,
            ),
            UserDetailsCard(
              isActionAllowed:true,
              title: "adult".tr,
              name: "Andrew Martin",
              email: "andrewmartin@gmail.com",
              mobile: "+92 334431234",
            ),
            Container(
              color: flyternBackgroundWhite,
              padding: flyternLargePaddingHorizontal,
              child: Divider(),
            ),
            UserDetailsCard(
              isActionAllowed:true,
              title: "child".tr,
              name: "Martin Andrew",
              email: "andrewmartin@gmail.com",
              mobile: "+92 334431234",
            ),
            Container(
              width: screenwidth,
              height: flyternSpaceMedium,
              color: flyternBackgroundWhite,
            ),
          ],
        ),
      ),
    );
  }
}
