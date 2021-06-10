import 'package:dio/dio.dart' hide Headers;

class ServerError implements Exception {
  int? _errorCode;
  String _errorMessage = '';
  DioErrorType? _errorType;

  ServerError.withError({required DioError error}) {
    _errorType = error.type;
    _errorCode = error.response?.statusCode;
    _handleError(error);
  }

  int? getErrorCode() {
    return _errorCode;
  }

  String getErrorMessage() {
    return _errorMessage;
  }

  DioErrorType? getErrorType() {
    return _errorType;
  }

  String _handleError(DioError error) {
    switch (error.type) {
      case DioErrorType.cancel:
        _errorMessage = 'Request was cancelled';
        break;
      case DioErrorType.connectTimeout:
        _errorMessage = 'Connection timeout';
        break;
      case DioErrorType.other:
        _errorMessage = 'Connection failed due to internet connection';
        break;
      case DioErrorType.receiveTimeout:
        _errorMessage = 'Receive timeout in connection';
        break;
      case DioErrorType.response:
        _errorMessage =
            'Received invalid status code: ${error.response!.statusCode}';
        break;
      case DioErrorType.sendTimeout:
        _errorMessage = 'Receive timeout in send request';
        break;
    }
    return _errorMessage;
  }
}
