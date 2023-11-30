import 'package:flytern/feature-modules/flight_booking/models/details.flight_booking.model.dart';
import 'package:flytern/shared-module/models/booking_info.dart';
import 'package:flytern/shared-module/models/payment_gateway.dart';

class GetGatewayData {

  final List<PaymentGateway> paymentGateways;
  final FlightDetails flightDetails;
  final List<BookingInfo> bookingInfo;
  final List<String> alert;

  GetGatewayData({
    required this.paymentGateways,
    required this.flightDetails,
    required this.bookingInfo,
    required this.alert,
  });


}
