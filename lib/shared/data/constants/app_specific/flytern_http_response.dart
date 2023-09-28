class FlyternHttpResponse{

  final num status_code;
  final String message;
  final dynamic data;

  FlyternHttpResponse({required this.status_code,
    required this.message,
    required this.data});

}