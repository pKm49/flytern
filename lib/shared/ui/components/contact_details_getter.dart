import 'package:flutter/material.dart';
import 'package:flytern/feature-modules/profile/controllers/profile_controller.dart';
import 'package:flytern/shared/controllers/shared_controller.dart';
import 'package:flytern/shared/data/constants/app_specific/app_route_names.dart';
import 'package:flytern/shared/data/models/business_models/country.dart';
import 'package:flytern/shared/services/utility-services/form_validator.dart';
import 'package:flytern/shared/ui/components/country_selector.dart';
import 'package:flytern/shared/ui/components/data_capsule_card.dart';
import 'package:flytern/shared/data/constants/ui_constants/style_params.dart';
import 'package:flytern/shared/data/constants/ui_constants/widget_styles.dart';
import 'package:flytern/shared/services/utility-services/widget_generator.dart';
import 'package:flytern/shared/services/utility-services/widget_properties_generator.dart';
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

  var selectedCountry = Country(
      isDefault: 1,
      countryName: "India",
      countryCode: "IND",
      countryISOCode: "IN",
      countryName_Ar: "الهند",
      flag: "https://flagcdn.com/48x36/in.png",
      code: "+91");

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

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
                    flex: 2,
                    child: InkWell(
                      onTap: openCountrySelector,
                      child: Container(
                        decoration:
                        flyternBorderedContainerSmallDecoration.copyWith(
                            color: flyternGrey10,
                            border: Border.all(
                                color: Colors.transparent, width: 0)),
                        padding: flyternMediumPaddingAll.copyWith(
                            top: flyternSpaceLarge,
                            bottom: flyternSpaceLarge),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.network(
                                profileController.selectedCountry.value.flag,
                                width: 20),
                            addHorizontalSpace(flyternSpaceMedium),
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
                    flex: 4,
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
                              {"mobileCntry":selectedCountry.code,
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
                          print("valueee is");
                          print(value);
                          if(value is bool){

                            if(value){
                              profileController.getUserDetails();
                            }

                          }
                          print("value");
                          print(value.toString());
                        });
                      },
                      child: Text("sign_in".tr),
                    )),
                    addHorizontalSpace(flyternSpaceMedium),
                    Expanded(child: OutlinedButton(
                      onPressed: ()   {

                        Get.toNamed(Approute_registerPersonalData,
                            arguments: [false])?.then((value) async {
                          print("valueee is");
                          print(value);
                          if(value is bool){

                            if(value){
                              profileController.getUserDetails();
                            }

                          }
                          print("value");
                          print(value.toString());
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
          return CountrySelector(countrySelected: (Country? country) {
            if (country != null) profileController.changeMobileCountry(country);
          });
        });
  }
}
