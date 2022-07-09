import 'dart:async';

import 'package:flutter/material.dart';
import 'package:koffiesoft_test/config/colors.dart';
import 'package:koffiesoft_test/config/shrd_pref.dart';
import 'package:koffiesoft_test/library/awlab_dialog.dart';
import 'package:koffiesoft_test/library/awlab_text.dart';
import 'package:koffiesoft_test/library/awlab_tools.dart';
import 'package:koffiesoft_test/library/log.dart';
import 'package:koffiesoft_test/library/rest/api_request.dart';
import 'package:koffiesoft_test/model/user_model.dart';
import 'package:koffiesoft_test/route/dashboard_route.dart';
import 'package:koffiesoft_test/route/otp_route.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OTPPage extends StatefulWidget {
  const OTPPage({Key? key}) : super(key: key);

  @override
  State<OTPPage> createState() => _OTPPageState();
}

class _OTPPageState extends State<OTPPage> {
  APIRequest restAPI = APIRequest();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController otpCodeCtrl = TextEditingController();
  StreamController<ErrorAnimationType>? errorController;
  bool otpHasError = false;
  String currentOTP = "";

  bool resendEnabled = true;
  bool autoSubmitOnComplete = true;

  // Page Animation Duration
  int animationDuration = 300;

  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void dispose() {
    errorController!.close();
    super.dispose();
  }

  void init() {
    errorController = StreamController<ErrorAnimationType>();
    // setState(() => resendEnabled = OTPRoute.of(context)?.isNewMember as bool);
  }

  void doResendVerification(String? credential) async {
    // TODO: Log Credential From Registration Form
    Log.d(credential);

    String title = 'Maaf';
    String message = 'Terjadi kesalahan, coba cek koneksi internet Kamu.';
    IconData icon = Icons.error_outline_outlined;
    Color color = Colors.orange;
    Color btnColor = Colors.red[300]!;

    OTPRoute.of(context)!.showLoading();

    var response = await restAPI.authSendOTP(credential: credential!);

    // ignore: use_build_context_synchronously
    OTPRoute.of(context)!.hideLoading();

    if(response != 'error') {
      if (response.status.kode == 'success') {
        title = 'Sukses';
        icon = Icons.check_circle_outlined;
        color = Colors.green;
        btnColor = color;
      }

      message = response.status.keterangan;
    }

    AWLabDialog.awlabMaterialDialog(
      context: context,
      headerBackgroundColor: color,
      headerIcon: icon,
      title: title,
      message: message,
      confirmButtonColor: btnColor,
      confirmButtonText: 'Oke',
      onConfirm: () => finish(context),
      onDismiss: () => finish(context),
    );
  }

  void doVerify(String? credential) async {
    // TODO: Log Credential From Registration Form
    Log.d(credential);

    String title = 'Maaf';
    String message = 'Terjadi kesalahan, coba cek koneksi internet Kamu.';
    IconData icon = Icons.error_outline_outlined;
    Color color = Colors.orange;
    Color btnColor = Colors.red[300]!;

    // TODO: Log Current OTP Code
    Log.d(currentOTP);

    OTPRoute.of(context)!.showLoading();

    var response = await restAPI.authValidateOTP(
      credential: credential!,
      code: currentOTP,
    );

    // ignore: use_build_context_synchronously
    OTPRoute.of(context)!.hideLoading();

    if (response != 'error') {
      if (response.status.kode == 'success') {
        title = 'Sukses';
        icon = Icons.check_circle_outlined;
        color = Colors.green;
        btnColor = color;

        UserModel user = UserModel.fromJSON(response.data);
        await AWLabShrdPref.setIsLoggedIn(true);
        await AWLabShrdPref.setUserData(user.toJSON());
      }

      message = response.status.keterangan;
    }

    AWLabDialog.awlabMaterialDialog(
      context: context,
      headerBackgroundColor: color,
      headerIcon: icon,
      title: title,
      message: message,
      confirmButtonColor: btnColor,
      confirmButtonText: 'Oke',
      onConfirm: () => finish(context),
      onDismiss: (val) async {
        if (response != 'error' && response.status.kode == 'success') {
          openPage();
        }
      },
    );
  }

  void openPage() async {
    await Future.delayed(Duration(milliseconds: animationDuration));
    AWLabShrdPref.setPageTitle('Dashboard');
    // ignore: use_build_context_synchronously
    const DashboardRoute().launch(
      context,
      isNewTask: true,
      pageRouteAnimation: PageRouteAnimation.Slide,
      duration: Duration(
        milliseconds: animationDuration,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(0.0),
      shrinkWrap: true,
      children: [
        Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: context.width() * 0.75,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    30.height,
                    SizedBox(
                      width: 200,
                      height: 200,
                      child: Image.asset(
                        AWLabTools.getAssets(
                          'img_code_verification.png',
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 220,
                      child: Text(
                        "Kode OTP telah dikirim ke email Anda. Silakan masukkan di bawah ini",
                        style: AWLabText.subhead(context)!
                            .copyWith(color: AppColors.grey_60),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    15.height,
                    Form(
                      key: formKey,
                      child: PinCodeTextField(
                        appContext: context,
                        pastedTextStyle: TextStyle(
                          color: Colors.green.shade600,
                          fontWeight: FontWeight.bold,
                        ),
                        length: 6,
                        animationType: AnimationType.fade,
                        validator: (v) {
                          if (v!.length < 6) {
                            return "Wajib untuk mengisi kode OTP!";
                          }

                          return null;
                        },
                        pinTheme: PinTheme(
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(5),
                          fieldHeight: 50,
                          fieldWidth: 40,
                          activeFillColor: Colors.white,
                        ),
                        cursorColor: Colors.black,
                        animationDuration: const Duration(milliseconds: 300),
                        enableActiveFill: true,
                        errorAnimationController: errorController,
                        controller: otpCodeCtrl,
                        keyboardType: TextInputType.number,
                        boxShadows: const [
                          BoxShadow(
                            offset: Offset(0, 1),
                            color: Colors.black12,
                            blurRadius: 10,
                          )
                        ],
                        onChanged: (value) {
                          setState(() => currentOTP = value);
                        },
                        onCompleted: (v) {
                          // TODO: Do something on OTP completed fill here
                          Log.d('OTP Completed');

                          if (autoSubmitOnComplete &&
                              formKey.currentState!.validate()) {
                            doVerify(OTPRoute.of(context)?.credential);
                          }
                        },
                        beforeTextPaste: (text) {
                          Log.d("Allowing to paste OTP $text");
                          //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                          //but you can show anything you want here, like your pop up saying wrong paste format or etc
                          return true;
                        },
                      ),
                    ),
                    30.height,
                    SizedBox(
                      width: 200,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          primary: Colors.transparent,
                        ),
                        child: Text(
                          "Kirim Ulang Kode Verifikasi",
                          style: TextStyle(color: AppColors.primary),
                        ),
                        onPressed: () {
                          if (resendEnabled) {
                            doResendVerification(
                                OTPRoute.of(context)?.credential);
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      width: 200,
                      child: TextButton(
                        style:
                            TextButton.styleFrom(primary: Colors.transparent),
                        child: Text(
                          "VERIFIKASI",
                          style: TextStyle(color: AppColors.primary),
                        ),
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            doVerify(OTPRoute.of(context)?.credential);
                          }
                        },
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}
