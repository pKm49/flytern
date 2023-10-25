import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flytern/shared/data/constants/ui_constants/style_params.dart';
import 'package:flytern/shared/data/constants/ui_constants/widget_styles.dart';
import 'package:flytern/shared/services/utility-services/widget_generator.dart';
import 'package:flytern/shared/services/utility-services/widget_properties_generator.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class CustomDatePicker extends StatefulWidget {

  DateTime selectedDate;
  final Function(DateTime? dateTime) dateSelected;

  CustomDatePicker({super.key, required this.dateSelected, required this.selectedDate});

  @override
  State<CustomDatePicker> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  DateTime selectedDOB = DateTime.now();

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Container(
      width: screenwidth,
      height: screenheight * .5,
      padding: flyternSmallPaddingAll,
      child: Column(
        children: [
          Expanded(
            child: Container(
              width: screenwidth,
              padding: flyternLargePaddingVertical,
              decoration: flyternBorderedContainerSmallDecoration,
              child: Column(
                children: [
                  Padding(
                    padding: flyternLargePaddingHorizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("select_date".tr,
                            style: getHeadlineMediumStyle(context).copyWith(
                                color: flyternGrey80,
                                fontWeight: flyternFontWeightBold),
                            textAlign: TextAlign.center),
                        InkWell(
                            onTap: (){
                              Navigator.pop(context);
                            },
                          child: Text("cancel".tr,
                              style: getHeadlineMediumStyle(context).copyWith(
                                  color: flyternSecondaryColor ),
                              textAlign: TextAlign.center),
                        ),
                      ],
                    ),
                  ),
                  addVerticalSpace(flyternSpaceSmall),
                  Divider(),
                  Expanded(
                    child: CupertinoDatePicker(
                      mode: CupertinoDatePickerMode.date,
                      initialDateTime: widget.selectedDate,
                      onDateTimeChanged: (DateTime newDateTime) {
                        setState(() {
                          selectedDOB = newDateTime;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          addVerticalSpace(flyternSpaceSmall),
          InkWell(
            onTap:() {
              widget.dateSelected(selectedDOB);
              Navigator.pop(context);
              },
            child: Container(
              width: screenwidth,
              padding: flyternMediumPaddingAll,
              decoration: flyternBorderedContainerSmallDecoration,
              child: Center(
                child: Text("done".tr,
                    style: getHeadlineMediumStyle(context)
                        .copyWith(color: flyternPrimaryColor,fontWeight: flyternFontWeightBold)),
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
