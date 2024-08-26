import 'package:flutter/material.dart';
import 'package:learning_app/core/constants/color_constants.dart';
import 'package:learning_app/core/constants/image_constants.dart';
import 'package:learning_app/core/widgets/custom_textformfield.dart';

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
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 80,
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
                      return 'Please enter the password';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 60,
                ),
                InkWell(
                  onTap: () {
                    // if (_formKey.currentState!.validate()) {}
                    Navigator.pushNamed(context, "/bottomnavigation");
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
                Text("Forgot password?"),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {
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
    );
  }
}
