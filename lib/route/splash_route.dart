import 'dart:async';

import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:koffiesoft_test/config/colors.dart';
import 'package:koffiesoft_test/config/shrd_pref.dart';
import 'package:koffiesoft_test/library/awlab_dialog.dart';
import 'package:koffiesoft_test/library/awlab_tools.dart';
import 'package:koffiesoft_test/library/rest/api_request.dart';
import 'package:koffiesoft_test/page/splashscreen_page.dart';
import 'package:koffiesoft_test/route/dashboard_route.dart';
import 'package:koffiesoft_test/route/login_route.dart';
import 'package:koffiesoft_test/route/main_route.dart';
import 'package:nb_utils/nb_utils.dart';

class SplashRoute extends StatefulWidget {
  static String tag = '/SplashRoute';
  const SplashRoute({Key? key}) : super(key: key);

  @override
  State<SplashRoute> createState() => _SplashRouteState();
}

class _SplashRouteState extends State<SplashRoute> {
  APIRequest restAPI = APIRequest();
  InternetConnectionChecker? internetChecker;

  int duration = 5;
  int animationDuration = 500;
  bool isLoggedIn = false;
  bool hasInternet = false;

  @override
  void initState() {
    super.initState();
    internetChecker = MainRoute.of(context)?.internetChecker;
    init();
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) super.setState(fn);
  }

  void init() async {
    hasInternet = await internetChecker!.hasConnection;

    setStatusBarColor(
      // ignore: use_build_context_synchronously
      Theme.of(context).backgroundColor,
      statusBarIconBrightness: Brightness.dark,
    );

    if (hasInternet) {
      startTime(duration);
    } else {
      noInternetDialog(action: () => init());
    }
  }

  noInternetDialog({Function? action}) {
    AWLabDialog.awlabMaterialDialog(
      context: context,
      headerBackgroundColor: Colors.orange,
      headerIcon: Icons.error_outline_outlined,
      title: 'Maaf',
      message: 'Coba cek koneksi internet Kamu.',
      showCancelButton: false,
      confirmButtonText: 'Coba Lagi',
      onConfirm: () {
        finish(context);
        if (action != null) action;
      },
      onCancel: () {
        finish(context);
        if (action != null) action();
      },
    );
  }

  showDialog({
    String? title,
    String? message,
    IconData? icon,
    String? confirmButtonText,
    Function? onConfirm,
    Function? onDismiss,
    Function? onCancel,
  }) {
    onConfirm ??= () => finish(context);
    onDismiss ??= () => {};
    if (onCancel == null) onDismiss = () => {};
    AWLabDialog.awlabMaterialDialog(
      context: context,
      headerBackgroundColor: AppColors.primary,
      headerIcon: icon ?? Icons.update_outlined,
      title: title ?? 'Oops, Terjadi Gangguan',
      message: message ?? "Koneksi internet Kamu bermasalah, coba kembali.",
      confirmButtonText: confirmButtonText,
      onConfirm: () {
        finish(context);
        if (onConfirm != null) onConfirm;
      },
      onDismiss: () {
        finish(context);
        if (onDismiss != null) onDismiss;
      },
      onCancel: () {
        finish(context);
        if (onCancel != null) onCancel;
      },
    );
  }

  startTime(int durationTime) async {
    var duration = Duration(seconds: durationTime);
    return Timer(duration, navigationPage);
  }

  navigationPage() async {
    // TODO: Only for check permission if needed
    // Uncomment method on awlab_tools.dart
    bool permissionsGranted = await AWLabTools.permissionChecker(context);
    bool loginStatus = await AWLabShrdPref.getIsLoggedIn();
    setState(() => isLoggedIn = loginStatus);

    if (permissionsGranted) {
      if (isLoggedIn) {
        AWLabShrdPref.setPageTitle('Dashboard');
        DashboardRoute().launch(
          context,
          isNewTask: true,
          pageRouteAnimation: PageRouteAnimation.SlideBottomTop,
          duration: Duration(
            milliseconds: animationDuration,
          ),
        );
      } else {
        AWLabShrdPref.setPageTitle('Login');
        LoginRoute().launch(
          context,
          isNewTask: true,
          pageRouteAnimation: PageRouteAnimation.SlideBottomTop,
          duration: Duration(
            milliseconds: animationDuration,
          ),
        );
      }
    } else {
      AWLabDialog.awlabMaterialDialog(
        context: context,
        headerBackgroundColor: Colors.orange,
        headerIcon: Icons.error_outline_outlined,
        title: 'Maaf',
        message: 'Semua izin akses diperlukan!',
        showCancelButton: false,
        confirmButtonText: 'Coba Lagi',
        onConfirm: () async {
          finish(context);
          await navigationPage();
        },
        onDismiss: () async {
          finish(context);
          await navigationPage();
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: null,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          body: const SplashScreenPage(),
        ),
      ),
    );
  }
}
