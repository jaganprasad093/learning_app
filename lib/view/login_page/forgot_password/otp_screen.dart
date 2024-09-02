import 'package:flutter/material.dart';
import 'package:learning_app/controller/login&registration/forgot_password_controller.dart';
import 'package:learning_app/core/constants/color_constants.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    var provider = context.read<ForgotPasswordController>();
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
        title: Text(
          "OTP verification",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Pinput(
                // closeKeyboardWhenCompleted: true,
                // errorText: provider.error_message,
                forceErrorState: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter OTP";
                  }
                  if (value.length != 4) {
                    return "Enter a valid 4-digit OTP";
                  }
                  return null;
                },
                controller: otp_controller,
                length: 4,
                defaultPinTheme: defaultPinTheme,
                focusedPinTheme: defaultPinTheme.copyWith(
                  decoration: defaultPinTheme.decoration!.copyWith(
                    border: Border.all(color: Colors.green),
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              InkWell(
                onTap: () async {
                  if (_formKey.currentState!.validate()) {
                    SharedPreferences otpSend =
                        await SharedPreferences.getInstance();
                    await otpSend.setString('otp_send', otp_controller.text);
                  }
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
            ],
          ),
        ),
      ),
    );
  }
}
