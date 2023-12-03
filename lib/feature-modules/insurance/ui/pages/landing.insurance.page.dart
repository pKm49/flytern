import 'package:flutter/material.dart';
import 'package:flytern/feature-modules/insurance/controllers/insurance.controller.dart';
import 'package:flytern/feature-modules/insurance/ui/components/family_member_count_selector.insurance.component.dart';
import 'package:flytern/shared-module/constants/app_specific/route_names.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/style_params.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/widget_styles.shared.constant.dart';
import 'package:flytern/shared-module/models/general_item.dart';
import 'package:flytern/shared-module/services/utility-services/form_validator.shared.service.dart';
import 'package:flytern/shared-module/services/utility-services/widget_generator.shared.service.dart';
import 'package:flytern/shared-module/services/utility-services/widget_properties_generator.shared.service.dart';
import 'package:flytern/shared-module/ui/components/contact_details_getter.shared.component.dart';
import 'package:flytern/shared-module/ui/components/custom_date_picker.shared.component.dart';
import 'package:flytern/shared-module/ui/components/dropdown_selector.shared.component.dart';
import 'package:flytern/shared-module/ui/components/selectable_text_pill.shared.component.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class InsuranceLandingPage extends StatefulWidget {
  const InsuranceLandingPage({super.key});

  @override
  State<InsuranceLandingPage> createState() => _InsuranceLandingPageState();
}

