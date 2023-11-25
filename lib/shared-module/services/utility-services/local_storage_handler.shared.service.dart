import 'package:flytern/shared-module/models/auth_token.dart';
import 'package:shared_preferences/shared_preferences.dart';

saveAuthTokenToSharedPreference(AuthToken authToken) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool("isGuest", authToken.isGuest);
  prefs.setString("accessToken", authToken.accessToken);
  prefs.setString("refreshToken", authToken.refreshToken);
  prefs.setString("expiryOn", authToken.expiryOn.toString());
}