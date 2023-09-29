import 'package:flutter/material.dart';
import 'package:flytern/feature-modules/activity_booking/ui/pages/activity_booking_landing_page.dart';
import 'package:flytern/feature-modules/flight_booking/ui/pages/flight_booking_landing_page.dart';
import 'package:flytern/feature-modules/hotel_booking/ui/pages/hotel_booking_landing_page.dart';
import 'package:flytern/feature-modules/package_booking/ui/pages/package_booking_landing_page.dart';
import 'package:flytern/feature-modules/profile/ui/pages/profile_landing_page.dart';
import 'package:flytern/shared/data/constants/ui_constants/style_params.dart';
import 'package:flytern/shared/data/constants/ui_constants/widget_styles.dart';
import 'package:get/get.dart';

class CoreLandingPage extends StatefulWidget {
  const CoreLandingPage({super.key});

  @override
  State<CoreLandingPage> createState() => _CoreLandingPageState();
}

class _CoreLandingPageState extends State<CoreLandingPage> with SingleTickerProviderStateMixin {

  late TabController _tabController;
  int _currentIndex = 0;
  List<Widget> _tabList = [
    FlightBookingLandingPage(),
    HotelBookingLandingPage(),
    PackageBookingLandingPage(),
    ActivityBookingLandingPage(),
    ProfileLandingPage()
  ];
  String pageTitle = "flights";

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabList.length, vsync: this);

    _tabController.animateTo(_currentIndex);
    _tabController.addListener(() {
      setState(() {
        _currentIndex = _tabController.index;
      });
    });



  }

  @override
  void dispose() {
    _tabController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            controller: _tabController,
            children: _tabList,
          )),
        bottomNavigationBar:Container(
            decoration: flyternTopShadowedContainerLargeDecoration,
            child: BottomNavigationBar(
              showSelectedLabels: true,
              showUnselectedLabels: true,
              selectedIconTheme: IconThemeData(color: flyternSecondaryColor),
              backgroundColor: flyternBackgroundWhite,
              type: BottomNavigationBarType.fixed,
              currentIndex: _currentIndex,
              selectedItemColor: flyternPrimaryColor,
              selectedLabelStyle: TextStyle(color: flyternPrimaryColor, fontWeight: flyternFontWeightBold),
              onTap: (int index) {
                setState(() {
                  _currentIndex = index;
                  changeTitle(index);
                });

                _tabController.animateTo(_currentIndex);


              },
              items: [
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: const EdgeInsets.only(bottom:flyternSpaceExtraSmall),
                    child: Icon(Icons.flight_land_outlined,size: flyternFontSize24 ),
                  ),
                  activeIcon: Padding(
                    padding: const EdgeInsets.only(bottom:flyternSpaceExtraSmall),
                    child: Icon(Icons.flight,size: flyternFontSize24 ),
                  ),
                  label: "flights".tr,
                ),

                BottomNavigationBarItem(
                  icon: Padding(
                    padding: const EdgeInsets.only(bottom:flyternSpaceExtraSmall),
                    child: Icon(Icons.hotel_outlined ),
                  ),
                  activeIcon: Padding(
                    padding: const EdgeInsets.only(bottom:flyternSpaceExtraSmall),
                    child: Icon(Icons.hotel ),
                  ),
                  label: "hotels".tr,
                ),

                BottomNavigationBarItem(
                  icon: Padding(
                    padding: const EdgeInsets.only(bottom:flyternSpaceExtraSmall),
                    child: Icon(Icons.backpack_outlined ),
                  ),
                  activeIcon: Padding(
                    padding: const EdgeInsets.only(bottom:flyternSpaceExtraSmall),
                    child: Icon(Icons.backpack ),
                  ),
                  label: "packages".tr,
                ),

                BottomNavigationBarItem(
                  icon: Padding(
                    padding: const EdgeInsets.only(bottom:flyternSpaceExtraSmall),
                    child: Icon(Icons.local_activity_outlined ),
                  ),
                  activeIcon: Padding(
                    padding: const EdgeInsets.only(bottom:flyternSpaceExtraSmall),
                    child: Icon(Icons.local_activity ),
                  ),
                  label: "activities".tr,
                ),

                BottomNavigationBarItem(
                  icon: Padding(
                    padding: const EdgeInsets.only(bottom:flyternSpaceExtraSmall),
                    child: Icon(Icons.person_outline ),
                  ),
                  activeIcon: Padding(
                    padding: const EdgeInsets.only(bottom:flyternSpaceExtraSmall),
                    child: Icon(Icons.person ),
                  ),
                  label: "profile".tr,
                ),
              ],
            )
        )
    );
  }

  Future<void> changeTitle(int index) async {
    var newTitle = '';
    switch (index) {
      case 0:
        {
          newTitle =  "flights";
          break;
        }
      case 1:
        {
          newTitle =  "hotels".tr;
          break;
        }
      case 2:
        {
          newTitle = "packages".tr;
          break;
        }
      case 3:
        {
          newTitle = "activities".tr;
          break;
        }
      case 4:
        {
          newTitle = "profile".tr;
          break;
        }
    }
    setState(() {
      pageTitle = newTitle;
    });
  }
}
