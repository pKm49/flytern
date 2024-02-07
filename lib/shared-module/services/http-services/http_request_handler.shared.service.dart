import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flytern/feature-modules/insurance/constants/http_request_endpoints.insurance.constant.dart';
import 'package:flytern/shared-module/constants/app_specific/route_names.shared.constant.dart';
import 'package:flytern/shared-module/services/utility-services/toaster_snackbar_shower.shared.service.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as httpForMultipart;
import 'package:http_certificate_pinning/http_certificate_pinning.dart';
import 'package:http_interceptor/http/http.dart';
import 'package:flytern/config/env.dart' as env;
import 'package:flytern/shared-module/models/flytern_http_response.dart';
import 'package:flytern/shared-module/services/http-services/http_interceptor.shared.service.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

SecureHttpClient getClient() {
  String certificateSHA256Fingerprints =
      "B6:65:3C:1D:23:21:0A:56:8A:AF:72:35:BB:C3:AD:59:B7:94:25:54:64:A9:21:1D:1B:6C:7B:EF:F5:0D:EE:1E";
  List<String> allowedShA1FingerprintList = [];
  allowedShA1FingerprintList.add(certificateSHA256Fingerprints);
  final secureClient = SecureHttpClient.build(allowedShA1FingerprintList);
  return secureClient;
}

getRequest(endpoint, parameters) async {
  bool result = await InternetConnectionChecker().hasConnection;

  if (result == true) {

    try {
      print("getRequest called");
      print(env.apiEndPoint + "$endpoint");
      print(parameters);

      final http = InterceptedHttp.build(
          client: getClient(), interceptors: [
        FlyternHttpInterceptor(),
      ]);

      final httpResponse = await http.get(Uri.https(env.apiEndPoint, "$endpoint"),
          params: json.decode(json.encode(parameters)));
      print(Uri.https(env.apiEndPoint, "$endpoint").toString());

      print("httpResponse");
      print(httpResponse.headers.toString());
      print("httpResponse body is "+httpResponse.body);
      print("httpResponse");
      var httpResponseBody = json.decode(httpResponse.body);
      return generateSuccessResponse(httpResponseBody);
    } catch (e) {
      // print("get exception");
      // print(e.toString());
      return generateErrorResponse("something_went_wrong".tr);
    }
  } else {
    if (Get.context != null)
      showSnackbar(Get.context!, "no_internet".tr, "error");
  }



}

postRequest(endpoint, body) async {
  // print("postRequest called");
  // print(endpoint);
  // print(Uri.https(env.apiEndPoint, "$endpoint").toString());
  // print(body);

  bool result = await InternetConnectionChecker().hasConnection;

  if (result == true) {
    try {
      final http = InterceptedHttp.build(client: getClient(), interceptors: [
        FlyternHttpInterceptor(),
      ]);
      // print("postRequest called pass 1");
      // print(Uri.https(env.apiEndPoint, "$endpoint").toString());
      // print("postRequest request");
      // print(endpoint.toString().contains('postRequest'));
      final httpResponse = await http.post(
          Uri.https(env.apiEndPoint, "$endpoint"),
          body: endpoint == InsuranceBookingHttpRequestEndpointGetPrice
              ? null
              : body != null
              ? json.encode(body)
              : body,
          params: endpoint == InsuranceBookingHttpRequestEndpointGetPrice
              ? body
              : null);
      // print("postRequest called pass 2");
      //
      // print("post body");
      // print(httpResponse.headers);
      // print(httpResponse.statusCode);
      // print(httpResponse.body);
      var httpResponseBody = json.decode(httpResponse.body);

      return generateSuccessResponse(httpResponseBody);
    } catch (e) {
      // print("get exception");
      // print(e.toString());
      return generateErrorResponse("something_went_wrong".tr);
    }
  } else {
    if (Get.context != null)
      showSnackbar(Get.context!, "no_internet".tr, "error");
  }

}

