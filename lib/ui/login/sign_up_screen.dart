import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:edusol/ui/login/sign_in_screen.dart';
import 'package:edusol/ui/root_screen.dart';
import 'package:edusol/viewmodels/account_provider.dart';
import 'package:edusol/widgets/custom_textfield.dart';
import 'package:edusol/widgets/global_widgets.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  AccountProvider _accountProvider;
  TextEditingController _emailController;
  TextEditingController _passwordController;
  TextEditingController _passwordAgainController;
  bool isQueryable = false;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _passwordAgainController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _accountProvider = Provider.of<AccountProvider>(context);

    var _height = screenHeightExcludingToolbar(context);
    var _width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: _appBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: _height, minWidth: _width),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Hero(tag: 'title', child: GlobalWidgets.appTitle()),
                  SizedBox(
                    height: 48,
                  ),
                  _emailField(),
                  _passwordField(),
                  _passwordAgainField(),
                  _signUpInfoText,
                  SizedBox(
                    height: 48,
                  ),
                  _submitButton(),
                  _createAccountLabel()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _appBar() {
    return AppBar(
      centerTitle: false,
      elevation: 0,
      title: Text(
        'Kaydol',
        style: GoogleFonts.montserrat(),
      ),
    );
  }

  Widget _emailField() {
    return CustomTextField(
      title: 'E-Posta Adresi',
      controller: _emailController,
      onChanged: (text) {
        _checkQueryable();
      },
      keyboardType: TextInputType.emailAddress,
    );
  }

  Widget _passwordField() {
    return CustomTextField(
      title: 'Parola',
      controller: _passwordController,
      onChanged: (text) {
        _checkQueryable();
      },
      obscureText: true,
      keyboardType: TextInputType.text,
    );
  }

  Widget _passwordAgainField() {
    return CustomTextField(
      title: 'Parola Tekrar',
      controller: _passwordAgainController,
      onChanged: (text) {
        _checkQueryable();
      },
      obscureText: true,
      keyboardType: TextInputType.text,
    );
  }

  Widget get _signUpInfoText {
    var defaultStyle = TextStyle(color: Colors.grey, fontSize: 14.0);
    var linkStyle = TextStyle(color: Colors.green);
    return RichText(
      textAlign: TextAlign.center,
      softWrap: true,
      text: TextSpan(
        style: defaultStyle,
        children: <TextSpan>[
          TextSpan(
              text:
                  'Kaydol butonuna basarak, gizlilik politikamızı kabul ediyorsun. Verilerin hakkında bilgi almak için '),
          TextSpan(
              text: 'Gizlilik Politikası',
              style: linkStyle,
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  _execPrivacyPage();
                }),
          TextSpan(text: "'nı inceleyebilirsin."),
        ],
      ),
    );
  }

  Widget _submitButton() {
    return InkWell(
      borderRadius: BorderRadius.all(Radius.circular(5)),
      onTap: isQueryable && _accountProvider.state == AccountState.Idle
          ? _register
          : null,
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.grey.shade200,
                  offset: Offset(2, 4),
                  blurRadius: 5,
                  spreadRadius: 2)
            ],
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors:
                    isQueryable && _accountProvider.state == AccountState.Idle
                        ? [Colors.lightGreen, Colors.green]
                        : [Colors.grey, Colors.blueGrey])),
        child: _accountProvider.state == AccountState.Idle
            ? Text(
                'Kayıt Ol',
                style: TextStyle(fontSize: 20, color: Colors.white),
              )
            : PlatformCircularProgressIndicator(),
      ),
    );
  }

  Widget _createAccountLabel() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SignInScreen()));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        padding: EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Zaten bir hesabın var mı?',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Giriş Yap',
              style: TextStyle(
                  color: Colors.green,
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  void _checkQueryable() {
    var emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(_emailController.text);

    var passwordValid = _passwordController.text.length >= 6 &&
        _passwordAgainController.text.length >= 6;

    setState(() {
      isQueryable = emailValid && passwordValid;
    });
  }

  void _register() async {
    if (_passwordController.text == _passwordAgainController.text) {
      var cQuery = await _accountProvider.createAccount(
          emailAddress: _emailController.text,
          password: _passwordController.text);

      if (cQuery.isSuccess) {
        _execHomeScreen();
      } else {
        /*
          Hata ele alınacak base widgetdan
        */
      }
    } else {
      _showPasswordError();
    }
  }

  void _showPasswordError() {
    /*
          Hata ele alınacak base widgetdan - şifreler aynı
        */
  }

  void _execHomeScreen() {
    Navigator.of(context).pushAndRemoveUntil(
        platformPageRoute(context: context, builder: (context) => RootScreen()),
        (route) => false);
  }

  double screenHeight(BuildContext context,
      {double dividedBy = 1, double reducedBy = 0.0}) {
    return (MediaQuery.of(context).size.height - reducedBy) / dividedBy;
  }

  double screenHeightExcludingToolbar(BuildContext context,
      {double dividedBy = 1}) {
    return screenHeight(context,
        dividedBy: dividedBy, reducedBy: kToolbarHeight);
  }

  void _execPrivacyPage() async {
    /*
      Privacy sayfasına yönlendirilecek
    */
  }
}
