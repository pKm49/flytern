import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flytern/shared/data/constants/ui_constants/style_params.dart';
import 'package:flytern/shared/data/constants/ui_constants/widget_styles.dart';
import 'package:flytern/shared/services/utility-services/widget_generator.dart';
import 'package:flytern/shared/services/utility-services/widget_properties_generator.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class BookingOptionsSelector extends StatefulWidget {

  int bookingServiceNumber;
  BookingOptionsSelector({super.key, required this.bookingServiceNumber});

  @override
  State<BookingOptionsSelector> createState() => _BookingOptionsSelectorState();
}

class _BookingOptionsSelectorState extends State<BookingOptionsSelector> {
  int selectedCabinClass = 1;

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Container(
      width: screenwidth,
      height:   widget.bookingServiceNumber==1?(screenheight*.65):(screenheight*.5),
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
                        Text( widget.bookingServiceNumber==1? "select_options".tr:
                        "select_users".tr,
                            style: getHeadlineMediumStyle(context).copyWith(
                                color: flyternGrey80,
                                fontWeight: flyternFontWeightBold),
                            textAlign: TextAlign.center),
                        Text("cancel".tr,
                            style: getHeadlineMediumStyle(context).copyWith(
                                color: flyternSecondaryColor ),
                            textAlign: TextAlign.center),
                      ],
                    ),
                  ),
                  addVerticalSpace(flyternSpaceSmall),
                  Divider(),
                  Visibility(
                      visible: widget.bookingServiceNumber==1,
                      child: addVerticalSpace(flyternSpaceLarge)),
                  Visibility(
                    visible: widget.bookingServiceNumber==1,
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
                                    style: getBodyMediumStyle(context).copyWith()),
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
                                    child: Icon(CupertinoIcons.plus_square,
                                        color: flyternGrey40,
                                        size: flyternFontSize24 * 1.2)),
                                Text("01",
                                    style: getBodyMediumStyle(context).copyWith()),
                                Expanded(
                                    child: Icon(CupertinoIcons.plus_square,
                                        color: flyternSecondaryColor,
                                        size: flyternFontSize24 * 1.2))
                              ],
                            ))
                      ],
                    ),
                  ),
                  addVerticalSpace(flyternSpaceExtraSmall),
                  Padding(padding: flyternLargePaddingHorizontal, child: Divider()),
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
                                    style: getBodyMediumStyle(context).copyWith()),
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
                                    child: Icon(CupertinoIcons.plus_square,
                                        color: flyternGrey40,
                                        size: flyternFontSize24 * 1.2)),
                                Text("01",
                                    style: getBodyMediumStyle(context).copyWith()),
                                Expanded(
                                    child: Icon(CupertinoIcons.plus_square,
                                        color: flyternSecondaryColor,
                                        size: flyternFontSize24 * 1.2))
                              ],
                            ))
                      ],
                    ),
                  ),
                  addVerticalSpace(flyternSpaceExtraSmall),
                  Padding(padding: flyternLargePaddingHorizontal, child: Divider()),
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
                                    style: getBodyMediumStyle(context).copyWith()),
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
                                    child: Icon(CupertinoIcons.plus_square,
                                        color: flyternGrey40,
                                        size: flyternFontSize24 * 1.2)),
                                Text("01",
                                    style: getBodyMediumStyle(context).copyWith()),
                                Expanded(
                                    child: Icon(CupertinoIcons.plus_square,
                                        color: flyternSecondaryColor,
                                        size: flyternFontSize24 * 1.2))
                              ],
                            ))
                      ],
                    ),
                  ),
                  Visibility(
                      visible: widget.bookingServiceNumber==1,child: addVerticalSpace(flyternSpaceExtraSmall)),
                  Visibility(
                      visible: widget.bookingServiceNumber==1,
                      child: Padding(padding: flyternLargePaddingHorizontal, child: Divider())),
                  addVerticalSpace(flyternSpaceLarge),
                  Visibility(
                    visible: widget.bookingServiceNumber==1,
                    child: Padding(
                      padding: flyternLargePaddingHorizontal,
                      child: Text("cabin_class".tr,
                          style: getBodyMediumStyle(context)
                              .copyWith(fontWeight: flyternFontWeightBold)),
                    ),
                  ),
                  Visibility(
                      visible: widget.bookingServiceNumber==1,child: addVerticalSpace(flyternSpaceMedium)),
                  Visibility(
                    visible: widget.bookingServiceNumber==1,
                    child: Padding(
                      padding: flyternLargePaddingHorizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                          Expanded(
                              flex: 1,
                              child: Row(
                                children: [

                                  Text("economy".tr,
                                      style: getBodyMediumStyle(context)
                                          .copyWith(color: flyternGrey80)),
                                  Radio(
                                    activeColor: flyternSecondaryColor,
                                    value: 1,
                                    groupValue: selectedCabinClass,
                                    onChanged: (value) {
                                      setState(() {
                                        print(value);
                                        selectedCabinClass = value!;
                                      });
                                    },
                                  ),
                                ],
                              )),
                          Expanded(
                              flex: 1,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [

                                  Text("business".tr,
                                      style: getBodyMediumStyle(context)
                                          .copyWith(color: flyternGrey80)),
                                  Radio(
                                    activeColor: flyternSecondaryColor,
                                    value: 2,
                                    groupValue: selectedCabinClass,
                                    onChanged: (value) {
                                      setState(() {
                                        print(value);
                                        selectedCabinClass = value!;
                                      });
                                    },
                                  ),
                                ],
                              )),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          addVerticalSpace(flyternSpaceSmall),
          Container(
            width: screenwidth,
            padding: flyternMediumPaddingAll,
            decoration: flyternBorderedContainerSmallDecoration,
            child: Center(
              child: Text("done".tr,style: getHeadlineMediumStyle(context).copyWith(color: flyternPrimaryColor,fontWeight: flyternFontWeightBold)),
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
