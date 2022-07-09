import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:koffiesoft_test/library/log.dart';
import 'package:nb_utils/nb_utils.dart';

class FormRegister extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final Function? onSubmit;
  const FormRegister({Key? key, required this.formKey, this.onSubmit})
      : super(key: key);

  @override
  State<FormRegister> createState() => _FormRegisterState();
}

class _FormRegisterState extends State<FormRegister> {
  // Form Text Editing Controller
  final TextEditingController _firstNameCtrl = TextEditingController();
  final TextEditingController _lastNameCtrl = TextEditingController();
  final TextEditingController _usernameCtrl = TextEditingController();
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _phoneCtrl = TextEditingController();
  final TextEditingController _dobCtrl = TextEditingController();
  final TextEditingController _passwordCtrl = TextEditingController();

  // Form Key for Validation Form
  GlobalKey<FormState>? _formKey;

  // Initially password is obscure
  bool _obscureText = true;

  // Gender
  List<DropdownMenuItem<int>> listGender = [
    const DropdownMenuItem<int>(
      value: 0,
      child: Text(
        "Pilih Jenis Kelamin",
      ),
    ),
    const DropdownMenuItem<int>(
      value: 1,
      child: Text(
        "Laki-Laki",
      ),
    ),
    const DropdownMenuItem<int>(
      value: 2,
      child: Text(
        "Perempuan",
      ),
    ),
  ];
  int selectedGender = 0;

  // Toggles the password show status
  void _toggle() => setState(() => _obscureText = !_obscureText);

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

  void onSubmit() {
    FormState? form = _formKey!.currentState;

    if (form!.validate()) {
      Map<String, dynamic> formResult = {
        'firstname': _firstNameCtrl.text,
        'lastname': _lastNameCtrl.text,
        'username': _usernameCtrl.text,
        'email': _emailCtrl.text,
        'hp': _phoneCtrl.text,
        'tgl_lahir': _dobCtrl.text,
        'jenis_kelamin': selectedGender,
        'password': _passwordCtrl.text,
        'grup': 'member',
        'role': 'member',
        'strict_password': false,
        'referral_code': '',
      };
      widget.onSubmit!(formResult);
    }
  }

  @override
  Widget build(BuildContext context) {
    var themes = Theme.of(context);
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.always,
      child: Center(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              // First Name Form
              TextFormField(
                controller: _firstNameCtrl,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: "Nama Depan",
                  hintText: "Masukkan nama depan Anda",
                  icon: Icon(
                    Icons.account_circle,
                    color: themes.primaryColor,
                  ),
                ),
                validator: (val) => val!.length < 3
                    ? 'Nama depan setidaknya harus berisi 3 karakter.'
                    : null,
              ),

              // Last Name Form
              TextFormField(
                controller: _lastNameCtrl,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: "Nama Belakang",
                  hintText: "Masukkan nama belakang Anda",
                  icon: Icon(
                    Icons.account_circle,
                    color: themes.primaryColor,
                  ),
                ),
                validator: (val) => val!.length < 3
                    ? 'Nama belakang setidaknya harus berisi 3 karakter.'
                    : null,
              ),

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
                validator: (val) => val!.length <= 3
                    ? 'Username setidaknya harus berisi 3 karakter.'
                    : null,
              ),

              // Email Form
              TextFormField(
                controller: _emailCtrl,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: "Email",
                  hintText: "Masukkan email Anda",
                  icon: Icon(
                    Icons.email_outlined,
                    color: themes.primaryColor,
                  ),
                ),
                validator: (val) => EmailValidator.validate(val!)
                    ? null
                    : 'Harap masukkan email yang valid.',
              ),

              // Phone Form
              TextFormField(
                controller: _phoneCtrl,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: "Telpon",
                  hintText: "Masukkan nomor telpon Anda",
                  icon: Icon(
                    Icons.phone_outlined,
                    color: themes.primaryColor,
                  ),
                ),
                validator: (val) {
                  String pattern = r'(^(?:[+0])?[0-9]{10,12}$)';
                  RegExp regExp = RegExp(pattern);
                  if (val!.isEmpty) {
                    return 'No telpon tidak boleh kosong';
                  } else if (!regExp.hasMatch(val)) {
                    return 'Harap masukkan no telpon valid hanya berupa angka.';
                  }
                  return null;
                },
              ),

              // DOB (Date Of Birth) Form
              TextFormField(
                controller: _dobCtrl,
                decoration: InputDecoration(
                  labelText: "Tanggal Lahir",
                  hintText: "Masukkan tanggal lahir Anda",
                  icon: Icon(
                    Icons.calendar_month_outlined,
                    color: themes.primaryColor,
                  ),
                ),
                onTap: () async {
                  DateTime? date = DateTime(1900);
                  FocusScope.of(context).requestFocus(FocusNode());
                  date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime(2100),
                  );

                  final f = DateFormat('yyyy-MM-dd');
                  _dobCtrl.text = f.format(date!);
                },
                validator: (val) =>
                    val!.isEmpty ? 'Wajib mengisi tanggal lahir.' : null,
              ),

              // Form Select Gender
              DropdownButtonFormField(
                decoration: InputDecoration(
                  labelText: "Jenis Kelamin",
                  hintText: "Pilih Jenis Kelamin",
                  icon: Icon(
                    Icons.transgender_outlined,
                    color: themes.primaryColor,
                  ),
                ),
                items: listGender,
                value: selectedGender,
                onChanged: (int? val) async {
                  setState(() => selectedGender = val!);
                },
                validator: (int? val) =>
                    val! == 0 ? 'Wajib memilih jenis kelamin.' : null,
              ),

              // Form Password
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
                  String pattern =
                      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
                  RegExp regExp = RegExp(pattern);
                  String pasw = val!;
                  if (pasw.length < 8) {
                    return 'Password setidaknya harus 8 karakter.';
                  } else if (pasw.length > 20) {
                    return 'Password maksimal 20 karakter.';
                  } else if (!regExp.hasMatch(pasw)) {
                    return 'Password harus memiliki 1 huruf besar dan kecil, 1 angka, dan 1 simbol (\$, @, atau #).';
                  }
                  return null;
                },
                obscureText: _obscureText,
                onFieldSubmitted: (password) =>
                    FocusScope.of(context).unfocus(),
              ),

              25.height,

              // Form Submit Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: themes.primaryColor,
                    onPrimary: Colors.white,
                    textStyle: boldTextStyle(size: 21),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  onPressed: onSubmit,
                  child: const Text("Daftar"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
