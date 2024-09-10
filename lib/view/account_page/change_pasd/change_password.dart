import 'package:flutter/material.dart';
import 'package:learning_app/controller/login&registration/changepsd_controler.dart';
import 'package:learning_app/core/constants/color_constants.dart';
import 'package:learning_app/core/widgets/custom_textformfield.dart';
import 'package:provider/provider.dart';

class Changepassword extends StatefulWidget {
  const Changepassword({super.key});

  @override
  State<Changepassword> createState() => _ChangepasswordState();
}

class _ChangepasswordState extends State<Changepassword> {
  TextEditingController old_controller = TextEditingController();
  TextEditingController new_controller = TextEditingController();
  TextEditingController reenter_controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String? _validatePassword(String? enterpsd, String? value,
      {bool isReenter = false}) {
    if (value == null || value.isEmpty) {
      return enterpsd;
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
    if (isReenter && new_controller.text != value) {
      return 'Passwords do not match';
    }
    return null; // Return null if all validations pass
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Change Password",
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
                  height: 150,
                ),
                CustomTextField(
                  errorText:
                      context.watch<ChangepsdControler>().passwordValidate,
                  controller: old_controller,
                  hintText: "Old Password",
                  isPassword: true,
                  validator: (value) =>
                      _validatePassword("Enter old password ", value),
                ),
                SizedBox(height: 20),
                CustomTextField(
                  controller: new_controller,
                  hintText: "New Password",
                  isPassword: true,
                  validator: (value) =>
                      _validatePassword("Enter new password ", value),
                ),
                SizedBox(height: 20),
                CustomTextField(
                  controller: reenter_controller,
                  hintText: "Re-enter Password",
                  isPassword: true,
                  validator: (value) => _validatePassword(
                    "Re-enter password ",
                    value,
                    isReenter: true,
                  ),
                ),
                SizedBox(height: 80),
                // CustomButton(
                //   onTap: () {
                //     if (_formKey.currentState!.validate()) {
                //       // Uncomment and implement your password change logic
                //       context.read<ChangepsdControler>().changepsd(
                //           context,
                //           old_controller.text,
                //           new_controller.text,
                //           reenter_controller.text);
                //     }
                //   },
                //   text: "Submit",
                // ),
                InkWell(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      // Uncomment and implement your password change logic
                      context.read<ChangepsdControler>().changepsd(
                          context,
                          old_controller.text,
                          new_controller.text,
                          reenter_controller.text);
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
                      child: context.watch<ChangepsdControler>().isLoading
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
