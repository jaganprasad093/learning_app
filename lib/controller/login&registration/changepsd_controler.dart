import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:learning_app/view/bottom_navigation/bottom_navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangepsdControler with ChangeNotifier {
  bool _isloading = false;
  bool get isLoading => _isloading;
  set isLoading(bool value) {
    _isloading = value;
    notifyListeners();
  }

  String? passwordValidate;

  changepsd(BuildContext context, var newpassword, var old_password,
      var retype_password) async {
    isLoading = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final url = 'http://learningapp.e8demo.com/api/change-password/';
    final accessToken = prefs.getString("access_token") ?? "";
    log(accessToken);

    Map<String, dynamic> data = {
      "old_password": newpassword,
      "retype_password": retype_password,
      "new_password": old_password,
      // "dob": dob,
      // "gender": gender,
      // "mobile": phone,
      // "profile_pic": profile_pic,
    };
    log("body--$data");
    // log("name--$name");
    // log("address--$address");
    String body = jsonEncode(data);
    final response = await http.put(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      },
      body: body,
    );
    log(response.body);
    // var jsonResponse = jsonDecode(response.body);

    if (response.statusCode == 200) {
// context.read<RegisterController>().

      var jsonResponse = jsonDecode(response.body);

      if (jsonResponse['result'] == "failure") {
        passwordValidate = "Old password is not correct";
      } else {
        // final accessToken = prefs.getString("access_token") ?? "";
        // final email = prefs.getString("email") ?? "";
        // final gender = prefs.getString("gender") ?? "";
        // final phone = prefs.getString("mobile") ?? "";
        // final address = prefs.getString("address") ?? "";
        // final profile_pic = prefs.getString("profile_pic") ?? "";
        // final name = prefs.getString("name") ?? "";
        // final dob = prefs.getString("dob") ?? "";
        // await context.read<RegisterController>().saveUserData(
        //     accessToken,
        //     "refreshToken",
        //     1,
        //     email,
        //     phone,
        //     name,
        //     gender,
        //     dob,
        //     true,
        //     address,
        //     profile_pic);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.green,
            content: Text("Password changed sucessfully"),
          ),
        );

        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => BottomNavigation(initialIndex: 4),
            ));
      }

      log('Data updated successfully: ${response.body}');
    } else {
      log('Failed to update data: ${response.statusCode}');
    }
    isLoading = false;
    notifyListeners();
  }
}
