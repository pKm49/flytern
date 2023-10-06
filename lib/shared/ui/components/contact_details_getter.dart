import 'package:flutter/material.dart';
import 'package:flytern/shared/data/constants/app_specific/app_route_names.dart';
import 'package:flytern/shared/services/utility-services/form_validator.dart';
import 'package:flytern/shared/ui/components/data_capsule_card.dart';
import 'package:flytern/shared/data/constants/ui_constants/style_params.dart';
import 'package:flytern/shared/data/constants/ui_constants/widget_styles.dart';
import 'package:flytern/shared/services/utility-services/widget_generator.dart';
import 'package:flytern/shared/services/utility-services/widget_properties_generator.dart';
import 'package:get/get.dart';

class ContactDetailsGetter extends StatefulWidget {

  String route;
  String? secondRoute;

    ContactDetailsGetter({super.key, required this.route, this.secondRoute});

  @override
  State<ContactDetailsGetter> createState() => _ContactDetailsGetterState();
}

class _ContactDetailsGetterState extends State<ContactDetailsGetter> {

  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Container(
      height: screenheight*.85,
      width: screenwidth,
      padding: flyternLargePaddingAll,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(flyternBorderRadiusSmall),
            topRight: Radius.circular(flyternBorderRadiusSmall)),
        color: flyternBackgroundWhite
      ),
      child: ListView(
        children: [
          Text("contact_details".tr,
              style: getHeadlineMediumStyle(context).copyWith(
                  color: flyternGrey80, fontWeight: flyternFontWeightBold),textAlign: TextAlign.center),

          addVerticalSpace(flyternSpaceLarge),
          TextFormField(
              controller: emailController,
              validator: (value) => checkIfEmailValid(value),
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: "email".tr,
              )),
          addVerticalSpace(flyternSpaceMedium),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: TextFormField(
                    controller: emailController,
                    validator: (value) => checkIfEmailValid(value),
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "🇰🇼 +965",
                    )),
              ),
              addHorizontalSpace(flyternSpaceMedium),
              Expanded(
                flex: 4,
                child: TextFormField(
                    controller: emailController,
                    validator: (value) => checkIfEmailValid(value),
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "mobile".tr,
                    )),
              ),
            ],
          ),
          Container(
            color: flyternBackgroundWhite,
            padding: flyternLargePaddingVertical,
            child: DataCapsuleCard(
              label: "Note : " + "notification_update_message".tr,
              theme: 2,
            ),
          ),
          addVerticalSpace(flyternSpaceLarge),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
                onPressed: ()   {
                  Get.toNamed(widget.route,
                      arguments: [
                        {"routeName": widget.secondRoute??Approute_landingpage}
                      ]);
                }, child: Text("continue_as".tr+" "+"guest_user".tr)),
          ),
          addVerticalSpace(flyternSpaceLarge),

          Row(
            children: [
              Expanded(child: Divider()),
              addHorizontalSpace(flyternSpaceSmall),
              Text("or".tr,style: getBodyMediumStyle(context).copyWith(color: flyternGrey60),),
              addHorizontalSpace(flyternSpaceSmall),
              Expanded(child: Divider()),
            ],
          ),
          addVerticalSpace(flyternSpaceLarge),

          Row(
            children: [
              Expanded(child: OutlinedButton(
                onPressed: ()   {

                },
                child: Text("sign_in".tr),
              )),
              addHorizontalSpace(flyternSpaceMedium),
              Expanded(child: OutlinedButton(
                onPressed: ()   {

                },
                child: Text("sign_up".tr),
              )),
            ],
          )
        ],
      ),
    );
  }
}
