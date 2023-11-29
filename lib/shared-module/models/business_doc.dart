import 'package:flytern/shared-module/models/country.dart';

class BusinessDoc {
  final List<Country> countries;
  final String terms;
  final String privacy;

  BusinessDoc(
      {required this.terms, required this.privacy, required this.countries});

  Map toJson() => {
        'terms': terms,
        'privacy': privacy,
        'countries': countries,
      };
}

BusinessDoc mapBusinessDoc(dynamic payload) {
  List<Country> tempCountries = [];

  if (payload["country"] != null) {
    payload["country"].forEach((element) {
      tempCountries.add(mapCountry(element));
    });
  }
  return BusinessDoc(
      countries: tempCountries,
      terms: payload["terms"] != null ? payload["terms"][0]["content"] : "",
      privacy:
          payload["privacy"] != null ? payload["privacy"][0]["content"] : "");
}
