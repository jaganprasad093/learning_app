import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:learning_app/controller/login&registration/forgot_password_controller.dart';
import 'package:learning_app/controller/login&registration/register_controller.dart';
import 'package:learning_app/core/constants/color_constants.dart';
import 'package:learning_app/core/constants/image_constants.dart';
import 'package:learning_app/core/widgets/custom_textformfield.dart';
import 'package:learning_app/view/login_page/forgot_password/forgot_password.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email']);
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool invisible = true;
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    // context.read<RegisterController>().reset();
    if (kDebugMode) {
      emailController.text = 'test123@gmail.com';
      passwordController.text = 'Jaan@1234';
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var provider = context.watch<RegisterController>();
    var providerForget = context.watch<ForgotPasswordController>();
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 150,
                ),
                CircleAvatar(
                  radius: 70,
                  backgroundImage: AssetImage(ImageConstants.splashscreen),
                ),
                SizedBox(
                  height: 40,
                ),
                CustomTextField(
                  errorText: context.watch<RegisterController>().loginErrorMsg,
                  controller: emailController,
                  hintText: "Email address",
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the email address';
                    }
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                      return "Enter a valid email address";
                    }

                    return null;
                  },
                ),
                SizedBox(height: 20),
                CustomTextField(
                  controller: passwordController,
                  hintText: "Password",
                  isPassword: true,
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter password';
                    }
                    if (value.length < 8) {
                      return "Password must be at least 8 characters long";
                    }
                    if (!RegExp(r'[A-Z]').hasMatch(value)) {
                      return "Password must contain at least one uppercase letter";
                    }

                    if (!RegExp(r'[a-z]').hasMatch(value)) {
                      return "Password must contain at least one lowercase letter";
                    }
                    final RegExp regSpecial = RegExp(r'[!@#\$&*~]');
                    if (!regSpecial.hasMatch(value)) {
                      return "Password must contain at least one special charater";
                    }
                    if (!RegExp(r'[0-9]').hasMatch(value)) {
                      return "Password must contain at least one number";
                    }
                  },
                ),
                SizedBox(
                  height: 60,
                ),
                InkWell(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      context.read<RegisterController>().loginData(
                          emailController.text,
                          passwordController.text,
                          context);
                    }
                  },
                  child: Container(
                    height: 50,
                    // width: 200,
                    decoration: BoxDecoration(
                      color: ColorConstants.button_color,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: provider.isLoading
                          ? CircularProgressIndicator(
                              color: ColorConstants.primary_white,
                            )
                          : Text(
                              "Login",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () async {
                    try {
                      await signInWithGoogle();
                    } catch (e) {
                      print("Error during Google login: $e");
                    }
                  },
                  child: Container(
                    height: 50,
                    // width: 200,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: providerForget.isLoading
                        ? Center(
                            child: CircularProgressIndicator(
                            color: ColorConstants.primary_white,
                          ))
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(15),
                                child: Container(
                                  child: Image.asset(
                                      "assets/images/google_icon.png"),
                                ),
                              ),
                              Center(
                                child: Text(
                                  "Google Login",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ],
                          ),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ForgotPassword(),
                          ));
                    },
                    child: Text("Forgot password?")),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: "Don't have an account? ",
                        style: TextStyle(color: Colors.black),
                        children: <TextSpan>[],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, "/register");
                      },
                      child: Text(
                        "Register",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: ColorConstants.button_color,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future signInWithGoogle() async {
    try {
      await googleSignIn.signOut();
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      log("google user---$googleUser");
      var googleEmail = googleUser!.email;
      var googleName = googleUser.displayName;
      var user_id = googleUser.id;
      // var googlepassword = googleUser.id;
      // log("$googlepassword,$googleOTP,$googleEmail");
      await context
          .read<ForgotPasswordController>()
          .socialLogin(googleEmail, googleName, user_id, context);
    } catch (e) {
      log(e.toString());
    }
  }
}
