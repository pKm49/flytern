import 'package:flutter/material.dart';
import 'package:flytern/core-module/constants/theme_data.core.constant.dart';
import 'package:flytern/shared-module/constants/app_specific/route_names.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/style_params.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/widget_styles.shared.constant.dart';
import 'package:flytern/shared-module/services/utility-services/widget_generator.shared.service.dart';
import 'package:flytern/shared-module/services/utility-services/widget_properties_generator.shared.service.dart';
import 'package:flytern/shared-module/ui/components/contact_details_getter.shared.component.dart';
import 'package:flytern/shared-module/ui/components/sort_option_selector.shared.component.dart';
import 'package:get/get.dart';

class UserDetailsSubmissionPage extends StatefulWidget {

  const UserDetailsSubmissionPage({super.key});

  @override
  State<UserDetailsSubmissionPage> createState() => _UserDetailsSubmissionPageState();
}

class _UserDetailsSubmissionPageState extends State<UserDetailsSubmissionPage> {

  final ExpansionTileController controller = ExpansionTileController();
  final ExpansionTileController controller2 = ExpansionTileController();
  dynamic argumentData = Get.arguments;

  String routeName = Approute_flightsSummary;

  @override
  void initState() {
    // TODO: implement initState
    routeName = argumentData[0]['routeName'];
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text("user_details".tr),
      ),
      body: Container(
        width: screenwidth,
        height: screenheight,
        color: flyternGrey10,
        child: ListView(
          children: [
            Container(
              margin: flyternLargePaddingVertical.copyWith(bottom: 0),
              padding: flyternLargePaddingHorizontal,
              color: flyternBackgroundWhite,
              child: ExpansionTile(

                tilePadding: EdgeInsets.zero,
                controller: controller,
                title:   Text('adult'.tr),
                children: <Widget>[

                  TextFormField(
                    onTap: (){
                      showPassengerSelector();
                    },
                      keyboardType: TextInputType.emailAddress,
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: "select_passenger".tr,
                      )),
                  addVerticalSpace(flyternSpaceMedium),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: TextFormField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: "enter_prefix".tr,
                            )),
                      ),
                      addHorizontalSpace(flyternSpaceMedium),
                      Expanded(
                        flex: 1,
                        child: TextFormField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: "select_gender".tr,
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
                              labelText: "enter_dob".tr,
                            )),
                      ),
                      addHorizontalSpace(flyternSpaceMedium),
                      Expanded(
                        flex: 1,
                        child: TextFormField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: "enter_nationality".tr,
                            )),
                      ),
                    ],
                  ),
                  addVerticalSpace(flyternSpaceMedium),

                  TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: "enter_passport".tr,
                      )),
                  addVerticalSpace(flyternSpaceMedium),
                  TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: "enter_frequent_flyer".tr,
                      )),
                  addVerticalSpace(flyternSpaceLarge),
                ],
              ),
            ),
            Container(
              color: flyternBackgroundWhite,
              padding: flyternLargePaddingHorizontal,
              child: Divider(),
            ),
            Container(
              padding: flyternLargePaddingHorizontal,
              color: flyternBackgroundWhite,
              child: ExpansionTile(

                tilePadding: EdgeInsets.zero,
                controller: controller2,
                title:   Text('child'.tr),
                children: <Widget>[

                  TextFormField(
                    onTap: (){
                      showPassengerSelector();
                    },
                      keyboardType: TextInputType.emailAddress,
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: "select_passenger".tr,
                      )),
                  addVerticalSpace(flyternSpaceMedium),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: TextFormField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: "enter_prefix".tr,
                            )),
                      ),
                      addHorizontalSpace(flyternSpaceMedium),
                      Expanded(
                        flex: 1,
                        child: TextFormField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: "select_gender".tr,
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
                              labelText: "enter_dob".tr,
                            )),
                      ),
                      addHorizontalSpace(flyternSpaceMedium),
                      Expanded(
                        flex: 1,
                        child: TextFormField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: "enter_nationality".tr,
                            )),
                      ),
                    ],
                  ),
                  addVerticalSpace(flyternSpaceMedium),

                  TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: "enter_passport".tr,
                      )),
                  addVerticalSpace(flyternSpaceMedium),
                  TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: "enter_frequent_flyer".tr,
                      )),
                  addVerticalSpace(flyternSpaceLarge),
                ],
              ),
            ),

          ],
        ),
      ),
      bottomSheet: Container(
        width: screenwidth,
        color: flyternBackgroundWhite,
        height: 60+(flyternSpaceSmall*2),
        padding: flyternLargePaddingAll.copyWith(top: flyternSpaceSmall,bottom: flyternSpaceSmall),
        child: Center(
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(style: getElevatedButtonStyle(context),
                onPressed: () {
                  Get.toNamed(routeName);
                 },
                child:Text("proceed".tr )),
          ),
        ),
      ),
    );
  }

  void showPassengerSelector( ) {
    showModalBottomSheet(
        useSafeArea: false,
        shape:   RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(flyternBorderRadiusSmall),
              topRight: Radius.circular(flyternBorderRadiusSmall)),
        ),
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) {
          return SortOptionSelector(
            selectedSort: "",
            sortChanged: (String selectedSort){},
            title: "select_user".tr,
            sortingDcs: [ ],
          );
        });

  }

}
