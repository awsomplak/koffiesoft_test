import 'package:koffiesoft_test/config/contant.dart';
import 'package:koffiesoft_test/model/user_model.dart';
import 'package:nb_utils/nb_utils.dart';

class AWLabShrdPref {
  static Future setIsLoggedIn(bool value) async {
    await setValue(Constant.CNF_SHRDPREF_IS_LOGGED_IN, value);
  }

  static Future<bool> getIsLoggedIn() async {
    bool isLoggedIn = getBoolAsync(Constant.CNF_SHRDPREF_IS_LOGGED_IN);
    return isLoggedIn;
  }

  static setPageTitle(String title) async {
    await setValue(Constant.CNF_SHRDPREF_PAGE_TITLE, title);
  }

  static Future<String> getPageTitle() async {
    return getStringAsync(Constant.CNF_SHRDPREF_PAGE_TITLE);
  }

  static Future setUserData(Map<String, dynamic> json) async {
    await setValue(Constant.CNF_SHRDPREF_USER_DATA, json);
  }

  static Future<UserModel> getUserData() async {
    UserModel userData = UserModel.fromJSON(
      getJSONAsync(Constant.CNF_SHRDPREF_USER_DATA),
    );
    return userData;
  }
}
