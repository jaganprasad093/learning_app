import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:learning_app/core/constants/url_const.dart';
import 'package:learning_app/model/orderModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Ordercontroller with ChangeNotifier {
  OrderModel? orderModel;
  bool _isloading = false;
  bool get isLoading => _isloading;
  set isLoading(bool value) {
    _isloading = value;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }

  getOrderList() async {
    isLoading = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString("access_token") ?? "";

    final url = '${UrlConst.baseUrl}order_history/';
    final headers = {
      'Authorization': 'Bearer $accessToken',
    };
    log(url);
    final response = await http.get(Uri.parse(url), headers: headers);
    log("orders ---${response.body}");
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      orderModel = OrderModel.fromJson(data);
    } else {
      log('Failed to load courses: ${response.statusCode}');
    }
    isLoading = false;
    notifyListeners();
  }
}
