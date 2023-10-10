import 'package:flutter/material.dart';
import 'package:flytern/shared/data/constants/app_specific/app_route_names.dart';
import 'package:flytern/shared/data/constants/ui_constants/style_params.dart';
import 'package:flytern/shared/data/constants/ui_constants/widget_styles.dart';
import 'package:flytern/shared/services/utility-services/widget_generator.dart';
import 'package:flytern/shared/services/utility-services/widget_properties_generator.dart';
import 'package:flytern/shared/ui/components/contact_details_getter.dart';
import 'package:get/get.dart';

class PackageUserDetailsSubmissionPage extends StatefulWidget {
  const PackageUserDetailsSubmissionPage({super.key});

  @override
  State<PackageUserDetailsSubmissionPage> createState() => _PackageUserDetailsSubmissionPageState();
}

class _PackageUserDetailsSubmissionPageState extends State<PackageUserDetailsSubmissionPage> {
  @override
  Widget build(BuildContext context) {

    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text("user_details".tr),
        elevation: 0.5,
      ),
      body: Container(
        height: screenheight,
        width: screenwidth,
        color: flyternGrey10,
        child: Column(
          children: [
            addVerticalSpace(flyternSpaceLarge),
            Expanded(

                child: Container(
                  color: flyternBackgroundWhite,
                  padding: flyternLargePaddingAll,
                  child: ListView(
              children: [

                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: TextFormField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: "enter_firstname".tr,
                            )),
                      ),
                      addHorizontalSpace(flyternSpaceMedium),
                      Expanded(
                        flex: 1,
                        child: TextFormField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: "enter_lastname".tr,
                            )),
                      ),
                    ],
                  ),
                  addVerticalSpace(flyternSpaceMedium),

                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: TextFormField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: "select_num_adults".tr,
                            )),
                      ),
                      addHorizontalSpace(flyternSpaceMedium),
                      Expanded(
                        flex: 1,
                        child: TextFormField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: "select_num_children".tr,
                            )),
                      ),
                    ],
                  ),
                  addVerticalSpace(flyternSpaceMedium),

                  TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: "select_num_infants".tr,
                      )),
                  addVerticalSpace(flyternSpaceMedium),
                  TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: "enter_description".tr,
                      )),
                  addVerticalSpace(flyternSpaceLarge),
              ],
            ),
                ))
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
                  Get.toNamed(Approute_landingpage );
                  },
                child: Text("submit_enquiry".tr)),
          ),
        ),
      ),
    );
  }



}
