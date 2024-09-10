import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:learning_app/controller/notification_controlller.dart';
import 'package:learning_app/core/constants/color_constants.dart';
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
  String? error_message;
  String? loginErrorMsg;
  reset() {
    loginErrorMsg = null;
  }

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
        var gender = jsonResponse["userdata"]["gender"] ?? "";
        var userId = jsonResponse["userdata"]["id"];
        var otp = jsonResponse["code"];
        var dob = jsonResponse["userdata"]["dob"] ?? "";
        var address = jsonResponse["userdata"]["address"] ?? "";
        var profile_pic = jsonResponse["userdata"]["profile_pic"];
        log("pro pic on registration---$profile_pic");

        // log("access_token---$access_token");
        // log("name---$name");
        await saveUserData(access_token, refresh_token, userId, email, mobile,
            name, gender, dob, true, address, profile_pic);
        context.read<NotificationControlller>().showNotification(
            id: 1, title: "OTP", body: " Your one time OTP is ${otp} ");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: Duration(seconds: 10),
            backgroundColor: Colors.green,
            content: Text("Your one time OTP is ${otp}"),
          ),
        );
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
      String name,
      var gender,
      String dob,
      bool islogged,
      String address,
      String profile_pic) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('access_token', accessToken);
    await prefs.setString('refresh_token', refreshToken);
    await prefs.setInt('user_id', userId);
    await prefs.setString('email', email);
    await prefs.setString('mobile', mobile);
    await prefs.setString('name', name);
    await prefs.setBool('islogged', islogged);
    await prefs.setString('gender', gender);
    await prefs.setString('dob', dob);
    await prefs.setString('address', address);
    await prefs.setString('profile_pic', profile_pic);

    log('Saved access_token: $accessToken');
    log('Saved refresh_token: $refreshToken');
    log('Saved user_id: $userId');
    log('Saved email: $email');
    log('Saved mobile: $mobile');
    log('Saved name: $name');
    log('Saved address: $address');
    log('profile pic: $profile_pic');
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
    log(response.body);
    // log("Response: ${response.body}");
    if (response.statusCode == 200) {
      // log("Response: ${response.body}");
      var jsonResponse = jsonDecode(response.body);

      if (jsonResponse['result'] == "failure") {
        String errorMessage = jsonResponse['errors'].toString();
        errorMessage = errorMessage.replaceAll('{', '');
        errorMessage = errorMessage.replaceAll('}', '');
        errorMessage = errorMessage.replaceAll('email:', '');
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(
        //     backgroundColor: Colors.red,
        //     content: Text("$errorMessage"),
        //   ),
        // );
        loginErrorMsg = errorMessage;

        log("login failed: $errorMessage");
      } else {
        var access_token = jsonResponse["token"]["access_token"];
        var refresh_token = jsonResponse["token"]["refresh_token"];
        var name = jsonResponse["name"];
        var email = jsonResponse["email"];
        var mobile = jsonResponse["mobile"];
        var gender = jsonResponse["gender"] ?? "";
        var userId = jsonResponse["id"];
        var dob = jsonResponse["dob"] ?? "";
        var address = jsonResponse["address"] ?? "null";
        var profile_pic = jsonResponse["profile_pic"];
        // var otp = jsonResponse["code"];
        await saveUserData(access_token, refresh_token, userId, email, mobile,
            name, gender, dob, true, address, profile_pic);
        // Navigator.pushNamed(context, "/bottomnavigation");
        Navigator.pushNamed(context, "/bottomnavigation");
        showSuccessDialog(context);

        log("Response: ${response.body}");
      }
      log("login sucess");
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text("email or password is incorrect"),
        ),
      );
    }

    isLoading = false;
    notifyListeners();
  }

  // otp submittion

  otp_submission(
      final String otp, final String email, BuildContext context) async {
    isLoading = true;
    error_message = null;
    // var login = Uri.parse("user-login/");
    Uri url =
        Uri.parse("http://learningapp.e8demo.com/api/user-email-verification/");
    // log("$url");
    Map data = {"email": email, "otp": otp};

    // String body = jsonEncode(data);

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
        // await SuccessDialog(
        //   onButtonPressed: () {
        //
        //   },
        // );
        Navigator.pushNamed(context, "/bottomnavigation");
        showSuccessDialog(context);
      }
    }
    if (jsonResponse['status'] == "failure") {
      error_message = "Given otp is not matching";
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //     backgroundColor: Colors.red,
      //     content: Text("Given otp is not matching"),
      //   ),
      // );
      log("Error: ${response.statusCode}");
    }

    isLoading = false;
    notifyListeners();
  }

  void showSuccessDialog(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) {
        return AlertDialog(
          content: Container(
            height: 100,
            child: Column(
              children: [
                SizedBox(height: 20),
                Text(
                  "Welcome!",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Colors.green,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  "The expert in anything was once a beginner.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          actions: [
            Center(
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, "/bottomnavigation");
                },
                child: Container(
                  height: 40,
                  width: 200,
                  decoration: BoxDecoration(
                    color: ColorConstants.button_color,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      "Get Started",
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
          ],
        );
      },
    );
  }
}
