
class FlightAllowedCabin {

  final String name;
  final String value;
  final bool isDefault;

  FlightAllowedCabin({
    required this.name,
    required this.value,
    required this.isDefault,
  });

  Map toJson() =>
      {
        'name': name,
        'value': value,
        'isDefault': isDefault,
      };

}

FlightAllowedCabin mapFlightAllowedCabin(dynamic payload) {
  return FlightAllowedCabin(
      name: payload["name"]??"",
      value: payload["value"]??"",
      isDefault: payload["isDefault"]??false);
}