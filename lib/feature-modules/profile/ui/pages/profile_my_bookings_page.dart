import 'package:flutter/material.dart';
import 'package:flytern/feature-modules/profile/controllers/profile_controller.dart';
import 'package:flytern/feature-modules/profile/data/enums/booking_categories.dart';
import 'package:flytern/feature-modules/profile/ui/pages/my_bookings_pages/profile_activity_bookings_list.dart';
import 'package:flytern/feature-modules/profile/ui/pages/my_bookings_pages/profile_flight_bookings_list.dart';
import 'package:flytern/feature-modules/profile/ui/pages/my_bookings_pages/profile_hotel_bookings_list.dart';
import 'package:flytern/feature-modules/profile/ui/pages/my_bookings_pages/profile_insurance_purchase_list.dart';
import 'package:flytern/feature-modules/profile/ui/pages/my_bookings_pages/profile_package_bookings_list.dart';
import 'package:flytern/shared-module/data/constants/ui_constants/style_params.dart';
import 'package:flytern/shared-module/data/constants/ui_constants/widget_styles.dart';
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
    profileController.getMyBookings(1,BookingCategory.FLIGHT);
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

  BookingCategory getBookingService(int index) {
    switch (index){
      case 0:return BookingCategory.FLIGHT;
      case 1:return BookingCategory.HOTEL;
      case 2:return BookingCategory.PACKAGE ;
      case 3:return BookingCategory.ACTIVITY;
      case 4:return BookingCategory.INSURANCE ;
      default:return BookingCategory.FLIGHT;
    }
  }
}
