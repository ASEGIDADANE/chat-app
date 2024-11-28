import 'package:chat_app/constant.dart';
import 'package:chat_app/services/alert_service.dart';
import 'package:chat_app/services/auth_service.dart';
import 'package:chat_app/services/navigation_service.dart';
import 'package:chat_app/widget/custom_text_field.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

// ignore: camel_case_types
class loginpage extends StatefulWidget {
  const loginpage({super.key});

  @override
  State<loginpage> createState() => _loginpageState();
}

// ignore: camel_case_types
class _loginpageState extends State<loginpage> {
  final GetIt getIt = GetIt.instance;

  final GlobalKey<FormState> _loginFormKey = GlobalKey();
  late AuthService _authService;
  late NavigationService _navigationService;
  late AlertService _alertService;
  @override
  void initState() {
    super.initState();
    _authService = getIt.get<AuthService>();
    _navigationService = getIt.get<NavigationService>();
    _alertService = getIt.get<AlertService>();
    //  _authService.authStateChangeStreamListener();
  }

  String? email, password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset:
          true, // it is use to responsive when keyboard is open
      body: _BuildUI(),
    );
  }

  Widget _BuildUI() {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
        child: Column(
          children: [_headerText(), _loginform(), _createAccountLink()],
        ),
      ),
    );
  }

  Widget _headerText() {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: const Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Hi Welcome Back',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w800,
            ),
          ),
          Text(
            'Hello again you\'ve been missed ',
            style: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          )
        ],
      ),
    );
  }

  Widget _loginform() {
    return Container(
      // take 40% of all screen
      height: MediaQuery.of(context).size.height * 0.40,
      margin: EdgeInsets.symmetric(
        vertical: MediaQuery.of(context).size.height * 0.05,
      ),
      child: Form(
        key: _loginFormKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomTextField(
              onsaved: (value) {
                setState(() {
                  email = value;
                });
              },
              height: MediaQuery.of(context).size.height * 0.1,
              hintText: 'Email',
              //  validating emailpattern that abased on the constant
              validationRegEx: emailPattern,
            ),
            CustomTextField(
              onsaved: (value) {
                setState(() {
                  password = value;
                });
              },
              obscureText: true,
              hintText: 'Password',
              height: MediaQuery.of(context).size.height * 0.1,
              validationRegEx: passwordPattern,
            ), // Comma added here
            // Add more widgets here if needed
            _loginButton(),
          ],
        ),
      ),
    );
  }

  Widget _loginButton() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: MaterialButton(
        onPressed: () async {
          if (_loginFormKey.currentState?.validate() ?? false) {
            // print('woohoo');
            _loginFormKey.currentState?.save();
            bool result = await _authService.login(email!, password!);
            // print(result);

            if (result) {
              print(result);
              print('result is naviage');
              _navigationService.pushReplacementNamed('/home');
            } else {
              _alertService.showToast(
                  text: 'Try again, login was not successful!',
                  icon: Icons.error);
            }
          }
        },
        color: Theme.of(context).colorScheme.primary,
        child: Text(
          'login',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget _createAccountLink() {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text('Don\'t have an account? '),
          GestureDetector(
            onTap: () {
              _navigationService.pushNamed('/register');
            },
            child: Text(
              'Sign Up',
              style: TextStyle(
                fontWeight: FontWeight.w800,
              ),
            ),
          )
        ],
      ),
    );
  }
}
