import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:edusol/ui/login/sign_in_screen.dart';
import 'package:edusol/ui/login/sign_up_screen.dart';
import 'package:edusol/ui/root_screen.dart';
import 'package:edusol/viewmodels/account_provider.dart';
import 'package:edusol/widgets/global_widgets.dart';
import 'package:provider/provider.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  AccountProvider _accountProvider;
  bool isAuthStateChecked = false;
  double statusBarHeight;

  @override
  void initState() {
    Future.microtask(() {
      checkAuthState();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _accountProvider = Provider.of<AccountProvider>(context);

    statusBarHeight = MediaQuery.of(context).padding.bottom;

    return Scaffold(
      body: isAuthStateChecked
          ? Stack(
              children: [
                Image.asset('asset/images/city.jpg',
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity),
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.white.withOpacity(0.4),
                        Colors.green.withOpacity(0.5)
                      ],
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 180,
                      ),
                      Hero(tag: 'title', child: GlobalWidgets.appTitle()),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            _signInButton(),
                            _signUpButton(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          : Container(),
    );
  }

  Widget _signInButton() {
    return InkWell(
      onTap: _execSignInScreen,
      child: Container(
        width: double.infinity,
        height: 75,
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              'Giriş Yap',
              style: GoogleFonts.montserrat(color: Colors.green, fontSize: 18),
            ),
          ),
        ),
      ),
    );
  }

  Widget _signUpButton() {
    return InkWell(
      onTap: _execSignUpScreen,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 75,
            decoration: BoxDecoration(
              color: Colors.green,
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  'Kayıt Ol',
                  style:
                      GoogleFonts.montserrat(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
          ),
          Container(
            height: statusBarHeight,
            width: double.infinity,
            color: Colors.green,
          )
        ],
      ),
    );
  }

  void _execSignInScreen() {
    Navigator.of(context).push(
      platformPageRoute(
          context: context,
          builder: (context) => SignInScreen(),
          fullscreenDialog: true),
    );
  }

  void _execSignUpScreen() {
    Navigator.of(context).push(
      platformPageRoute(
          context: context,
          builder: (context) => SignUpScreen(),
          fullscreenDialog: true),
    );
  }

  void checkAuthState() {
    if (_accountProvider.currentUserId != null) {
      _accountProvider.listenCurrentUser(onComplated: () {
        Navigator.of(context).pushAndRemoveUntil(
            platformPageRoute(
                context: context, builder: (context) => RootScreen()),
            (route) => false);
      });
    } else {
      setState(() {
        isAuthStateChecked = true;
      });
    }
  }
}
