import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:learning_app/controller/register_controller.dart';
import 'package:learning_app/core/constants/color_constants.dart';
import 'package:learning_app/core/widgets/custom_button.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Verification extends StatefulWidget {
  const Verification({Key? key}) : super(key: key);

  @override
  State<Verification> createState() => _VerificationState();
}

class _VerificationState extends State<Verification> {
  String? email;
  @override
  void initState() {
    initi();
    super.initState();
  }

  initi() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    email = prefs.getString('email');
    log("email in otp verification--$email");
  }

  @override
  Widget build(BuildContext context) {
    var provider = context.watch<RegisterController>();
    TextEditingController otp_controller = TextEditingController();
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 60,
      textStyle: const TextStyle(
        fontSize: 22,
        color: Colors.black,
      ),
      decoration: BoxDecoration(
        color: Colors.green.shade100,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.transparent),
      ),
    );
    return Scaffold(
      appBar: AppBar(
        leading: Text(""),
        backgroundColor: ColorConstants.button_color,
        title: const Text(
          'OTP Verification',
          style: TextStyle(
              fontWeight: FontWeight.bold, color: ColorConstants.primary_white),
        ),
        centerTitle: true,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Container(
            margin: const EdgeInsets.only(top: 40),
            width: double.infinity,
            child: Column(
              children: [
                SizedBox(
                  height: 100,
                ),
                const Text(
                  "Verification",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 40),
                  child: const Text(
                    "Enter the code sent to your email",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 18,
                    ),
                  ),
                ),
                Pinput(
                  controller: otp_controller,
                  length: 4,
                  defaultPinTheme: defaultPinTheme,
                  focusedPinTheme: defaultPinTheme.copyWith(
                    decoration: defaultPinTheme.decoration!.copyWith(
                      border: Border.all(color: Colors.green),
                    ),
                  ),
                  onCompleted: (pin) => debugPrint(pin),
                ),
                SizedBox(
                  height: 100,
                ),
                InkWell(
                  onTap: () {
                    provider.otp_submission(
                        otp_controller.text, email ?? "1", context);
                  },
                  child: Container(
                    height: 50,
                    width: 400,
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
                              "Submit",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                    ),
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.all(10),
                //   child: CustomButton(
                //     text: "Submit",
                //     onTap: () async {
                //       context.read<RegisterController>().otp_submission(
                //           otp_controller.text, email ?? "1", context);
                //     },
                //   ),
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
