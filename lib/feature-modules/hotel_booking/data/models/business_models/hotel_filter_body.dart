class HotelFilterBody {

  final int pageId;
  final int objectID;
  final String priceMinMaxDc;
  final String arrivalTimeDc;
  final String departureTimeDc;
  final String airlineDc;
  final String stopDc;
  final String sortingDc;

  HotelFilterBody({
    required this.pageId,
    required this.objectID,
    required this.priceMinMaxDc,
    required this.arrivalTimeDc,
    required this.departureTimeDc,
    required this.airlineDc,
    required this.stopDc,
    required this.sortingDc
  });

  Map toJson() => {
    'pageId': pageId,
    'objectID': objectID,
    'priceMinMaxDc': priceMinMaxDc,
    'arrivalTimeDc': arrivalTimeDc,
    'departureTimeDc': departureTimeDc,
    'airlineDc': airlineDc,
    'stopDc': stopDc,
    'sortingDc': sortingDc,
  };

}

