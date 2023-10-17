 
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flytern/feature-modules/profile/controllers/copax_controller.dart';
import 'package:flytern/shared/controllers/shared_controller.dart';
import 'package:flytern/shared/data/constants/ui_constants/asset_urls.dart';
import 'package:flytern/shared/data/constants/ui_constants/style_params.dart';
import 'package:flytern/shared/data/constants/ui_constants/widget_styles.dart';
import 'package:flytern/shared/data/models/business_models/gender.dart';
import 'package:flytern/shared/data/models/business_models/general_item.dart';
import 'package:flytern/shared/services/utility-services/form_validator.dart';
import 'package:flytern/shared/services/utility-services/widget_generator.dart';
import 'package:flytern/shared/services/utility-services/widget_properties_generator.dart';
import 'package:flytern/shared/ui/components/dropdown_selector.dart';
import 'package:get/get.dart';

class ProfileAuditCopassengerPage extends StatefulWidget {
  const ProfileAuditCopassengerPage({super.key});

  @override
  State<ProfileAuditCopassengerPage> createState() => _ProfileAuditCopassengerPageState();
}

class _ProfileAuditCopassengerPageState extends State<ProfileAuditCopassengerPage> {

  final coPaxController = Get.find<CoPaxController>();
  final sharedController = Get.find<SharedController>();


  @override
  Widget build(BuildContext context) {

    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Scaffold(
        appBar: AppBar(
          title: Text("add_co_passenger".tr),
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
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                          controller: coPaxController.firsNameController.value,
                          validator: (value) => checkIfNameFormValid(value, "first_name".tr),
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            labelText: "first_name".tr,
                          )),
                    ),
                    addHorizontalSpace(flyternSpaceMedium),
                    Expanded(
                      child: TextFormField(
                          controller: coPaxController.firsNameController.value,
                          validator: (value) => checkIfNameFormValid(value, "last_name".tr),
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            labelText: "last_name".tr,
                          )),
                    ),
                  ],
                ),
              ),
              Container(
                padding: flyternLargePaddingHorizontal.copyWith(top: flyternSpaceLarge,bottom: flyternSpaceMedium),
                color: flyternBackgroundWhite,
                child: Row(
                  children: [
                    Expanded(
                      child: DropDownSelector(
                        titleText: coPaxController.gender.value,
                        selected:coPaxController.gender.value  ,
                        items: [
                          for(var i =0; i<sharedController.genders.length;i++)
                            GeneralItem(id: sharedController.genders[i].code,
                                name: sharedController.genders[i].name)
                        ],
                        hintText:"gender".tr ,
                        valueChanged: (newGender) {

                          List<Gender> genders = sharedController.genders.where((e) => e.code == newGender).toList();
                          if(genders.isNotEmpty){
                            coPaxController
                                .changeGender(
                                genders[0]
                            );
                          }


                        },
                      )
                    ),
                    addHorizontalSpace(flyternSpaceMedium),
                    Expanded(
                      child: TextFormField(
                          controller: coPaxController.firsNameController.value,
                          validator: (value) => checkIfNameFormValid(value, "last_name".tr),
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            labelText: "last_name".tr,
                          )),
                    ),
                  ],
                ),
              ),


              Container(
                padding: flyternLargePaddingHorizontal.copyWith(top: 0,bottom: flyternSpaceMedium),
                color: flyternBackgroundWhite,
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: TextFormField(
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
                          validator: (value) => checkIfEmailValid(value),
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: "mobile".tr,
                          )),
                    ),
                  ],
                ),
              ),

              Container(
                padding: flyternLargePaddingHorizontal.copyWith(top: 0,bottom: flyternSpaceMedium),
                color: flyternBackgroundWhite,
                child: TextFormField(
                    validator: (value) => checkIfEmailValid(value),
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: "enter_dob".tr,
                    )),
              ),

              Container(
                padding: flyternLargePaddingHorizontal.copyWith(top: 0,bottom: flyternSpaceMedium),
                color: flyternBackgroundWhite,
                child: TextFormField(
                    validator: (value) => checkIfEmailValid(value),
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: "enter_nationality".tr,
                    )),
              ),

              Container(
                padding: flyternLargePaddingHorizontal.copyWith(top: 0,bottom: flyternSpaceMedium),
                color: flyternBackgroundWhite,
                child: TextFormField(
                    validator: (value) => checkIfEmailValid(value),
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: "enter_passport".tr,
                    )),
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
              child: ElevatedButton(style: getElevatedButtonStyle(context),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("add".tr)),
            ),
          ),
        )
    );
  }
}
