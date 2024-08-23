import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:learning_app/core/constants/color_constants.dart';
import 'package:learning_app/core/constants/image_constants.dart';

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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 70,
                  backgroundImage: AssetImage(ImageConstants.splashscreen),
                ),
                SizedBox(
                  height: 40,
                ),
                TextFormField(
                  controller: name_Controller,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    hintText: "Name",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (String? value) {
                    return (value == null || value.isEmpty)
                        ? 'Please enter the name'
                        : null;
                  },
                ),
                SizedBox(height: 10),
                // TextFormField(
                //   keyboardType: TextInputType.phone,
                //   controller: name_Controller,
                //   decoration: InputDecoration(

                //     contentPadding:
                //         EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                //     hintText: "Mobile Number",
                //     border: OutlineInputBorder(
                //       borderRadius: BorderRadius.circular(10),
                //     ),
                //   ),
                //   validator: (String? value) {
                //     return (value == null || value.isEmpty)
                //         ? 'Please enter the phone no'
                //         : null;
                //   },
                // ),
                IntlPhoneField(
                  disableLengthCheck: true,
                  focusNode: focusNode,
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
                  // validator: (p0) {},
                ),

                SizedBox(height: 10),
                TextFormField(
                  controller: email_Controller,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    hintText: "Email address",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
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
                TextFormField(
                  controller: password_controller,
                  obscureText: invisible,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    hintText: "Password",
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          invisible = !invisible;
                        });
                      },
                      child: Icon(
                          invisible ? Icons.visibility : Icons.visibility_off),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (String? value) {
                    return (value == null || value.isEmpty)
                        ? 'Please enter the password'
                        : null;
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: repass_Controller,
                  obscureText: invisible2,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    hintText: "Re-enter ",
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          invisible2 = !invisible2;
                        });
                      },
                      child: Icon(
                          invisible2 ? Icons.visibility : Icons.visibility_off),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (String? value) {
                    return (value == null || value.isEmpty)
                        ? 'Please re-enter the password'
                        : null;
                  },
                ),
                SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 70),
                  child: InkWell(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {}
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
