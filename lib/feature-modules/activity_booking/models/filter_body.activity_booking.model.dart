class ActivityFilterBody {

  final int pageId;
  final int objectID;
  final String priceMinMaxDc;
  final String tourCategoryDc;
  final String bestDealsDc;
  final String sortingDc;

  ActivityFilterBody({
    required this.pageId,
    required this.objectID,
    required this.priceMinMaxDc,
    required this.tourCategoryDc,
    required this.bestDealsDc,
    required this.sortingDc
  });

  Map toJson() => {
    'pageId': pageId,
    'objectID': objectID,
    'priceMinMaxDc': priceMinMaxDc,
    'tourCategoryDc': tourCategoryDc,
    'bestDealsDc': bestDealsDc,
    'sortingDc': sortingDc,
  };

}

