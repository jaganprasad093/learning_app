import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RegisterController with ChangeNotifier {
  Future<void> registerData(final String name, final int phone,
      final String email, final String password) async {
    Uri url = Uri.parse("http://learningapp.e8demo.com/api/user-register/");
    Map<String, dynamic> data = {
      "name": name,
      "email": email,
      "password": password,
      "mobile": phone
    };

    String body = jsonEncode(data);

    var response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: body,
    );

    if (response.statusCode == 200) {
      log("Response: ${response.body}");
    } else {
      log("Error: ${response.statusCode}");
    }
  }

  Future<void> loginData(final String email, final String password) async {
    Uri url = Uri.parse("http://learningapp.e8demo.com/api/user-login/");
    Map<String, dynamic> data = {
      "email": email,
      "password": password,
    };

    String body = jsonEncode(data);

    var response = await http.post(
      url,
      // headers: {"Content-Type": "application/json"},
      body: body,
    );
    // log("Response: ${response.body}");
    if (response.statusCode == 200) {
      log("Response: ${response.body}");
      log("login sucess");
    } else {
      log("Error: ${response.statusCode}");
    }
  }
}
