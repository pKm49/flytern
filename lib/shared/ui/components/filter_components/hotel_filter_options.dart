import 'package:flutter/material.dart';
import 'package:flytern/shared/data/constants/ui_constants/style_params.dart';
import 'package:flytern/shared/data/constants/ui_constants/widget_styles.dart';
import 'package:flytern/shared/services/utility-services/widget_generator.dart';
import 'package:flytern/shared/services/utility-services/widget_properties_generator.dart';
import 'package:flytern/shared/ui/components/filter_option_selector.dart';
import 'package:flytern/shared/ui/components/selectable_text_pill.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class HotelFilterOptions extends StatefulWidget {

  final GestureTapCallback setModalState;

  HotelFilterOptions({super.key, required this.setModalState});

  @override
  State<HotelFilterOptions> createState() => _HotelFilterOptionsState();
}

class _HotelFilterOptionsState extends State<HotelFilterOptions> {

  int selectedRating = 3;
  double _currentSliderValue = 20;
  List<String> deals = ["Properties with special offers","Free cancellation","Reserve now, pay at stay"];
  List<String> propertyTypes = ["Hotels","Specialty lodgings","Motels","BRBs & Inns"];
  List<String> amenities = ["Free Wifi","Air conditioning","Internet","Meal"];
  List<int> selectedDeals = [];
  List<int> selectedPropertyTypes = [];
  List<int> selectedAmenities = [];

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


                        //  Departure Time
                        const Padding(
                          padding: flyternLargePaddingHorizontal,
                          child: Divider(),
                        ),
                        addVerticalSpace(flyternSpaceMedium),
                        Padding(
                          padding: flyternLargePaddingHorizontal,
                          child: Text("deals".tr,
                              style: getBodyMediumStyle(context)
                                  .copyWith(fontWeight: flyternFontWeightBold)),
                        ),
                        Padding(
                          padding: flyternLargePaddingAll,
                          child: Wrap(
                            children: [
                              for(var i=0;i<deals.length;i++)
                                Padding(
                                  padding: const EdgeInsets.only(right:flyternSpaceSmall,bottom: flyternSpaceSmall),
                                  child: SelectableTilePill(
                                    onPressed:(){
                                      if(selectedDeals.contains(i)){
                                        selectedDeals.remove(i);
                                      }else{
                                        selectedDeals.add(i);
                                      }
                                      print('SelectableTilePill modalState Changed');

                                      setState(() {
                                      });
                                      widget.setModalState();
                                    },
                                    label: deals[i],
                                    isSelected: selectedDeals.contains(i),
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
                          child: Text("property_type".tr,
                              style: getBodyMediumStyle(context)
                                  .copyWith(fontWeight: flyternFontWeightBold)),
                        ),
                        Padding(
                          padding: flyternLargePaddingAll,
                          child: Wrap(
                            children: [
                              for(var i=0;i<propertyTypes.length;i++)
                                Padding(
                                  padding: const EdgeInsets.only(right:flyternSpaceSmall,bottom: flyternSpaceSmall),
                                  child: SelectableTilePill(
                                    onPressed:(){
                                      if(selectedPropertyTypes.contains(i)){
                                        selectedPropertyTypes.remove(i);
                                      }else{
                                        selectedPropertyTypes.add(i);
                                      }

                                      print('SelectableTilePill modalState Changed');

                                      setState(() {
                                      });
                                      widget.setModalState();
                                    },
                                    label: propertyTypes[i],
                                    isSelected: selectedPropertyTypes.contains(i),
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
                          child: Text("rating".tr,
                              style: getBodyMediumStyle(context)
                                  .copyWith(fontWeight: flyternFontWeightBold)),
                        ),
                        Padding
                          (
                          padding: flyternLargePaddingAll,
                          child: Wrap(
                            children: [
                              for(var i=1;i<=5;i++)
                                Padding(
                                  padding: const EdgeInsets.only(right:flyternSpaceSmall),
                                  child: Icon(
                                      selectedRating < i+1 && selectedRating > i ?
                                      Ionicons.star_half:
                                      i<=selectedRating.round()?Ionicons.star:
                                      Ionicons.star_outline,
                                      color:
                                      i<=selectedRating.round()?
                                      flyternAccentColor:flyternGrey40),
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
                          child: Text("amenities".tr,
                              style: getBodyMediumStyle(context)
                                  .copyWith(fontWeight: flyternFontWeightBold)),
                        ),
                        Padding(
                          padding: flyternLargePaddingAll,
                          child: Wrap(
                            children: [
                              for(var i=0;i<amenities.length;i++)
                                Padding(
                                  padding: const EdgeInsets.only(right:flyternSpaceSmall,bottom: flyternSpaceSmall),
                                  child: SelectableTilePill(
                                    onPressed:(){
                                      if(selectedAmenities.contains(i)){
                                        selectedAmenities.remove(i);
                                      }else{
                                        selectedAmenities.add(i);
                                      }

                                      print('SelectableTilePill modalState Changed');

                                      setState(() {
                                      });
                                      widget.setModalState();
                                    },
                                    label: amenities[i],
                                    isSelected: selectedAmenities.contains(i),
                                    themeNumber: 2,
                                  ),
                                ),
                            ],
                          ),
                        ),
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
            child: Text("cancel".tr,style: getHeadlineMediumStyle(context).copyWith(color: flyternSecondaryColor)),
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
