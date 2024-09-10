import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:learning_app/controller/login&registration/register_controller.dart';
import 'package:learning_app/controller/notification_controlller.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ForgotPasswordController with ChangeNotifier {
  bool _isloading = false;
  bool get isLoading => _isloading;
  set isLoading(bool value) {
    _isloading = value;
    notifyListeners();
  }

  String? email_validate;
  String? otp_validate;
  reset() {
    email_validate = null;
    otp_validate = null;
  }

  otpSend(
    BuildContext context,
    var email,
  ) async {
    isLoading = true;
    final url =
        'http://learningapp.e8demo.com/api/user-forgotpassword/forgot_password_otp/';
    Map<String, dynamic> data = {
      "email": email,
    };

    String body = jsonEncode(data);
    log("body--$body");
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
      body: body,
    );

    log(response.body);
    var jsonResponse = jsonDecode(response.body);
    var otp = jsonResponse["code"];
    var status = jsonResponse["status"];
    var message = jsonResponse["message"]; // Capture the message

    if (response.statusCode == 200) {
      if (status == false) {
        // Check for false status
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(
        //     backgroundColor: Colors.red,
        //     content: Text(message), // Use the message from the response
        //   ),
        // );
        email_validate = message;
        log("email validate--$email_validate");
      } else {
        NotificationControlller().showNotification(
            id: 1, body: "Learning app", title: " Your one time OTP is $otp");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.green,
            content: Text("The OTP is $otp"),
          ),
        );
        SharedPreferences emailSave = await SharedPreferences.getInstance();
        await emailSave.setString('email', email);
        Navigator.pushNamed(context, "/forgotpsd");
      }
    } else {
      log('Failed to update data: ${response.statusCode}');
    }

    isLoading = false;
    notifyListeners();
  }

// change password
  otpverification(
      BuildContext context, var email, var password, var otp_code) async {
    isLoading = true;
    final url =
        "http://learningapp.e8demo.com/api/user-forgotpassword/forgot_password_otp_verification/";
    Map<String, dynamic> data = {
      "email": email,
      "otp": otp_code,
      "new_password": password
    };

    String body = jsonEncode(data);
    log("body--$body");
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
      body: body,
    );

    log(response.body);
    var jsonResponse = jsonDecode(response.body);
    var status = jsonResponse["status"];
    var message = jsonResponse["message"];

    if (response.statusCode == 200) {
      if (status == false) {
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(
        //     backgroundColor: Colors.red,
        //     content: Text(message),
        //   ),
        // );
        otp_validate = message;
      } else {
        // NotificationControlller().showNotification(
        //     id: 1,
        //     body: "Learning app",
        //     title: "Your password has been changed successfully");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.green,
            content: Text("Password changed successfully"),
          ),
        );
        Navigator.pushNamed(context, "/login");
      }

      log('Data updated successfully: ${response.body}');
    } else {
      log('Failed to update data: ${response.statusCode}');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text("Failed to change password. Please try again."),
        ),
      );
    }

    isLoading = false;
    notifyListeners();
  }

// google login

  socialLogin(var email, var name, var user_id, BuildContext context) async {
    isLoading = true;
    final url = 'http://learningapp.e8demo.com/api/social_login/';

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'email': email,
          'name': name,
          'user_social_id': user_id,
        }),
      );

      var jsonResponse = jsonDecode(response.body);
      log("Response JSON: ${jsonResponse}");

      if (response.statusCode == 200) {
        var result = jsonResponse["result"];
        log("Result: $result");

        if (result == "success") {
          var access_token = jsonResponse["token"]["access_token"];
          var refresh_token = jsonResponse["token"]["refresh_token"];
          var email = jsonResponse["email"];
          var user_id = jsonResponse["id"];

          await context.read<RegisterController>().saveUserData(access_token,
              refresh_token, user_id, email, "", name, "", "", true, "", "");

          Navigator.pushReplacementNamed(context, "/bottomnavigation");
          // Navigator.pushReplacement(
          //     context,
          //     MaterialPageRoute(
          //       builder: (context) => BottomNavigation(initialIndex: 0),
          //     ));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.red,
              content: Text(
                  "Your account is blocked. Please send an inquiry to support"),
            ),
          );
        }
      } else {
        log("Login failed: ${response.body}");
      }
    } catch (error) {
      log("Error occurred: $error");
    }
    isLoading = false;
    notifyListeners();
  }
}
