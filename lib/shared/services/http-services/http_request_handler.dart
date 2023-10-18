import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as httpForMultipart;
import 'package:http_interceptor/http/http.dart';
import 'package:flytern/config/env.dart' as env;
import 'package:flytern/shared/data/models/app_specific/flytern_http_response.dart';
 import 'package:flytern/shared/services/http-services/http_interceptor.dart';
import 'package:shared_preferences/shared_preferences.dart';

getRequest(endpoint, parameters) async {
  try {
    print("getRequest called");
    print(env.apiEndPoint+ "$endpoint");
    print(parameters);

    final http = InterceptedHttp.build(interceptors: [
      FlyternHttpInterceptor(),
    ]);

    final httpResponse = await http
        .get(Uri.https(env.apiEndPoint, "$endpoint"),params: json.decode(json.encode(parameters)));
    print(Uri.https(env.apiEndPoint, "$endpoint").toString());

    print("httpResponse");
    print(httpResponse.headers.toString());
    print(httpResponse.body);
    print("httpResponse");
    var httpResponseBody = json.decode(httpResponse.body);
    return generateSuccessResponse(httpResponseBody);

  } on SocketException {
    print("SocketException");
    return generateErrorResponse('Couldn\'t Connect, Try Again Later');
  } on FormatException catch (e,stack) {

    if (e.toString().contains("Request Not Implemented")) {
      return generateErrorResponse('Request Not Implemented');
    }
    if (e.toString().contains("Already authorised")) {
      return generateErrorResponse('Already authorised');
    }
    if (e.toString().contains("Request Not Authorised")) {
      return generateErrorResponse('Request Not Authorised');
    }
    print("get FormatException exception");
    print(e.toString());
    print(stack.toString());
    return generateErrorResponse('Something went wrong, try again');
  } on Exception catch (e) {
    print("get exception");
    print(e.toString());
    return generateErrorResponse('Something went wrong, try again');
  }
}

postRequest(endpoint, body) async {
  print("postRequest called");
  print(endpoint);
  print(Uri.https(env.apiEndPoint, "$endpoint").toString());
  print(body);
  try {
    final http = InterceptedHttp.build(interceptors: [
      FlyternHttpInterceptor(),
    ]);
    print("postRequest called pass 1");
    print(Uri.https(env.apiEndPoint, "$endpoint").toString());
  print("postRequest request");
  print(endpoint.toString().contains('postRequest'));
    final httpResponse = await http.post(
        Uri.https(env.apiEndPoint, "$endpoint"),
        body:body!=null?json.encode(body):body
    );
    print("postRequest called pass 2");

    print("post body");
    print(httpResponse.headers);
    print(httpResponse.statusCode);
    print(httpResponse.body);
    var httpResponseBody = json.decode(httpResponse.body);

    return generateSuccessResponse(httpResponseBody);
  } on SocketException {
    print("post SocketException exception");
    return generateErrorResponse('Couldn\'t Connect, Try Again Later');
  } on FormatException catch (e,stacktrace) {
    print("post FormatException exception");
    print(e.toString());
    print(stacktrace);
    if (e.toString().contains("Request Not Implemented")) {
      return generateErrorResponse('Request Not Implemented');
    }

    if (e.toString().contains("Already authorised")) {
      return generateErrorResponse('Already authorised');
    }

    if (e.toString().contains("Request Not Authorised")) {
      return generateErrorResponse('Request Not Authorised');
    }

    return generateErrorResponse('Something went wrong, try again');
  } on Exception catch (e) {

    print("post exception");
    print(e.toString());
    return generateErrorResponse('Something went wrong, try again');
  }

}

patchRequest(endpoint, body) async {
  try {
    final http = InterceptedHttp.build(interceptors: [
      FlyternHttpInterceptor(),
    ]);

    final httpResponse = await http.patch(
        Uri.https(env.apiEndPoint, "/$endpoint"),
        body: json.encode(body));

    var httpResponseBody = json.decode(httpResponse.body);

    return generateSuccessResponse(httpResponseBody);
  } on SocketException {
    return generateErrorResponse('Couldn\'t Connect, Try Again Later');
  } on FormatException catch (e) {
    if (e.toString().contains("Request Not Implemented")) {
      return generateErrorResponse('Request Not Implemented');
    }

    if (e.toString().contains("Already authorised")) {
      return generateErrorResponse('Already authorised');
    }
    if (e.toString().contains("Request Not Authorised")) {
      return generateErrorResponse('Request Not Authorised');
    }
    return generateErrorResponse('Something went wrong, try again');
  } on Exception {
    return generateErrorResponse('Something went wrong, try again');
  }
}

