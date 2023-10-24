import 'package:flytern/feature-modules/flight_booking/data/models/business_models/flight_destination.dart';

class FlightAllowedCabin {

  final String name;
  final String value;
  final bool isDefault;

  FlightAllowedCabin({
    required this.name,
    required this.value, 
    required this.isDefault,
  });

  Map toJson() => {
    'name': name,
    'value': value,
    'isDefault': isDefault,
  };

} 