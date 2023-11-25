import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flytern/feature-modules/flight_booking/ui/components/explore_section/travel_stories_item_card.dart';
import 'package:flytern/feature-modules/hotel_booking/controllers/hotel_booking_controller.dart';
import 'package:flytern/feature-modules/hotel_booking/data/models/hotel_room_option.dart';
import 'package:flytern/shared-module/constants/app_specific/default_values.shared.constant.dart';
import 'package:flytern/shared-module/models/general_item.dart';
import 'package:flytern/shared-module/services/utility-services/element_style_helper.shared.service.dart';
import 'package:flytern/shared-module/ui/components/contact_details_getter.shared.component.dart';
import 'package:flytern/shared-module/ui/components/custom_media_carousel.shared.component.dart';
import 'package:flytern/shared-module/constants/app_specific/route_names.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/asset_urls.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/style_params.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/widget_styles.shared.constant.dart';
import 'package:flytern/shared-module/services/utility-services/widget_generator.shared.service.dart';
import 'package:flytern/shared-module/services/utility-services/widget_properties_generator.shared.service.dart';
import 'package:flytern/shared-module/ui/components/selectable_text_pill.shared.component.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class HotelDetailsPage extends StatefulWidget {
  const HotelDetailsPage({super.key});

  @override
  State<HotelDetailsPage> createState() => _HotelDetailsPageState();
}

