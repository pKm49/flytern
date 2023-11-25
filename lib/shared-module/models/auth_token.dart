
import 'package:flytern/shared-module/constants/app_specific/default_values.shared.constant.dart';

class AuthToken {


  final String  accessToken;
  final String  refreshToken;
  final DateTime expiryOn;
  final bool isGuest;

  AuthToken({
    required this.accessToken,
    required this.refreshToken,
    required this.expiryOn,
    required this.isGuest,
  });

  Map toJson() => {
    'accessToken': accessToken,
    'refreshToken': refreshToken,
    'expiryOn': expiryOn,
    'isGuest': isGuest,
  };

}

AuthToken mapAuthToken(dynamic payload, bool isGuest){
  return AuthToken(
    isGuest:isGuest,
    accessToken :payload["accessToken"]??"",
    refreshToken :payload["refreshToken"]??"",
    expiryOn :payload["expiryOn"] != null?DateTime.parse(payload["expiryOn"]):
    DefaultInvalidDate,
  );
}
