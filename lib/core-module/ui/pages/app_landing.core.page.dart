import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flytern/core-module/ui/components/drawer_menu.core.component.dart';
import 'package:flytern/feature-modules/flight_booking/controllers/flight_booking.controller.dart';
import 'package:flytern/feature-modules/flight_booking/ui/pages/landing.flight_booking.page.dart';
import 'package:flytern/feature-modules/hotel_booking/controllers/hotel_booking.controller.dart';
import 'package:flytern/feature-modules/hotel_booking/ui/pages/landing.hotel_booking.page.dart';
import 'package:flytern/feature-modules/insurance/controllers/insurance.controller.dart';
import 'package:flytern/feature-modules/insurance/ui/pages/landing.insurance.page.dart';
import 'package:flytern/feature-modules/packages/controllers/package.controller.dart';
import 'package:flytern/feature-modules/packages/ui/pages/landing.packages.page.dart';
import 'package:flytern/feature-modules/profile/controllers/profile.controller.dart';
import 'package:flytern/feature-modules/profile/ui/pages/landing.profile.page.dart';
import 'package:flytern/shared-module/constants/app_specific/route_names.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/asset_urls.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/style_params.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/widget_styles.shared.constant.dart';
import 'package:flytern/shared-module/services/utility-services/toaster_snackbar_shower.shared.service.dart';
import 'package:flytern/shared-module/services/utility-services/widget_generator.shared.service.dart';
import 'package:flytern/shared-module/services/utility-services/widget_properties_generator.shared.service.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class CoreLandingPage extends StatefulWidget {
  const CoreLandingPage({super.key});

  @override
  State<CoreLandingPage> createState() => _CoreLandingPageState();
}

