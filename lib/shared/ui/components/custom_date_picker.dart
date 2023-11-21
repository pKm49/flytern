import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flytern/shared/data/constants/app_specific/default_values.dart';
import 'package:flytern/shared/data/constants/ui_constants/style_params.dart';
import 'package:flytern/shared/data/constants/ui_constants/widget_styles.dart';
import 'package:flytern/shared/services/utility-services/widget_generator.dart';
import 'package:flytern/shared/services/utility-services/widget_properties_generator.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class CustomDatePicker extends StatefulWidget {
  DateTime selectedDate;
  DateTime? minimumDate;
  DateTime? maximumDate;

  final Function(DateTime? dateTime) dateSelected;

  CustomDatePicker(
      {super.key,
      required this.dateSelected,
      this.minimumDate,
      this.maximumDate,
      required this.selectedDate});

  @override
  State<CustomDatePicker> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  DateTime selectedDOB =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedDOB = widget.selectedDate;
  }

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
                  Expanded(
                      child: CalendarDatePicker2(
                    config: CalendarDatePicker2Config(
                      firstDate: widget.minimumDate ?? DefaultMinimumDate,
                      lastDate: widget.maximumDate ?? DefaultMaximumDate,
                    ),
                    value: [selectedDOB],
                    onValueChanged: (dates) => {
                      setState(() {
                        selectedDOB =
                            (dates.isNotEmpty ? dates[0] : DateTime.now()) ??
                                DateTime.now();
                      })
                    },
                  )),
                ],
              ),
            ),
          ),

          //; CupertinoDatePicker(
          //                       mode: CupertinoDatePickerMode.date,
          //                       initialDateTime: getInitialDate(),
          //                       minimumDate: widget.minimumDate ?? DefaultMinimumDate,
          //                       maximumDate: widget.maximumDate ?? DefaultMaximumDate,
          //                       onDateTimeChanged: (DateTime newDateTime) {
          //                         setState(() {
          //                           selectedDOB = newDateTime;
          //                         });
          //                       },
          //                     ),
          addVerticalSpace(flyternSpaceSmall),
          InkWell(
            onTap: () {
              print("date selected");
              print(selectedDOB.year);
              print(selectedDOB.month);
              print(selectedDOB.day);
              print(DateTime.now().year);
              print(DateTime.now().month);
              print(DateTime.now().day);
              if (selectedDOB.year == DateTime.now().year &&
                  selectedDOB.month == DateTime.now().month &&
                  selectedDOB.day == DateTime.now().day) {
                widget.dateSelected(widget.minimumDate);
              } else {
                widget.dateSelected(selectedDOB);
              }
              Navigator.pop(context);
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

  getInitialDate() {
    if (widget.selectedDate
            .isBefore(widget.maximumDate ?? DefaultMaximumDate) &&
        widget.selectedDate.isAfter(widget.minimumDate ?? DefaultMinimumDate)) {
      return widget.selectedDate;
    } else if (widget.selectedDate
        .isAfter(widget.maximumDate ?? DefaultMaximumDate)) {
      return widget.maximumDate;
    } else {
      return widget.minimumDate;
    }
  }
}
