import 'package:flytern/shared-module/models/country.dart';
import 'package:flytern/shared-module/models/gender.dart';
import 'package:flytern/shared-module/models/language.dart';

class SupportInfo {

  final List<Language> languages;
  final List<Country> countriesList;
  final List<Country> mobileCountryList;
  final List<Gender> genderList;
  final List<Gender> titleList;

  SupportInfo({
    required this.languages,
    required this.countriesList,
    required this.mobileCountryList,
    required this.genderList,
    required this.titleList,
  });

  Map toJson() => {
    'languages': languages,
    'countriesList': countriesList,
    'mobileCountryList': mobileCountryList,
    'genderList': genderList,
    'titleList': titleList,
  };

}

SupportInfo mapSupportInfo(dynamic payload){

  List<Language> tempLanguages = [];
  List<Country> countriesList = [];
  List<Country> mobileCountryList = [];
  List<Gender> genderList = [];
  List<Gender> titleList = [];

  if (payload["countriesList"] != null) {
    payload["countriesList"].forEach((element) {
      countriesList.add(mapCountry(element));
    });
  }

  if (payload["mobileCountryList"] != null) {
    payload["mobileCountryList"].forEach((element) {
      mobileCountryList.add(mapCountry(element));
    });
  }

  if (payload["genderList"] != null) {
    payload["genderList"].forEach((element) {
      genderList.add(mapGender(element));
    });
  }

  if (payload["titleList"] != null) {
    payload["titleList"].forEach((element) {
      titleList.add(mapGender(element));
    });
  }
  if(payload["languages"] != null){
    payload["languages"].forEach((element) {
      tempLanguages.add(mapLanguage(element));
    });
  }



  return SupportInfo(
    languages :tempLanguages,
      countriesList: countriesList,
      mobileCountryList: mobileCountryList,
      genderList: genderList,
      titleList: titleList,
  );
}
