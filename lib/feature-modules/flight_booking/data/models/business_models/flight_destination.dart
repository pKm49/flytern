class FlightDestination {

  final String airportCode;
  final String airportName;
  final String uniqueCombination;
  final int sort;
  final String countryISOCode; 
  final String flag;

  FlightDestination({
    required this.airportCode,
    required this.airportName, 
    required this.uniqueCombination,
    required this.sort,
    required this.countryISOCode,
    required this.flag,
  });

  Map toJson() => {
    'airportCode': airportCode,
    'airportName': airportName,
    'uniqueCombination': uniqueCombination,
    'sort': sort,
    'countryISOCode': countryISOCode,
    'flag': flag,
  };

}

FlightDestination mapFlightDestination(dynamic payload){
  return FlightDestination(
    airportCode :payload["airportCode"]??"",
    airportName :payload["airportName"]??"",
    uniqueCombination :payload["uniqueCombination"]??"",
    sort :payload["sort"]??-1,
    countryISOCode :payload["countryISOCode"]??"",
    flag :payload["flag"]??"",
  );
}

FlightDestination getDefaultFlightDestination(bool isArrival){
  return FlightDestination(
    airportCode :isArrival?"KBL":"IST",
    airportName :isArrival?"Kabul":"Istanbul",
    uniqueCombination :isArrival?"KBL":"IST",
    sort :isArrival?1:2,
    countryISOCode :isArrival?"Pakistan":"Pakistan",
    flag :isArrival?"":"",
  );
}