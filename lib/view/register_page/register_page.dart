import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:learning_app/core/constants/color_constants.dart';
import 'package:learning_app/core/constants/image_constants.dart';
import 'package:learning_app/core/widgets/custom_textformfield.dart';

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
  bool invisible = true;
  bool invisible2 = true;
  final _formKey = GlobalKey<FormState>();
  FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
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
                    hintText: "Name",
                    validator: (String? value) {
                      return (value == null || value.isEmpty)
                          ? 'Please enter the name'
                          : null;
                    },
                  ),
                  SizedBox(height: 10),
                  IntlPhoneField(
                    disableLengthCheck: true,
                    // focusNode: focusNode,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      hintText: 'Phone Number',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    languageCode: "en",
                    initialCountryCode: "IN",
                    onChanged: (phone) {
                      print(phone.completeNumber);
                    },
                    onCountryChanged: (country) {
                      print('Country changed to: ' + country.name);
                    },
                    validator: (PhoneNumber? phonenumber) {
                      if (phonenumber == null || phonenumber.number.isEmpty) {
                        return 'enter phone number';
                      }
                      RegExp regex = RegExp(
                          r'^\s*(?:\+?(\d{1,3}))?[-. (]*(\d{3})[-. )]*(\d{3})[-. ]*(\d{4})(?: *x(\d+))?\s*$');
                      if (!regex.hasMatch(phonenumber.toString())) {
                        return "Enter a valid phone number";
                      }
                      return null;
                    },
                    // validator: (p0) {},
                  ),
                  SizedBox(height: 10),
                  CustomTextField(
                    controller: email_Controller,
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
                  SizedBox(height: 10),
                  CustomTextField(
                    controller: password_controller,
                    hintText: "Password",
                    isPassword: true,
                    validator: (String? value) {
                      return (value == null || value.isEmpty)
                          ? 'Please enter the password'
                          : null;
                    },
                  ),
                  SizedBox(height: 10),
                  CustomTextField(
                    controller: repass_Controller,
                    hintText: "Re-enter",
                    isPassword: true,
                    validator: (String? value) {
                      return (value == null || value.isEmpty)
                          ? 'Please enter the password'
                          : null;
                    },
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  InkWell(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        log("register sucess");
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
