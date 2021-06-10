import 'package:dio/dio.dart';
import 'package:eTour_flutter/app_localizations.dart';
import 'package:eTour_flutter/global/etour_toast.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart' as getter;

class ApiClientHelper {
  static Future<Dio> getDio() async {
    Dio addInterceptors(Dio dio) {
      return dio..interceptors.add(AppInterceptors());
    }

    final dio = Dio();
    return addInterceptors(dio);
  }
}

class AppInterceptors extends Interceptor {
  // Change to true if you want prints of api calls
  final bool debugApi = false && kDebugMode;
  final int _maxCharactersPerLine = 200;
  @override
  Future onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    if (debugApi) {
      print('--> ${options.method} ${options.path} ${options.queryParameters}');
      print('Content type: ${options.contentType}');
      print('<-- END HTTP');
    }

    return super.onRequest(options, handler);
  }

  @override
  Future onResponse(
      Response response, ResponseInterceptorHandler handler) async {
    if (debugApi) {
      print(
          '<-- ${response.statusCode} ${response.requestOptions.method} ${response.requestOptions.path}');
    }

    final responseAsString = response.data.toString();
    if (responseAsString.length > _maxCharactersPerLine) {
      final iterations =
          (responseAsString.length / _maxCharactersPerLine).floor();
      for (var i = 0; i <= iterations; i++) {
        var endingIndex = i * _maxCharactersPerLine + _maxCharactersPerLine;
        if (endingIndex > responseAsString.length) {
          endingIndex = responseAsString.length;
        }
        if (debugApi) {
          print(responseAsString.substring(
              i * _maxCharactersPerLine, endingIndex));
        }
      }
    } else {
      if (debugApi) {
        print(response.data);
      }
    }
    if (debugApi) {
      print('<-- END HTTP');
    }
    return super.onResponse(response, handler);
  }

  @override
  Future onError(DioError err, ErrorInterceptorHandler handler) async {
    print(err);
    // Offline error
    if (err.type == DioErrorType.other) {
      print("otherError");
      if (getter.Get.context != null) {
        await ETourToast.showToast(AppLocalizations.of(getter.Get.context!)!
            .translate('generic_offline_error')!);
      }

      return super.onError(err, handler);
    }
    final res = err.response!;
    if (debugApi) {
      print('<-- Error --> ${err.response!.requestOptions.path}');
      print(err.error);
      print(err.message);
    }
    // Unauthorized error, log out
    if (res.statusCode != null &&
        res.statusCode != 404 &&
        res.statusCode != 401) {
      await ETourToast.showToast(AppLocalizations.of(getter.Get.context!)!
          .translate('generic_error_description')!);
    }

    return super.onError(err, handler);
  }
}
