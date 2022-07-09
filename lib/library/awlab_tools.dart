import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class AWLabTools {
  static String getAssets(String fileName) {
    return 'assets/images/$fileName';
  }

  static MaterialColor swatchify(MaterialColor color, int value) {
    return MaterialColor(color[value].hashCode, <int, Color>{
      50: color[value]!,
      100: color[value]!,
      200: color[value]!,
      300: color[value]!,
      400: color[value]!,
      500: color[value]!,
      600: color[value]!,
      700: color[value]!,
      800: color[value]!,
      900: color[value]!,
    });
  }

  // TODO: Only for check permission if needed
  static Future<bool> permissionChecker(BuildContext context) async {
    bool result = true;

    /* Map<Permission, PermissionStatus> statuses = await [
      Permission.location,
      Permission.camera,
    ].request();

    statuses.forEach((permission, status) {
      if (status != PermissionStatus.granted) result = false;
    }); */

    return result;
  }

  static bool isEmpty(dynamic item) {
    if (item.runtimeType == int) {
      return item == 0;
    } else if ([String, bool].contains(item.runtimeType) &&
        ['', 0, null, false].contains(item)) {
      return true;
    } else if (item.runtimeType == Null) {
      return true;
    } else if (item == {}) {
      return true;
    }
    return item.isEmpty ?? true;
  }
}
