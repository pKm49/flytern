import 'package:flutter/material.dart';
import 'package:flytern/shared/data/constants/ui_constants/style_params.dart';
import 'package:flytern/shared/data/constants/ui_constants/widget_styles.dart';
import 'package:flytern/shared/services/utility-services/widget_generator.dart';
import 'package:flytern/shared/services/utility-services/widget_properties_generator.dart';
import 'package:flytern/shared/ui/components/filter_components/flight_filter_options.dart';
import 'package:flytern/shared/ui/components/filter_components/hotel_filter_options.dart';
import 'package:flytern/shared/ui/components/selectable_text_pill.dart';
import 'package:get/get.dart';

class FilterOptionSelector extends StatefulWidget {

  final GestureTapCallback setModalState;
  int bookingServiceNumber;

  FilterOptionSelector({super.key, required this.setModalState, required this.bookingServiceNumber});

  @override
  State<FilterOptionSelector> createState() => _FilterOptionSelectorState();
}

class _FilterOptionSelectorState extends State<FilterOptionSelector> {



  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Container(
      width: screenwidth,
      height: screenheight*.9,
      padding: flyternSmallPaddingAll,
      child: widget.bookingServiceNumber ==1?
      FlightFilterOptions(
        setModalState: widget.setModalState,
      ):
      HotelFilterOptions(
        setModalState: widget.setModalState,
      ),
    );
  }


}

class CustomTrackShape extends RoundedRectSliderTrackShape {
  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final trackHeight = sliderTheme.trackHeight;
    final trackLeft = offset.dx;
    final trackTop = offset.dy + (parentBox.size.height - trackHeight!) / 2;
    final trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}