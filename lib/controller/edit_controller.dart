import 'dart:developer';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:learning_app/controller/register_controller.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditController with ChangeNotifier {
  editprofileData(var name, var phone, var email, var gender, var dob,
      var address, BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final url = 'http://learningapp.e8demo.com/api/user-edit/';
    final accessToken = prefs.getString("access_token") ?? "";

    Map<String, dynamic> data = {
      "name": name,
      "address": address,
      "email": email,
      "dob": dob,
      "gender": gender,
      "mobile": phone
    };
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
    var jsonResponse = jsonDecode(response.body);

    if (response.statusCode == 200) {
      if (jsonResponse['status'] != "failure") {
// context.read<RegisterController>().

        Navigator.pop(context);
        context.read<RegisterController>().saveUserData(accessToken,
            "refreshToken", 1, email, phone, name, gender, dob, true, address);
      }
      log('Data updated successfully: ${response.body}');
    } else {
      log('Failed to update data: ${response.statusCode}');
    }
  }
}
