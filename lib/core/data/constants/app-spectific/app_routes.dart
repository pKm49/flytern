
import 'package:flytern/core/ui/pages/language_selector.dart';
import 'package:flytern/feature-modules/auth/ui/pages/auth_selector.dart';
import 'package:flytern/feature-modules/auth/ui/pages/login.dart';
import 'package:flytern/feature-modules/auth/ui/pages/register/register_details_input.dart';
import 'package:flytern/feature-modules/auth/ui/pages/register/register_otp_input.dart';
import 'package:flytern/feature-modules/auth/ui/pages/reset_password/reset_password_credentials.dart';
import 'package:flytern/feature-modules/auth/ui/pages/reset_password/reset_password_new_password.dart';
import 'package:flytern/feature-modules/auth/ui/pages/reset_password/reset_password_otp.dart';
import 'package:flytern/shared/data/constants/app_specific/app_route_names.dart';
import 'package:get/get.dart';

getAppRoutes() => [
  GetPage(
    name:  Approute_langaugeSelector,
    page: () =>   CoreLanguageSelector(),
    // transition: Transition.rightToLeft,
    // transitionDuration: const Duration(milliseconds: 200),
  ),
  GetPage(
    name: Approute_authSelector,
    page: () => const AuthSelectorPage(),
    middlewares: [MyMiddelware()],
  ),
  GetPage(
    name: Approute_registerMobile,
    page: () => const AuthRegisterDetailsInputPage(),
    middlewares: [MyMiddelware()],
  ),
  GetPage(
    name: Approute_registerOtp,
    page: () => const AuthRegisterOTPInputPage(),
    middlewares: [MyMiddelware()],
  ),
  GetPage(
    name: Approute_login,
    page: () => const AuthLoginPage(),
    middlewares: [MyMiddelware()],
  ),
  GetPage(
    name: Approute_resetPasswordMobile,
    page: () => const AuthResetPasswordCredentialsPage(),
    middlewares: [MyMiddelware()],
  ),
  GetPage(
    name: Approute_resetPasswordOtp,
    page: () => const AuthResetPasswordOTPPage(),
    middlewares: [MyMiddelware()],
  ),
  GetPage(
    name: Approute_resetPasswordNewpassword,
    page: () => const AuthResetPasswordNewPasswordPage(),
    middlewares: [MyMiddelware()],
  ),
];

class MyMiddelware extends GetMiddleware {
  @override
  GetPage? onPageCalled(GetPage? page) {
    print(page?.name);
    return super.onPageCalled(page);
  }
}