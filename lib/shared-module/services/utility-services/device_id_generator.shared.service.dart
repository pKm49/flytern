 import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';

Future<String?> getDeviceId() async {
    String idPattern = "FLYMOB";
    var deviceInfo = DeviceInfoPlugin();
    String uniqueDeviceId = '';

    if (Platform.isIOS) {
      var iosDeviceInfo = await deviceInfo.iosInfo;

      uniqueDeviceId =
      '$idPattern-IOS-${iosDeviceInfo.name}-${iosDeviceInfo.identifierForVendor}';
    } else if(Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;


      uniqueDeviceId =
      '$idPattern-AND-${androidDeviceInfo.brand}-${androidDeviceInfo.model}-${androidDeviceInfo.id}' ;
    }

    return uniqueDeviceId;
  }
