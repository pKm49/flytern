import 'package:flutter/material.dart';
import 'package:flytern/shared-module/models/sorting_dcs.dart';
import 'package:flytern/shared-module/constants/ui_specific/style_params.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/widget_styles.shared.constant.dart';
import 'package:flytern/shared-module/services/utility-services/widget_generator.shared.service.dart';
import 'package:flytern/shared-module/services/utility-services/widget_properties_generator.shared.service.dart';
import 'package:get/get.dart';

class SortOptionSelector extends StatefulWidget {
  String selectedSort;
  String title;
  List<SortingDcs> sortingDcs;
  final Function(String selectedSort) sortChanged;      // <------------|

  SortOptionSelector(
      {super.key,
      required this.title,
      required this.selectedSort,
      required this.sortChanged,
      required this.sortingDcs});

  @override
  State<SortOptionSelector> createState() => _SortOptionSelectorState();
}

class _SortOptionSelectorState extends State<SortOptionSelector> {
  String selectedSort = "1";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedSort = widget.selectedSort;
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Container(
      width: screenwidth,
      height: (widget.sortingDcs.length * 60)+200,
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
                        Text("cancel".tr,
                            style: getBodyMediumStyle(context).copyWith(
                                color: flyternSecondaryColor,
                                fontWeight: flyternFontWeightBold),
                            textAlign: TextAlign.center),
                      ],
                    ),
                  ),
                  addVerticalSpace(flyternSpaceSmall),
                  Divider(),
                  addVerticalSpace(flyternSpaceMedium),
                  Expanded(
                      child: ListView.builder(
                          itemCount: widget.sortingDcs.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: flyternLargePaddingHorizontal.copyWith(
                                  bottom: flyternSpaceMedium),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(widget.sortingDcs[index].name,
                                      style: getBodyMediumStyle(context)
                                          .copyWith(color: flyternGrey80)),
                                  Radio(
                                    activeColor: flyternSecondaryColor,
                                    value: widget.sortingDcs[index].value,
                                    groupValue: selectedSort,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedSort = value!;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            );
                          })),
                ],
              ),
            ),
          ),
          addVerticalSpace(flyternSpaceSmall),
          InkWell(
            onTap: (){
              widget.sortChanged(selectedSort);
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
}
