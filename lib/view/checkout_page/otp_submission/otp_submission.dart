import 'package:flutter/material.dart';
import 'package:learning_app/controller/notification_controlller.dart';
import 'package:learning_app/core/constants/color_constants.dart';
import 'package:learning_app/core/constants/image_constants.dart';
import 'package:learning_app/core/widgets/custom_button.dart';
import 'package:learning_app/core/widgets/custom_textformfield.dart';

class OtpSubmission extends StatelessWidget {
  TextEditingController otp_controller = TextEditingController();
  bool invisible = true;
  final _formKey = GlobalKey<FormState>();
  OtpSubmission({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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
                CircleAvatar(
                  radius: 70,
                  backgroundImage: AssetImage(ImageConstants.splashscreen),
                ),
                SizedBox(
                  height: 40,
                ),
                CustomTextField(
                  controller: otp_controller,
                  hintText: " Enter OTP",
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the otp';
                    }

                    return null;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                CustomButton(
                  text: "Submit",
                  onTap: () {
                    NotificationControlller().showNotification(
                        id: 1, body: "one min ago", title: "Confrimed order");
                    // Navigator.pushReplacementNamed(context, "/confrim");
                  },
                ),
                SizedBox(
                  height: 40,
                ),
                InkWell(
                  onTap: () {},
                  child: RichText(
                    text: TextSpan(
                      text: "Isn't recive OTP? ",
                      style: TextStyle(color: Colors.black),
                      children: <TextSpan>[
                        TextSpan(
                          text: "Resend",
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
                  height: 100,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
