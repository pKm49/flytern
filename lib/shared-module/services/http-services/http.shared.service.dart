import 'package:flytern/shared-module/constants/business_specific/http_request_endpoints.shared.constant.dart';
import 'package:flytern/shared-module/models/flytern_http_response.dart';
import 'package:flytern/shared-module/models/set_device_info_request_body.dart';
import 'package:flytern/shared-module/models/auth_token.dart';
import 'package:flytern/shared-module/models/business_doc.dart';
 import 'package:flytern/shared-module/models/info_response_data.dart';
import 'package:flytern/shared-module/models/support_info.dart';
import 'package:flytern/shared-module/services/http-services/http_request_handler.shared.service.dart';

class SharedHttpService {

  Future<SupportInfo> getInitialSupportInfo( ) async {

    try{
      FlyternHttpResponse response = await getRequest(
          SharedHttpRequestEndpointGetInitalInfo, null);

      if(response.success){
        if(response.data != null){
          SupportInfo supportInfo = mapSupportInfo(response.data);
          return supportInfo;
        }
      }

      return mapSupportInfo({});
    }catch (e){
      return mapSupportInfo({});
    }
  }

  Future<BusinessDoc> getPreRegisterSupportInfo( ) async {


    try{

      FlyternHttpResponse response = await getRequest(
          SharedHttpRequestEndpointGetPreRegisterInfo, null);

      if(response.success){
        if(response.data != null){
          BusinessDoc businessDoc = mapBusinessDoc(response.data);
          return businessDoc;
        }
      }

      return mapBusinessDoc({});
    }catch (e){
      return mapBusinessDoc({});
    }
  }

  Future<InfoResponseData> getInfo(String type ) async {

    try{
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
    }catch (e){
      return mapInfoResponseData({});
    }

  }

  Future<bool> setDeviceInfo(SetDeviceInfoRequestBody setDeviceInfoRequestBody ) async {

    try{
      FlyternHttpResponse response = await postRequest(
          SharedHttpRequestEndpointSetDeviceInfo,setDeviceInfoRequestBody.toJson());
      return true;
    }catch (e){
      return false;
    }

  }

  Future<bool> resendOtp(String userId) async {

    try {
      FlyternHttpResponse response =
      await postRequest(SharedHttpRequestEndpointResendOTP, {"userID": userId});

      if (response.success && response.data != null) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;

    }
  }

  Future<AuthToken> verifyOtp(String userId, String otp) async {

    try {
      FlyternHttpResponse response = await postRequest(
          SharedHttpRequestEndpointVerifyOTP, {"otp": otp, "userID": userId});

      if (response.success && (response.statusCode == 200 || response.statusCode == 202)) {
        AuthToken authToken = mapAuthToken(response.data, false);
        return authToken;
      } else {
        return mapAuthToken({},true);
      }
    } catch (e) {
      return mapAuthToken({},true);
    }
  }

}
