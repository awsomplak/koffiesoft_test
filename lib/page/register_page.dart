import 'package:flutter/material.dart';
import 'package:koffiesoft_test/config/colors.dart';
import 'package:koffiesoft_test/config/contant.dart';
import 'package:koffiesoft_test/config/shrd_pref.dart';
import 'package:koffiesoft_test/library/awlab_dialog.dart';
import 'package:koffiesoft_test/library/awlab_text.dart';
import 'package:koffiesoft_test/library/awlab_tools.dart';
import 'package:koffiesoft_test/library/log.dart';
import 'package:koffiesoft_test/library/rest/api_request.dart';
import 'package:koffiesoft_test/route/otp_route.dart';
import 'package:koffiesoft_test/widget/form_register.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:nb_utils/nb_utils.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  APIRequest restAPI = APIRequest();

  // Form Key for Validation Form
  final _formKey = GlobalKey<FormState>();

  // Is Page Loading
  bool _isLoading = false;

  // Page Animation Duration
  int animationDuration = 300;

  @override
  void initState() {
    super.initState();
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) super.setState(fn);
  }

  void showLoading() => setState(() => _isLoading = true);

  void hideLoading() => setState(() => _isLoading = false);

  void _registerOnClick(Map<String, dynamic> registerData) async {
    // TODO: Log User Register Data
    Log.d(registerData);

    showLoading();

    await _doRegister(registerData);

    hideLoading();
  }

  Future _doRegister(Map<String, dynamic> registerData) async {
    String title = 'Maaf';
    String message = 'Terjadi kesalahan, coba cek koneksi internet Kamu.';
    IconData icon = Icons.error_outline_outlined;
    Color color = Colors.orange;
    Color btnColor = Colors.red[300]!;
    bool alreadyRegistered = false;

    var response = await restAPI.authRegister(registerData: registerData);

    if (response != 'error') {
      alreadyRegistered = response.status.kode == 'failed' &&
          response.status.keterangan == 'Email sudah terdaftar';

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
      confirmButtonText: alreadyRegistered ? 'Verifikasi' : 'Oke',
      onConfirm: () => finish(context),
      onDismiss: (val) async {
        if (alreadyRegistered ||
            response != 'error' && response.status.kode == 'success') {
          openPage(
            credential: registerData['email'],
            isNewMember: !alreadyRegistered
          );
        }
      },
    );
  }

  void openPage({String? credential, bool? isNewMember}) async {
    await Future.delayed(Duration(milliseconds: animationDuration));
    AWLabShrdPref.setPageTitle('Verifikasi OTP');
    // ignore: use_build_context_synchronously
    OTPRoute(
      credential: credential,
      isNewMember: isNewMember,
    ).launch(
      context,
      isNewTask: false,
      pageRouteAnimation: PageRouteAnimation.Slide,
      duration: Duration(
        milliseconds: animationDuration,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var themes = Theme.of(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: themes.backgroundColor,
        body: LoadingOverlay(
          isLoading: _isLoading,
          opacity: .5,
          color: Colors.black,
          progressIndicator: CircularProgressIndicator(
            color: themes.primaryColor,
          ),
          child: Column(
            children: [
              // Register Header
              Container(
                height: context.height() * .30,
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(100),
                  ),
                  gradient: LinearGradient(
                    colors: [AppColorsDark.primaryDark!, AppColors.primary!],
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(
                          AWLabTools.getAssets(Constant.APP_LOGO),
                          color: Constant.LOGO_COLOR,
                          scale: Constant.LOGO_SCALE,
                          fit: BoxFit.cover,
                        ),
                        10.height,
                        Text(
                          Constant.APP_NAME,
                          style: AWLabText.headline(context)!.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      'Register',
                      style: AWLabText.headline(context)!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.right,
                    ).withWidth(double.infinity).paddingRight(16),
                  ],
                ),
              ),

              // Register Form
              Expanded(
                child: FormRegister(
                  formKey: _formKey,
                  onSubmit: _registerOnClick,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
