import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flytern/feature-modules/flight_booking/models/cabin_class.flight_booking.model.dart';
import 'package:flytern/shared-module/constants/ui_specific/style_params.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/widget_styles.shared.constant.dart';
import 'package:flytern/shared-module/models/general_item.dart';
import 'package:flytern/shared-module/services/utility-services/widget_generator.shared.service.dart';
import 'package:flytern/shared-module/services/utility-services/widget_properties_generator.shared.service.dart';
import 'package:flytern/shared-module/ui/components/dropdown_selector.shared.component.dart';
import 'package:get/get.dart';

class BookingOptionsSelector extends StatefulWidget {
  int bookingServiceNumber;
  int selectedAdultCount;
  int selectedChildCount;
  int selectedInfantCount;
  List<String> selectedCabinClasses;
  List<int> childAges;
  List<CabinClass> cabinClasses;
  final Function(int adultCount, int childCount, int infantCount,
      List<CabinClass> cabinClasses, List<int> childAges) dataSubmitted;

  BookingOptionsSelector({
    super.key,
    required this.bookingServiceNumber,
    required this.selectedAdultCount,
    required this.selectedChildCount,
    required this.selectedInfantCount,
    required this.selectedCabinClasses,
    required this.dataSubmitted,
    required this.cabinClasses,
    required this.childAges,
  });

  @override
  State<BookingOptionsSelector> createState() => _BookingOptionsSelectorState();
}

class _BookingOptionsSelectorState extends State<BookingOptionsSelector> {
  int adultCount = 0;
  int childCount = 0;
  int infantCount = 0;
  String selectedCabinClasses = "";
  List<int> childAges = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    adultCount = widget.selectedAdultCount;
    childCount = widget.selectedChildCount;
    infantCount = widget.selectedInfantCount;
    selectedCabinClasses = widget.selectedCabinClasses.isNotEmpty?widget.selectedCabinClasses[0]:"";
    childAges = widget.childAges;
    setState(() {});
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
              child: ListView(
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
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Text("cancel".tr,
                              style: getHeadlineMediumStyle(context)
                                  .copyWith(color: flyternSecondaryColor),
                              textAlign: TextAlign.center),
                        ),
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
                                    if (adultCount > 1) {
                                      setState(() {
                                        reduceAdultCount();
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
                                      if (getAdultMaxCountConditionStatusMet()) {
                                        adultCount++;
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
                                Text(
                                    widget.bookingServiceNumber == 1
                                        ? "children_description".tr
                                        : "children_description_hotel".tr,
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
                                    if (childCount > 0) {
                                      setState(() {
                                        // if(widget.bookingServiceNumber==2){
                                        //   childAges.removeAt(childCount--);
                                        // }
                                        childAges.removeAt(--childCount);
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
                                      if (getChildMaxCountConditionStatusMet()) {
                                        childCount++;
                                        childAges.add(childCount);
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
                  Visibility(
                      visible: widget.bookingServiceNumber != 2,
                      child: addVerticalSpace(flyternSpaceExtraSmall)),
                  Visibility(
                      visible: widget.bookingServiceNumber != 2,
                      child: const Padding(
                          padding: flyternLargePaddingHorizontal,
                          child: Divider())),
                  Visibility(
                    visible: widget.bookingServiceNumber != 2,
                    child: Padding(
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
                                      style: getBodyMediumStyle(context)
                                          .copyWith()),
                                  addVerticalSpace(flyternSpaceExtraSmall),
                                  Text("infant_description".tr,
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
                                      if (infantCount > 0) {
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
                                      style: getBodyMediumStyle(context)
                                          .copyWith()),
                                  Expanded(
                                      child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        if (getInfantMaxCountConditionStatusMet()) {
                                          infantCount++;
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
                  ),
                  Visibility(
                      visible: widget.bookingServiceNumber == 1,
                      child: addVerticalSpace(flyternSpaceExtraSmall)),
                  Visibility(
                      visible: widget.bookingServiceNumber == 1,
                      child: Padding(
                          padding: flyternLargePaddingHorizontal,
                          child: Divider())),
                  Visibility(
                      visible: widget.bookingServiceNumber == 1,
                      child: addVerticalSpace(flyternSpaceLarge)),
                  Visibility(
                      visible:
                          childCount > 0 && widget.bookingServiceNumber == 2,
                      child: addVerticalSpace(flyternSpaceLarge * 2)),
                  for (var i = 0; i < childCount; i++)
                    Visibility(
                      visible: widget.bookingServiceNumber == 2,
                      child: Container(
                          decoration: BoxDecoration(
                              border: flyternDefaultBorderBottomOnly),
                          padding: flyternLargePaddingHorizontal.copyWith(
                              bottom: flyternSpaceSmall,
                              top: flyternSpaceSmall),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 2,
                                child: Text(
                                    "age_for_child"
                                        .tr
                                        .replaceAll("1", (i + 1).toString()),
                                    style: getBodyMediumStyle(context)),
                              ),
                              Expanded(
                                flex: 1,
                                child: DropDownSelector(
                                  validator: (value) => null,
                                  titleText: "",
                                  selected: "1",
                                  items: [
                                    for (var ind = 1; ind < 17; ind++)
                                      GeneralItem(
                                          id: ind.toString(),
                                          name: ind.toString(),
                                          imageUrl: "")
                                  ],
                                  hintText: "",
                                  valueChanged: (newLang) {
                                    List<int> tChildAges = [];
                                    for (var indx = 0;
                                        indx < childCount;
                                        indx++) {
                                      if (i == indx) {
                                        tChildAges.add(int.parse(newLang));
                                      } else {
                                        tChildAges.add(childAges[i]);
                                      }
                                    }
                                  },
                                ),
                              ),
                            ],
                          )),
                    ),
                  Visibility(
                      visible: widget.bookingServiceNumber == 1,
                      child: addVerticalSpace(flyternSpaceLarge)),
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
                              Radio(
                                activeColor: flyternSecondaryColor,
                                value: widget.cabinClasses[i].value,
                                groupValue: selectedCabinClasses,
                                onChanged: (value) {
                                  setState(() {
                                    if (value != null) {
                                      selectedCabinClasses =
                                          widget.cabinClasses[i].value;
                                    }
                                    setState(() {});
                                  });
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
            onTap: () {
              widget.dataSubmitted(
                  adultCount,
                  childCount,
                  infantCount,
                  widget.cabinClasses
                      .where((element) =>
                          selectedCabinClasses == element.value)
                      .toList(),
                  childAges);
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

  bool getAdultMaxCountConditionStatusMet() {
    if (widget.bookingServiceNumber != 1) {
      return adultCount < 6;
    }

    if (adultCount + childCount + infantCount < 9) {
      return true;
    }
    return false;
  }

  void reduceAdultCount() {
    adultCount--;
    if (infantCount > 0) {
      infantCount--;
    }
    setState(() {});
  }

  bool getChildMaxCountConditionStatusMet() {
    if (widget.bookingServiceNumber != 1) {
      return childCount < 4;
    }

    if (adultCount + childCount + infantCount < 9) {
      return true;
    }
    return false;
  }

  bool getInfantMaxCountConditionStatusMet() {
    if (widget.bookingServiceNumber != 1) {
      return true;
    }

    if (adultCount + childCount + infantCount < 9 && infantCount < adultCount) {
      return true;
    }
    return false;
  }
}
