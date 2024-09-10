import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:learning_app/controller/login&registration/forgot_password_controller.dart';
import 'package:learning_app/core/constants/color_constants.dart';
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
  TextEditingController otpController = TextEditingController();
  TextEditingController newPsdController = TextEditingController();
  TextEditingController reenterPsdController = TextEditingController();

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

  String? _validatePassword(String? value, {bool isReenter = false}) {
    if ((value == null || value.isEmpty) && isReenter) {
      return 'Please enter password';
    }
    if (value!.length < 8) {
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
    if (isReenter && newPsdController.text != value) {
      return 'Passwords do not match';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
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
                  keyboardType: TextInputType.number,
                  errorText: provider.otp_validate,
                  controller: otpController,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
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
                  controller: newPsdController,
                  hintText: "New Password",
                  isPassword: true,
                  validator: (value) => _validatePassword(value),
                ),
                SizedBox(height: 20),
                CustomTextField(
                  controller: reenterPsdController,
                  hintText: "Re-enter Password",
                  isPassword: true,
                  validator: (value) =>
                      _validatePassword(value, isReenter: true),
                ),
                SizedBox(height: 80),
                InkWell(
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      provider.otpverification(
                        context,
                        email,
                        newPsdController.text,
                        otpController.text,
                      );
                    }
                  },
                  child: Container(
                    height: 50,
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
