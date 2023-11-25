class FlyternHttpResponse{

  final bool success;
  final int statusCode;
  final dynamic data;
  final List<String> errors;
  final List<String> message;

  FlyternHttpResponse({
    required this.success,
    required this.statusCode,
    required this.data,
    required this.errors,
    required this.message});

}