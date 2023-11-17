class HotelFilterBody {

  final int pageId;
  final int objectID;
  final String priceMinMaxDc;
  final String ratingDcs;
  final String locationDcs;
  final String sortingDc;

  HotelFilterBody({
    required this.pageId,
    required this.objectID,
    required this.priceMinMaxDc,
    required this.ratingDcs,
    required this.locationDcs,
    required this.sortingDc
  });

  Map toJson() => {
    'pageId': pageId,
    'objectID': objectID,
    'priceMinMaxDc': priceMinMaxDc,
    'ratingDcs': ratingDcs,
    'locationDcs': locationDcs,
    'sortingDc': sortingDc,
  };

}

