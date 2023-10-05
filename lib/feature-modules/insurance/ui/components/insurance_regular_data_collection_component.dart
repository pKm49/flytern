import 'package:flutter/material.dart';
import 'package:flytern/shared/data/constants/ui_constants/style_params.dart';
import 'package:flytern/shared/data/constants/ui_constants/widget_styles.dart';
import 'package:flytern/shared/services/utility-services/widget_generator.dart';
import 'package:flytern/shared/services/utility-services/widget_properties_generator.dart';
import 'package:get/get.dart';

class InsuranceRegularDataCollectionComponent extends StatefulWidget {
  const InsuranceRegularDataCollectionComponent({super.key});

  @override
  State<InsuranceRegularDataCollectionComponent> createState() => _InsuranceRegularDataCollectionComponentState();
}

class _InsuranceRegularDataCollectionComponentState extends State<InsuranceRegularDataCollectionComponent> {

  int selectedPolicyType = 1;
  int selectedPolicyPlan = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: [
          Padding(
            padding: flyternLargePaddingAll,
            child: Text("policy_type".tr,
                style: getBodyMediumStyle(context).copyWith(
                    color: flyternGrey80, fontWeight: flyternFontWeightBold)),
          ),
          Container(
            color: flyternBackgroundWhite,
            padding: flyternLargePaddingHorizontal.copyWith(top: flyternSpaceSmall),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Text("individual".tr,
                    style: getBodyMediumStyle(context)
                        .copyWith(color: flyternGrey80)),
                Radio(
                  activeColor: flyternSecondaryColor,
                  value: 1,
                  groupValue: selectedPolicyType,
                  onChanged: (value) {
                    setState(() {
                      print(value);
                      selectedPolicyType = value!;
                    });
                  },
                ),
              ],
            ),
          ),
          Container(
              color: flyternBackgroundWhite,            padding: flyternLargePaddingHorizontal,
              child: Divider()),
          Container(
            color: flyternBackgroundWhite,
            padding: flyternLargePaddingHorizontal.copyWith(bottom: flyternSpaceSmall),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Text("family".tr,
                    style: getBodyMediumStyle(context)
                        .copyWith(color: flyternGrey80)),
                Radio(
                  activeColor: flyternSecondaryColor,
                  value: 2,
                  groupValue: selectedPolicyType,
                  onChanged: (value) {
                    setState(() {
                      print(value);
                      selectedPolicyType = value!;
                    });
                  },
                ),
              ],
            ),
          ),

          Visibility(
            visible: selectedPolicyType==2,
            child: Padding(
              padding: flyternLargePaddingAll,
              child: Text("family_members".tr,
                  style: getBodyMediumStyle(context).copyWith(
                      color: flyternGrey80, fontWeight: flyternFontWeightBold)),
            ),
          ),
          Visibility(
            visible: selectedPolicyType==2,
            child: Container(
              padding: flyternLargePaddingHorizontal.copyWith(top: flyternSpaceLarge,bottom: flyternSpaceMedium),
              color: flyternBackgroundWhite,
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("family_member".tr+' 1',style: getBodyMediumStyle(context).copyWith(
                            color: flyternGrey60
                        )),
                        addVerticalSpace(flyternSpaceSmall),
                        TextFormField(
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                              labelText: "contributor".tr,
                            )),
                      ],
                    ),
                  ),
                  addHorizontalSpace(flyternSpaceMedium),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("family_member".tr+' 2',style: getBodyMediumStyle(context).copyWith(
                            color: flyternGrey60
                        )),
                        addVerticalSpace(flyternSpaceSmall),
                        TextFormField(
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                              labelText: "spouse".tr,
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Visibility(
            visible: selectedPolicyType==2,
            child: Container(
              padding: flyternLargePaddingHorizontal.copyWith(top: flyternSpaceSmall,bottom: flyternSpaceMedium),
              color: flyternBackgroundWhite,
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("family_member".tr+' 3',style: getBodyMediumStyle(context).copyWith(
                            color: flyternGrey60
                        )),
                        addVerticalSpace(flyternSpaceSmall),
                        TextFormField(
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                              labelText: "son".tr,
                            )),
                      ],
                    ),
                  ),
                  addHorizontalSpace(flyternSpaceMedium),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("family_member".tr+' 2',style: getBodyMediumStyle(context).copyWith(
                            color: flyternGrey60
                        )),
                        addVerticalSpace(flyternSpaceSmall),
                        TextFormField(
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                              labelText: "daughter".tr,
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: flyternLargePaddingAll,
            child: Text("policy_plan".tr,
                style: getBodyMediumStyle(context).copyWith(
                    color: flyternGrey80, fontWeight: flyternFontWeightBold)),
          ),
          Container(
            color: flyternBackgroundWhite,
            padding: flyternLargePaddingHorizontal.copyWith(top: flyternSpaceSmall),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Text("silver".tr,
                    style: getBodyMediumStyle(context)
                        .copyWith(color: flyternGrey80)),
                Radio(
                  activeColor: flyternSecondaryColor,
                  value: 1,
                  groupValue: selectedPolicyType,
                  onChanged: (value) {
                    setState(() {
                      print(value);
                      selectedPolicyType = value!;
                    });
                  },
                ),
              ],
            ),
          ),
          Container(
              color: flyternBackgroundWhite,            padding: flyternLargePaddingHorizontal,
              child: Divider()),
          Container(
            color: flyternBackgroundWhite,
            padding: flyternLargePaddingHorizontal ,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Text("gold".tr,
                    style: getBodyMediumStyle(context)
                        .copyWith(color: flyternGrey80)),
                Radio(
                  activeColor: flyternSecondaryColor,
                  value: 2,
                  groupValue: selectedPolicyType,
                  onChanged: (value) {
                    setState(() {
                      print(value);
                      selectedPolicyType = value!;
                    });
                  },
                ),
              ],
            ),
          ),
          Container(
              color: flyternBackgroundWhite,            padding: flyternLargePaddingHorizontal,
              child: Divider()),
          Container(
            color: flyternBackgroundWhite,
            padding: flyternLargePaddingHorizontal.copyWith(bottom: flyternSpaceSmall),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Text("platinum".tr,
                    style: getBodyMediumStyle(context)
                        .copyWith(color: flyternGrey80)),
                Radio(
                  activeColor: flyternSecondaryColor,
                  value: 2,
                  groupValue: selectedPolicyType,
                  onChanged: (value) {
                    setState(() {
                      print(value);
                      selectedPolicyType = value!;
                    });
                  },
                ),
              ],
            ),
          ),

          Padding(
            padding: flyternLargePaddingAll,
            child: Text("policy_time".tr,
                style: getBodyMediumStyle(context).copyWith(
                    color: flyternGrey80, fontWeight: flyternFontWeightBold)),
          ),
          Container(
            padding: flyternLargePaddingHorizontal.copyWith(top: flyternSpaceLarge,bottom: flyternSpaceMedium),
            color: flyternBackgroundWhite,
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        labelText: "select_policy_period".tr,
                      )),
                ),
                addHorizontalSpace(flyternSpaceMedium),
                Expanded(
                  child: TextFormField(
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        labelText: "select_policy_date".tr,
                      )),
                ),
              ],
            ),
          ),
          Container(
            height: 70+(flyternSpaceSmall*2),
            padding: flyternLargePaddingAll,
          )
        ],
      ),
    );
  }
}
