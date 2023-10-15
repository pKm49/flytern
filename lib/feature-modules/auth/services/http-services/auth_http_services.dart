import 'package:flytern/feature-modules/auth/data/constants/app_specific/auth_http_request_endpoints.dart';
import 'package:flytern/feature-modules/auth/data/models/business_models/login_credential.dart';
import 'package:flytern/shared/data/models/app_specific/flytern_http_response.dart';
import 'package:flytern/shared/data/models/business_models/auth_token.dart';
import 'package:flytern/shared/services/http-services/http_request_handler.dart';

class AuthHttpService {

  Future<AuthToken > login(LoginCredential loginCredential ) async {
    FlyternHttpResponse response = await postRequest(
        AuthHttpRequestEndpointLogin, loginCredential.toJson());

    print(" response.message ");
    print(response.message);
    print(response.errors);
    print(response.success);

   try{
     if(response.success && response.data != null){
       AuthToken authToken = mapAuthToken(response.data, false);
       return authToken;
     }else{
       throw Exception(response.errors[0]);
     }
   }catch (e){
     rethrow;
   }

  }


}
