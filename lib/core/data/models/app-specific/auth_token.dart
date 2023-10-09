
import 'package:flytern/shared/data/constants/app_specific/default_values.dart';

class AuthToken {


  final String  accessToken;
  final String  refreshToken;
  final DateTime expiryOn;

  AuthToken({
    required this.accessToken,
    required this.refreshToken,
    required this.expiryOn,
  });

  Map toJson() => {
    'accessToken': accessToken,
    'refreshToken': refreshToken,
    'expiryOn': expiryOn,
  };

}

AuthToken mapAuthToken(dynamic payload){
  return AuthToken(
    accessToken :payload["accessToken"]??"",
    refreshToken :payload["refreshToken"]??"",
    expiryOn :payload["expiryOn"] != null?DateTime.parse(payload["expiryOn"]):
    DefaultInvalidDate,
  );
}