class _HotelDetailsPageState extends State<HotelDetailsPage> {
  final hotelBookingController = Get.find<HotelBookingController>();
  var elementStyleHelpers = ElementStyleHelpers();
  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Obx(
      () => Scaffold(
        appBar: AppBar(
          title: Text("hotel_details".tr),
          // title: Text(hotelBookingController.hotelDetails.value.name),
          elevation: 0.5,
        ),
        body: Container(
            width: screenwidth,
            height: screenheight,
            color: flyternBackgroundWhite,
            child: Stack(
              children: [
                Visibility(
                  visible:  !hotelBookingController.isHotelDetailsLoading.value,
                  child: Container(
                    child: ListView(
                      children: [
                        CustomMediaCarousel(
                          medias: hotelBookingController.hotelDetails.value.imageUrls,
                        ),
                        Container(
                          padding: flyternLargePaddingAll.copyWith(bottom: 0,top: 0),
                          color: flyternBackgroundWhite,
                          child: Text(hotelBookingController.hotelDetails.value.hotelName,
                              style: getHeadlineMediumStyle(context).copyWith(
                                  color: flyternGrey80, fontWeight: flyternFontWeightBold)),
                        ),
                        Container(
                            padding: flyternLargePaddingAll.copyWith(
                                top: flyternSpaceMedium, bottom: flyternSpaceExtraSmall),
                            color: flyternBackgroundWhite,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(Ionicons.star,
                                    color: flyternAccentColor,
                                    size: flyternFontSize20),
                                addHorizontalSpace(flyternSpaceExtraSmall),
                                Text(
                                  "${hotelBookingController.hotelDetails.value.rating}",
                                  style: getBodyMediumStyle(context)
                                      .copyWith(color: flyternGrey80),
                                ),
                              ],
                            )),
                        Container(
                          padding: flyternLargePaddingAll.copyWith(top: flyternSpaceSmall,bottom: flyternSpaceSmall ),
                          color: flyternBackgroundWhite,
                          child: Text(hotelBookingController.hotelDetails.value.descriptionInfo,
                              style: getBodyMediumStyle(context).copyWith(
                                  color: flyternGrey60 )),
                        ),
                        addVerticalSpace(flyternSpaceLarge),

                        Padding(
                          padding: flyternMediumPaddingHorizontal,
                          child: InkWell(
                            onTap: (){
                              _launchUrl(hotelBookingController
                                  .hotelDetails.value.locationurl);
                            },
                            child: Row(
                              children: [
                                Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          flyternBorderRadiusExtraSmall),
                                    ),
                                    clipBehavior: Clip.hardEdge,
                                    width: screenwidth * .15,
                                    child: Image.asset(ASSETS_LOCATION_ICON,
                                        width: screenwidth * .15)),
                                addHorizontalSpace(flyternSpaceMedium),
                                Expanded(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      hotelBookingController.hotelDetails.value.location,
                                      style: getBodyMediumStyle(context)
                                          .copyWith(color: flyternGrey80),
                                    ),
                                    addVerticalSpace(flyternSpaceExtraSmall),
                                    Text(
                                      hotelBookingController.hotelDetails.value.address,
                                      style: getBodyMediumStyle(context).copyWith(
                                        color: flyternGrey60,
                                      ),
                                    )
                                  ],
                                ))
                              ],
                            ),
                          ),
                        ),
                        addVerticalSpace(flyternSpaceLarge),
                        Container(  width: screenwidth,
                            color: flyternGrey10,
                            height: 1),

                        Container(
                          padding: flyternLargePaddingAll,
                          width: screenwidth,
                          height: screenwidth * .22 + (flyternSpaceLarge * 2),
                          child:ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: hotelBookingController
                                  .hotelDetails.value.amenitys.length,
                              itemBuilder: (context, i) {
                                return Container(
                                  margin:EdgeInsets.only(right: flyternSpaceMedium),
                                  width: screenwidth * .2,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [

                                      Image.network(hotelBookingController
                                          .hotelDetails.value.amenitys[i].imagePath,
                                          height: screenwidth * .1,
                                          errorBuilder: (context, error, stackTrace) {
                                            return Container(
                                                color: flyternGrey10,
                                                height: screenwidth * .1);
                                          }),
                                      addVerticalSpace(flyternSpaceSmall),
                                      Text(
                                        hotelBookingController
                                            .hotelDetails.value.amenitys[i].amenityName,
                                        maxLines: 2,
                                        textAlign: TextAlign.center,
                                        style: getLabelLargeStyle(context)
                                            .copyWith(color: flyternGrey60),
                                      )
                                    ],
                                  ),
                                );
                              }),
                        ),

                        Container(
                          padding: flyternLargePaddingAll,
                          width: screenwidth,
                          color: flyternGrey10,
                          child: Text(
                            "room_selection".tr,
                            style: getHeadlineMediumStyle(context).copyWith(
                                color: flyternGrey80,
                                fontWeight: flyternFontWeightBold),
                          ),
                        ),


                        Visibility(
                          visible: hotelBookingController
                              .hotelSearchData.value.rooms.length>1,
                          child: Container(
                            padding: flyternLargePaddingAll,
                            width: screenwidth,
                            height: 77,
                            child:ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: hotelBookingController.hotelDetails.value.rooms.length,
                                itemBuilder: (context, i) {
                                  return Padding(
                                    padding:EdgeInsets.only(right: flyternSpaceMedium),
                                    child: SelectableTilePill(
                                      onPressed: () {
                                          hotelBookingController.changeSelectedRoomSelectionIndex(i);

                                      },
                                      label:
                                      "${hotelBookingController.hotelDetails.value.rooms[i].roomDisplayNo} - ${hotelBookingController.hotelDetails.value.rooms[i].roomref}",
                                      isSelected: i == hotelBookingController.selectedRoomSelectionIndex.value,
                                      themeNumber: 2,
                                    ),
                                  );
                                }),
                          ),
                        ),

                        for (var i = 0;
                        i <
                            (hotelBookingController.selectedRoom.value[hotelBookingController.selectedRoomSelectionIndex.value].roomOptions.isNotEmpty
                                ? hotelBookingController.selectedRoom.value[hotelBookingController.selectedRoomSelectionIndex.value].roomOptions.length
                                : 0);
                        i++)
                          Padding(
                              padding: flyternLargePaddingHorizontal.copyWith(
                                  bottom: flyternSpaceExtraSmall),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    flex:9,
                                    child: Text(
                                        hotelBookingController.selectedRoom.value[hotelBookingController.selectedRoomSelectionIndex.value].roomOptions[i].roomName,
                                        maxLines: 2,
                                        style: getBodyMediumStyle(context)),
                                  ),
                                  addHorizontalSpace(flyternSpaceSmall),
                                  Expanded(
                                    flex:1,
                                    child: Checkbox(
                                      checkColor: Colors.white,
                                      fillColor: MaterialStateProperty.resolveWith(
                                          elementStyleHelpers.getColor),
                                      value:hotelBookingController.selectedRoom.value[hotelBookingController.selectedRoomSelectionIndex.value].roomOptions[i].roomOptionid ==
                                          hotelBookingController.selectedRoomOption[hotelBookingController.selectedRoomSelectionIndex.value].roomOptionid,
                                      onChanged: (bool? value) {
                                        if(value != null && value ==true){
                                          hotelBookingController.changeSelectedRoomOptionForIndex(
                                              hotelBookingController.selectedRoom.value[0].roomOptions[i]);
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              )),
                        addVerticalSpace(flyternSpaceLarge),


                        Container(
                          padding: flyternLargePaddingHorizontal.copyWith(top: 0,
                              bottom: flyternSpaceLarge),
                          color: flyternBackgroundWhite,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("per_night".tr,style: getBodyMediumStyle(context).copyWith(color: flyternGrey60)),
                              Text("${hotelBookingController.selectedRoomOption.value[hotelBookingController.selectedRoomSelectionIndex.value].currency}"
                                  " ${hotelBookingController.selectedRoomOption.value[hotelBookingController.selectedRoomSelectionIndex.value].perNightPrice}",style: getBodyMediumStyle(context).copyWith(color: flyternGrey80)),
                            ],
                          ),
                        ),
                        Container(
                          padding: flyternLargePaddingHorizontal.copyWith(top: 0,
                              bottom: flyternSpaceLarge),
                          color: flyternBackgroundWhite,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("total_fare".tr,style: getBodyMediumStyle(context).copyWith(color: flyternGrey60)),
                              Text("${hotelBookingController.selectedRoomOption.value[hotelBookingController.selectedRoomSelectionIndex.value].currency}"
                                  " ${hotelBookingController.selectedRoomOption.value[hotelBookingController.selectedRoomSelectionIndex.value].totalPrice}",style: getBodyMediumStyle(context).copyWith(color: flyternGrey80)),
                            ],
                          ),
                        ),

                        Container(  width: screenwidth,
                            color: flyternGrey10,
                            height: 1),
                        addVerticalSpace(flyternSpaceLarge),
                        Container(
                          padding: flyternLargePaddingHorizontal.copyWith(top: 0,
                              bottom: flyternSpaceLarge),
                          color: flyternBackgroundWhite,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("grand_total".tr,style: getBodyMediumStyle(context).copyWith(color: flyternGrey60)),

                              Text("${hotelBookingController.selectedRoomOption.value[hotelBookingController.selectedRoomSelectionIndex.value].currency}"
                                  " ${getGrandTotal()}",
                                  style: getBodyMediumStyle(context).copyWith(color: flyternGrey80,
                                      fontWeight: flyternFontWeightBold)),

                            ],
                          ),
                        ),
                        Container(
                          padding: flyternLargePaddingAll,
                          width: screenwidth,
                          color: flyternGrey10,
                          child: Text(
                            "basic_details".tr,
                            style: getHeadlineMediumStyle(context).copyWith(
                                color: flyternGrey80,
                                fontWeight: flyternFontWeightBold),
                          ),
                        ),


                        for(var ind=0;ind<hotelBookingController.hotelDetails.value.basicDetails.length;ind++)
                          Container(
                            padding: flyternLargePaddingHorizontal,
                            decoration: BoxDecoration(
                                color:flyternBackgroundWhite,
                                border: flyternDefaultBorderBottomOnly
                            ),
                            child: Theme(
                              data: ThemeData().copyWith(dividerColor: Colors.transparent),
                              child: ExpansionTile(
                                tilePadding: EdgeInsets.zero,
                                title:   Text(
                                  hotelBookingController.hotelDetails.value.basicDetails[ind].policyName,
                                  style: getBodyMediumStyle(context).copyWith(fontWeight: flyternFontWeightBold),
                                ),
                                children: <Widget>[
                                  Padding(
                                    padding: flyternSmallPaddingVertical,
                                    child: Html(
                                      data: hotelBookingController.hotelDetails.value.basicDetails[ind].policyText,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),


                        
                        Container(
                          color: flyternGrey10,
                          height: 70 + (flyternSpaceSmall * 2),
                          padding: flyternLargePaddingAll,
                        )
                      ],
                    ),
                  ),
                ),
                Visibility(
                    visible:  hotelBookingController.isHotelDetailsLoading.value,
                    child: Center(
                        child: LoadingAnimationWidget.prograssiveDots(
                          color: flyternSecondaryColor,
                          size: 50,
                        )
                    ))
              ],
            )),
        bottomSheet: Container(
          width: screenwidth,
          color: flyternBackgroundWhite,
          height: 60 + (flyternSpaceSmall * 2),
          padding: flyternLargePaddingAll.copyWith(
              top: flyternSpaceSmall, bottom: flyternSpaceSmall),
          child: Center(
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  style: getElevatedButtonStyle(context),
                  onPressed: () {
                    openContactDetailsGetterBottomSheet();
                  },
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          "${hotelBookingController.hotelDetails.value.priceUnit} "
                              "${getGrandTotal()}",
                        ),
                      ),
                      Text("book_now".tr),
                      addHorizontalSpace(flyternSpaceSmall),
                      Icon(
                        Ionicons.chevron_forward,
                        size: flyternFontSize20,
                      )
                    ],
                  )),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _launchUrl(String urlString) async {
    final Uri _url = Uri.parse(urlString);

    if (!await launchUrl(_url)) {
      print('Could not launch $_url');
    }
  }

  void openContactDetailsGetterBottomSheet() {
    showModalBottomSheet(
        useSafeArea: false,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(flyternBorderRadiusSmall),
              topRight: Radius.circular(flyternBorderRadiusSmall)),
        ),
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return ContactDetailsGetter(route: Approute_hotelsUserSelection);
        });
  }

  bool isItemSelected(List<HotelRoomOption> hotelRoomOptions, HotelRoomOption hotelRoomOption) {
    return hotelRoomOptions
        .where((element) => element.roomOptionid == hotelRoomOption.roomOptionid)
        .toList()
        .isNotEmpty;
  }

  getGrandTotal() {
    double grandTotal = 0;
    hotelBookingController.selectedRoomOption.value.forEach((element) {
      grandTotal += element.totalPrice;
    });
    return grandTotal;
  }
}
