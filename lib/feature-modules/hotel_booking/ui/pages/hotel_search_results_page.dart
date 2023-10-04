import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flytern/feature-modules/hotel_booking/ui/components/hote_search_result_card.dart';
import 'package:flytern/shared/data/constants/ui_constants/style_params.dart';
import 'package:flytern/shared/data/constants/ui_constants/widget_styles.dart';
import 'package:flytern/shared/services/utility-services/widget_generator.dart';
import 'package:flytern/shared/services/utility-services/widget_properties_generator.dart';
import 'package:flytern/shared/ui/components/filter_option_selector.dart';
import 'package:flytern/shared/ui/components/sort_option_selector.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class HotelSearchResultPage extends StatefulWidget {
  const HotelSearchResultPage({super.key});

  @override
  State<HotelSearchResultPage> createState() => _HotelSearchResultPageState();
}

class _HotelSearchResultPageState extends State<HotelSearchResultPage> with SingleTickerProviderStateMixin{



  @override
  Widget build(BuildContext context) {

    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Scaffold(

      appBar: AppBar(
        elevation: 0.5,
        title: Text("search_results".tr),
      ),
      body: Container(
        width: screenwidth,
        height: screenheight,
        child: Column(
          children: [
            Container(
              padding: flyternMediumPaddingAll,
              decoration: BoxDecoration(
                border: flyternDefaultBorderBottomOnly
              ),
              child:  Row(
                children: [
                  Expanded(
                      child: InkWell(
                        onTap: (){
                          showSortOptions();
                        },
                        child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                             Text("sort".tr,style: getLabelLargeStyle(context).copyWith(fontWeight: flyternFontWeightLight,color: flyternGrey40)),
                            addVerticalSpace(flyternSpaceExtraSmall),
                            Text("price".tr,style: getBodyMediumStyle(context).copyWith(color: flyternGrey80)),

                          ],
                        ),
                        Icon(Ionicons.chevron_down,color: flyternGrey40)
                    ],
                  ),
                      )),
                  addHorizontalSpace(flyternSpaceLarge),
                  Expanded(child: InkWell(
                    onTap: (){
                      showFilterOptions();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                             Text("filter".tr,style: getLabelLargeStyle(context).copyWith(fontWeight: flyternFontWeightLight,color: flyternGrey40)),
                            addVerticalSpace(flyternSpaceExtraSmall),
                            Text("all".tr,style: getBodyMediumStyle(context).copyWith(color: flyternGrey80)),

                          ],
                        ),
                        Icon(Ionicons.chevron_down,color: flyternGrey40)
                      ],
                    ),
                  ))
                ],
              ),
            ),
            Container(
              color: flyternGrey10,
              padding: flyternMediumPaddingAll,
              width: screenwidth,
              child: Text('Dubai - 04-06 July, 23 - Round Trip - 1 Adults 1 Child',
                  textAlign: TextAlign.start,
                  style: getLabelLargeStyle(context).copyWith(
                      fontWeight: flyternFontWeightLight,color: flyternGrey40)),
            ),

            Expanded(child:
            Container(
              color: flyternBackgroundWhite,
              child: ListView(
                children: [
                  addVerticalSpace(flyternSpaceLarge),


                   HotelSearchResultCard(),
                  addVerticalSpace(flyternSpaceLarge),
                  HotelSearchResultCard(),
                  addVerticalSpace(flyternSpaceLarge),
                  HotelSearchResultCard(),
                  addVerticalSpace(flyternSpaceLarge),
                  addVerticalSpace(flyternSpaceLarge),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }

  void showSortOptions( ) {
    showModalBottomSheet(
        useSafeArea: false,
        shape:   RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(flyternBorderRadiusSmall),
              topRight: Radius.circular(flyternBorderRadiusSmall)),
        ),
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) {
          return SortOptionSelector(
            title: "sort_by".tr,
            values: ["airline".tr,"price".tr],
          );
        });

  }

  void showFilterOptions( ) {
    showModalBottomSheet(
        useSafeArea: false,
        shape:   RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(flyternBorderRadiusSmall),
              topRight: Radius.circular(flyternBorderRadiusSmall)),
        ),
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setModalState /*You can rename this!*/) {
                return FilterOptionSelector(
                    setModalState:(){
                      print('modalState Changed');
                      setModalState(() {

                      });
                    }
                );
              });
        });

  }

}
