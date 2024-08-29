import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:learning_app/controller/notification_controlller.dart';
import 'package:learning_app/controller/register_controller.dart';
import 'package:learning_app/core/constants/color_constants.dart';
import 'package:learning_app/core/constants/image_constants.dart';
import 'package:learning_app/core/widgets/custom_textformfield.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController name_Controller = TextEditingController();
  TextEditingController email_Controller = TextEditingController();
  TextEditingController password_controller = TextEditingController();
  TextEditingController repass_Controller = TextEditingController();
  TextEditingController phone_Controller = TextEditingController();

  bool invisible = true;
  bool invisible2 = true;
  final _formKey = GlobalKey<FormState>();
  FocusNode focusNode = FocusNode();
  String? email_validate;
  String? mobile_validate;

  @override
  Widget build(BuildContext context) {
    var provider = context.watch<RegisterController>();
    log("mob vali 1--$mobile_validate");
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Register",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  CircleAvatar(
                    radius: 70,
                    backgroundImage: AssetImage(ImageConstants.splashscreen),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  CustomTextField(
                    controller: name_Controller,
                    // minLines: 3,
                    hintText: "Name",
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter the name';
                      }
                      if (value.length < 3) {
                        return 'Name must be at least 3 characters long';
                      }

                      RegExp regex = RegExp(r'^[a-zA-Z\s]+$');

                      if (!regex.hasMatch(value)) {
                        return "Please enter a valid name ";
                      }
                    },
                  ),
                  SizedBox(height: 10),
                  CustomTextField(
                    // prefixText: "+91 ",
                    errorText:
                        context.watch<RegisterController>().mobile_validate,
                    keyboardType: TextInputType.number,
                    prefix: Text(
                      "  🇦🇪 +971 ",
                      style:
                          TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
                    ),

                    controller: phone_Controller,
                    maxLength: 10,
                    hintText: "Phone number",
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter the phone number';
                      }
                      RegExp regex = RegExp(r'^\+?[0-9]{10,15}$');
                      if (!regex.hasMatch(phone_Controller.text)) {
                        return "Enter a valid phone number";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  CustomTextField(
                    errorText:
                        context.watch<RegisterController>().email_validate,
                    controller: email_Controller,
                    hintText: "Email address",
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the email address';
                      }
                      if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                        return "Enter a valid email address";
                      }
                      if (email_validate != null) {
                        return "User with email already exists.";
                      }

                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  CustomTextField(
                    controller: password_controller,
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
                  SizedBox(height: 10),
                  // CustomTextField(
                  //   controller: repass_Controller,
                  //   hintText: "Re-enter",
                  //   isPassword: true,
                  //   validator: (String? value) {
                  //     if (value == null || value.isEmpty) {
                  //       return "re-enter password";
                  //     }
                  //     if (value.length < 8) {
                  //       return "Password must be at least 8 characters long";
                  //     }
                  //     if (!RegExp(r'[A-Z]').hasMatch(value)) {
                  //       return "Password must contain at least one uppercase letter";
                  //     }

                  //     if (!RegExp(r'[a-z]').hasMatch(value)) {
                  //       return "Password must contain at least one lowercase letter";
                  //     }
                  //     final RegExp regSpecial = RegExp(r'[!@#\$&*~]');
                  //     if (!regSpecial.hasMatch(value)) {
                  //       return "Password must contain at least one special charater";
                  //     }
                  //     if (password_controller.text != value) {
                  //       return 'Passwords do not match';
                  //     }
                  //   },
                  // ),
                  SizedBox(
                    height: 50,
                  ),
                  InkWell(
                    onTap: () async {
                      if (_formKey.currentState!.validate()) {
                        await context.read<RegisterController>().registerData(
                            name_Controller.text,
                            int.parse(phone_Controller.text),
                            email_Controller.text,
                            password_controller.text,
                            context);
                      }
                      // Navigator.pushNamed(context, "/verification");
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
                            ? Padding(
                                padding: const EdgeInsets.all(8),
                                child: CircularProgressIndicator(
                                  color: ColorConstants.primary_white,
                                ),
                              )
                            : Text(
                                "Register",
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
                    onTap: () {
                      Navigator.pushNamed(context, "/login");
                    },
                    child: RichText(
                      text: TextSpan(
                        text: "Already registered? ",
                        style: TextStyle(color: Colors.black),
                        children: <TextSpan>[
                          TextSpan(
                            text: "Login",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: ColorConstants.button_color,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
