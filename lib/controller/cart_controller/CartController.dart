import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:learning_app/core/constants/url_const.dart';
import 'package:learning_app/model/cart_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Cartcontroller with ChangeNotifier {
  CartModel? cartModel;
  bool _isloading = false;
  bool get isLoading => _isloading;
  set isLoading(bool value) {
    _isloading = value;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }

  AddCartItems(var courseID, var variantID, var price, BuildContext context,
      bool isDetail) async {
    isLoading = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString("access_token") ?? "";
    var response = await http.post(
        Uri.parse("http://learningapp.e8demo.com/api/add_to_cart/"),
        headers: {
          "Authorization": 'Bearer ${accessToken}',
          "Content-Type": "application/json"
        },
        body: jsonEncode(
            {"course": courseID, "variant": variantID, "price": price}));
    log(response.body);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      isDetail
          ? ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.green,
                content: Text("Added cart sucessfully"),
              ),
            )
          : log(" snackbar is shown");
      // courseDetailModel = CourseDetailModel.fromJson(data);
    } else {
      log('Failed to load courses: ${response.statusCode}');
    }
    isLoading = false;
    notifyListeners();
  }

  removeCartItems(var courseID, var variantID) async {
    isLoading = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString("access_token") ?? "";
    Map<String, dynamic> data = {
      "course": courseID.toString(),
      "variant": variantID.toString(),
    };
    var response = await http.put(
        Uri.parse("http://learningapp.e8demo.com/api/add_to_cart/"),
        headers: {
          "Authorization": "Bearer ${accessToken}",
          "Content-Type": "application/json"
        },
        body: jsonEncode({"course": courseID, "section": variantID}));
    log(response.body);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      getCart();
      // courseDetailModel = CourseDetailModel.fromJson(data);
    } else {
      log('Failed to load courses: ${response.statusCode}');
    }
    isLoading = false;
    notifyListeners();
  }

  getCart() async {
    isLoading = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString("access_token") ?? "";
    final url = '${UrlConst.baseUrl}add_to_cart/';
    log(url);

    final response = await http.get(
      Uri.parse(url),
      headers: {
        "Authorization": "Bearer ${accessToken}",
        "Content-Type": "application/json"
      },
    );
    log("response of cart--- ${response.body}");
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      cartModel = CartModel.fromJson(data);
    } else {
      log('Failed to load courses: ${response.statusCode}');
    }
    isLoading = false;
    notifyListeners();
  }
}
