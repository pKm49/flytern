import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flytern/main.dart';
import 'package:flytern/shared-module/constants/ui_specific/style_params.shared.constant.dart';
import 'package:flytern/shared-module/services/utility-services/widget_properties_generator.shared.service.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:in_app_update/in_app_update.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flytern/config/env.dart' as env;

class AppUpdateChecker {
  Future<bool> checkStatus() async {
    if (Platform.isAndroid) {
      return await checkAndroidUpdateStatus();
    }
    return await checkIOSUpdateStatus();
  }

  Future<bool> checkIOSUpdateStatus() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    String appVersionName = _getCleanVersion(packageInfo.version);

    VersionStatus versionStatus = await getIosStoreVersionName(packageInfo) ??
        VersionStatus(
            localVersion: packageInfo.version,
            storeVersion: '0.0.0',
            appStoreLink: 'appStoreLink');
    debugPrint("appVersionCode $appVersionName");
    debugPrint("storeVersionCode ${versionStatus.storeVersion}");
    debugPrint("storeVersionCode ${versionStatus.canUpdate}");
    if (versionStatus.canUpdate) {
      showUpdateDialog(storeLink: versionStatus.appStoreLink);
    }
    return versionStatus.canUpdate;
  }

  Future<bool> checkAndroidUpdateStatus() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    int appVersionCode = int.parse(packageInfo.buildNumber);
    int storeVersionCode = await getAndroidStoreVersion(appVersionCode);
    debugPrint("appVersionCode $appVersionCode");
    debugPrint("storeVersionCode $storeVersionCode");
    final uri = Uri.https("play.google.com", "/store/apps/details",
        {"id": env.playStorePackageId, "hl": "en"});

    if (storeVersionCode > appVersionCode) {
      showUpdateDialog(storeLink: uri.toString());

      return true;
    } else {
      return false;
    }
  }

  Future<VersionStatus?> getIosStoreVersionName(PackageInfo packageInfo) async {
    final id = env.appStorePackageId;
    final parameters = {"bundleId": id};
    String countryCode =
        findCountryCodeEdited(context: MyApp.navigatorKey.currentContext!);

    parameters.addAll({"country": countryCode});

    var uri = Uri.https("itunes.apple.com", "/lookup", parameters);
    final response = await http.get(uri);
    if (response.statusCode != 200) {
      debugPrint('Failed to query iOS App Store');
      return null;
    }
    final jsonObj = json.decode(response.body);
    final List results = jsonObj['results'];
    if (results.isEmpty) {
      debugPrint('Can\'t find an app in the App Store with the id: $id');
      return null;
    }
    return VersionStatus(
      localVersion: _getCleanVersion(packageInfo.version),
      storeVersion: _getCleanVersion(jsonObj['results'][0]['version']),
      appStoreLink: jsonObj['results'][0]['trackViewUrl'],
      releaseNotes: jsonObj['results'][0]['releaseNotes'],
    );
  }

  Future<String?> getAppStoreLink(String bundleID) async {
    final parameters = {"bundleId": bundleID};
    String countryCode =
        findCountryCodeEdited(context: MyApp.navigatorKey.currentContext!);

    parameters.addAll({"country": countryCode});

    var uri = Uri.https("itunes.apple.com", "/lookup", parameters);
    final response = await http.get(uri);
    if (response.statusCode != 200) {
      debugPrint('Failed to query iOS App Store');
      return null;
    }
    final jsonObj = json.decode(response.body);
    final List results = jsonObj['results'];
    if (results.isEmpty) {
      debugPrint('Can\'t find an app in the App Store with the id: $bundleID');
      return null;
    }
    return jsonObj['results'][0]['trackViewUrl'];
  }

  String _getCleanVersion(String version) =>
      RegExp(r'\d+\.\d+\.\d+').stringMatch(version) ?? '0.0.0';

  Future<int> getAndroidStoreVersion(int appVersionCode) async {
    try {
      AppUpdateInfo appUpdateInfo = await InAppUpdate.checkForUpdate();

      return appUpdateInfo.availableVersionCode ?? 0;
    } catch (e) {
      return 0;
    }
  }

  void showUpdateDialog({
    required String storeLink,
  }) async {
    BuildContext context = MyApp.navigatorKey.currentContext!;
    final dialogTitleWidget = Text('app_update_title'.tr,style: getHeadlineLargeStyle(context).copyWith(color: flyternGrey80));
    final dialogTextWidget = Text( 'app_update_content'.tr,style: getBodyMediumStyle(context),
    );

    final updateButtonTextWidget = Text('app_update_button_text'.tr);

    updateAction() {
      launchAppStore(storeLink);
    }

    List<Widget> actions = [
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
}

class VersionStatus {
  final String localVersion;
  final String storeVersion;
  final String appStoreLink;

  final String? releaseNotes;

  bool get canUpdate {
    final local = localVersion.split('.').map(int.parse).toList();
    final store = storeVersion.split('.').map(int.parse).toList();

    for (var i = 0; i < store.length; i++) {
      if (store[i] > local[i]) {
        return true;
      }

      if (local[i] > store[i]) {
        return false;
      }
    }
    return false;
  }

  VersionStatus({
    required this.localVersion,
    required this.storeVersion,
    required this.appStoreLink,
    this.releaseNotes,
  });
}

Future<void> launchAppStore(String appStoreLink) async {
  debugPrint(appStoreLink);
  if (await canLaunchUrl(Uri.parse(appStoreLink))) {
    await launchUrl(Uri.parse(appStoreLink));
  } else {
    throw 'something_went_wrong'.tr;
  }
}

String findCountryCodeEdited({required BuildContext context}) {
  Locale? locale = Localizations.maybeLocaleOf(context);

  String code = (locale == null || locale.countryCode == null)
      ? 'US'
      : locale.countryCode!;
  return code;
}
