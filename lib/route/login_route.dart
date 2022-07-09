import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:koffiesoft_test/config/colors.dart';
import 'package:koffiesoft_test/library/awlab_dialog.dart';
import 'package:koffiesoft_test/page/login_page.dart';
import 'package:nb_utils/nb_utils.dart';

class LoginRoute extends StatefulWidget {
  static String tag = '/LoginRoute';
  const LoginRoute({Key? key}) : super(key: key);

  @override
  State<LoginRoute> createState() => _LoginRouteState();
}

class _LoginRouteState extends State<LoginRoute> {
  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) super.setState(fn);
  }

  void init() async {
    setStatusBarColor(
      AppColors.primary!.withOpacity(.75),
      statusBarIconBrightness: Brightness.light,
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: const LoginPage(),
      onWillPop: () => AWLabDialog.awlabMaterialDialog(
        context: context,
        title: 'Keluar Aplikasi ?',
        headerBackgroundColor: AppColors.primary,
        headerIcon: Icons.power_settings_new_outlined,
        showCancelButton: true,
        cancelButtonText: 'Batal',
        confirmButtonText: 'Keluar',
        confirmButtonColor: Colors.blue[700],
        cancelButtonColor: Colors.red[400],
        onConfirm: () => SystemNavigator.pop(),
        onCancel: () => finish(context),
      ),
    );
  }
}
