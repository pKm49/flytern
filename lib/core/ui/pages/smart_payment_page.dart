
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flytern/shared/data/constants/app_specific/app_route_names.dart';
import 'package:flytern/shared/data/constants/ui_constants/asset_urls.dart';
import 'package:flytern/shared/data/constants/ui_constants/style_params.dart';
import 'package:flytern/shared/data/constants/ui_constants/widget_styles.dart';
import 'package:flytern/shared/services/utility-services/form_validator.dart';
import 'package:flytern/shared/services/utility-services/widget_generator.dart';
import 'package:flytern/shared/services/utility-services/widget_properties_generator.dart';
import 'package:flytern/shared/ui/components/data_capsule_card.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class SmartPaymentPage extends StatefulWidget {
  const SmartPaymentPage({super.key});

  @override
  State<SmartPaymentPage> createState() => _SmartPaymentPageState();
}

class _SmartPaymentPageState extends State<SmartPaymentPage> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Scaffold(
        appBar: AppBar(
          title: Text("smart_payment".tr),
          elevation: 0.5,
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
                height: flyternSpaceLarge,
                decoration: BoxDecoration(
                  color: flyternGrey10,
                ),
              ),
              Container(
                padding: flyternLargePaddingHorizontal.copyWith(top: flyternSpaceLarge,bottom: flyternSpaceMedium),
                color: flyternBackgroundWhite,
                child: TextFormField(
                    controller: emailController,
                    validator: (value) => checkIfEmailValid(value),
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      suffixIcon: Icon(Ionicons.eye_outline),
                      labelText: "enter_booking_id".tr,
                    )),
              ),
              Container(
                color: flyternBackgroundWhite,
                padding: flyternLargePaddingAll.copyWith(top: 0),
                child: DataCapsuleCard(
                  label: "Note : " + "enter_booking_id_message".tr,
                  theme: 2,
                ),
              ),

              Container(
                height: 70+(flyternSpaceSmall*2),
                padding: flyternLargePaddingAll,
              )
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
              child: ElevatedButton(
                  onPressed: () {
                   Get.toNamed(Approute_flightsDetails);
                  },
                  child: Text("submit".tr)),
            ),
          ),
        )
    );
  }
}
