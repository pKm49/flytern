import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flytern/core-module/services/notification_controller.dart';
import 'package:flytern/core-module/ui/components/drawer_menu.core.component.dart';
import 'package:flytern/feature-modules/activity_booking/ui/pages/landing_page.activity_booking.page.dart';
import 'package:flytern/feature-modules/flight_booking/ui/pages/landing.flight_booking.page.dart';
import 'package:flytern/feature-modules/hotel_booking/ui/pages/landing.hotel_booking.page.dart';
import 'package:flytern/feature-modules/insurance/ui/pages/landing.insurance.page.dart';
import 'package:flytern/feature-modules/packages/ui/pages/landing.packages.page.dart';
import 'package:flytern/feature-modules/profile/controllers/profile.controller.dart';
import 'package:flytern/feature-modules/profile/ui/pages/landing.profile.page.dart';
import 'package:flytern/shared-module/constants/app_specific/route_names.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/asset_urls.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/style_params.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/widget_styles.shared.constant.dart';
 import 'package:flytern/shared-module/services/utility-services/widget_generator.shared.service.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class CoreLandingPage extends StatefulWidget {
  const CoreLandingPage({super.key});

  @override
  State<CoreLandingPage> createState() => _CoreLandingPageState();
}

class _CoreLandingPageState extends State<CoreLandingPage> with SingleTickerProviderStateMixin {

  late TabController _tabController;
  int _currentIndex = 0;
  final List<Widget> _tabList = [
    const FlightBookingLandingPage(),
    const HotelBookingLandingPage(),
    const PackageBookingLandingPage(),
    const InsuranceLandingPage(),
    const ProfileLandingPage()
  ];
  String pageTitle = "flights";
  var getArguments = Get.arguments;
  final profileController = Get.put(ProfileController());

  @override
  void initState() {
    print( "getArguments" );
    print( getArguments );
    if(getArguments !=null){
      print( getArguments[0]);
      if(getArguments[0] !=null){
        _launchUrl(getArguments[0] );
      }
    }


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

    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: pageTitle == "flights"?
        Image.asset(ASSETS_NAMELOGO,width: screenwidth*.33):Text(pageTitle),
      actions: [
        // Visibility(
        //     visible:  pageTitle == "flights" || pageTitle == "hotels".tr,
        //     child: InkWell(
        //         onTap: (){
        //           showSearch(context: context, delegate: CustomSearchDelegate());
        //         },
        //         child: Icon(CupertinoIcons.search,color: flyternGrey80))),
        // addHorizontalSpace(flyternSpaceMedium),
        Visibility(
            child: InkWell(
                onTap: (){
                  Get.toNamed(Approute_notificationspage);
                },
                child: Icon(CupertinoIcons.bell,color: flyternGrey80))),
        addHorizontalSpace(flyternSpaceMedium),

      ],
      ),
      drawer: CoreDrawerMenuPage(),
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
                    child: Icon(Icons.airplane_ticket_outlined,size: flyternFontSize24 ),
                  ),
                  activeIcon: Padding(
                    padding: const EdgeInsets.only(bottom:flyternSpaceExtraSmall),
                    child: Icon(Icons.airplane_ticket,size: flyternFontSize24 ),
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
                    child: Icon(Icons.monitor_heart_outlined ),
                  ),
                  activeIcon: Padding(
                    padding: const EdgeInsets.only(bottom:flyternSpaceExtraSmall),
                    child: Icon(Icons.monitor_heart ),
                  ),
                  label: "insurance".tr,
                ),

                // BottomNavigationBarItem(
                //   icon: Padding(
                //     padding: const EdgeInsets.only(bottom:flyternSpaceExtraSmall),
                //     child: Icon(Icons.local_activity_outlined ),
                //   ),
                //   activeIcon: Padding(
                //     padding: const EdgeInsets.only(bottom:flyternSpaceExtraSmall),
                //     child: Icon(Icons.local_activity ),
                //   ),
                //   label: "activities".tr,
                // ),

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
          // newTitle = "activities".tr;
          newTitle = "insurance".tr;
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

  Future<void> _launchUrl(String urlString) async {
    final Uri _url = Uri.parse(urlString);

    if (!await launchUrl(_url)) {
    }
  }
}
