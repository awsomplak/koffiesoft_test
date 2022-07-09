import 'dart:convert';

import 'package:koffiesoft_test/library/awlab_tools.dart';
import 'package:koffiesoft_test/library/log.dart';
import 'package:koffiesoft_test/library/rest/api_decode.dart';
import 'package:koffiesoft_test/model/rest/data.dart';
import 'package:koffiesoft_test/model/rest/paging.dart';
import 'package:koffiesoft_test/model/rest/status.dart';

enum APIResponseDataType { object, list }

class APIResponse implements APIDecode<APIResponse> {
  ModelRestPaging? paging;
  ModelRestStatus? status;
  dynamic data;

  @override
  APIResponse decode(json) {
    return APIResponse.fromJSON(json);
  }

  APIResponse.fromJSON(dynamic json) {
    Map<String, dynamic> res = jsonDecode(json);
    paging = res.containsKey('paging')
        ? (AWLabTools.isEmpty(res['paging'])
            ? null
            : ModelRestPaging.fromJSON(res['paging']))
        : null;
    status = res.containsKey('status')
        ? (AWLabTools.isEmpty(res['status'])
            ? null
            : ModelRestStatus.fromJSON(res['status']))
        : null;
    data = res.containsKey('data')
        ? (res['data'] == null ? [] : ModelRestData.fromJSON(res['data']))
        : null;
  }
}
