import 'package:flytern/feature-modules/flight_booking/models/details.flight_booking.model.dart';
import 'package:flytern/shared-module/models/payment_gateway.dart';

class GetGatewayData {

  final List<PaymentGateway> paymentGateways;
  final FlightDetails flightDetails;

  GetGatewayData({
    required this.paymentGateways,
    required this.flightDetails
  });


}
