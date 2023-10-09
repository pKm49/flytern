import 'dart:convert';
import 'dart:developer';
import 'package:flytern/core/data/constants/app-spectific/http_request_endpoints.dart';
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
        data.headers["DeviceID"] = "123123";
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
}
