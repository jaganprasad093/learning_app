import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:learning_app/controller/notification_controlller.dart';
import 'package:learning_app/main.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterController with ChangeNotifier {
  bool _isloading = false;
  bool get isLoading => _isloading;
  set isLoading(bool value) {
    _isloading = value;
    notifyListeners();
  }

  String? email_validate;
  String? mobile_validate;

  Uri domain = Uri.parse("http://learningapp.e8demo.com/api/");
  Future<void> registerData(
    final String name,
    final int phone,
    final String email,
    final String password,
    BuildContext context,
  ) async {
    isLoading = true;
    var register = "user-register/";
    Uri url = Uri.parse("$domain$register");
    // log(" url----------------$domain$register");
    Map<String, dynamic> data = {
      "name": name,
      "email": email,
      "password": password,
      "mobile": phone
    };
    email_validate = null;
    mobile_validate = null;
    String body = jsonEncode(data);

    var response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    log("body---$body");
    var jsonResponse = jsonDecode(response.body);
    log("Response: ${response.body}");
    if (response.statusCode == 200) {
      if (jsonResponse['status'] == false) {
        email_validate = jsonResponse['message']['email'];
        mobile_validate = jsonResponse['message']['mobile'];
        log("email_validate---$email_validate");
        log("mobile_validate---$mobile_validate");
        log("Response: ${response.body}");
      } else {
        var access_token = jsonResponse["token"]["access_token"];
        var refresh_token = jsonResponse["token"]["refresh_token"];
        var name = jsonResponse["userdata"]["name"];
        var email = jsonResponse["userdata"]["email"];
        var mobile = jsonResponse["userdata"]["mobile"];
        var gender = jsonResponse["userdata"]["gender"];
        var userId = jsonResponse["userdata"]["id"];
        var otp = jsonResponse["code"];

        // log("access_token---$access_token");
        // log("name---$name");
        await saveUserData(
            access_token, refresh_token, userId, email, mobile, gender, name);
        context.read<NotificationControlller>().showNotification(
            id: 1, title: "OTP", body: " Your one time OTP is ${otp} ");
        log("Response: ${response.body}");
        Navigator.pushNamed(context, "/verification");
        log("registed sucessfully");
      }
    } else {
      log("Error: ${response.statusCode}");
    }

    isLoading = false;
    notifyListeners();
  }

// saving users data while loging

  Future<void> saveUserData(
    String accessToken,
    String refreshToken,
    int userId,
    String email,
    String mobile,
    var gender,
    String name,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('access_token', accessToken);
    await prefs.setString('refresh_token', refreshToken);
    await prefs.setInt('user_id', userId);
    await prefs.setString('email', email);
    await prefs.setString('mobile', mobile);
    await prefs.setString('name', name);

    log('Saved access_token: $accessToken');
    log('Saved refresh_token: $refreshToken');
    log('Saved user_id: $userId');
    log('Saved email: $email');
    log('Saved mobile: $mobile');
    log('Saved name: $name');
  }

// login api

  Future<void> loginData(
      final String email, final String password, BuildContext context) async {
    isLoading = true;
    var login = Uri.parse("user-login/");
    Uri url = Uri.parse("${domain}$login");
    log("$url");
    Map<String, dynamic> data = {"email": email, "password": password};

    String body = jsonEncode(data);
    log("body--$body");
    var response = await http.post(
      url,
      // headers: {"Content-Type": "application/json"},
      body: data,
    );

    // log("Response: ${response.body}");
    if (response.statusCode == 200) {
      log("Response: ${response.body}");
      var jsonResponse = jsonDecode(response.body);
      if (jsonResponse['result'] == "failure") {
        String errorMessage = jsonResponse['errors'].toString();
        errorMessage = errorMessage.replaceAll('{', '');
        errorMessage = errorMessage.replaceAll('}', '');
        errorMessage = errorMessage.replaceAll('email:', '');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Text("$errorMessage"),
          ),
        );

        log("login failed: $errorMessage");
      } else {
        Navigator.pushNamed(context, "/bottomnavigation");
        log("Response: ${response.body}");
      }
      log("login sucess");
    } else {
      log("Error: ${response.statusCode}");
    }

    isLoading = false;
    notifyListeners();
  }

  // otp submittion

  otp_submission(
      final String otp, final String email, BuildContext context) async {
    isLoading = true;
    var login = Uri.parse("user-login/");
    Uri url =
        Uri.parse("http://learningapp.e8demo.com/api/user-email-verification/");
    // log("$url");
    Map data = {"email": email, "otp": otp};

    String body = jsonEncode(data);

    // log("body--$body");
    var response = await http.post(
      url,
      // headers: {"Content-Type": "application/json"},
      body: data,
    );
    var jsonResponse = jsonDecode(response.body);
    log("response--- ${response.body}");
    if (response.statusCode == 200) {
      log("result--${jsonResponse['result']}");
      if (jsonResponse['result'] == "success") {
        log("otp verification sucess ");
        Navigator.pushNamed(context, "/bottomnavigation");
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text("Given otp is not matching"),
        ),
      );
      log("Error: ${response.statusCode}");
    }

    isLoading = false;
    notifyListeners();
  }
}