class _CoreLandingPageState extends State<CoreLandingPage>
    with SingleTickerProviderStateMixin {
  late StreamSubscription<InternetConnectionStatus> connectivityListener;

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
  bool isConnected = true;

  @override
  void initState() {
    if (getArguments != null) {
      if (getArguments[0] != null) {
        _launchUrl(getArguments[0]);
      }
    }
    checkNotificationsPermission();

    super.initState();
    _tabController = TabController(length: _tabList.length, vsync: this);

    _tabController.animateTo(_currentIndex);
    _tabController.addListener(() {
      setState(() {
        _currentIndex = _tabController.index;
      });
    });

    connectivityListener =
        InternetConnectionChecker().onStatusChange.listen((status) {
      switch (status) {
        case InternetConnectionStatus.connected:
          setState(() {
            isConnected = true;
          });
          getInitialData();
          break;
        case InternetConnectionStatus.disconnected:
          setState(() {
            isConnected = false;
          });
          break;
      }
    });
  }

  @override
  void dispose() {
    isConnected = true;
    _tabController.dispose();
    connectivityListener.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Scaffold(
        appBar: AppBar(
          centerTitle: isConnected ? false : true,
          titleSpacing: 0,
          title: isConnected
              ? (pageTitle == "flights")
                  ? Image.asset(ASSETS_NAMELOGO, width: screenwidth * .33)
                  : Text(pageTitle)
              : null,
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
                visible: isConnected,
                child: InkWell(
                    onTap: () {
                      Get.toNamed(Approute_notificationspage);
                    },
                    child: Icon(CupertinoIcons.bell, color: flyternGrey80))),
            Visibility(
                visible: isConnected,
                child: addHorizontalSpace(flyternSpaceMedium)),
          ],
        ),
        drawer: isConnected ? CoreDrawerMenuPage() : null,
        body: isConnected
            ? Container(
                child: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                controller: _tabController,
                children: _tabList,
              ))
            : Container(
                height: screenheight,
                width: screenwidth,
                padding: flyternLargePaddingAll,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        runSpacing: flyternSpaceLarge,
                        spacing: flyternSpaceLarge,
                        direction: Axis.vertical,
                        children: [
                          Icon(
                            Icons.wifi_off_outlined,
                            color: flyternGrey40,
                            size: screenwidth * .3,
                          ),
                          Padding(
                            padding:
                                EdgeInsets.only(top: flyternSpaceLarge * 1),
                            child: Text(
                              "no_internet".tr,
                              style: getHeadlineMediumStyle(context)
                                  .copyWith(color: flyternSecondaryColor),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          ElevatedButton(
                              onPressed: () {
                                checkConnectivity();
                              },
                              style: getElevatedButtonStyle(context).copyWith(
                                  padding: MaterialStateProperty.all<
                                          EdgeInsetsGeometry>(
                                      EdgeInsets.symmetric(
                                          horizontal: flyternSpaceLarge,
                                          vertical: flyternSpaceSmall))),
                              child: Text("try_again".tr))
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: screenheight * .2),
                      child:
                          Image.asset(ASSETS_NAMELOGO, width: screenwidth * .5),
                    ),
                  ],
                ),
              ),
        bottomNavigationBar: isConnected
            ? Container(
                decoration: flyternTopShadowedContainerLargeDecoration,
                child: BottomNavigationBar(
                  showSelectedLabels: true,
                  showUnselectedLabels: true,
                  selectedIconTheme:
                      IconThemeData(color: flyternSecondaryColor),
                  backgroundColor: flyternBackgroundWhite,
                  type: BottomNavigationBarType.fixed,
                  currentIndex: _currentIndex,
                  selectedItemColor: flyternPrimaryColor,
                  selectedLabelStyle: TextStyle(
                      color: flyternPrimaryColor,
                      fontWeight: flyternFontWeightBold),
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
                        padding: const EdgeInsets.only(
                            bottom: flyternSpaceExtraSmall),
                        child: Icon(Icons.airplane_ticket_outlined,
                            size: flyternFontSize24),
                      ),
                      activeIcon: Padding(
                        padding: const EdgeInsets.only(
                            bottom: flyternSpaceExtraSmall),
                        child: Icon(Icons.airplane_ticket,
                            size: flyternFontSize24),
                      ),
                      label: "flights".tr,
                    ),

                    BottomNavigationBarItem(
                      icon: Padding(
                        padding: const EdgeInsets.only(
                            bottom: flyternSpaceExtraSmall),
                        child: Icon(Icons.hotel_outlined),
                      ),
                      activeIcon: Padding(
                        padding: const EdgeInsets.only(
                            bottom: flyternSpaceExtraSmall),
                        child: Icon(Icons.hotel),
                      ),
                      label: "hotels".tr,
                    ),

                    BottomNavigationBarItem(
                      icon: Padding(
                        padding: const EdgeInsets.only(
                            bottom: flyternSpaceExtraSmall),
                        child: Icon(Icons.backpack_outlined),
                      ),
                      activeIcon: Padding(
                        padding: const EdgeInsets.only(
                            bottom: flyternSpaceExtraSmall),
                        child: Icon(Icons.backpack),
                      ),
                      label: "packages".tr,
                    ),

                    BottomNavigationBarItem(
                      icon: Padding(
                        padding: const EdgeInsets.only(
                            bottom: flyternSpaceExtraSmall),
                        child: Icon(Icons.monitor_heart_outlined),
                      ),
                      activeIcon: Padding(
                        padding: const EdgeInsets.only(
                            bottom: flyternSpaceExtraSmall),
                        child: Icon(Icons.monitor_heart),
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
                        padding: const EdgeInsets.only(
                            bottom: flyternSpaceExtraSmall),
                        child: Icon(Icons.person_outline),
                      ),
                      activeIcon: Padding(
                        padding: const EdgeInsets.only(
                            bottom: flyternSpaceExtraSmall),
                        child: Icon(Icons.person),
                      ),
                      label: "profile".tr,
                    ),
                  ],
                ))
            : null);
  }

  Future<void> changeTitle(int index) async {
    var newTitle = '';
    switch (index) {
      case 0:
        {
          newTitle = "flights";
          break;
        }
      case 1:
        {
          newTitle = "hotels".tr;
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

    if (!await launchUrl(_url)) {}
  }

  void getInitialData() {
    // log("getInitialData");
    // log(_currentIndex.toString());

    switch (_currentIndex) {
      case 0:
        {
          // newTitle =  "flights";
          final flightBookingController = Get.find<FlightBookingController>();
          flightBookingController.getInitialInfo();
          break;
        }
      case 1:
        {
          // newTitle =  "hotels".tr;
          final hotelBookingController = Get.find<HotelBookingController>();
          hotelBookingController.getRecentSearch();
          break;
        }
      case 2:
        {
          // newTitle = "packages".tr;
          final packageBookingController = Get.find<PackageBookingController>();
          packageBookingController.getInitialInfo();
          break;
        }
      case 3:
        {
          // newTitle = "activities".tr;
          // newTitle = "insurance".tr;
          final insuranceBookingController =
              Get.find<InsuranceBookingController>();
          insuranceBookingController.getInitialInfo();
          break;
        }
      case 4:
        {
          // newTitle = "profile".tr;
          final profileController = Get.find<ProfileController>();
          profileController.getUserDetails();
          break;
        }
      default:
        break;
    }
  }

  Future<void> checkConnectivity() async {
    bool result = await InternetConnectionChecker().hasConnection;

    if (result == true) {
      setState(() {
        isConnected = true;
      });
      getInitialData();
    } else {
      if (Get.context != null) {
        showSnackbar(Get.context!, "no_internet".tr, "error");
      }
    }
  }

  Future<void> checkNotificationsPermission() async {
    await Permission.notification.isDenied.then((value) async {
      if (value) {
        await Permission.notification.isPermanentlyDenied.then((value) async {
          if (!value) {
            if(!await getPermissionRequestSharedPreference()){
              showPermissionDialogue();
            }
          }
        });
      }
    });
  }

  void showPermissionDialogue( ) async {
    setPermissionRequestSharedPreference();

    final dialogTitleWidget = Text('notification_access_permission_title'.tr,style: getHeadlineMediumStyle(context).copyWith(color: flyternGrey80,fontWeight: flyternFontWeightBold));
     final dialogTextWidget = Text( 'notification_access_permission_info'.tr,style: getBodyMediumStyle(context),
    );

    final updateButtonTextWidget = Text('continue'.tr);
    final updateButtonCancelTextWidget = Text('cancel'.tr);

    updateAction() {
      Navigator.pop(context);
      Permission.notification.request();
    }

    List<Widget> actions = [

      TextButton(onPressed: (){
        Navigator.pop(context);
      }, child: updateButtonCancelTextWidget),

      Platform.isAndroid
          ?  ElevatedButton(
          onPressed:updateAction,
          style: getElevatedButtonStyle(context).copyWith(padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
              EdgeInsets.symmetric(
                  horizontal: flyternSpaceLarge,
                  vertical: flyternSpaceSmall))),
          child:  updateButtonTextWidget)
          : CupertinoDialogAction(
        onPressed: updateAction,
        child: updateButtonTextWidget,
      ),
    ];

    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
            child: Platform.isAndroid
                ? AlertDialog(
              title: dialogTitleWidget,
              content: dialogTextWidget,
              actions: actions,
            )
                : CupertinoAlertDialog(
              title: dialogTitleWidget,
              content: dialogTextWidget,
              actions: actions,
            ),
            onWillPop: () => Future.value(false));
      },
    );
  }

  Future<bool> getPermissionRequestSharedPreference() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool? isNotificationPermissionAsked = prefs.getBool('isNotificationPermissionAsked');
    print("getPermissionRequestSharedPreference");
    print(isNotificationPermissionAsked);
    return isNotificationPermissionAsked !=null?isNotificationPermissionAsked:false;
  }

  Future<void> setPermissionRequestSharedPreference() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isNotificationPermissionAsked',true);
  }

}
