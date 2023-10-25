import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/business_models/cabin_class.dart';
import 'package:flytern/shared/data/constants/ui_constants/style_params.dart';
import 'package:flytern/shared/data/constants/ui_constants/widget_styles.dart';
import 'package:flytern/shared/services/utility-services/widget_generator.dart';
import 'package:flytern/shared/services/utility-services/widget_properties_generator.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class BookingOptionsSelector extends StatefulWidget {
  int bookingServiceNumber;
  int selectedAdultCount;
  int selectedChildCount;
  int selectedInfantCount;
  List<String> selectedCabinClasses;
  List<CabinClass> cabinClasses;
  final Function(int adultCount, int childCount, int infantCount,
      List<CabinClass> cabinClasses) dataSubmitted;

  BookingOptionsSelector({
    super.key,
    required this.bookingServiceNumber,
    required this.selectedAdultCount,
    required this.selectedChildCount,
    required this.selectedInfantCount,
    required this.selectedCabinClasses,
    required this.dataSubmitted,
    required this.cabinClasses,
  });

  @override
  State<BookingOptionsSelector> createState() => _BookingOptionsSelectorState();
}

class _BookingOptionsSelectorState extends State<BookingOptionsSelector> {
  int adultCount = 0;
  int childCount = 0;
  int infantCount = 0;
  List<String> selectedCabinClasses = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    adultCount = widget.selectedAdultCount;
    childCount = widget.selectedChildCount;
    infantCount = widget.selectedInfantCount;
    selectedCabinClasses = widget.selectedCabinClasses;
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Container(
      width: screenwidth,
      height: widget.bookingServiceNumber == 1
          ? ((screenheight * .65) + widget.cabinClasses.length * 33)
          : (screenheight * .5),
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
                        Text(
                            widget.bookingServiceNumber == 1
                                ? "select_options".tr
                                : "select_users".tr,
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
                  Visibility(
                      visible: widget.bookingServiceNumber == 1,
                      child: addVerticalSpace(flyternSpaceLarge)),
                  Visibility(
                    visible: widget.bookingServiceNumber == 1,
                    child: Padding(
                      padding: flyternLargePaddingHorizontal,
                      child: Text("passengers".tr,
                          style: getBodyMediumStyle(context)
                              .copyWith(fontWeight: flyternFontWeightBold)),
                    ),
                  ),
                  addVerticalSpace(flyternSpaceLarge),
                  Padding(
                    padding: flyternLargePaddingHorizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("adults".tr,
                                    style:
                                        getBodyMediumStyle(context).copyWith()),
                                addVerticalSpace(flyternSpaceExtraSmall),
                                Text("adult_description".tr,
                                    style: getBodyMediumStyle(context)
                                        .copyWith(color: flyternGrey40)),
                              ],
                            )),
                        Expanded(
                            flex: 1,
                            child: Row(
                              children: [
                                Expanded(
                                    child: InkWell(
                                  onTap: () {
                                    if(adultCount>0){
                                      setState(() {
                                        adultCount--;
                                      });
                                    }

                                  },
                                  child: Icon(CupertinoIcons.minus_square,
                                      color: adultCount > 0
                                          ? flyternSecondaryColor
                                          : flyternGrey40,
                                      size: flyternFontSize24 * 1.2),
                                )),
                                Text(adultCount.toString(),
                                    style:
                                        getBodyMediumStyle(context).copyWith()),
                                Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          adultCount++;
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
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("children".tr,
                                    style:
                                        getBodyMediumStyle(context).copyWith()),
                                addVerticalSpace(flyternSpaceExtraSmall),
                                Text("children_description".tr,
                                    style: getBodyMediumStyle(context)
                                        .copyWith(color: flyternGrey40)),
                              ],
                            )),
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
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("infants".tr,
                                    style:
                                        getBodyMediumStyle(context).copyWith()),
                                addVerticalSpace(flyternSpaceExtraSmall),
                                Text("infant_description".tr,
                                    style: getBodyMediumStyle(context)
                                        .copyWith(color: flyternGrey40)),
                              ],
                            )),
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
                  Visibility(
                      visible: widget.bookingServiceNumber == 1,
                      child: addVerticalSpace(flyternSpaceExtraSmall)),
                  Visibility(
                      visible: widget.bookingServiceNumber == 1,
                      child: Padding(
                          padding: flyternLargePaddingHorizontal,
                          child: Divider())),
                  addVerticalSpace(flyternSpaceLarge),
                  Visibility(
                    visible: widget.bookingServiceNumber == 1,
                    child: Padding(
                      padding: flyternLargePaddingHorizontal,
                      child: Text("cabin_class".tr,
                          style: getBodyMediumStyle(context)
                              .copyWith(fontWeight: flyternFontWeightBold)),
                    ),
                  ),
                  Visibility(
                      visible: widget.bookingServiceNumber == 1,
                      child: addVerticalSpace(flyternSpaceMedium)),
                  for (var i = 0; i < widget.cabinClasses.length; i++)
                    Visibility(
                      visible: widget.bookingServiceNumber == 1,
                      child: Padding(
                          padding: flyternLargePaddingHorizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(widget.cabinClasses[i].name,
                                  style: getBodyMediumStyle(context)),
                              Checkbox(
                                checkColor: Colors.white,
                                fillColor:
                                    MaterialStateProperty.resolveWith(getColor),
                                value: selectedCabinClasses
                                    .contains(widget.cabinClasses[i].value),
                                onChanged: (bool? value) {
                                  if (value != null) {
                                    if (value) {
                                      selectedCabinClasses.contains(
                                              widget.cabinClasses[i].value)
                                          ? null
                                          : selectedCabinClasses.add(
                                              widget.cabinClasses[i].value);
                                    } else {
                                      selectedCabinClasses.contains(
                                              widget.cabinClasses[i].value)
                                          ? selectedCabinClasses.remove(
                                              widget.cabinClasses[i].value)
                                          : null;
                                    }

                                    setState(() {});
                                  }
                                },
                              ),
                            ],
                          )),
                    ),
                ],
              ),
            ),
          ),
          addVerticalSpace(flyternSpaceSmall),
          InkWell(
            onTap: (){
              widget.dataSubmitted(
                  adultCount, childCount, infantCount,
                  widget.cabinClasses.where((element) => selectedCabinClasses.contains(element.value)).toList()
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
