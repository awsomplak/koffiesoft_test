import 'package:flutter/material.dart';
import 'package:koffiesoft_test/config/colors.dart';
import 'package:koffiesoft_test/config/contant.dart';
import 'package:koffiesoft_test/config/shrd_pref.dart';
import 'package:koffiesoft_test/library/awlab_dialog.dart';
import 'package:koffiesoft_test/library/awlab_text.dart';
import 'package:koffiesoft_test/library/awlab_tools.dart';
import 'package:koffiesoft_test/library/rest/api_request.dart';
import 'package:koffiesoft_test/model/rest/status.dart';
import 'package:koffiesoft_test/model/user_model.dart';
import 'package:koffiesoft_test/route/dashboard_route.dart';
import 'package:koffiesoft_test/widget/form_login.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:nb_utils/nb_utils.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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

  void _loginOnClick(String username, String password) async {
    FormState? form = _formKey.currentState!;
    form.save();

    showLoading();

    if (form.validate()) {
      await _doLogin(
        username: username,
        password: password,
      );
    }

    hideLoading();
  }

  Future _doLogin({
    String? username,
    String? password,
  }) async {
    String title = 'Maaf';
    String message = 'Terjadi kesalahan, coba cek koneksi internet Kamu.';
    IconData icon = Icons.error_outline_outlined;
    Color color = Colors.orange;
    Color btnColor = Colors.red[300]!;

    var response = await restAPI.authLogin(
      username: username!,
      password: password!,
    );

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
      onConfirm: () => finish(context),
      onDismiss: (val) async {
        if (response != 'error' && response.status == 202) openPage();
      },
    );
  }

  void showLoading() => setState(() => _isLoading = true);

  void hideLoading() => setState(() => _isLoading = false);

  void openPage() async {
    await Future.delayed(Duration(milliseconds: animationDuration));
    AWLabShrdPref.setPageTitle('Home');
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
              // Login Header
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
                      'LOGIN',
                      style: AWLabText.headline(context)!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.right,
                    ).withWidth(double.infinity).paddingRight(16),
                  ],
                ),
              ),

              // Login Form
              Expanded(
                child: FormLogin(
                  formKey: _formKey,
                  onSubmit: _loginOnClick,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
