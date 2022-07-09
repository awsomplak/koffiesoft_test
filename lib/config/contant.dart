// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

class Constant {
  // Release Mode
  static const String RELEASE_MODE = 'development';

  // APP INFO
  static const String APP_NAME = 'Koffiesoft';
  static const String APP_LOGO = 'koffiesoft.png';
  static const double LOGO_SCALE = 2;
  static const Color LOGO_COLOR = Colors.white;

  // APP Current Version
  static const int APP_CURRENT_VERSION_CODE = 1;
  static const String APP_CURRENT_VERSION_NAME = 'v1.0.0';

  // REST Constant
  static const String REST_API_KEY = '';
  static const String REST_API_PROTOCOL = 'http';
  static const String REST_API_HOST = '202.157.184.201';
  static const String REST_API_PORT = ':8000';
  static const String REST_API_PATH = '';
  static const String REST_API_URL =
      "$REST_API_PROTOCOL://$REST_API_HOST$REST_API_PORT/$REST_API_PATH/";

  // SYSTEM Constant
  static const String CNF_SHRDPREF_PAGE_TITLE = "page_title";
  static const String CNF_SHRDPREF_IS_LOGGED_IN = "isLoggedIn";
  static const String CNF_SHRDPREF_USER_DATA = "userData";
}
