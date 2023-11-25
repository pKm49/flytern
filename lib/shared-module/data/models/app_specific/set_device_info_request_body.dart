class SetDeviceInfoRequestBody {

  final String language;
  final String countryCode;
  final bool notificationEnabled;
  final String notificationToken;

  SetDeviceInfoRequestBody({
    required this.language,
    required this.countryCode,
    required this.notificationEnabled,
    required this.notificationToken
  });

  Map toJson() => {
    'language': language,
    'countryCode': countryCode,
    'notificationEnabled': notificationEnabled,
    'notificationToken': notificationToken
  };

}
