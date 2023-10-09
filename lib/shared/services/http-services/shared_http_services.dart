import 'package:flytern/shared/data/constants/app_specific/shared_http_request_endpoints.dart';
import 'package:flytern/shared/data/models/app_specific/flytern_http_response.dart';
import 'package:flytern/shared/services/http-services/http_request_handler.dart';

class SharedHttpService {

  getInitialSupportInfo(bool notificationEnabled, String notificationToken) async {
    FlyternHttpResponse response = await postRequest(
        SharedHttpRequestEndpointGetInitalInfo, {
      notificationEnabled: notificationEnabled,
      notificationToken: notificationToken
    });

    return response;
  }

}
