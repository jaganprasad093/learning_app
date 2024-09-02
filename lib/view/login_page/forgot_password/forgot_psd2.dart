import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:learning_app/controller/login&registration/forgot_password_controller.dart';
import 'package:learning_app/core/constants/color_constants.dart';
import 'package:learning_app/core/widgets/custom_button.dart';
import 'package:learning_app/core/widgets/custom_textformfield.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ForgotPsd2 extends StatefulWidget {
  const ForgotPsd2({super.key});

  @override
  State<ForgotPsd2> createState() => _ForgotPsd2State();
}

class _ForgotPsd2State extends State<ForgotPsd2> {
  var email;
  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    SharedPreferences emailSave = await SharedPreferences.getInstance();
    email = emailSave.getString("email");
    log("email---$email");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController otp_controller = TextEditingController();
    TextEditingController new_psd_controller = TextEditingController();
    TextEditingController psd_controller = TextEditingController();

    String? _validatePassword(String? value, {bool isReenter = false}) {
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
      if (!RegExp(r'[!@#\$&*~]').hasMatch(value)) {
        return "Password must contain at least one special character";
      }
      if (!RegExp(r'[0-9]').hasMatch(value)) {
        return "Password must contain at least one number";
      }
      if (isReenter && new_psd_controller.text != value) {
        return 'Passwords do not match';
      }
      return null;
    }

    var provider = context.watch<ForgotPasswordController>();
    final _formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "OTP",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 200,
                ),
                CustomTextField(
                  errorText: provider.otp_validate,
                  controller: otp_controller,
                  hintText: "OTP",
                  maxLength: 4,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter OTP";
                    }
                    if (value.length != 4) {
                      return "Enter a valid 4-digit OTP";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                CustomTextField(
                  controller: new_psd_controller,
                  hintText: "New Password",
                  isPassword: true,
                  validator: (value) => _validatePassword(value),
                ),
                SizedBox(height: 20),
                CustomTextField(
                  controller: psd_controller,
                  hintText: "Re-enter Password",
                  isPassword: true,
                  validator: (value) =>
                      _validatePassword(value, isReenter: true),
                ),
                SizedBox(height: 80),
                InkWell(
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      provider.otpverification(context, email,
                          new_psd_controller.text, otp_controller.text);
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
                              "Submit",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
