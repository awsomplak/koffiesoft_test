import 'package:flutter/material.dart';
import 'package:koffiesoft_test/route/register_route.dart';
import 'package:nb_utils/nb_utils.dart';

class FormLogin extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final Function? onSubmit;
  const FormLogin({Key? key, required this.formKey, this.onSubmit})
      : super(key: key);

  @override
  State<FormLogin> createState() => _FormLoginState();
}

class _FormLoginState extends State<FormLogin> {
  final TextEditingController _usernameCtrl = TextEditingController();
  final TextEditingController _passwordCtrl = TextEditingController();

  // Form Key for Validation Form
  GlobalKey<FormState>? _formKey;

  // Initially password is obscure
  bool _obscureText = true;

  // Toggles the password show status
  void _toggle() => setState(() => _obscureText = !_obscureText);

  int animationDuration = 500;

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
    _formKey = widget.formKey;
  }

  void onSubmit(String username, String password) {
    widget.onSubmit!(username, password);
  }

  @override
  Widget build(BuildContext context) {
    var themes = Theme.of(context);
    return Form(
      key: _formKey,
      child: Center(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              // Username Form
              TextFormField(
                controller: _usernameCtrl,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: "Username",
                  hintText: "Masukkan username Anda",
                  icon: Icon(
                    Icons.account_circle,
                    color: themes.primaryColor,
                  ),
                ),
                validator: (val) => val != null && val.length <= 3
                    ? 'Username terlalu pendek.'
                    : null,
              ),

              25.height,

              // Password Form
              TextFormField(
                controller: _passwordCtrl,
                enableSuggestions: false,
                autocorrect: false,
                obscuringCharacter: '*',
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                  labelText: "Password",
                  hintText: "Masukkan password Anda",
                  icon: Icon(
                    Icons.lock,
                    color: themes.primaryColor,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility : Icons.visibility_off,
                      color: themes.primaryColor,
                    ),
                    onPressed: _toggle,
                  ),
                ),
                validator: (val) {
                  if (val != null) {
                    if (val.length < 8) {
                      return 'Password terlalu pendek. Min 8 karakter.';
                    } else if (val.length > 20) {
                      return 'Password terlalu panjang.';
                    }
                  }
                  return null;
                },
                obscureText: _obscureText,
                onFieldSubmitted: (password) =>
                    FocusScope.of(context).unfocus(),
              ),
              25.height,
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: themes.primaryColor,
                    onPrimary: Colors.white,
                    textStyle: boldTextStyle(size: 21),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  onPressed: () =>
                      onSubmit(_usernameCtrl.text, _passwordCtrl.text),
                  child: const Text("Login"),
                ),
              ),
              15.height,
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.amber[700],
                    onPrimary: Colors.white,
                    textStyle: boldTextStyle(size: 21),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  onPressed: () => {
                    const RegisterRoute().launch(
                      context,
                      isNewTask: true,
                      pageRouteAnimation: PageRouteAnimation.Slide,
                      duration: Duration(
                        milliseconds: animationDuration,
                      ),
                    )
                  },
                  child: const Text('Daftar'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
