import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'sign_up_screen.dart';
import '../root_screen.dart';
import '../../viewmodels/account_provider.dart';
import '../../widgets/custom_textfield.dart';
import '../../widgets/global_widgets.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  AccountProvider _accountProvider;
  TextEditingController _emailController;
  TextEditingController _passwordController;
  bool isQueryable = false;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
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
        'Giriş Yap',
        style: GoogleFonts.montserrat(),
      ),
    );
  }

  Widget _emailField() {
    return CustomTextField(
      title: 'E-Posta',
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

  Widget _submitButton() {
    return InkWell(
      borderRadius: BorderRadius.all(Radius.circular(5)),
      onTap: isQueryable && _accountProvider.state == AccountState.Idle
          ? _login
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
                'Giriş Yap',
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
            context, MaterialPageRoute(builder: (context) => SignUpScreen()));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        padding: EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Bir hesabın yok mu?',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Kayıt Ol',
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

    var passwordValid = _passwordController.text.length >= 6;

    setState(() {
      isQueryable = emailValid && passwordValid;
    });
  }

  void _login() async {
    var cQuery = await _accountProvider.signInWithEmailAndPassword(
        email: _emailController.text, password: _passwordController.text);

    if (cQuery.isSuccess) {
      _execHomeScreen();
    } else {
      /*
        Hata ele alınacak base widgetdan
      */
    }
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

  void _execHomeScreen() {
    Navigator.of(context).pushAndRemoveUntil(
        platformPageRoute(context: context, builder: (context) => RootScreen()),
        (route) => false);
  }
}
