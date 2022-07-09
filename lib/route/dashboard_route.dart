import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:koffiesoft_test/config/colors.dart';
import 'package:koffiesoft_test/config/shrd_pref.dart';
import 'package:koffiesoft_test/library/awlab_dialog.dart';
import 'package:koffiesoft_test/route/login_route.dart';
import 'package:nb_utils/nb_utils.dart';

class DashboardRoute extends StatefulWidget {
  static String tag = '/DashboardRoute';
  const DashboardRoute({Key? key}) : super(key: key);

  @override
  State<DashboardRoute> createState() => _DashboardRouteState();
}

class _DashboardRouteState extends State<DashboardRoute> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) super.setState(fn);
  }

  void logout() async {
    AWLabShrdPref.setIsLoggedIn(false);
    AWLabShrdPref.setPageTitle('Login');

    await Future.delayed(const Duration(milliseconds: 300));

    // ignore: use_build_context_synchronously
    const LoginRoute().launch(
      context,
      isNewTask: true,
      pageRouteAnimation: PageRouteAnimation.Slide,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  Widget build(BuildContext context) {
    var themes = Theme.of(context);
    return WillPopScope(
      child: SafeArea(
        child: Scaffold(
          backgroundColor: themes.backgroundColor,
          body: Center(
            child: Column(
              children: [
                Row(
                  children: [
                    const Text('Selamat datang \$username'),
                    25.height,
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: themes.primaryColor,
                        onPrimary: Colors.white,
                        textStyle: boldTextStyle(size: 21),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      onPressed: logout,
                      child: const Text('Logout'),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
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
