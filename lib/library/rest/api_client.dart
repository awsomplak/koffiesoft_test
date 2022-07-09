// ignore_for_file: unused_local_variable, body_might_complete_normally_nullable

import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:koffiesoft_test/library/log.dart';
import 'package:koffiesoft_test/library/rest/api_response.dart';
import 'package:koffiesoft_test/library/rest/api_route.dart';

abstract class BaseAPIClient {
  Future? request() {
    @required
    APIRouteConfigurable route;
    dynamic data;
  }
}

class APIClient extends BaseAPIClient {
  final BaseOptions options;
  Dio? instance;

  APIClient(this.options) {
    instance = Dio(options);
    (instance!.httpClientAdapter as DefaultHttpClientAdapter)
        .onHttpClientCreate = (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
  }

  @override
  Future request({
    @required APIRouteConfigurable? route,
    dynamic data,
    dynamic contentType,
    dynamic header,
  }) async {
    final config = route!.getConfig();
    config.followRedirects = false;
    config.baseUrl = options.baseUrl;
    config.validateStatus = (status) => (status! <= 503);
    config.data = data;

    if (contentType != null && !contentType.isEmpty) {
      config.contentType = contentType;
    }

    if (header != null && !header.isEmpty) {
      config.headers.addAll(header);
    }

    var response;
    var responseData;

    try {
      response = await instance!.fetch(config);
      responseData = APIResponse.fromJSON(response.toString());
    } on DioError catch (e) {
      Log.e(e);
      responseData = null;
    } on Exception catch (e) {
      Log.e(e);
      responseData = null;
    }

    responseData ??= 'error';

    return responseData;
  }
}
