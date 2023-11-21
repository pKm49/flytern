import 'package:flytern/feature-modules/hotel_booking/data/models/business_models/hotel_destination.dart';
import 'package:intl/intl.dart';

class HotelSearchItemRoomData {

  final int adults;
  final int childs;
  final List<int> childAges;

  HotelSearchItemRoomData({
    required this.adults,
    required this.childs,
    required this.childAges
  });

  Map toJson() =>
      {
        'adults': adults,
        'childs': childs,
        'childAges': childAges,
      };

  String getFormattedDate(DateTime dateTime) {
    final f = DateFormat('yyyy-MM-dd');
    return f.format(dateTime);
  }
}

HotelSearchItemRoomData mapHotelSearchItem(dynamic payload) {
  List<int> childAges = [];

  if(payload["childAges"] != null){
    payload["childAges"].forEach((element) {
      childAges.add(int.parse(element.toString()));
    });
  }
  return HotelSearchItemRoomData(
      adults: payload["adults"]??1,
      childs: payload["childs"]??1,
      childAges: childAges
  );

}

HotelSearchItemRoomData getDefaultHotelSearchItem() {

  return HotelSearchItemRoomData(
      adults: 1,
      childs: 0,
      childAges: []
  );

}