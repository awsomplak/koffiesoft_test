// ignore_for_file: library_private_types_in_public_api

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:koffiesoft_test/config/colors.dart';
import 'package:koffiesoft_test/route/dashboard_route.dart';
import 'package:koffiesoft_test/route/login_route.dart';
import 'package:koffiesoft_test/route/register_route.dart';
import 'package:koffiesoft_test/route/splash_route.dart';
import 'package:provider/provider.dart';

class MainRoute extends StatefulWidget {
  const MainRoute({Key? key}) : super(key: key);

  static _MainRouteState? of(BuildContext context) =>
      context.findAncestorStateOfType<_MainRouteState>();

  @override
  State<MainRoute> createState() => _MainRouteState();
}

class _MainRouteState extends State<MainRoute> {
  InternetConnectionChecker internetChecker = InternetConnectionChecker();

  bool hasInternet = false;
  StreamSubscription<InternetConnectionStatus>? listener;

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
    hasInternet = await internetChecker.hasConnection;

    if (!internetChecker.hasListeners) {
      listener = internetChecker.onStatusChange.listen((status) async {
        if (status == InternetConnectionStatus.disconnected) {
          init();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        backgroundColor: AppColors.backgroundColor
      ),
      home: StreamProvider(
        create: (context) => InternetConnectionChecker().onStatusChange,
        initialData: InternetConnectionStatus.connected,
        child: const SplashRoute(),
      ),
      routes: {
        SplashRoute.tag: (context) => const SplashRoute(),
        LoginRoute.tag: (context) => const LoginRoute(),
        RegisterRoute.tag: (context) => const RegisterRoute(),
        DashboardRoute.tag: (context) => const DashboardRoute(),
      },
    );
  }
}
