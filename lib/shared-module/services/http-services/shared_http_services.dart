import 'package:flytern/shared-module/data/constants/app_specific/shared_http_request_endpoints.dart';
import 'package:flytern/shared-module/data/models/app_specific/flytern_http_response.dart';
import 'package:flytern/shared-module/data/models/app_specific/set_device_info_request_body.dart';
import 'package:flytern/shared-module/data/models/business_models/auth_token.dart';
import 'package:flytern/shared-module/data/models/business_models/business_doc.dart';
import 'package:flytern/shared-module/data/models/business_models/general_item.dart';
import 'package:flytern/shared-module/data/models/business_models/info_response_data.dart';
import 'package:flytern/shared-module/data/models/business_models/language.dart';
import 'package:flytern/shared-module/data/models/business_models/support_info.dart';
import 'package:flytern/shared-module/services/http-services/http_request_handler.dart';

class SharedHttpService {

  getInitialSupportInfo( ) async {
    FlyternHttpResponse response = await getRequest(
        SharedHttpRequestEndpointGetInitalInfo, null);

    if(response.success){
      if(response.data != null){
        SupportInfo supportInfo = mapSupportInfo(response.data);
        return supportInfo;
      }
    }

    return response;
  }

  getPreRegisterSupportInfo( ) async {
    FlyternHttpResponse response = await getRequest(
        SharedHttpRequestEndpointGetPreRegisterInfo, null);

    if(response.success){
      if(response.data != null){
        BusinessDoc businessDoc = mapBusinessDoc(response.data);
        return businessDoc;
      }
    }

    return null;
  }

  Future<InfoResponseData> getInfo(String type ) async {
    FlyternHttpResponse response = await getRequest(
        SharedHttpRequestEndpointGetBusinessInfo, {"type":type});

    if(response.success && response.statusCode==200){
      if(response.data != null){
        if(response.data["information"] != null){
          if(response.data["information"][0] != null){
            InfoResponseData infoResponseData = mapInfoResponseData(response.data["information"][0]);
            return infoResponseData;
          }
        }
      }
    }

    return mapInfoResponseData({});
  }


  setDeviceInfo(SetDeviceInfoRequestBody setDeviceInfoRequestBody ) async {

    FlyternHttpResponse response = await postRequest(
        SharedHttpRequestEndpointSetDeviceInfo,setDeviceInfoRequestBody.toJson());

  }

  Future<void> resendOtp(String userId) async {
    FlyternHttpResponse response =
    await postRequest(SharedHttpRequestEndpointResendOTP, {"userID": userId});

    print("resendOtp response.message ");
    print(response.message);
    print(response.errors);
    print(response.success);

    try {
      if (response.success && response.data != null) {
        return;
      } else {
        throw Exception(response.errors[0]);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<AuthToken> verifyOtp(String userId, String otp) async {
    print("verifyOtp");
    print(otp);
    print(userId);
    FlyternHttpResponse response = await postRequest(
        SharedHttpRequestEndpointVerifyOTP, {"otp": otp, "userID": userId});

    print(" response.message ");
    print(response.message);
    print(response.errors);
    print(response.success);

    try {
      if (response.success && (response.statusCode == 200 || response.statusCode == 202)) {
        AuthToken authToken = mapAuthToken(response.data, false);
        return authToken;
      } else {
        throw Exception(response.errors.isNotEmpty?response.errors[0]:response.data);
      }
    } catch (e) {
      rethrow;
    }
  }

}
