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

  late TabController tabController;
  bool isModifySearchVisible =false;
  int selectedTab = 1;
  int multicityCount = 1;
  @override
  void initState() {
    super.initState();
    tabController = TabController(vsync: this, length: 3, initialIndex: 0);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    tabController.dispose();
  }

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
            addVerticalSpace(flyternSpaceMedium),
            Visibility(
              visible: !isModifySearchVisible,
              child: Container(
                padding: flyternMediumPaddingHorizontal,
                child: Text('KWI-DXB - 04-06 July, 23 - Round Trip - 1 Adults 1 Child',
                    textAlign: TextAlign.start,
                    style: getLabelLargeStyle(context).copyWith(
                        fontWeight: flyternFontWeightLight,color: flyternGrey40)),
              ),
            ),
            Visibility(
                visible: !isModifySearchVisible,child: addVerticalSpace(flyternSpaceSmall)),
            Visibility(
                visible: !isModifySearchVisible,child: Divider()),
            Visibility(
                visible: !isModifySearchVisible,child: addVerticalSpace(flyternSpaceSmall)),
            Container(
              padding: flyternMediumPaddingHorizontal,
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
            addVerticalSpace(flyternSpaceSmall),
            Divider(),
            Container(
              padding: flyternMediumPaddingHorizontal,
              decoration: BoxDecoration(
                border: flyternDefaultBorderBottomOnly
              ),
              child:  TabBar(
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorPadding: EdgeInsets.zero,
                  labelPadding: flyternSmallPaddingAll,
                  // indicator: new BubbleTabIndicator(
                  //   indicatorHeight: 30.0,
                  //   indicatorColor: AppColors.PrimaryColor,
                  //   tabBarIndicatorSize: TabBarIndicatorSize.tab,
                  // ),
                  indicatorColor: flyternSecondaryColor,
                  indicatorWeight: 2,
                  padding: EdgeInsets.zero,
                  controller: tabController,
                  labelColor: flyternSecondaryColor,
                  labelStyle: TextStyle(color:flyternPrimaryColor,fontWeight: FontWeight.bold ),
                  unselectedLabelColor: flyternGrey20,
                  tabs: <Container>[
                      Container(
                      padding:flyternExtraSmallPaddingVertical,
                      child: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        direction: Axis.vertical,
                        spacing: flyternSpaceExtraSmall,
                        children: [
                          Text("Tue July 4, 2023",style: getLabelLargeStyle(context).copyWith(
                            color: tabController.index == 0?flyternSecondaryColor:flyternGrey40
                          )),
                          Text("AED 15,000",style: getBodyMediumStyle(context).copyWith(
                              fontWeight: flyternFontWeightBold,
                          color: tabController.index == 0?flyternSecondaryColor:flyternGrey40),),
                        ],
                      ),
                    ),
                      Container(
                      padding:flyternExtraSmallPaddingVertical,
                      child: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        direction: Axis.vertical,
                        spacing: flyternSpaceExtraSmall,
                        children: [
                          Text("Wed July 5, 2023",style: getLabelLargeStyle(context).copyWith(
                            color: tabController.index == 1?flyternSecondaryColor:flyternGrey40
                          )),
                          Text("AED 15,000",style: getBodyMediumStyle(context).copyWith(
                              fontWeight: flyternFontWeightBold,
                          color: tabController.index == 1?flyternSecondaryColor:flyternGrey40),),
                        ],
                      ),
                    ),
                      Container(
                      padding:flyternExtraSmallPaddingVertical,
                      child: Wrap(
                        direction: Axis.vertical,
                        spacing: flyternSpaceExtraSmall,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Text("Thu July 6, 2023",style: getLabelLargeStyle(context).copyWith(
                            color: tabController.index == 2?flyternSecondaryColor:flyternGrey40
                          )),
                          Text("AED 15,000",style: getBodyMediumStyle(context).copyWith(
                              fontWeight: flyternFontWeightBold,
                          color: tabController.index == 2?flyternSecondaryColor:flyternGrey40),),
                        ],
                      ),
                    ),
                  ])
            ),

            Expanded(child:
            Container(
              color: flyternGrey10,
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