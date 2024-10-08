class NetworkResponse {
  final int statusCode;
  dynamic responseData;
  String ? errorMessage;
  final bool isSuccess;

  NetworkResponse({
    required this.statusCode,
    required this.isSuccess,
    this.responseData,
    this.errorMessage = 'Something went wrong'
  });

}