class _InsuranceLandingPageState extends State<InsuranceLandingPage>
    with SingleTickerProviderStateMixin {
  final insuranceBookingController = Get.find<InsuranceBookingController>();

  final GlobalKey<FormState> policyPlanDropDownKey = GlobalKey<FormState>();
  final GlobalKey<FormState> policyTimeDropDownKey = GlobalKey<FormState>();


  @override
  void initState() {
    super.initState();
    insuranceBookingController.getInitialInfo();
  }

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
     return Obx(
      () => Scaffold(
          // appBar: AppBar(
          //   title: Text('travel_insurance'.tr),
          // ),
          body: Stack(
            children: [
              Visibility(
                  visible:
                      insuranceBookingController.isInitialDataLoading.value,
                  child: Container(
                    width: screenwidth,
                    height: screenheight * .8,
                    color: flyternGrey10,
                    child: Center(
                        child: LoadingAnimationWidget.prograssiveDots(
                      color: flyternSecondaryColor,
                      size: 50,
                    )),
                  )),
              Visibility(
                visible: !insuranceBookingController.isInitialDataLoading.value,
                child: Container(
                  width: screenwidth,
                  height: screenheight,
                  color: flyternGrey10,
                  child: ListView(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: flyternLargePaddingAll,
                              child: Text("policy_header".tr,
                                  style: getBodyMediumStyle(context).copyWith(
                                      color: flyternGrey80,
                                      fontWeight: flyternFontWeightBold)),
                            ),
                          ),
                          Expanded(
                              child: InkWell(
                            onTap: () {
                              _launchUrl(insuranceBookingController
                                  .insuranceInitialData.value.knowYourPolicy);
                            },
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Icon(Ionicons.information_circle_outline,
                                      color: flyternTertiaryColor,
                                      size: flyternFontSize20),
                                  addHorizontalSpace(flyternSpaceExtraSmall),
                                  Center(
                                      child: Text(
                                    "info".tr,
                                    textAlign: TextAlign.center,
                                    style: getBodyMediumStyle(context).copyWith(
                                        color: flyternTertiaryColor,
                                        decoration: TextDecoration.underline),
                                  )),
                                  addHorizontalSpace(flyternSpaceMedium),
                                ]),
                          ))
                        ],
                      ),
                      Container(
                        color: flyternBackgroundWhite,
                        padding: flyternLargePaddingAll,
                        child: Wrap(
                          children: [
                            for (var i = 0;
                                i <
                                    (insuranceBookingController
                                        .insuranceInitialData
                                        .value
                                        .lstPolicyHeaderType
                                        .length);
                                i++)
                              Padding(
                                padding: const EdgeInsets.only(
                                    right: flyternSpaceSmall,
                                    bottom: flyternSpaceSmall),
                                child: SelectableTilePill(
                                  onPressed: () {
                                    insuranceBookingController
                                        .changePolicyHeader(
                                            insuranceBookingController
                                                .insuranceInitialData
                                                .value
                                                .lstPolicyHeaderType[i]
                                                .id);
                                  },
                                  label:
                                      '${insuranceBookingController.insuranceInitialData.value.lstPolicyHeaderType[i].name}',
                                  isSelected: insuranceBookingController
                                          .insuranceInitialData
                                          .value
                                          .lstPolicyHeaderType[i]
                                          .id ==
                                      insuranceBookingController
                                          .insurancePriceGetBody
                                          .value
                                          .covidtype,
                                  themeNumber: 2,
                                ),
                              ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: flyternLargePaddingAll,
                        child: Text("policy_type".tr,
                            style: getBodyMediumStyle(context).copyWith(
                                color: flyternGrey80,
                                fontWeight: flyternFontWeightBold)),
                      ),
                      for (var i = 0;
                          i <
                              insuranceBookingController.insuranceInitialData
                                  .value.lstPolicyType.length;
                          i++)
                        Container(
                          color: flyternBackgroundWhite,
                          padding: flyternLargePaddingHorizontal.copyWith(
                              top: flyternSpaceSmall,
                              bottom: i ==
                                      (insuranceBookingController
                                              .insuranceInitialData
                                              .value
                                              .lstPolicyType
                                              .length -
                                          1)
                                  ? flyternSpaceSmall
                                  : 0),
                          child: Container(
                            padding: EdgeInsets.only(
                                bottom: i ==
                                        (insuranceBookingController
                                                .insuranceInitialData
                                                .value
                                                .lstPolicyType
                                                .length -
                                            1)
                                    ? 0
                                    : flyternSpaceExtraSmall),
                            decoration: BoxDecoration(
                                border: i ==
                                        (insuranceBookingController
                                                .insuranceInitialData
                                                .value
                                                .lstPolicyType
                                                .length -
                                            1)
                                    ? null
                                    : flyternDefaultBorderBottomOnly),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                    insuranceBookingController
                                        .insuranceInitialData
                                        .value
                                        .lstPolicyType[i]
                                        .name,
                                    style: getBodyMediumStyle(context)
                                        .copyWith(color: flyternGrey80)),
                                Radio(
                                  activeColor: flyternSecondaryColor,
                                  value: insuranceBookingController
                                      .insuranceInitialData
                                      .value
                                      .lstPolicyType[i]
                                      .id,
                                  groupValue: insuranceBookingController
                                      .insurancePriceGetBody.value.policy_type,
                                  onChanged: (value) {
                                    setState(() {
                                       insuranceBookingController
                                          .changePolicyType(value);
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      Visibility(
                        visible: insuranceBookingController
                                .insurancePriceGetBody.value.policy_type ==
                            "2",
                        child: Padding(
                          padding: flyternLargePaddingAll,
                          child: Text("family_members".tr,
                              style: getBodyMediumStyle(context).copyWith(
                                  color: flyternGrey80,
                                  fontWeight: flyternFontWeightBold)),
                        ),
                      ),
                      Visibility(
                        visible: insuranceBookingController
                            .insurancePriceGetBody.value.policy_type ==
                            "2",
                        child: InkWell(
                          onTap: () {
                            openInsuranceFamilyMemberSelector();
                          },
                          child: Container(
                            color: flyternBackgroundWhite,
                            padding: flyternLargePaddingAll,
                            child: Row(
                              children: [
                                Icon(Ionicons.person_outline,
                                    color: flyternSecondaryColor, size: flyternFontSize20),
                                addHorizontalSpace(flyternSpaceSmall * 1.5),
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'number_family_members'.tr,
                                        style: getLabelLargeStyle(context).copyWith(
                                            color: flyternGrey40, fontWeight: FontWeight.w400),
                                      ),
                                      addVerticalSpace(flyternSpaceExtraSmall * 1.5),
                                      Text("${insuranceBookingController.spouse.value.toString()} ${'spouse'.tr}, "
                                          "${insuranceBookingController.daughter.value.toString()} ${'daughter'.tr}, "
                                          "${insuranceBookingController.son.value.toString()} ${'son'.tr}",
                                          style: getLabelLargeStyle(context).copyWith(
                                            color: flyternGrey80,
                                          )),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),

                      Padding(
                        padding: flyternLargePaddingAll,
                        child: Text("policy_plan".tr,
                            style: getBodyMediumStyle(context).copyWith(
                                color: flyternGrey80,
                                fontWeight: flyternFontWeightBold)),
                      ),
                      Container(
                        color: flyternBackgroundWhite,
                        padding: flyternLargePaddingAll,
                        child: Container(
                          decoration:
                              flyternBorderedContainerSmallDecoration.copyWith(
                                  color: flyternGrey10,
                                  border: Border.all(
                                      color: flyternGrey10, width: .2)),
                          padding: flyternMediumPaddingHorizontal.copyWith(
                              top: flyternSpaceExtraSmall,
                              bottom: flyternSpaceExtraSmall),
                          child: DropDownSelector(
                            key: policyPlanDropDownKey,
                            titleText: "policy_plan".tr,
                            selected: insuranceBookingController
                                .insurancePriceGetBody.value.policyplan,
                            items: [
                              GeneralItem(
                                  imageUrl: "",
                                  id: "0",
                                  name: "select_policy_plan".tr),
                              for (var i = 0;
                                  i <
                                      insuranceBookingController
                                          .insuranceInitialData
                                          .value
                                          .lstPolicyOption
                                          .length;
                                  i++)
                                GeneralItem(
                                    imageUrl: "",
                                    id: insuranceBookingController
                                        .insuranceInitialData
                                        .value
                                        .lstPolicyOption[i]
                                        .id
                                        .toString(),
                                    name:
                                        "${insuranceBookingController.insuranceInitialData.value.lstPolicyOption[i].name}")
                            ],
                            hintText: "select_policy_plan".tr,
                            valueChanged: (newPlan) {
                              insuranceBookingController
                                  .changePolicyPlan((newPlan));
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: flyternLargePaddingAll,
                        child: Text("policy_time".tr,
                            style: getBodyMediumStyle(context).copyWith(
                                color: flyternGrey80,
                                fontWeight: flyternFontWeightBold)),
                      ),
                      Container(
                        color: flyternBackgroundWhite,
                        padding: flyternLargePaddingAll,
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                decoration:
                                flyternBorderedContainerSmallDecoration.copyWith(
                                    color: flyternGrey10,
                                    border: Border.all(
                                        color: flyternGrey10, width: .2)),
                                padding: flyternMediumPaddingHorizontal.copyWith(
                                    top: flyternSpaceExtraSmall,
                                    bottom: flyternSpaceExtraSmall),
                                child: DropDownSelector(
                                  key: policyTimeDropDownKey,
                                  titleText: "policy_time".tr,
                                  selected: insuranceBookingController
                                      .insurancePriceGetBody.value.policyperiod,
                                  items: [
                                    GeneralItem(
                                        imageUrl: "",
                                        id: "0",
                                        name: "select_policy_period".tr),
                                    for (var i = 0;
                                    i <
                                        insuranceBookingController
                                            .insuranceInitialData
                                            .value
                                            .lstPolicyPeriod
                                            .length;
                                    i++)
                                      GeneralItem(
                                          imageUrl: "",
                                          id: insuranceBookingController
                                              .insuranceInitialData
                                              .value
                                              .lstPolicyPeriod[i]
                                              .id
                                              .toString(),
                                          name:
                                          "${insuranceBookingController.insuranceInitialData.value.lstPolicyPeriod[i].name}")
                                  ],
                                  hintText: "select_policy_period".tr,
                                  valueChanged: (newPlan) {
                                    insuranceBookingController
                                        .changePolicyPeriod((newPlan));
                                  },
                                ),
                              ),
                            ),
                            addHorizontalSpace(flyternSpaceMedium),
                            Expanded(
                              child: TextFormField(
                                  readOnly: true,
                                  onTap: () {
                                    showDatePickerDialog(insuranceBookingController.policyDate.value);
                                  },
                                  controller: insuranceBookingController.policyDateController.value,
                                  validator: (value) =>
                                      checkIfNameFormValid(value, "policy_date".tr),
                                  keyboardType: TextInputType.name,
                                  decoration: InputDecoration(
                                    hintText: "DD-MM-YY",
                                    labelText: "select_policy_date".tr,
                                  )),
                            )
                          ],
                        ),
                      ),

                      Container(
                        height: 70 + (flyternSpaceSmall * 2),
                        padding: flyternLargePaddingAll,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          bottomSheet: !insuranceBookingController.isInitialDataLoading.value
              ? Container(
                  width: screenwidth,
                  color: flyternBackgroundWhite,
                  height: 60 + (flyternSpaceSmall * 2),
                  padding: flyternLargePaddingAll.copyWith(
                      top: flyternSpaceSmall, bottom: flyternSpaceSmall),
                  child: Center(
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          style: getElevatedButtonStyle(context),
                          onPressed: () {
                            openContactDetailsGetterBottomSheet();

                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Visibility(
                                visible: !insuranceBookingController
                                    .isInsurancePriceGetterLoading.value,
                                child: Text(
                                    "${insuranceBookingController.insurancePriceData.value.code} ${insuranceBookingController.insurancePriceData.value.price}"),
                              ),
                              Visibility(
                                  visible: insuranceBookingController
                                      .isInsurancePriceGetterLoading.value,
                                  child: LoadingAnimationWidget.prograssiveDots(
                                    color: flyternBackgroundWhite,
                                    size: 20,
                                  )),
                              Expanded(
                                child: Container(),
                              ),
                              Text("next".tr),
                              addHorizontalSpace(flyternSpaceSmall),
                              Icon(
                                Ionicons.chevron_forward,
                                size: flyternFontSize20,
                              )
                            ],
                          )),
                    ),
                  ),
                )
              : Container(
                  width: screenwidth,
                  color: flyternGrey10,
                  height: 60 + (flyternSpaceSmall * 2),
                )),
    );
  }

  void openContactDetailsGetterBottomSheet() {
    showModalBottomSheet(
        useSafeArea: false,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(flyternBorderRadiusSmall),
              topRight: Radius.circular(flyternBorderRadiusSmall)),
        ),
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return ContactDetailsGetter(
              route: Approute_insuranceUserDetailsSubmission);
        });
  }

  Future<void> _launchUrl(String urlString) async {
    final Uri _url = Uri.parse(urlString);

    if (!await launchUrl(_url)) {
     }
  }

  void openInsuranceFamilyMemberSelector() {
    showModalBottomSheet(
        useSafeArea: false,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(flyternBorderRadiusSmall),
              topRight: Radius.circular(flyternBorderRadiusSmall)),
        ),
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) {
          return FamilyMemberCountSelector(
            selectedDaughterCount: insuranceBookingController.daughter.value,
            selectedSonCount: insuranceBookingController.son.value,
            selectedSpouseCount: insuranceBookingController.spouse.value,
            dataSubmitted: (int spouseCount, int daughterCount, int sonCount) {
              insuranceBookingController.updateFamilyMembersCount( spouseCount,
                  daughterCount, sonCount );
              Navigator.pop(context);
            },
                 );
        });
  }

  void showDatePickerDialog( DateTime dateTime) {
    showModalBottomSheet(
        useSafeArea: false,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(flyternBorderRadiusSmall),
              topRight: Radius.circular(flyternBorderRadiusSmall)),
        ),
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) {
          return CustomDatePicker(
            selectedDate: dateTime,
            maximumDate: insuranceBookingController.insuranceInitialData.value.maxPolicyDate,
            minimumDate: insuranceBookingController.insuranceInitialData.value.minPolicyDate,
            dateSelected: (DateTime? dateTime) {
              if (dateTime != null) {
                insuranceBookingController.changePolicyDate(dateTime);
              }
            },
          );
        });
  }

}
