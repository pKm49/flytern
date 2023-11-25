import 'package:flytern/feature-modules/flight_booking/data/constants/business_specific/flight_mode.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/flight_allowed_cabin.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/flight_destination.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/flight_search_item.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/flight_search_response_dto_segment.dart';
import 'package:flytern/shared-module/models/general_item.dart';

class InsurancePriceData {
  final String code;
  final double price; 

  InsurancePriceData(
      {required this.code,
      required this.price });
}

InsurancePriceData mapInsurancePriceData(dynamic payload) { 

  return InsurancePriceData(
    code: payload["code"] ?? "",
    price: payload["price"] ?? 0.0, 
  );

}
