import 'package:flutter/material.dart';
import 'package:flytern/shared/data/constants/ui_constants/style_params.dart';
import 'package:flytern/shared/data/constants/ui_constants/widget_styles.dart';
import 'package:flytern/shared/services/utility-services/widget_generator.dart';
import 'package:flytern/shared/services/utility-services/widget_properties_generator.dart';
import 'package:get/get.dart';

class SortOptionSelector extends StatefulWidget {

  String title;
  List<String> values;

    SortOptionSelector({super.key, required this.title, required this.values});

  @override
  State<SortOptionSelector> createState() => _SortOptionSelectorState();
}

class _SortOptionSelectorState extends State<SortOptionSelector> {

  int selectedSort = 1;
  
  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Container(
      width: screenwidth,
      height: screenheight*.4,
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
                        Text(widget.title,
                            style: getHeadlineMediumStyle(context).copyWith(
                                color: flyternGrey80,
                                fontWeight: flyternFontWeightBold),
                            textAlign: TextAlign.center),
                        Text("done".tr,
                            style: getHeadlineMediumStyle(context).copyWith(
                                color: flyternPrimaryColor,
                                fontWeight: flyternFontWeightBold),
                            textAlign: TextAlign.center),
                      ],
                    ),
                  ),
                  addVerticalSpace(flyternSpaceSmall),
                  Divider(),
                  addVerticalSpace(flyternSpaceMedium),
                  Padding(
                    padding: flyternLargePaddingHorizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        Text(widget.values.length>0?widget.values[0]:'',
                            style: getBodyMediumStyle(context)
                                .copyWith(color: flyternGrey80)),
                        Radio(
                          activeColor: flyternSecondaryColor,
                          value: 1,
                          groupValue: selectedSort,
                          onChanged: (value) {
                            setState(() {
                              print(value);
                              selectedSort = value!;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  addVerticalSpace(flyternSpaceMedium),
                  Padding(
                    padding: flyternLargePaddingHorizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        Text(widget.values.length>1?widget.values[1]:'',
                            style: getBodyMediumStyle(context)
                                .copyWith(color: flyternGrey80)),
                        Radio(
                          activeColor: flyternSecondaryColor,
                          value: 1,
                          groupValue: selectedSort,
                          onChanged: (value) {
                            setState(() {
                              print(value);
                              selectedSort = value!;
                            });
                          },
                        ),
                      ],
                    )
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
              child: Text("cancel".tr,style: getHeadlineMediumStyle(context).copyWith(color: flyternSecondaryColor)),
            ),
          )
        ],
      ),
    );
  }
}