deleteRequest(endpoint) async {
  try {
    final http = InterceptedHttp.build(interceptors: [
      FlyternHttpInterceptor(),
    ]);

    final httpResponse =
        await http.delete(Uri.https(env.apiEndPoint, "/$endpoint"));

    var httpResponseBody = json.decode(httpResponse.body);


    return generateSuccessResponse(httpResponseBody);
  } on SocketException {
    return generateErrorResponse('Couldn\'t Connect, Try Again Later');
  } on FormatException catch (e) {
    if (e.toString().contains("Request Not Implemented")) {
      return generateErrorResponse('Request Not Implemented');
    }
    if (e.toString().contains("Already authorised")) {
      return generateErrorResponse('Already authorised');
    }
    if (e.toString().contains("Request Not Authorised")) {
      return generateErrorResponse('Request Not Authorised');
    }
    return generateErrorResponse('Something went wrong, try again');
  } on Exception {
    return generateErrorResponse('Something went wrong, try again');
  }
}

generateErrorResponse(String errorMessage) {
  FlyternHttpResponse poundHttpResponse = FlyternHttpResponse(
    errors: [errorMessage],
      statusCode: 500,  message: [], data: null, success: false);

  return poundHttpResponse;
}

generateSuccessResponse(dynamic httpResponseBody ) {


    FlyternHttpResponse poundHttpResponse = FlyternHttpResponse(
        statusCode:httpResponseBody['statusCode']??500,
        message: httpResponseBody['message'] !=null?getStringListFromDynamic(httpResponseBody['errors']):[],
        errors: httpResponseBody['errors'] !=null?getStringListFromDynamic(httpResponseBody['errors']):[],
        data: httpResponseBody['data']??{},
        success: httpResponseBody['success']??false);
    return poundHttpResponse;

}

List<String> getStringListFromDynamic(List<dynamic> list) {
  List<String> returnList = [];

  list.forEach((element) {
    returnList.add(element.toString());
  });

  return returnList;
}

fileUpload(dynamic body, File? file, String field, String endpoint, String requestType) async {
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
    request.fields.addAll(Map<String, String>.from(body)  );

    if(file !=null){
      request.files.add(httpForMultipart.MultipartFile(
          field, file.readAsBytes().asStream(), file.lengthSync(),
          filename: file.path.split("/").last));
    }


    httpForMultipart.Response httpResponse =
        await httpForMultipart.Response.fromStream(await request.send());

    var httpResponseBody = json.decode(httpResponse.body);

    return generateSuccessResponse(httpResponseBody );
  } on SocketException {
    print("post SocketException exception");
    return generateErrorResponse('Couldn\'t Connect, Try Again Later');
  } on FormatException catch (e,stacktrace) {
    print("post FormatException exception");
    print(e.toString());
    print(stacktrace);
    if (e.toString().contains("Request Not Implemented")) {
      return generateErrorResponse('Request Not Implemented');
    }

    if (e.toString().contains("Already authorised")) {
      return generateErrorResponse('Already authorised');
    }

    if (e.toString().contains("Request Not Authorised")) {
      return generateErrorResponse('Request Not Authorised');
    }

    return generateErrorResponse('Something went wrong, try again');
  } on Exception catch (e) {

    print("post exception");
    print(e.toString());
    return generateErrorResponse('Something went wrong, try again');
  }
}


paymentRequest( body) async {
  try {
    final http = InterceptedHttp.build(interceptors: [
      FlyternHttpInterceptor(),
    ]);
    final httpResponse = await http.post(
        Uri.parse(""),
        body: json.encode(body));

    var httpResponseBody = json.decode(httpResponse.body);

    return FlyternHttpResponse(
        statusCode: 200,
        message: [],
        errors: [],
        data: httpResponseBody['data'], success: httpResponseBody['success'] );
  } on SocketException {
    return generateErrorResponse('Couldn\'t Connect, Try Again Later');
  } on FormatException catch (e) {
    if (e.toString().contains("Request Not Implemented")) {
      return generateErrorResponse('Request Not Implemented');
    }

    if (e.toString().contains("Already authorised")) {
      return generateErrorResponse('Already authorised');
    }

    if (e.toString().contains("Request Not Authorised")) {
      return generateErrorResponse('Request Not Authorised');
    }
    return generateErrorResponse('Something went wrong, try again');
  } on Exception catch (e) {
    return generateErrorResponse('Something went wrong, try again');
  }
}

