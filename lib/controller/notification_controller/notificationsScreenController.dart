import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:learning_app/core/constants/url_const.dart';
import 'package:learning_app/model/notification_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Notificationsscreencontroller with ChangeNotifier {
  NotificationModel? notificationModel;
  getNotifications() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString("access_token") ?? "";
    final url = '${UrlConst.baseUrl}notification/';
    final headers = {
      'Authorization': 'Bearer $accessToken',
    };
    log(url);
    final response = await http.get(Uri.parse(url), headers: headers);
    log(response.body);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      notificationModel = NotificationModel.fromJson(data);
    } else {
      log('Failed to load courses: ${response.statusCode}');
    }
  }
}
