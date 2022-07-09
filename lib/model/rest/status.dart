import 'package:koffiesoft_test/library/rest/api_decode.dart';

class ModelRestStatus implements APIDecode<ModelRestStatus> {
  String? kode; // success / failed
  String? keterangan;

  ModelRestStatus();

  @override
  ModelRestStatus decode(dynamic json) {
    return ModelRestStatus.fromJSON(json);
  }

  ModelRestStatus.fromJSON(dynamic json) {
    kode = json['kode'];
    keterangan = json['keterangan'];
  }

  Map<String, String> toJSON() => {'kode': kode!, 'keterangan': keterangan!};
}
