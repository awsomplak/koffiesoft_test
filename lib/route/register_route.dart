import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:koffiesoft_test/config/colors.dart';
import 'package:koffiesoft_test/library/awlab_dialog.dart';
import 'package:koffiesoft_test/page/register_page.dart';
import 'package:nb_utils/nb_utils.dart';

class RegisterRoute extends StatefulWidget {
  static String tag = '/RegisterRoute';
  const RegisterRoute({Key? key}) : super(key: key);

  @override
  State<RegisterRoute> createState() => _RegisterRouteState();
}

class _RegisterRouteState extends State<RegisterRoute> {
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
      child: const RegisterPage(),
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
