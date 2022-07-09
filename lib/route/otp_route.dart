// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:koffiesoft_test/config/colors.dart';
import 'package:koffiesoft_test/library/awlab_dialog.dart';
import 'package:koffiesoft_test/page/otp_page.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:nb_utils/nb_utils.dart';

class OTPRoute extends StatefulWidget {
  final String? credential;
  final bool? isNewMember;
  const OTPRoute({Key? key, this.credential, this.isNewMember})
      : super(key: key);

  static _OTPRouteState? of(BuildContext context) =>
      context.findAncestorStateOfType<_OTPRouteState>();

  @override
  State<OTPRoute> createState() => _OTPRouteState();
}

class _OTPRouteState extends State<OTPRoute> {
  // Is Page Loading
  bool _isLoading = false;

  String? credential;
  bool? isNewMember;

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) super.setState(fn);
  }

  void init() {
    setState(() {
      credential = widget.credential;
      isNewMember = widget.isNewMember;
    });
  }

  void showLoading() => setState(() => _isLoading = true);
  
  void hideLoading() => setState(() => _isLoading = false);

  @override
  Widget build(BuildContext context) {
    var themes = Theme.of(context);
    return WillPopScope(
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Verifikasi OTP'),
            titleSpacing: 0.0,
          ),
          backgroundColor: themes.backgroundColor,
          body: LoadingOverlay(
            isLoading: _isLoading,
            child: const OTPPage(),
          ),
        ),
      ),
      onWillPop: () => AWLabDialog.awlabMaterialDialog(
        context: context,
        title: 'Batalkan Verifikasi ?',
        headerBackgroundColor: AppColors.primary,
        headerIcon: Icons.power_settings_new_outlined,
        showCancelButton: true,
        cancelButtonText: 'Batal',
        confirmButtonText: 'Ya',
        confirmButtonColor: Colors.blue[700],
        cancelButtonColor: Colors.red[400],
        onConfirm: () {
          finish(context);
          finish(context);
        },
        onCancel: () => finish(context),
      ),
    );
  }
}
