// import 'package:dotted_line/dotted_line.dart';
// import 'package:flutter/material.dart';
// import 'package:flytern/feature-modules/flight_booking/models/segment.flight_booking.model.dart';
// import 'package:flytern/feature-modules/flight_booking/ui/components/airport_lable_card.flight_booking.component.dart';
// import 'package:flytern/shared-module/ui/components/data_capsule_card.shared.component.dart';
// import 'package:flytern/shared-module/constants/app_specific/route_names.shared.constant.dart';
// import 'package:flytern/shared-module/constants/ui_specific/asset_urls.shared.constant.dart';
// import 'package:flytern/shared-module/constants/ui_specific/style_params.shared.constant.dart';
// import 'package:flytern/shared-module/constants/ui_specific/widget_styles.shared.constant.dart';
// import 'package:flytern/shared-module/services/utility-services/widget_generator.shared.service.dart';
// import 'package:flytern/shared-module/services/utility-services/widget_properties_generator.shared.service.dart';
// import 'package:get/get.dart';
// import 'package:ionicons/ionicons.dart';
//
// class FlightDetailsItineraryCard extends StatelessWidget {
//   FlightSegment flightSegment;
//     FlightDetailsItineraryCard({super.key, required this.flightSegment});
//
//   @override
//   Widget build(BuildContext context) {
//
//     double screenwidth = MediaQuery.of(context).size.width;
//
//     return Container(
//       decoration: flyternBorderedContainerSmallDecoration,
//       width: screenwidth - (flyternSpaceLarge * 2),
//       margin: flyternLargePaddingHorizontal,
//       child: Wrap(
//         runSpacing: 0,
//         children: [
//           Container(
//             width: screenwidth - (flyternSpaceLarge * 2),
//             padding: flyternMediumPaddingAll.copyWith(bottom: 0),
//             child: Center(
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   Icon(Icons.flight_takeoff_outlined,
//                       color: flyternSecondaryColor),
//                   addHorizontalSpace(flyternSpaceSmall),
//                   Expanded(
//                     child: Text(
//                       "${flightSegment.departure}",
//                       style: getBodyMediumStyle(context),
//                     ),
//                   ),
//                 ],
//               )
//             ),
//           ),
//           Container(
//             width: screenwidth - (flyternSpaceLarge * 2),
//             padding: flyternMediumPaddingAll.copyWith(top:flyternSpaceSmall , bottom: flyternSpaceMedium),
//             child: Center(
//                 child: Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     const Icon(Icons.linear_scale, color: flyternSecondaryColor),
//                     addHorizontalSpace(flyternSpaceSmall),
//                     Expanded(
//                       child: Text(
//                         flightSegment.arrival,
//                         style: getBodyMediumStyle(context),
//                       ),
//                     ),
//                   ],
//                 )
//             ),
//           ),
//
//           Container(
//             width: screenwidth - (flyternSpaceLarge * 2),
//             margin: EdgeInsets.only(bottom: flyternSpaceSmall),
//             padding: flyternMediumPaddingHorizontal,
//             child: Wrap(
//               alignment: WrapAlignment.start,
//               crossAxisAlignment: WrapCrossAlignment.start,
//               direction: Axis.horizontal,
//               spacing: flyternSpaceSmall,
//               runSpacing: flyternSpaceSmall,
//               children: [
//                 Visibility(
//                   visible: flightSegment.flightSegmentDetails.length>1,
//                   child: Container(
//                     padding: flyternSmallPaddingHorizontal.copyWith(top: flyternSpaceExtraSmall,
//                   bottom: flyternSpaceExtraSmall),
//                     decoration: BoxDecoration(
//                       color: flyternPrimaryColorBg ,
//                       borderRadius: BorderRadius.circular(flyternBorderRadiusExtraSmall),
//                     ),
//                     child: Text(
//                         "${flightSegment.flightSegmentDetails.isNotEmpty ?
//                         flightSegment.flightSegmentDetails.length-1:0} ${'stops'.tr}",
//                        style: getLabelLargeStyle(context).copyWith(color:
//                        flyternPrimaryColor ),
//                     ),
//                   ),
//                 ),
//                 Container(
//                   padding: flyternSmallPaddingHorizontal.copyWith(top: flyternSpaceExtraSmall,bottom: flyternSpaceExtraSmall),
//                   decoration: BoxDecoration(
//                     color: flyternPrimaryColorBg ,
//                     borderRadius: BorderRadius.circular(flyternBorderRadiusExtraSmall),
//                   ),
//                   child: Wrap(
//                     crossAxisAlignment: WrapCrossAlignment.center,
//                     children: [
//                       Icon(Ionicons.time_outline,color: flyternPrimaryColor,size: flyternFontSize16),
//                       addHorizontalSpace(flyternSpaceSmall),
//
//                       Text(
//                         "${flightSegment.travelTime } "
//                         ,style: getLabelLargeStyle(context).copyWith(color:
//                       flyternPrimaryColor ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 for(var i=0;i<flightSegment.flightSegmentBaggages.length;i++)
//
//                   Container(
//                     padding: flyternSmallPaddingHorizontal.copyWith(top: flyternSpaceExtraSmall,
//                         bottom: flyternSpaceExtraSmall),
//                     decoration: BoxDecoration(
//                       color: flyternPrimaryColorBg ,
//                       borderRadius: BorderRadius.circular(flyternBorderRadiusExtraSmall),
//                     ),
//                     child: Text(
//                       "${flightSegment.flightSegmentBaggages[i].passTy} - ${flightSegment.flightSegmentBaggages[i].cabin}",
//
//                       style: getLabelLargeStyle(context).copyWith(color:
//                       flyternPrimaryColor ),
//                     ),
//                   ),
//               ],
//             ),
//           ),
//           Divider(),
//           for(var i=0;i<flightSegment.flightSegmentDetails.length;i++)
//           Container(
//             width: screenwidth - (flyternSpaceLarge * 2),
//             height:flightSegment.flightSegmentDetails[i].stopover !=""||
//                 flightSegment.flightSegmentDetails[i].layover !=""? 300:270,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Expanded(child:
//                 Container(
//                   padding: flyternMediumPaddingAll ,
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Expanded(
//                               child: FlightAirportLabelCard(
//                                 topLabel: getTopLabel(
//                                     flightSegment.flightSegmentDetails[i].departurecntry),
//                                 midLabel: flightSegment.flightSegmentDetails[i].departure,
//                                 bottomLabel: flightSegment.flightSegmentDetails[i].departuretime,
//                                 sideNumber: 1,
//                               )),
//                           Padding(
//                             padding: flyternSmallPaddingHorizontal,
//                             child: Column(
//                               children: [
//                                 Image.asset(ASSETS_FLIGHT_CHART_ICON,width: screenwidth*.3, ),
//                                 addVerticalSpace(flyternSpaceSmall),
//                                 Text(flightSegment.flightSegmentDetails[i].duration,style: getBodyMediumStyle(context),)
//                               ],
//                             ),
//                           ),
//                           Expanded(
//                               child: Row(
//                                 crossAxisAlignment: CrossAxisAlignment.end,
//                                 mainAxisAlignment: MainAxisAlignment.end,
//                                 children: [
//                                   FlightAirportLabelCard(
//                                     topLabel: getTopLabel(
//                                         flightSegment.flightSegmentDetails[i].arrivalcntry),
//                                     midLabel: flightSegment.flightSegmentDetails[i].arrival,
//                                     bottomLabel: flightSegment.flightSegmentDetails[i].arrivaltime,
//                                     sideNumber: 2,
//                                   ),
//                                 ],
//                               ))
//                         ],
//                       ),
//                       addVerticalSpace(flyternSpaceMedium),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           for (var i = 0; i < (screenwidth -  (screenwidth/1.3)); i++)
//                             Container(
//                               color: i % 2 == 0
//                                   ? flyternGrey40
//                                   : Colors.transparent,
//                               height: 1,
//                               width: 3,
//                             ),
//                         ],
//                       ),
//                       addVerticalSpace(flyternSpaceMedium),
//                       Container(
//                         height: 100,
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Expanded(
//                               child: Row(
//                                 children: [
//                                   Expanded(
//                                     child: Column(
//                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                       crossAxisAlignment: CrossAxisAlignment.start,
//                                       children: [
//                                         Text(
//                                           "flight_no".tr,
//                                           style: getLabelLargeStyle(context).copyWith(
//                                               color: flyternGrey40,
//                                               fontWeight: FontWeight.  w400),
//                                         ),
//                                         addVerticalSpace(flyternSpaceExtraSmall),
//                                         Text(
//                                           flightSegment.flightSegmentDetails[i].flightNumber,
//                                           style: getLabelLargeStyle(context).copyWith(
//                                               color: flyternGrey80,
//                                               fontWeight: flyternFontWeightBold),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                   Expanded(
//                                     child: Column(
//                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         Text(
//                                           "cabin_class".tr,
//                                           style: getLabelLargeStyle(context).copyWith(
//                                               color: flyternGrey40,
//                                               fontWeight: FontWeight.  w400),
//                                         ),
//                                         addVerticalSpace(flyternSpaceExtraSmall),
//                                         Text(
//                                           flightSegment.flightSegmentDetails[i].cabin,
//                                           style: getLabelLargeStyle(context).copyWith(
//                                               color: flyternGrey80,
//                                               fontWeight: flyternFontWeightBold),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                   Expanded(
//                                     child: Column(
//                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                       crossAxisAlignment: CrossAxisAlignment.end,
//                                       children: [
//                                         Text(
//                                           "flight_date".tr,
//                                           style: getLabelLargeStyle(context).copyWith(
//                                               color: flyternGrey40,
//                                               fontWeight: FontWeight.  w400),
//                                         ),
//                                         addVerticalSpace(flyternSpaceExtraSmall),
//                                         Text(
//                                           flightSegment.flightSegmentDetails[i].departuredt,
//                                           style: getLabelLargeStyle(context).copyWith(
//                                               color: flyternGrey80,
//                                               fontWeight: flyternFontWeightBold),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             addVerticalSpace(flyternSpaceLarge),
//                             Expanded(
//                               child: Row(
//                                 children: [
//                                   Expanded(
//                                     child: Column(
//                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                       crossAxisAlignment: CrossAxisAlignment.start,
//                                       children: [
//                                         Text(
//                                           "airline".tr,
//                                           style: getLabelLargeStyle(context).copyWith(
//                                               color: flyternGrey40,
//                                               fontWeight: FontWeight.  w400),
//                                         ),
//                                         addVerticalSpace(flyternSpaceExtraSmall),
//                                         Text(
//                                           flightSegment.flightSegmentDetails[i].flightName,
//                                           style: getLabelLargeStyle(context).copyWith(
//                                               color: flyternGrey80,
//                                               fontWeight: flyternFontWeightBold),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                   Expanded(
//                                     child: Column(
//                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         Text(
//                                           "carrier".tr,
//                                           style: getLabelLargeStyle(context).copyWith(
//                                               color: flyternGrey40,
//                                               fontWeight: FontWeight.  w400),
//                                         ),
//                                         addVerticalSpace(flyternSpaceExtraSmall),
//                                         Text(flightSegment.flightSegmentDetails[i].carrier,
//                                           style: getLabelLargeStyle(context).copyWith(
//                                               color: flyternGrey80,
//                                               fontWeight: flyternFontWeightBold),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                   Expanded(
//                                     child: Column(
//                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                       crossAxisAlignment: CrossAxisAlignment.end,
//                                       children: [
//                                         Text(
//                                           "duration".tr,
//                                           style: getLabelLargeStyle(context).copyWith(
//                                               color: flyternGrey40,
//                                               fontWeight: FontWeight.  w400),
//                                         ),
//                                         addVerticalSpace(flyternSpaceExtraSmall),
//                                         Text(
//                                           flightSegment.flightSegmentDetails[i].duration,
//                                           style: getLabelLargeStyle(context).copyWith(
//                                               color: flyternGrey80,
//                                               fontWeight: flyternFontWeightBold),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 )),
//                 Visibility(
//                   visible: flightSegment.flightSegmentDetails[i].stopover !=""||
//                       flightSegment.flightSegmentDetails[i].layover !="",
//                   child: Container(
//                     padding: flyternMediumPaddingAll.copyWith(top: flyternSpaceSmall,bottom: flyternSpaceSmall),
//                     color: flyternPrimaryColorBg,
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Expanded(child:DottedLine(
//                           direction: Axis.horizontal,
//                           alignment: WrapAlignment.center,
//                           lineLength: double.infinity,
//                           lineThickness: 1.0,
//                           dashLength: 4.0,
//                           dashColor: flyternGrey60,
//                           dashRadius: 0.0,
//                           dashGapLength: 4.0,
//                           dashGapColor:flyternPrimaryColorBg,
//                           dashGapRadius: 0.0,
//                         )),
//                         Visibility(
//                           visible: flightSegment.flightSegmentDetails[i].stopover !="" ,
//                           child: Padding(
//                             padding: const EdgeInsets.symmetric(horizontal: flyternSpaceMedium),
//                             child: Text(
//                                 '${'stopover'.tr} ${flightSegment.flightSegmentDetails[i].stopover}',
//                                 style: getBodyMediumStyle(context).copyWith(color: flyternGrey60)),
//                           ),
//                         ),
//                         Visibility(
//                           visible: flightSegment.flightSegmentDetails[i].layover !="" ,
//                           child: Padding(
//                             padding: const EdgeInsets.symmetric(horizontal: flyternSpaceMedium),
//                             child: Text(
//                                 "${'layover'.tr} ${flightSegment.flightSegmentDetails[i].layover}",
//                             style: getBodyMediumStyle(context).copyWith(color: flyternGrey60)),
//                           ),
//                         ),
//                         const Expanded(child:DottedLine(
//                           direction: Axis.horizontal,
//                           alignment: WrapAlignment.center,
//                           lineLength: double.infinity,
//                           lineThickness: 1.0,
//                           dashLength: 4.0,
//                           dashColor: flyternGrey60,
//                           dashRadius: 0.0,
//                           dashGapLength: 4.0,
//                           dashGapColor:flyternPrimaryColorBg,
//                           dashGapRadius: 0.0,
//                         )),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//
//         ],
//       ),
//     );
//   }
//
//   getTopLabel(String toCountry) {
//     if (toCountry.split(",").toList().length > 1) {
//       return toCountry.split(",").toList()[1];
//     }
//     if (toCountry.split(",").toList().length == 1) {
//       return toCountry.split(",").toList()[0];
//     }
//     return toCountry;
//   }
//
//   String getBaggageWeight(FlightSegment flightSegment) {
//     String baggage = "";
//     if(flightSegment.flightSegmentBaggages.isNotEmpty){
//       baggage = flightSegment.flightSegmentBaggages[0].cabin;
//     }
//     return baggage;
//   }
// }
