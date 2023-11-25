import 'package:flytern/feature-modules/flight_booking/data/models/cabin_class.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/flight_details.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/flight_search_data.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/flight_search_response.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/popular_destination.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/recommended_package.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/travel_story.dart';
import 'package:flytern/shared-module/models/country.dart';
import 'package:flytern/shared-module/models/language.dart';
import 'package:flytern/shared-module/models/payment_gateway.dart';

class GetGatewayData {

  final List<PaymentGateway> paymentGateways;
  final FlightDetails flightDetails;

  GetGatewayData({
    required this.paymentGateways,
    required this.flightDetails
  });


}
