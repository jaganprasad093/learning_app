import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';
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
                    controller: phone_Controller,
                    disableLengthCheck: true,
                    focusNode: focusNode,
                    decoration: InputDecoration(
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: ColorConstants.red),
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      hintText: 'Phone Number',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    languageCode: "en",
                    initialCountryCode: "IN",
                    onSaved: (newValue) {},
                    onChanged: (phone) {
                      print(phone.completeNumber);
                    },
                    onCountryChanged: (country) {
                      print('Country changed to: ' + country.name);
                    },
                    validator: (PhoneNumber? phonenumber) {
                      if (phonenumber == null || phonenumber.number.isEmpty) {
                        return 'Enter phone number';
                      }
                      RegExp regex = RegExp(r'^\+?[0-9]{10,15}$');
                      if (!regex.hasMatch(phonenumber.number)) {
                        return "Enter a valid phone number";
                      }
                      return null;
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                  ),
                  // IntlPhoneField(
                  //   decoration: InputDecoration(
                  //     labelText: 'Phone Number',
                  //     border: OutlineInputBorder(
                  //       borderSide: BorderSide(),
                  //     ),
                  //   ),
                  //   onChanged: (phone) {
                  //     print(phone.completeNumber);
                  //   },
                  //   onCountryChanged: (country) {
                  //     print('Country changed to: ' + country.name);
                  //   },
                  //   validator: (PhoneNumber? phonenumber) {
                  //     if (phonenumber == null || phonenumber.number.isEmpty) {
                  //       return 'enter phone number';
                  //     }
                  //     RegExp regex = RegExp(r'^\+?[0-9]{10,15}$');
                  //     // if (!regex.hasMatch(phonenumber.toString())) {
                  //     //   return "Enter a valid phone number";
                  //     // }
                  //     return null;
                  //   },
                  //   // autovalidateMode: AutovalidateMode.disabled,
                  //   // validator: (p0) {},
                  // ),

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
                      if (value == null || value.isEmpty) {
                        return 'Please enter password';
                      }
                    },
                  ),
                  SizedBox(height: 10),
                  CustomTextField(
                    controller: repass_Controller,
                    hintText: "Re-enter",
                    isPassword: true,
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "re-enter password";
                      }
                      if (password_controller.text != value) {
                        return 'Passwords do not match';
                      }
//                       final RegExp passwordRegExp = RegExp(
//                         r'^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#$%^&*(),.?":{}|<>])[A-Za-z\d!@#$%^&*(),.?":{}|<>]{8,}$',
//                       );
//                       if (!passwordRegExp.hasMatch(value)) {
//                         return '''
// Password must contain 8 characters, one uppercase letter, one lowercase letter, one number, and one special character.''';
//                       }
                    },
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  InkWell(
                    onTap: () async {
                      if (_formKey.currentState!.validate()) {
                        final RegExp passwordRegExp = RegExp(
                          r'^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#$%^&*(),.?":{}|<>])[A-Za-z\d!@#$%^&*(),.?":{}|<>]{8,}$',
                        );
                        if (!passwordRegExp
                            .hasMatch(password_controller.text)) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              backgroundColor: Colors.red,
                              content: Text(
                                  "Password must contain 8 charaters including one uppercase character, one lowercase character,one special character and numbers")));
                        } else {
                          await context.read<RegisterController>().registerData(
                              name_Controller.text,
                              int.parse(phone_Controller.text),
                              email_Controller.text,
                              password_controller.text);
                        }
                      }
                      // log("phone--${int.parse(phone_Controller.text)}");
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
