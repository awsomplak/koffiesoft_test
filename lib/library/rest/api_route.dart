import 'package:dio/dio.dart';
import 'package:koffiesoft_test/config/contant.dart';

abstract class APIRouteConfigurable {
  RequestOptions getConfig();
}

class APIMethod {
  static const get = 'GET';
  static const post = 'POST';
  static const put = 'PUT';
  static const patch = 'PATCH';
  static const delete = 'DELETE';
}

enum APIType { auth, register, sendOtp, verifyOtp }

class APIRoute implements APIRouteConfigurable {
  final APIType? type;
  final Map<String, dynamic>? queryParams;
  final String? path;
  final String? method;
  final bool isNeedToken = true;
  final String? token;

  APIRoute({
    this.type,
    this.queryParams,
    this.path,
    this.method,
    isNeedToken,
    this.token,
  });

  // Return config of api (method, url, header)
  @override
  RequestOptions getConfig() {
    RequestOptions requestOptions;

    switch (type) {
      //auth request
      case APIType.auth:
        requestOptions = _setRequestOptions(
          path: 'login',
          method: APIMethod.post,
          isNeedToken: false,
        );
        break;
      case APIType.register:
        requestOptions = _setRequestOptions(
          path: 'users',
          method: APIMethod.post,
          isNeedToken: false,
        );
        break;
      case APIType.sendOtp:
        requestOptions = _setRequestOptions(
          path: 'users/otp',
          method: APIMethod.post,
          isNeedToken: false,
        );
        break;
      case APIType.verifyOtp:
        requestOptions = _setRequestOptions(
          path: 'users/verifikasi',
          method: APIMethod.post,
          isNeedToken: false,
        );
        break;
      default:
        requestOptions = _setRequestOptions(
          path: path,
          method: method,
          isNeedToken: isNeedToken,
        );
    }

    return requestOptions;
  }

  RequestOptions _setRequestOptions({
    String? path,
    String? method,
    Map<String, dynamic>? extra,
    bool? isNeedToken,
  }) {
    return RequestOptions(
      path: path is String ? path : path.toString(),
      method: method,
      queryParameters: queryParams,
      headers: isNeedToken! ? {Constant.REST_API_KEY: 'Bearer ${token!}'} : {},
      extra: extra,
    );
  }
}
