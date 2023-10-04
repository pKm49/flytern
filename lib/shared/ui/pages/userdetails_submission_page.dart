import 'package:flutter/material.dart';
import 'package:flytern/core/data/constants/ui-specific/theme_data.dart';
import 'package:flytern/shared/data/constants/app_specific/app_route_names.dart';
import 'package:flytern/shared/data/constants/ui_constants/style_params.dart';
import 'package:flytern/shared/data/constants/ui_constants/widget_styles.dart';
import 'package:flytern/shared/services/utility-services/widget_generator.dart';
import 'package:flytern/shared/services/utility-services/widget_properties_generator.dart';
import 'package:flytern/shared/ui/components/contact_details_getter.dart';
import 'package:flytern/shared/ui/components/sort_option_selector.dart';
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
        title: Text("passenger_details".tr),
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
            child: ElevatedButton(
                onPressed: () {
                  openContactDetailsGetterBottomSheet();
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
            title: "select_passenger".tr,
            values: ["John Murphy","Will Smith"],
          );
        });

  }

  void openContactDetailsGetterBottomSheet( ) {
  showModalBottomSheet(
      useSafeArea: false,
      shape:   RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(flyternBorderRadiusSmall),
            topRight: Radius.circular(flyternBorderRadiusSmall)),
      ),
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return ContactDetailsGetter(route: routeName);
      });
}
}
