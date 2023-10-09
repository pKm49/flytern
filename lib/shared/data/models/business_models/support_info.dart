import 'package:flytern/shared/data/models/business_models/country.dart';
import 'package:flytern/shared/data/models/business_models/language.dart';

class SupportInfo {

  final List<Language> languages;
  final List<Country> countries;

  SupportInfo({
    required this.languages,
    required this.countries,
  });

  Map toJson() => {
    'languages': languages,
    'countries': countries,
  };

}

SupportInfo mapSupportInfo(dynamic payload){
  return SupportInfo(
    languages :payload["languages"]??[],
    countries :payload["countries"] ??[],
  );
}
