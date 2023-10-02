import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
 import 'package:flytern/shared/data/constants/ui_constants/style_params.dart';
import 'package:flytern/shared/data/constants/ui_constants/widget_styles.dart';
import 'package:flytern/shared/services/utility-services/widget_generator.dart';
import 'package:get/get.dart';
 
class DOBPicker extends StatefulWidget {
  final Function(DateTime dob) dobPicked;      // <------------|

  const DOBPicker({super.key, required this.dobPicked});

  @override
  State<DOBPicker> createState() => _DOBPickerState();
}

class _DOBPickerState extends State<DOBPicker> {

  DateTime selectedDOB = DateTime.now();


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius:
          BorderRadius.all(Radius.circular(flyternBorderRadiusLarge))),
      contentPadding: flyternSmallPaddingAll,
      content: StatefulBuilder(// You need this, notice the parameters below:
          builder: (BuildContext context, StateSetter _setState) {
            return SizedBox(
              height: 250,
              child: Column(
                children: [
                  Expanded(
                    child: CupertinoDatePicker(
                      mode: CupertinoDatePickerMode.date,
                      initialDateTime: DateTime(1969, 1, 1),
                      onDateTimeChanged: (DateTime newDateTime) {
                        setState(() {
                          selectedDOB = newDateTime;
                        });

                      },
                    ),
                  ),
                  addVerticalSpace(flyternSpaceMedium),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        child: Text(
                            "submit".tr,
                            textAlign: TextAlign.center),
                        onPressed: () {
                          widget.dobPicked(selectedDOB);

                          Navigator.pop(context);
                        }),
                  )
                ],
              ),
            );
          }),
    );
  }
}
