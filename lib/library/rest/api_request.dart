// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:dio/dio.dart';
import 'package:koffiesoft_test/config/contant.dart';
import 'package:koffiesoft_test/library/awlab_tools.dart';
import 'package:koffiesoft_test/library/rest/api_client.dart';
import 'package:koffiesoft_test/library/rest/api_route.dart';
import 'package:koffiesoft_test/library/rest/interceptors/log_interceptor.dart';

class APIRequest {
  APIClient? client;
  final interceptors = [APILogInterceptor()];

  APIRequest() {
    _initClient();
  }

  _initClient() {
    client = APIClient(BaseOptions(baseUrl: Constant.REST_API_URL));
    client!.instance?.interceptors.addAll(interceptors);
  }

  Future authLogin({
    required String username,
    required String password,
  }) async {
    var request;
    var formData = {
      'username': username,
      'password': password,
    };

    request = await client?.request(
      route: APIRoute(type: APIType.auth),
      contentType: Headers.formUrlEncodedContentType,
      data: formData,
    );

    request ??= 'error';
    if (request != 'error' && AWLabTools.isEmpty(request.data)) {
      request.data = [];
    }

    return request;
  }

  Future authRegister({
    required Map<String, dynamic> registerData,
  }) async {
    var request = await client?.request(
      route: APIRoute(type: APIType.register),
      contentType: Headers.jsonContentType,
      data: registerData,
    );

    request ??= 'error';
    if (request != 'error' && AWLabTools.isEmpty(request.data)) {
      request.data = [];
    }

    return request;
  }

  Future authSendOTP({
    required String credential,
  }) async {
    var request = await client?.request(
      route: APIRoute(type: APIType.sendOtp),
      contentType: Headers.jsonContentType,
      data: {
        'credential': credential,
        'tujuan': 'email',
        'zona_waktu': 'Asia/Jakarta',
      },
    );

    request ??= 'error';
    if (request != 'error' && AWLabTools.isEmpty(request.data)) {
      request.data = [];
    }

    return request;
  }

  Future authValidateOTP({
    required String credential,
    required String code,
  }) async {
    var request = await client?.request(
      route: APIRoute(type: APIType.verifyOtp),
      contentType: Headers.jsonContentType,
      data: {
        'credential': credential,
        'code': code,
      },
    );

    request ??= 'error';
    if (request != 'error' && AWLabTools.isEmpty(request.data)) {
      request.data = [];
    }

    return request;
  }
}
