import 'dart:convert';
import 'dart:developer';
import 'package:http_interceptor/http_interceptor.dart';
 import 'package:shared_preferences/shared_preferences.dart';

class FlyternHttpInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    try {
      var sharedPreferences = await SharedPreferences.getInstance();
      var Bearer = await sharedPreferences.getString("access_token");

      data.headers["Accept"] = "*/*";
      data.headers["Content-Type"] = "application/json";

      if (Bearer != null && Bearer != "") {
        data.headers["Authorization"] = "Bearer $Bearer";
      }
    } catch (e) {
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
            if (httpResponseBody['result']['access_token'] != null) {
              var sharedPreferences = await SharedPreferences.getInstance();
              sharedPreferences.setString("access_token",
                  httpResponseBody['result']['access_token'].toString());
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
}
