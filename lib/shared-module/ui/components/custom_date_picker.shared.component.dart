import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flytern/shared-module/constants/app_specific/default_values.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/style_params.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/widget_styles.shared.constant.dart';
import 'package:flytern/shared-module/services/utility-services/widget_generator.shared.service.dart';
import 'package:flytern/shared-module/services/utility-services/widget_properties_generator.shared.service.dart';
import 'package:get/get.dart';

class CustomDatePicker extends StatefulWidget {
  DateTime selectedDate;
  DateTime? minimumDate;
  DateTime? maximumDate;
  String? title;
  bool? isSingleTapSubmission;
  DatePickerMode? calendarViewMode;
  final Function(DateTime? dateTime) dateSelected;

  CustomDatePicker(
      {super.key,
      required this.dateSelected,
      this.minimumDate,
      this.maximumDate,
      this.calendarViewMode,
      this.title,
      this.isSingleTapSubmission,
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

    if(widget.selectedDate.day == DefaultInvalidDate.day &&
        widget.selectedDate.month == DefaultInvalidDate.month &&
        widget.selectedDate.year == DefaultInvalidDate.year){
      selectedDOB = DOBCalendarStartDate;
    }else{
      selectedDOB = widget.selectedDate;
    }

  }

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Container(
      width: screenwidth,
      height:widget.isSingleTapSubmission==true?screenheight*.6: screenheight * .7,
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
                        Text(widget.title != null? widget.title!: "select_date".tr ,
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
                  const Divider(),
                  Expanded(
                    child: ListView(
                      children: [
                        CalendarDatePicker2(
                          config: CalendarDatePicker2Config(
                            calendarViewMode:widget.calendarViewMode ?? DatePickerMode.day,
                        firstDate: widget.minimumDate ?? DefaultMinimumDate,
                        lastDate: widget.maximumDate ?? DefaultMaximumDate,
                          ),
                          value: [selectedDOB],
                          onValueChanged: (dates) => {
                        setState(() {
                          selectedDOB =
                              (dates.isNotEmpty ? dates[0] : DateTime.now()) ??
                                  DateTime.now();
                          print("widget.isSingleTapSubmission");
                          print(widget.isSingleTapSubmission);
                          if(widget.isSingleTapSubmission == true){
                            widget.dateSelected(selectedDOB);
                            Navigator.pop(context);
                          }

                        })
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          addVerticalSpace(flyternSpaceSmall),
          Visibility( 
            visible: widget.isSingleTapSubmission != true,
            child: InkWell(
              onTap: () {
                widget.dateSelected(selectedDOB);

                // if (selectedDOB.year == DateTime.now().year &&
                //     selectedDOB.month == DateTime.now().month &&
                //     selectedDOB.day == DateTime.now().day) {
                //   widget.dateSelected(widget.selectedDate);
                // } else {
                //   widget.dateSelected(selectedDOB);
                // }
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
