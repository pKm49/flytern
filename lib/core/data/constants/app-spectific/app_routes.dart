
import 'package:flytern/core/ui/pages/language_selector.dart';
import 'package:flytern/feature-modules/auth/ui/pages/auth_selector.dart';
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
];

class MyMiddelware extends GetMiddleware {
  @override
  GetPage? onPageCalled(GetPage? page) {
    print(page?.name);
    return super.onPageCalled(page);
  }
}