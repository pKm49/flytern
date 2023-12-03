import 'package:flutter/material.dart';
import 'package:flytern/feature-modules/profile/controllers/profile.controller.dart';
 import 'package:flytern/feature-modules/profile/ui/pages/my_bookings_pages/my_activities_list.profile.page.dart';
import 'package:flytern/feature-modules/profile/ui/pages/my_bookings_pages/my_flight_bookings_list.profile.page.dart';
import 'package:flytern/feature-modules/profile/ui/pages/my_bookings_pages/my_hotel_bookings_list.profile.page.dart';
import 'package:flytern/feature-modules/profile/ui/pages/my_bookings_pages/my_insurances_list.profile.page.dart';
import 'package:flytern/feature-modules/profile/ui/pages/my_bookings_pages/my_packages_list.profile.page.dart';
import 'package:flytern/shared-module/constants/service_types.core.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/style_params.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/widget_styles.shared.constant.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ProfileMyBookingsPage extends StatefulWidget {
  const ProfileMyBookingsPage({super.key});

  @override
  State<ProfileMyBookingsPage> createState() => _ProfileMyBookingsPageState();
}

class _ProfileMyBookingsPageState extends State<ProfileMyBookingsPage>
    with SingleTickerProviderStateMixin{
  late TabController tabController;
  final profileController = Get.find<ProfileController>();
  int selectedTab = -1;


  @override
  void initState() {
    super.initState();
    tabController = TabController(vsync: this, length: 5, initialIndex: 0);
    profileController.getMyBookings(1,ServiceType.FLIGHT);
    tabController.addListener(() {
      if (selectedTab != tabController.index) {
        profileController.getMyBookings(1,getBookingService(tabController.index));
        selectedTab = tabController.index;
        setState(() {});
      }
    });
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
        title: Text('my_bookings'.tr),
      ),
      body: Obx(
        ()=> Container(
          width: screenwidth,
          height: screenheight,
          color: flyternGrey10,
          child: Column(
            children: [
              Container(
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
                         Tab(text: "flight_bookings".tr),
                         Tab(text: "hotel_bookings".tr),
                         Tab(text: "package_bookings".tr),
                         Tab(text: "activity_bookings".tr),
                         Tab(text: "insurance_purchases".tr),
                      ])
              ),
              Visibility(
                  visible: profileController.isMyBookingsLoading.value,
                  child: Container(
                    width: screenwidth,
                    height: screenheight*.5,
                    color: flyternGrey10,
                    child: Center(
                        child: LoadingAnimationWidget.prograssiveDots(
                          color: flyternSecondaryColor,
                          size: 50,
                        )
                    ),
                  )),
              Visibility(
                visible: !profileController.isMyBookingsLoading.value,
                child: Expanded(child:TabBarView(controller: tabController, children:   <Widget>[
                  ProfileFlightBookingsList(),
                  ProfileHotelBookingsList(),
                  ProfilePackageBookingsList(),
                  ProfileActivityBookingsList(),
                  ProfileInsurancePurchaseList(),
                ])),
              )
            ],
          ),
        ),
      ),
    );
  }

  ServiceType getBookingService(int index) {
    switch (index){
      case 0:return ServiceType.FLIGHT;
      case 1:return ServiceType.HOTEL;
      case 2:return ServiceType.PACKAGE ;
      case 3:return ServiceType.ACTIVITY;
      case 4:return ServiceType.INSURANCE ;
      default:return ServiceType.FLIGHT;
    }
  }
}
