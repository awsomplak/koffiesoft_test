import 'package:koffiesoft_test/library/rest/api_decode.dart';

class ModelRestData implements APIDecode<ModelRestData> {
  dynamic data;

  ModelRestData();

  @override
  ModelRestData decode(dynamic json) {
    return ModelRestData.fromJSON(json);
  }

  ModelRestData.fromJSON(dynamic json) {
    data = json;
  }
}
