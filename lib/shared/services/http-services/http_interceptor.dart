import 'dart:convert';
import 'dart:developer';
import 'dart:io';
// import 'package:device_info_plus/device_info_plus.dart';
import 'package:flytern/core/data/constants/core_http_request_endpoints.dart';
import 'package:http_interceptor/http_interceptor.dart';
 import 'package:shared_preferences/shared_preferences.dart';
import 'package:flytern/config/env.dart' as env;

class FlyternHttpInterceptor implements InterceptorContract {

  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    try {
      var sharedPreferences = await SharedPreferences.getInstance();
      var Bearer = await sharedPreferences.getString("accessToken");
      var Basic = env.basicToken;

      print("Bearer");
      print(Bearer);
      print("Basic");
      print(Basic);
      print(data.url.contains(CoreHttpRequestEndpointGetGuestToken));
      print(data.baseUrl);

      data.headers["Accept"] = "*/*";
      data.headers["Content-Type"] = "application/json";

      if (Bearer != null && Bearer != "") {
        data.headers["Authorization"] = "Bearer $Bearer";
      }else{
        data.headers["Authorization"] = "Basic $Basic";
      }

      data.headers["Host"]=env.apiEndPoint;
      if(data.url.contains(CoreHttpRequestEndpointGetGuestToken)){
        String? deviceId = await _getId();
        data.headers["DeviceID"] = deviceId??"";
      }

      print("does contain");
      print(data.url.contains(CoreHttpRequestEndpointGetNewAccesToken));
      if(data.url.contains(CoreHttpRequestEndpointGetNewAccesToken)){
        String? refreshToken = await getRefreshToken();
        data.headers["RefreshToken"] = refreshToken ;
      }

      print(" interceptRequest data.headers");
      print(data.headers);
    } catch (e) {
      print("interceptRequest error");
      print(e);
    }
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    try {
      if (data.body != null) {
        var httpResponseBody = json.decode(data.body!);
        if (httpResponseBody['result'] != null) {
          if (httpResponseBody['result'] is String && httpResponseBody["result"].toString().contains('UNAUTHORIZED')) {
            // var sharedHttpService = new SharedHttpService();
            // await sharedHttpService.getAccessToken();
          } else {
            if (httpResponseBody['data']['accessToken'] != null) {
              var sharedPreferences = await SharedPreferences.getInstance();
              sharedPreferences.setString("accessToken",
                  httpResponseBody['data']['accessToken'].toString());
            }
          }
        }
      }
    } catch (e) {
      print(e);
    }
    return data;
  }

  @override
  Future<bool> shouldInterceptRequest() {
    // TODO: implement shouldInterceptRequest
    throw UnimplementedError();
  }

  @override
  Future<bool> shouldInterceptResponse() {
    // TODO: implement shouldInterceptResponse
    throw UnimplementedError();
  }

  Future<String?> _getId() async {
    String idPattern = "FLYMOB";
    // var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) { // import 'dart:io'
      idPattern += "IOS123123123";
      // var iosDeviceInfo = await deviceInfo.iosInfo;
      return  idPattern;; // unique ID on iOS
    } else if(Platform.isAndroid) {
      idPattern += "AND123123123123";
      // var androidDeviceInfo = await deviceInfo.androidInfo;
      return idPattern;; // unique ID on Android
    }
  }

  Future<String> getRefreshToken() async {

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? refreshToken = prefs.getString('refreshToken');

    print("getRefreshToken");
    print(refreshToken);
    return refreshToken??"";
  }

}
