import 'package:koffiesoft_test/library/rest/api_decode.dart';

class UserModel implements APIDecode<UserModel> {
  int? id;
  String? email;
  String? phone;
  String? firstName;
  String? lastName;
  String? group;
  String? role;
  String? dob;
  int? gender;

  @override
  UserModel decode(json) {
    return UserModel.fromJSON(json);
  }

  UserModel.fromJSON(json) {
    id = json['id'];
    email = json['email'];
    phone = json['hp'];
    firstName = json['firstname'];
    lastName = json['lastname'];
    group = json['grup'];
    role = json['role'];
    dob = json['tgl_lahir'];
    gender = json['jenis_kelamin'];
  }

  Map<String, dynamic> toJSON() => {
        "id": id,
        "email": email,
        "hp": phone,
        "firstname": firstName,
        "lastname": lastName,
        "grup": group,
        "role": role,
        "tgl_lahir": dob,
        "jenis_kelamin": gender,
      };
}
