import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/business_models/cabin_class.dart';
import 'package:flytern/shared/data/constants/ui_constants/style_params.dart';
import 'package:flytern/shared/data/constants/ui_constants/widget_styles.dart';
import 'package:flytern/shared/services/utility-services/widget_generator.dart';
import 'package:flytern/shared/services/utility-services/widget_properties_generator.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class FamilyMemberCountSelector extends StatefulWidget {
 
  int selectedSpouseCount;
  int selectedDaughterCount;
  int selectedSonCount;
  final Function(int spouseCount, int daughterCount, int sonCount ) dataSubmitted;

  FamilyMemberCountSelector({
    super.key,
    required this.selectedSpouseCount,
    required this.selectedDaughterCount,
    required this.selectedSonCount,
    required this.dataSubmitted,
  });

  @override
  State<FamilyMemberCountSelector> createState() => _FamilyMemberCountSelectorState();
}

class _FamilyMemberCountSelectorState extends State<FamilyMemberCountSelector> {
  int spouseCount = 0;
  int childCount = 0;
  int infantCount = 0;
  List<String> selectedCabinClasses = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    spouseCount = widget.selectedSpouseCount;
    childCount = widget.selectedDaughterCount;
    infantCount = widget.selectedSonCount;
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Container(
      width: screenwidth,
      height:  (screenheight * .42),
      padding: flyternSmallPaddingAll,
      child: Column(
        children: [
          Expanded(
            child: Container(
              width: screenwidth,
              padding: flyternLargePaddingVertical,
              decoration: flyternBorderedContainerSmallDecoration,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: flyternLargePaddingHorizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(  "select_users".tr,
                            style: getHeadlineMediumStyle(context).copyWith(
                                color: flyternGrey80,
                                fontWeight: flyternFontWeightBold),
                            textAlign: TextAlign.center),
                        Text("cancel".tr,
                            style: getHeadlineMediumStyle(context)
                                .copyWith(color: flyternSecondaryColor),
                            textAlign: TextAlign.center),
                      ],
                    ),
                  ),
                  addVerticalSpace(flyternSpaceSmall),
                  Divider(),

                  addVerticalSpace(flyternSpaceLarge),
                  Padding(
                    padding: flyternLargePaddingHorizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            flex: 2,
                            child:Text("spouse".tr,
                                style:
                                getBodyMediumStyle(context).copyWith())),
                        Expanded(
                            flex: 1,
                            child: Row(
                              children: [
                                Expanded(
                                    child: InkWell(
                                  onTap: () {
                                    if(spouseCount>0){
                                      setState(() {
                                        spouseCount--;
                                      });
                                    }

                                  },
                                  child: Icon(CupertinoIcons.minus_square,
                                      color: spouseCount > 0
                                          ? flyternSecondaryColor
                                          : flyternGrey40,
                                      size: flyternFontSize24 * 1.2),
                                )),
                                Text(spouseCount.toString(),
                                    style:
                                        getBodyMediumStyle(context).copyWith()),
                                Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          if(spouseCount<1){
                                            spouseCount++;
                                          }
                                        });
                                      },
                                      child: Icon(CupertinoIcons.plus_square,
                                          color: flyternSecondaryColor,
                                          size: flyternFontSize24 * 1.2),
                                    ))
                              ],
                            ))
                      ],
                    ),
                  ),
                  addVerticalSpace(flyternSpaceExtraSmall),
                  Padding(
                      padding: flyternLargePaddingHorizontal, child: Divider()),
                  addVerticalSpace(flyternSpaceExtraSmall),
                  Padding(
                    padding: flyternLargePaddingHorizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            flex: 2,
                            child: Text("daughter".tr,
                                style:
                                getBodyMediumStyle(context).copyWith()),),
                        Expanded(
                            flex: 1,
                            child: Row(
                              children: [
                                Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        if(childCount>0){
                                          setState(() {
                                            childCount--;
                                          });
                                        }

                                      },
                                      child: Icon(CupertinoIcons.minus_square,
                                          color: childCount > 0
                                              ? flyternSecondaryColor
                                              : flyternGrey40,
                                          size: flyternFontSize24 * 1.2),
                                    )),
                                Text(childCount.toString(),
                                    style:
                                    getBodyMediumStyle(context).copyWith()),
                                Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          childCount++;
                                        });
                                      },
                                      child: Icon(CupertinoIcons.plus_square,
                                          color: flyternSecondaryColor,
                                          size: flyternFontSize24 * 1.2),
                                    ))
                              ],
                            ))
                      ],
                    ),
                  ),
                  addVerticalSpace(flyternSpaceExtraSmall),
                  Padding(
                      padding: flyternLargePaddingHorizontal, child: Divider()),
                  Padding(
                    padding: flyternLargePaddingHorizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            flex: 2,
                            child:  Text("son".tr,
                                style:
                                getBodyMediumStyle(context).copyWith())),
                        Expanded(
                            flex: 1,
                            child:Row(
                              children: [
                                Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        if(infantCount>0){
                                          setState(() {
                                            infantCount--;
                                          });
                                        }

                                      },
                                      child: Icon(CupertinoIcons.minus_square,
                                          color: infantCount > 0
                                              ? flyternSecondaryColor
                                              : flyternGrey40,
                                          size: flyternFontSize24 * 1.2),
                                    )),
                                Text(infantCount.toString(),
                                    style:
                                    getBodyMediumStyle(context).copyWith()),
                                Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          infantCount++;
                                        });
                                      },
                                      child: Icon(CupertinoIcons.plus_square,
                                          color: flyternSecondaryColor,
                                          size: flyternFontSize24 * 1.2),
                                    ))
                              ],
                            ))
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          addVerticalSpace(flyternSpaceSmall),
          InkWell(
            onTap: (){
              widget.dataSubmitted(
                  spouseCount, childCount, infantCount
              );
            },
            child: Container(
              width: screenwidth,
              padding: flyternMediumPaddingAll,
              decoration: flyternBorderedContainerSmallDecoration,
              child: Center(
                child: Text("done".tr,
                    style: getHeadlineMediumStyle(context).copyWith(
                        color: flyternPrimaryColor,
                        fontWeight: flyternFontWeightBold)),
              ),
            ),
          )
        ],
      ),
    );
  }

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
      MaterialState.selected
    };
    if (states.any(interactiveStates.contains)) {
      return flyternSecondaryColor;
    }
    return flyternBackgroundWhite;
  }
}