patchRequest(endpoint, body) async {

  bool result = await InternetConnectionChecker().hasConnection;

  if (result == true) {
    try {
      final http = InterceptedHttp.build(client: getClient(), interceptors: [
        FlyternHttpInterceptor(),
      ]);

      final httpResponse = await http.patch(
          Uri.https(env.apiEndPoint, "$endpoint"),
          body: json.encode(body));

      var httpResponseBody = json.decode(httpResponse.body);

      return generateSuccessResponse(httpResponseBody);
    } catch (e) {
      // print("get exception");
      // print(e.toString());
      return generateErrorResponse("something_went_wrong".tr);
    }
  } else {
    if (Get.context != null)
      showSnackbar(Get.context!, "no_internet".tr, "error");
  }

}

deleteRequest(endpoint) async {

  bool result = await InternetConnectionChecker().hasConnection;

  if (result == true) {
    try {
      final http = InterceptedHttp.build(client: getClient(), interceptors: [
        FlyternHttpInterceptor(),
      ]);

      final httpResponse =
      await http.delete(Uri.https(env.apiEndPoint, "/$endpoint"));

      var httpResponseBody = json.decode(httpResponse.body);

      return generateSuccessResponse(httpResponseBody);
    } catch (e) {
      // print("get exception");
      // print(e.toString());
      return generateErrorResponse("something_went_wrong".tr);
    }
  } else {
    if (Get.context != null)
      showSnackbar(Get.context!, "no_internet".tr, "error");
  }

}

generateErrorResponse(String errorMessage) {
  FlyternHttpResponse poundHttpResponse = FlyternHttpResponse(
      errors: [errorMessage],
      statusCode: 500,
      message: [],
      data: null,
      success: false);

  return poundHttpResponse;
}

generateSuccessResponse(dynamic httpResponseBody) {
  FlyternHttpResponse poundHttpResponse = FlyternHttpResponse(
      statusCode: httpResponseBody['statusCode'] ?? 500,
      message: httpResponseBody['message'] != null
          ? getStringListFromDynamic(httpResponseBody['errors'])
          : [],
      errors: httpResponseBody['errors'] != null
          ? getStringListFromDynamic(httpResponseBody['errors'])
          : [],
      data: httpResponseBody['data'] ?? {},
      success: httpResponseBody['success'] ?? false);
  return poundHttpResponse;
}

List<String> getStringListFromDynamic(List<dynamic> list) {
  List<String> returnList = [];

  list.forEach((element) {
    returnList.add(element.toString());
  });

  return returnList;
}

fileUpload(dynamic body, File? file, String field, String endpoint,
    String requestType) async {

  bool result = await InternetConnectionChecker().hasConnection;

  if (result == true) {
    try {
      Map<String, String> headers = {
        "Accept": "application/json",
        "Content-Type": "application/json",
      };

      var sharedPreferences = await SharedPreferences.getInstance();
      var Bearer = await sharedPreferences.getString("accessToken");

      if (Bearer != null && Bearer != "") {
        headers["Authorization"] = "Bearer $Bearer";
      }

      var request = httpForMultipart.MultipartRequest(
          requestType, Uri.https(env.apiEndPoint, endpoint));

      request.headers.addAll(headers);
      request.fields.addAll(Map<String, String>.from(body));

      if (file != null) {
        request.files.add(httpForMultipart.MultipartFile(
            field, file.readAsBytes().asStream(), file.lengthSync(),
            filename: file.path.split("/").last));
      }

      httpForMultipart.Response httpResponse =
      await httpForMultipart.Response.fromStream(await request.send());

      var httpResponseBody = json.decode(httpResponse.body);

      return generateSuccessResponse(httpResponseBody);
    } catch (e) {
      // print("get exception");
      // print(e.toString());
      return generateErrorResponse("something_went_wrong".tr);
    }
  } else {
    if (Get.context != null)
      showSnackbar(Get.context!, "no_internet".tr, "error");
  }
  // print("fileUpload called");
  // print(endpoint);
  // print(Uri.https(env.apiEndPoint, "$endpoint").toString());
  // print(body);

}
