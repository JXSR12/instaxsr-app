import 'package:flutter/material.dart';
import 'package:instaxsr/home.dart';
import 'package:instaxsr/globals.dart' as gl;
import 'package:instaxsr/thememan.dart';

class LoginPage extends StatefulWidget {
  ThemeNotifier tnotifier;
  LoginPage({super.key, required this.tnotifier}) {
    gl.themeNotifier = tnotifier;
  }

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool _validatedUname = true;
  String _valUnameErrorMsg = "";

  bool _validatedPw = true;
  String _valPwErrorMsg = "";

  void _login() {
    setState(() {
      String uname = usernameController.text;
      String password = passwordController.text;

      _validatedUname = true;
      _validatedPw = true;
      _valUnameErrorMsg = "";
      _valPwErrorMsg = "";

      if (uname.length <= 4) {
        _validatedUname = false;
        _valUnameErrorMsg = "Must be more than 4 characters";
        return;
      } else if (uname.length >= 20) {
        _validatedUname = false;
        _valUnameErrorMsg = "Must be less than 20 characters";
        return;
      }

      if (password.length < 8) {
        _validatedPw = false;
        _valPwErrorMsg = "Must be at least 8 characters";
        return;
      }
      if (!password.contains(RegExp(r'[A-Z]'))) {
        _validatedPw = false;
        _valPwErrorMsg = "Must contain at least one uppercase letter";
        return;
      }
      if (!password.contains(RegExp(r'[a-z]'))) {
        _validatedPw = false;
        _valPwErrorMsg = "Must contain at least one lowercase letter";
        return;
      }
      if (!password.contains(RegExp(r'[0-9]'))) {
        _validatedPw = false;
        _valPwErrorMsg = "Must contain at least one digit";
        return;
      }

      gl.username = usernameController.text;

      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: ((context) {
        return HomePage();
      })), (route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: gl.main_color,
        title: const Text("Login to your InstaXSR account"),
      ),
      body: SingleChildScrollView(
          child: Container(
              padding: const EdgeInsets.all(25.0),
              child: Padding(
                padding: const EdgeInsets.only(top: 50, bottom: 400),
                child: Column(
                  children: [
                    Image.asset(
                        gl.themeNotifier.getTheme().brightness ==
                                Brightness.dark
                            ? "assets/logo_fordark.png"
                            : "assets/logo_forlight.png",
                        height: 240,
                        width: 240),
                    TextField(
                      controller: usernameController,
                      decoration: InputDecoration(
                          hintText: "Enter Username",
                          errorStyle: const TextStyle(),
                          errorText:
                              _validatedUname ? null : _valUnameErrorMsg),
                    ),
                    TextField(
                      controller: passwordController,
                      decoration: InputDecoration(
                          hintText: "Enter Password",
                          errorStyle: const TextStyle(),
                          errorText: _validatedPw ? null : _valPwErrorMsg),
                      obscureText: true,
                    ),
                    Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                minimumSize: const Size.fromHeight(50),
                                backgroundColor: gl.main_color),
                            onPressed: _login,
                            child: const Text("Sign In")))
                  ],
                ),
              ))),
    );
  }
}
