import 'package:koffiesoft_test/library/rest/api_decode.dart';

class ModelRestPaging implements APIDecode<ModelRestPaging> {
  int? page;
  int? totalPages;
  int? recordsPerPage;

  ModelRestPaging();

  @override
  ModelRestPaging decode(dynamic json) {
    return ModelRestPaging.fromJSON(json);
  }

  ModelRestPaging.fromJSON(dynamic json) {
    page = json['page'];
    totalPages = json['total_pages'];
    recordsPerPage = json['records_per_page'];
  }

  Map<String, dynamic> toJson() => {
        'page': page,
        'total_pages': totalPages,
        'records_per_page': recordsPerPage
      };
}
