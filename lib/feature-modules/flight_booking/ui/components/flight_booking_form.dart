import 'package:flutter/material.dart';
import 'package:flytern/shared/data/constants/ui_constants/asset_urls.dart';
import 'package:flytern/shared/data/constants/ui_constants/style_params.dart';
import 'package:flytern/shared/data/constants/ui_constants/widget_styles.dart';
import 'package:flytern/shared/services/utility-services/widget_generator.dart';
import 'package:flytern/shared/services/utility-services/widget_properties_generator.dart';
import 'package:ionicons/ionicons.dart';

class FlightBookingForm extends StatefulWidget {
  final int selectedTab;

  const FlightBookingForm({super.key, required this.selectedTab});

  @override
  State<FlightBookingForm> createState() => _FlightBookingFormState();
}

class _FlightBookingFormState extends State<FlightBookingForm> {

  bool isDirectFlight = false;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        addVerticalSpace(flyternSpaceLarge),
        Container(
          decoration: flyternBorderedContainerSmallDecoration.copyWith(
              border: Border.all(color: flyternSecondaryColor, width: .5)),
          padding: flyternMediumPaddingAll,
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Row(
                  children: [
                    Wrap(
                      alignment: WrapAlignment.center,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      direction: Axis.vertical,
                      children: [
                        for (var i = 0; i < 10; i++)
                          Container(
                            color: i % 2 == 0
                                ? flyternSecondaryColor
                                : Colors.transparent,
                            width: 1,
                            height: 3,
                          ),
                        Icon(Icons.flight_takeoff_outlined,
                            color: flyternSecondaryColor),
                      ],
                    ),
                    addHorizontalSpace(flyternSpaceSmall),
                    Wrap(
                      direction: Axis.vertical,
                      alignment: WrapAlignment.start,
                      crossAxisAlignment: WrapCrossAlignment.start,
                      children: [
                        Text(
                          'From',
                          style: getLabelLargeStyle(context).copyWith(
                              color: flyternGrey40,
                              fontWeight: FontWeight.  w400),
                        ),
                        addVerticalSpace(flyternSpaceExtraSmall),
                        Text('IST',
                            style: getHeadlineLargeStyle(context)
                                .copyWith(fontSize: flyternFontSize24 * 1.5)),
                        addVerticalSpace(flyternSpaceExtraSmall),
                        Text('Istanbul'),
                      ],
                    )
                  ],
                ),
              ),
              addHorizontalSpace(flyternSpaceMedium),
              Image.asset(ASSETS_ROUND_TRIP_ICON, width: 35),
              addHorizontalSpace(flyternSpaceMedium),
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Wrap(
                      alignment: WrapAlignment.center,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      direction: Axis.vertical,
                      children: [
                        for (var i = 0; i < 10; i++)
                          Container(
                            color: i % 2 == 0
                                ? flyternSecondaryColor
                                : Colors.transparent,
                            width: 1,
                            height: 3,
                          ),
                        Icon(Icons.flight_land_outlined,
                            color: flyternSecondaryColor),
                      ],
                    ),
                    addHorizontalSpace(flyternSpaceSmall),
                    Wrap(
                      direction: Axis.vertical,
                      alignment: WrapAlignment.start,
                      crossAxisAlignment: WrapCrossAlignment.start,
                      children: [
                        Text(
                          'To',
                          style: getLabelLargeStyle(context).copyWith(
                              color: flyternGrey40,
                              fontWeight: FontWeight.  w400),
                        ),
                        addVerticalSpace(flyternSpaceExtraSmall),
                        Text('KBL',
                            style: getHeadlineLargeStyle(context)
                                .copyWith(fontSize: flyternFontSize24 * 1.5)),
                        addVerticalSpace(flyternSpaceExtraSmall),
                        Text('Kabul'),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        addVerticalSpace(flyternSpaceMedium),
        Row(
          children: [
            Expanded(
                flex: 1,
                child: Container(
                  decoration: flyternBorderedContainerSmallDecoration.copyWith(
                      border: Border.all(color: flyternGrey20, width: .5)),
                  padding: flyternMediumPaddingAll,
                  child: Row(
                    children: [
                      Icon(Icons.calendar_month,
                          color: flyternSecondaryColor,size: flyternFontSize20),
                      addHorizontalSpace(flyternSpaceSmall*1.5),
                      Expanded(
                        flex: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Travel Date',
                              style: getLabelLargeStyle(context).copyWith(
                                  color: flyternGrey40,
                                  fontWeight: FontWeight.  w400),
                            ),
                            addVerticalSpace(flyternSpaceExtraSmall*1.5),
                            Text('Jul 24, 2023',
                                style: getLabelLargeStyle(context)
                                    .copyWith(color: flyternGrey80, )),
                          ],
                        ),
                      )
                    ],
                  ),
                )),
            Visibility(
                visible: widget.selectedTab == 2,
                child: addHorizontalSpace(flyternSpaceSmall)),
            Visibility(
              visible: widget.selectedTab == 2,
              child: Expanded(
                  flex: 1,
                  child: Container(
                    decoration: flyternBorderedContainerSmallDecoration.copyWith(
                        border: Border.all(color: flyternGrey20, width: .5)),
                    padding: flyternMediumPaddingAll ,
                    child: Row(
                      children: [
                        Icon(Icons.calendar_month,
                            color: flyternSecondaryColor,size: flyternFontSize20),
                        addHorizontalSpace(flyternSpaceSmall*1.5),
                        Expanded(
                          flex: 1,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Return Date',
                                style: getLabelLargeStyle(context).copyWith(
                                    color: flyternGrey40,
                                    fontWeight: FontWeight.  w400),
                              ),
                              addVerticalSpace(flyternSpaceExtraSmall*1.5),
                              Text('Jul 24, 2023',
                                  style: getLabelLargeStyle(context)
                                      .copyWith( color: flyternGrey80)),
                            ],
                          ),
                        )
                      ],
                    ),
                  )),
            ),
          ],
        ),
        addVerticalSpace(flyternSpaceMedium),
        Container(
          decoration: flyternBorderedContainerSmallDecoration.copyWith(
              border: Border.all(color: flyternGrey20, width: .5)),
          padding: flyternMediumPaddingAll,
          child: Row(
            children: [
              Icon(Ionicons.person_outline,
                  color: flyternSecondaryColor,size: flyternFontSize20),
              addHorizontalSpace(flyternSpaceSmall*1.5),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Passengers / Cabin Class',
                      style: getLabelLargeStyle(context).copyWith(
                          color: flyternGrey40,
                          fontWeight: FontWeight.  w400),
                    ),
                    addVerticalSpace(flyternSpaceExtraSmall*1.5),
                    Text('2 Passengers, Economy',
                        style: getLabelLargeStyle(context)
                            .copyWith(color: flyternGrey80, )),
                  ],
                ),
              )
            ],
          ),
        ),
        addVerticalSpace(flyternSpaceMedium),
        Container(
          decoration: flyternBorderedContainerSmallDecoration.copyWith(
              border: Border.all(color: flyternGrey20, width: .5)),
          padding: flyternMediumPaddingAll,
          child: Row(
            children: [
              Icon(Icons.discount_outlined,
                  color: flyternSecondaryColor,size: flyternFontSize20),
              addHorizontalSpace(flyternSpaceSmall*1.5),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Promo Code',
                      style: getLabelLargeStyle(context).copyWith(
                          color: flyternGrey40,
                          fontWeight: FontWeight.  w400),
                    ),
                    addVerticalSpace(flyternSpaceExtraSmall*1.5),
                    Text('VXS234',
                        style: getLabelLargeStyle(context)
                            .copyWith( color: flyternGrey80, )),
                  ],
                ),
              )
            ],
          ),
        ),
        addVerticalSpace(flyternSpaceSmall),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Checkbox(
              checkColor: Colors.white,
              fillColor: MaterialStateProperty.resolveWith(getColor),
              value:  isDirectFlight,
              onChanged: (bool? value) {
                setState(() {
                   isDirectFlight = value??false;
                });
              },
            ),

            addHorizontalSpace(flyternSpaceSmall),

            Expanded(
              child: Text("Direct Flight",style: getBodyMediumStyle(context),
                  maxLines: 2),
            ),
          ],
        ),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
              onPressed: ()   {

              }, child: Text("Search Flights" )),
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