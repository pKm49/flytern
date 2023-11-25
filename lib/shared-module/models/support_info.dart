import 'package:flytern/shared-module/models/country.dart';
import 'package:flytern/shared-module/models/language.dart';

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

  List<Language> tempLanguages = [];
  List<Country> tempCountries = [];

  if(payload["languages"] != null){
    payload["languages"].forEach((element) {
      tempLanguages.add(mapLanguage(element));
    });
  }

  if(payload["countries"] != null){
    payload["countries"].forEach((element) {
      tempCountries.add(mapCountry(element));
    });
  }


  return SupportInfo(
    languages :tempLanguages,
    countries :tempCountries,
  );
}
