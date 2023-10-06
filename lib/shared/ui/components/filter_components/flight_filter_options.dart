import 'package:flutter/material.dart';
import 'package:flytern/shared/data/constants/ui_constants/style_params.dart';
import 'package:flytern/shared/data/constants/ui_constants/widget_styles.dart';
import 'package:flytern/shared/services/utility-services/widget_generator.dart';
import 'package:flytern/shared/services/utility-services/widget_properties_generator.dart';
import 'package:flytern/shared/ui/components/filter_option_selector.dart';
import 'package:flytern/shared/ui/components/selectable_text_pill.dart';
import 'package:get/get.dart';

class FlightFilterOptions extends StatefulWidget {

  final GestureTapCallback setModalState;

  FlightFilterOptions({super.key, required this.setModalState});

  @override
  State<FlightFilterOptions> createState() => _FlightFilterOptionsState();
}

class _FlightFilterOptionsState extends State<FlightFilterOptions> {

  bool isAirline1Selected = false;
  bool isAirline2Selected = false;
  bool isAirline3Selected = false;
  bool isAirline4Selected = false;
  int selectedFilter = 1;
  double _currentSliderValue = 20;
  List<int> selectedDepartureDates = [];
  List<int> selectedArrivalDates = [];

  @override
  Widget build(BuildContext context) {

    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Column(
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
                      Text("filter".tr,
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
                    child: ListView(
                      children: [

                        // price
                        Padding(
                          padding: flyternLargePaddingHorizontal,
                          child: Text("price".tr,
                              style: getBodyMediumStyle(context)
                                  .copyWith(fontWeight: flyternFontWeightBold)),
                        ),
                        addVerticalSpace(flyternSpaceMedium),
                        Container(
                          color: flyternBackgroundWhite,
                          padding: flyternLargePaddingHorizontal,
                          height: 75,
                          child: Column(
                            children: [
                              const Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(child: Text("AED 1000")),
                                  Expanded(child: Text("AED 1500")),
                                  Expanded(child: Text("AED 2000")),
                                ],
                              ),

                              SliderTheme(
                                data: SliderThemeData(
                                  // here
                                  trackShape: CustomTrackShape(),
                                ),
                                child: Slider(

                                  value: _currentSliderValue,
                                  max: 100,
                                  divisions: 3,
                                  activeColor: flyternSecondaryColor,
                                  label: _currentSliderValue.round().toString(),
                                  onChanged: (double value) {
                                    setState(() {
                                      _currentSliderValue = value;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),

                        //airline
                        const Padding(
                          padding: flyternLargePaddingHorizontal,
                          child: Divider(),
                        ),
                        addVerticalSpace(flyternSpaceMedium),

                        Padding(
                          padding: flyternLargePaddingHorizontal,
                          child: Text("airline".tr,
                              style: getBodyMediumStyle(context)
                                  .copyWith(fontWeight: flyternFontWeightBold)),
                        ),
                        addVerticalSpace(flyternSpaceSmall),
                        Padding(
                            padding:flyternLargePaddingHorizontal,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Air Canada (3)",
                                    style: getBodyMediumStyle(context) ),
                                Checkbox(
                                  checkColor: Colors.white,
                                  fillColor: MaterialStateProperty.resolveWith(getColor),
                                  value: isAirline1Selected,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      isAirline1Selected = value??false;
                                    });
                                  },
                                ),
                              ],
                            )),
                        addVerticalSpace(flyternSpaceExtraSmall),
                        Padding(
                            padding:flyternLargePaddingHorizontal,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("PIA (10)",
                                    style: getBodyMediumStyle(context) ),
                                Checkbox(
                                  checkColor: Colors.white,
                                  fillColor: MaterialStateProperty.resolveWith(getColor),
                                  value: isAirline2Selected,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      isAirline2Selected = value??false;
                                    });
                                  },
                                ),
                              ],
                            )),
                        addVerticalSpace(flyternSpaceExtraSmall),
                        Padding(
                            padding:flyternLargePaddingHorizontal,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Qatar Airways (4)",
                                    style: getBodyMediumStyle(context) ),
                                Checkbox(
                                  checkColor: Colors.white,
                                  fillColor: MaterialStateProperty.resolveWith(getColor),
                                  value: isAirline3Selected,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      isAirline3Selected = value??false;
                                    });
                                  },
                                ),
                              ],
                            )),
                        addVerticalSpace(flyternSpaceExtraSmall),
                        Padding(
                            padding:flyternLargePaddingHorizontal,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Air Blue (5)",
                                    style: getBodyMediumStyle(context) ),
                                Checkbox(
                                  checkColor: Colors.white,
                                  fillColor: MaterialStateProperty.resolveWith(getColor),
                                  value: isAirline4Selected,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      isAirline4Selected = value??false;
                                    });
                                  },
                                ),
                              ],
                            )),
                        addVerticalSpace(flyternSpaceMedium),

                        //  Departure Time
                        const Padding(
                          padding: flyternLargePaddingHorizontal,
                          child: Divider(),
                        ),
                        addVerticalSpace(flyternSpaceMedium),
                        Padding(
                          padding: flyternLargePaddingHorizontal,
                          child: Text("departure_time".tr,
                              style: getBodyMediumStyle(context)
                                  .copyWith(fontWeight: flyternFontWeightBold)),
                        ),
                        Padding(
                          padding: flyternLargePaddingAll,
                          child: Wrap(
                            children: [
                              for(var i=6;i<12;i++)
                                Padding(
                                  padding: const EdgeInsets.only(right:flyternSpaceSmall,bottom: flyternSpaceSmall),
                                  child: SelectableTilePill(
                                    onPressed:(){
                                      if(selectedDepartureDates.contains(i)){
                                        selectedDepartureDates.remove(i);
                                      }else{
                                        selectedDepartureDates.add(i);
                                      }
                                      print('SelectableTilePill modalState Changed');

                                      setState(() {
                                      });
                                      widget.setModalState();
                                    },
                                    label: '$i:00PM',
                                    isSelected: selectedDepartureDates.contains(i),
                                    themeNumber: 2,
                                  ),
                                ),
                            ],
                          ),
                        ),
                        const Padding(
                          padding: flyternLargePaddingHorizontal,
                          child: Divider(),
                        ),
                        addVerticalSpace(flyternSpaceMedium),
                        Padding(
                          padding: flyternLargePaddingHorizontal,
                          child: Text("arrival_time".tr,
                              style: getBodyMediumStyle(context)
                                  .copyWith(fontWeight: flyternFontWeightBold)),
                        ),
                        Padding(
                          padding: flyternLargePaddingAll,
                          child: Wrap(
                            children: [
                              for(var i=6;i<12;i++)
                                Padding(
                                  padding: const EdgeInsets.only(right:flyternSpaceSmall,bottom: flyternSpaceSmall),
                                  child: SelectableTilePill(
                                    onPressed:(){
                                      if(selectedArrivalDates.contains(i)){
                                        selectedArrivalDates.remove(i);
                                      }else{
                                        selectedArrivalDates.add(i);
                                      }

                                      print('SelectableTilePill modalState Changed');

                                      setState(() {
                                      });
                                      widget.setModalState();
                                    },
                                    label: '$i:00PM',
                                    isSelected: selectedArrivalDates.contains(i),
                                    themeNumber: 2,
                                  ),
                                ),
                            ],
                          ),
                        ),
                        const Padding(
                          padding: flyternLargePaddingHorizontal,
                          child: Divider(),
                        ),
                        addVerticalSpace(flyternSpaceMedium),
                        Padding(
                          padding: flyternLargePaddingHorizontal,
                          child: Text("stops".tr,
                              style: getBodyMediumStyle(context)
                                  .copyWith(fontWeight: flyternFontWeightBold)),
                        ),
                        addVerticalSpace(flyternSpaceSmall),
                        Padding(
                            padding:flyternLargePaddingHorizontal,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Air Canada (3)",
                                    style: getBodyMediumStyle(context) ),
                                Checkbox(
                                  checkColor: Colors.white,
                                  fillColor: MaterialStateProperty.resolveWith(getColor),
                                  value: isAirline1Selected,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      isAirline1Selected = value??false;
                                    });
                                  },
                                ),
                              ],
                            )),
                        addVerticalSpace(flyternSpaceExtraSmall),
                        Padding(
                            padding:flyternLargePaddingHorizontal,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("PIA (10)",
                                    style: getBodyMediumStyle(context) ),
                                Checkbox(
                                  checkColor: Colors.white,
                                  fillColor: MaterialStateProperty.resolveWith(getColor),
                                  value: isAirline2Selected,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      isAirline2Selected = value??false;
                                    });
                                  },
                                ),
                              ],
                            )),

                      ],
                    ))
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
        ),
      ],
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
