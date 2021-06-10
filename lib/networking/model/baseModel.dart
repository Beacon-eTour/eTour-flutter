import 'package:eTour_flutter/networking/server_error.dart';

class BaseModel<T> {
  ServerError? _error;
  T? data;

  void setException(ServerError error) {
    _error = error;
  }

  BaseModel<T> setData(T data) {
    this.data = data;
    return this;
  }

  ServerError? getException() {
    return _error;
  }
}
