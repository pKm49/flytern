
class HotelAllowedCabin {

  final String name;
  final String value;
  final bool isDefault;

  HotelAllowedCabin({
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