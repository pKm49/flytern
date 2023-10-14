import 'package:flytern/shared/data/constants/app_specific/shared_http_request_endpoints.dart';
import 'package:flytern/shared/data/models/app_specific/flytern_http_response.dart';
import 'package:flytern/shared/data/models/app_specific/set_device_info_request_body.dart';
import 'package:flytern/shared/data/models/business_models/business_doc.dart';
import 'package:flytern/shared/data/models/business_models/general_item.dart';
import 'package:flytern/shared/data/models/business_models/language.dart';
import 'package:flytern/shared/data/models/business_models/support_info.dart';
import 'package:flytern/shared/services/http-services/http_request_handler.dart';

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

  setDeviceInfo(SetDeviceInfoRequestBody setDeviceInfoRequestBody ) async {

    FlyternHttpResponse response = await postRequest(
        SharedHttpRequestEndpointSetDeviceInfo,setDeviceInfoRequestBody.toJson());

  }

}
