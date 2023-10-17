import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flytern/feature-modules/profile/controllers/profile_controller.dart';
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
  final profileController = Get.find<ProfileController>();

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
        child: Column(
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
            Visibility(
              visible: profileController.userCopaxes.isEmpty,
              child: Container(
                width: screenwidth,
                color: flyternBackgroundWhite,
                padding: flyternLargePaddingAll,
                child: Center(
                  child: Text("no_item".tr,style: getBodyMediumStyle(context).copyWith(
                      color: flyternGrey60
                  ),),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: profileController.userCopaxes.length,
                  itemBuilder: (BuildContext context, int index) {
                    return  UserDetailsCard(
                      isActionAllowed: true,
                      passportNumber: profileController.userCopaxes[index].passportNumber,
                      name: "${profileController.userCopaxes[index].firstName} ${profileController.userCopaxes[index].lastName}",
                      age: getAge(profileController.userCopaxes[index].dateOfBirth),
                      gender: profileController.userCopaxes[index].gender,
                    );
                  }),
            ),

          ],
        ),
      ),
    );
  }

  getAge(DateTime dateOfBirth) {
    int currenYear = DateTime.now().year;
    int dobYear = dateOfBirth.year;
    return "${currenYear - dobYear} years";
  }
}
