import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:learning_app/controller/register_controller.dart';
import 'package:learning_app/core/constants/color_constants.dart';
import 'package:learning_app/core/constants/image_constants.dart';
import 'package:learning_app/core/widgets/custom_textformfield.dart';
import 'package:learning_app/main.dart';
import 'package:learning_app/view/login_page/forgot_password/forgot_password.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool invisible = true;
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    if (kDebugMode) {
      emailController.text = 'jaan1@gmail.com';
      passwordController.text = 'Jaan@2255';
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
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
                        child: Text(
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
                  InkWell(
                    onTap: () async {
                      Navigator.pushNamed(context, "/register");
                    },
                    child: RichText(
                      text: TextSpan(
                        text: "Don't have an account? ",
                        style: TextStyle(color: Colors.black),
                        children: <TextSpan>[
                          TextSpan(
                            text: "Register",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: ColorConstants.button_color,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
