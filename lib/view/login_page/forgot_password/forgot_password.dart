import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:learning_app/core/widgets/custom_button.dart';
import 'package:learning_app/core/widgets/custom_textformfield.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController old_controller = TextEditingController();
  TextEditingController new_controller = TextEditingController();
  TextEditingController reenter_controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Forgot password",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomTextField(
                  controller: old_controller,
                  hintText: "Old-Password",
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
                  height: 20,
                ),
                CustomTextField(
                  controller: new_controller,
                  hintText: " New Password",
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
                  height: 20,
                ),
                CustomTextField(
                  controller: reenter_controller,
                  hintText: "Re-Password",
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
                  height: 80,
                ),
                CustomButton(text: "Submit")
              ],
            ),
          ),
        ),
      ),
    );
  }
}
