import 'package:flutter/material.dart';
import 'package:flytern/feature-modules/profile/controllers/profile.controller.dart';
import 'package:flytern/shared-module/controllers/shared.controller.dart';
import 'package:flytern/shared-module/constants/app_specific/route_names.shared.constant.dart';
import 'package:flytern/shared-module/models/country.dart';
import 'package:flytern/shared-module/services/utility-services/form_validator.shared.service.dart';
import 'package:flytern/shared-module/ui/components/country_selector.shared.component.dart';
import 'package:flytern/shared-module/ui/components/data_capsule_card.shared.component.dart';
import 'package:flytern/shared-module/constants/ui_specific/style_params.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/widget_styles.shared.constant.dart';
import 'package:flytern/shared-module/services/utility-services/widget_generator.shared.service.dart';
import 'package:flytern/shared-module/services/utility-services/widget_properties_generator.shared.service.dart';
import 'package:get/get.dart';

class ContactDetailsGetter extends StatefulWidget {

  String route;

    ContactDetailsGetter({super.key, required this.route });

  @override
  State<ContactDetailsGetter> createState() => _ContactDetailsGetterState();
}

class _ContactDetailsGetterState extends State<ContactDetailsGetter> {

  final profileController = Get.find<ProfileController>();
  final GlobalKey<FormState> setContactDetailsFormKey = GlobalKey<FormState>();
  final sharedController = Get.find<SharedController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    profileController.updateEditForm(profileController.userDetails.value);
    if(sharedController.titleList.isEmpty){
      sharedController.getInitialInfo();
    }

  }

  @override
  Widget build(BuildContext context) {

    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Obx(
      ()=> Container(
        height: screenheight*.85,
        width: screenwidth,
        padding: flyternLargePaddingAll,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(flyternBorderRadiusSmall),
              topRight: Radius.circular(flyternBorderRadiusSmall)),
          color: flyternBackgroundWhite
        ),
        child: Form(
          key: setContactDetailsFormKey,
          child: ListView(
            children: [
              Text("contact_details".tr,
                  style: getHeadlineMediumStyle(context).copyWith(
                      color: flyternGrey80, fontWeight: flyternFontWeightBold),textAlign: TextAlign.center),

              addVerticalSpace(flyternSpaceLarge),
              TextFormField(
                  controller: profileController.emailController.value,
                  validator: (value) => checkIfEmailValid(value),
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: "email".tr,
                  )),
              addVerticalSpace(flyternSpaceMedium),
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: InkWell(
                      onTap: openCountrySelector,
                      child: Container(
                        decoration:
                        flyternBorderedContainerSmallDecoration.copyWith(
                            color: flyternGrey20,
                            border: Border.all(
                                color: flyternGrey40, width: 0)),
                        padding: flyternMediumPaddingAll.copyWith(
                            top: flyternSpaceMedium,
                            bottom: flyternSpaceMedium),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.network(
                                profileController.selectedCountry.value.flag,
                                width: 17),
                            addHorizontalSpace(flyternSpaceSmall),
                            Expanded(
                              child: Text(
                                  profileController.selectedCountry.value.code,
                                  style: getBodyMediumStyle(context)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  addHorizontalSpace(flyternSpaceMedium),
                  Expanded(
                    flex: 5,
                    child: TextFormField(
                        controller: profileController.mobileController.value,
                        validator: (value) => checkIfMobileNumberValid(value),
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
                child: ElevatedButton(style: getElevatedButtonStyle(context),
                    onPressed: ()   {
                      if (setContactDetailsFormKey.currentState!.validate()  ){
                        Navigator.pop(context);
                        Get.toNamed(widget.route,
                            arguments: [
                              {"mobileCntry":profileController.selectedCountry.value.code,
                                "mobileNumber":profileController.mobileController.value.text,
                                "email":profileController.emailController.value.text
                              },
                            ]);
                      }
                    }, child: profileController.userDetails.value.isGuest?
                    Text("continue_as".tr+" "+"guest_user".tr):
                    Text("continue".tr )),
              ),
              addVerticalSpace(flyternSpaceLarge),

              Visibility(
                visible: profileController.userDetails.value.isGuest,
                child: Row(
                  children: [
                    Expanded(child: Divider()),
                    addHorizontalSpace(flyternSpaceSmall),
                    Text("or".tr,style: getBodyMediumStyle(context).copyWith(color: flyternGrey60),),
                    addHorizontalSpace(flyternSpaceSmall),
                    Expanded(child: Divider()),
                  ],
                ),
              ),

              Visibility(
                  visible: profileController.userDetails.value.isGuest,
                  child: addVerticalSpace(flyternSpaceLarge)),

              Visibility(
                visible: profileController.userDetails.value.isGuest,
                child: Row(
                  children: [
                    Expanded(child: OutlinedButton(
                      onPressed: ()   {
                        Get.toNamed(Approute_login,
                            arguments: [false])?.then((value) async {

                          if(value is bool){

                            if(value){
                              profileController.getUserDetails();
                            }

                          }

                        });
                      },
                      child: Text("sign_in".tr),
                    )),
                    addHorizontalSpace(flyternSpaceMedium),
                    Expanded(child: OutlinedButton(
                      onPressed: ()   {

                        Get.toNamed(Approute_registerPersonalData,
                            arguments: [false])?.then((value) async {

                          if(value is bool){

                            if(value){
                              profileController.getUserDetails();
                            }

                          }

                        });
                      },
                      child: Text("sign_up".tr),
                    )),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void openCountrySelector() {
    showModalBottomSheet(
        useSafeArea: false,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(flyternBorderRadiusSmall),
              topRight: Radius.circular(flyternBorderRadiusSmall)),
        ),
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return CountrySelector(
              isMobile:true,
              isGlobal: false,
              countrySelected: (Country? country) {
            if (country != null) {
              profileController.changeMobileCountry(country);
              setState(() {

              });
            }
          });
        });
  }
}
