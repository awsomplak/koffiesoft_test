import 'package:flutter/material.dart';
import 'package:koffiesoft_test/library/awlab_tools.dart';

class AppColors {
  // Primary Sapta
  static Color? primary = Colors.blue[700];
  static Color? primaryDark = Colors.blue[900];
  static Color? primaryLight = Colors.blue[400];
  static MaterialColor mainColor = AWLabTools.swatchify(Colors.blue, 700);

  static Color? accent = Colors.blue[800];
  static Color? accentDark = Colors.indigo[900];
  static Color? accentLight = Colors.blue[400];

  static const Color grey_3 = Color(0xFFf7f7f7);
  static const Color grey_5 = Color(0xFFf2f2f2);
  static const Color grey_10 = Color(0xFFe6e6e6);
  static const Color grey_20 = Color(0xFFcccccc);
  static const Color grey_40 = Color(0xFF999999);
  static const Color grey_60 = Color(0xFF666666);
  static const Color grey_80 = Color(0xFF37474F);
  static const Color grey_90 = Color(0xFF263238);
  static const Color grey_95 = Color(0xFF1a1a1a);
  static const Color grey_100_ = Color(0xFF0d0d0d);

  static const Color textPrimaryColor = Color(0xFF2E3033);
  static const Color textSecondaryColor = Color(0xFF757575);

  static Color? backgroundLight = Colors.grey[50];
  static Color? backgroundColor = Colors.grey[200];
}

class AppColorsDark {
  static Color? primary = Colors.blue[700];
  static Color? primaryDark = Colors.blue[900];
}