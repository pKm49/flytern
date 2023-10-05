import 'package:flutter/material.dart';
import 'package:flytern/feature-modules/insurance/ui/components/insurance_covid_data_collection_component.dart';
import 'package:flytern/feature-modules/insurance/ui/components/insurance_regular_data_collection_component.dart';
import 'package:flytern/shared/data/constants/app_specific/app_route_names.dart';
import 'package:flytern/shared/data/constants/ui_constants/style_params.dart';
import 'package:flytern/shared/data/constants/ui_constants/widget_styles.dart';
import 'package:get/get.dart';

class InsuranceLandingPage extends StatefulWidget {
  const InsuranceLandingPage({super.key});

  @override
  State<InsuranceLandingPage> createState() => _InsuranceLandingPageState();
}

class _InsuranceLandingPageState extends State<InsuranceLandingPage>  with SingleTickerProviderStateMixin{

  late TabController tabController;


  @override
  void initState() {
    super.initState();
    tabController = TabController(vsync: this, length: 2, initialIndex: 0);
  }


  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text('travel_insurance'.tr),
      ),
      body: Container(
        width: screenwidth,
        height: screenheight,
        color: flyternGrey10,
        child: Column(
          children: [
            Container(
              width: screenwidth,
                padding: flyternMediumPaddingHorizontal,
                decoration: BoxDecoration(
                  border: flyternDefaultBorderBottomOnly,
                  color: flyternBackgroundWhite,

                ),
                child:  TabBar(
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicatorPadding: EdgeInsets.zero,
                    labelPadding:  flyternMediumPaddingHorizontal,
                    // indicator: new BubbleTabIndicator(
                    //   indicatorHeight: 30.0,
                    //   indicatorColor: AppColors.PrimaryColor,
                    //   tabBarIndicatorSize: TabBarIndicatorSize.tab,
                    // ),
                    indicatorColor: flyternSecondaryColor,
                    indicatorWeight: 2,
                    isScrollable: true,
                    padding: EdgeInsets.zero,
                    controller: tabController,
                    labelColor: flyternSecondaryColor,
                    labelStyle: TextStyle(color:flyternPrimaryColor,fontWeight: FontWeight.bold ),
                    unselectedLabelColor: flyternGrey60,
                    tabs: <Tab>[
                      Tab(text: "covid".tr),
                      Tab(text: "regular".tr),
                    ])
            ),
            Expanded(child:TabBarView(controller: tabController, children:   <Widget>[
              InsuranceCovidDataCollectionComponent(),
              InsuranceRegularDataCollectionComponent(),
            ]))
          ],
        ),
      ),
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
                  onPressed: () {
                    Get.toNamed(Approute_insuranceUserDetailsSubmission);
                  },
                  child: Text("apply_now".tr)),
            ),
          ),
        )
    );
  }
}
