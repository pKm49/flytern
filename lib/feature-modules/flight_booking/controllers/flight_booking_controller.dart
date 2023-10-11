import 'package:flytern/shared/data/constants/business_constants/available_countries.dart';
import 'package:flytern/shared/data/constants/business_constants/available_languages.dart';
import 'package:flytern/shared/data/models/business_models/country.dart';
import 'package:flytern/shared/data/models/business_models/language.dart';
import 'package:flytern/shared/data/models/business_models/support_info.dart';
import 'package:flytern/shared/services/http-services/shared_http_services.dart';
import 'package:get/get.dart';

class FlightBookingController extends GetxController {

  var isSetDeviceLanguageAndCountrySubmitting = false.obs;
  var sharedHttpService = SharedHttpService();

  var languages = <Language>[].obs;
  var countries = <Country>[].obs;

  @override
  void onInit() {
    super.onInit();

    languages.value = availableLanguages;
    countries.value = availableCountries;
  }

  Future<void> getInitialInfo() async {
    SupportInfo supportInfo = await sharedHttpService.getInitialSupportInfo();

    languages.value = supportInfo.languages;
    countries.value = supportInfo.countries;
  }

}
