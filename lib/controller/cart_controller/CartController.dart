import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:learning_app/core/constants/color_constants.dart';
import 'package:learning_app/core/constants/url_const.dart';
import 'package:learning_app/model/cart_model.dart';
import 'package:learning_app/model/checkoutModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Cartcontroller with ChangeNotifier {
  CartModel? cartModel;
  CheckOutModel? _checkOutModel;
  CheckOutModel? get checkOutModel => _checkOutModel;
  set checkOutModel(value) {
    _checkOutModel = value;
    notifyListeners();
  }

  List cartItems = [];
  String? error_message;
  String? orderId;
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
    log("Respone of cart" + response.body);
    if (response.statusCode == 200) {
      // final data = json.decode(response.body);
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
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: ColorConstants.button_color,
          content: Text("Course is already purchased !"),
        ),
      );
      log('Failed to load courses: ${response.statusCode}');
    }
    isLoading = false;
    notifyListeners();
  }

  removeCartItems(var courseID, var variantID) async {
    isLoading = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString("access_token") ?? "";
    // Map<String, dynamic> data = {
    //   "course": courseID.toString(),
    //   "variant": variantID.toString(),
    // };
    var response = await http.put(
        Uri.parse("http://learningapp.e8demo.com/api/add_to_cart/"),
        headers: {
          "Authorization": "Bearer ${accessToken}",
          "Content-Type": "application/json"
        },
        body: jsonEncode({"course": courseID, "section": variantID}));
    log(response.body);
    if (response.statusCode == 200) {
      // final data = json.decode(response.body);
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
    cartItems.clear();
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

    final data = json.decode(response.body);
    cartModel = CartModel.fromJson(data);
    if (response.statusCode == 200) {
      log("response of cart--- ${response.body}");

      for (var item in cartModel?.data?.cartItem ?? []) {
        cartItems.add(item.courseId);
      }
      log("cartItems---$cartItems");
    } else {
      log('Failed to load courses: ${response.statusCode}');
    }
    isLoading = false;
    notifyListeners();
  }

// checkout controller

  checkout(var payment) async {
    isLoading = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString("access_token") ?? "";

    final url = '${UrlConst.baseUrl}confirm_purchase/';
    log(url);
    Map<String, dynamic> data = {
      "payment_method": payment.toString(),
      // "promo_code": promocode
    };
    log("$data");
    final headers = {
      'Authorization': 'Bearer $accessToken',
    };

    // String body = jsonEncode(data);
    final response =
        await http.post(Uri.parse(url), headers: headers, body: data);
    log("response----${response.body}");
    var jsonResponse = jsonDecode(response.body);
    if (response.statusCode == 200) {
      orderId = jsonResponse['data']["order_id"];
      log("order id----------------$orderId");
      // final data = json.decode(response.body);
      log("it enters");

      // courseDetailModel = CourseDetailModel.fromJson(data);
    } else {
      log('Failed to load courses: ${response.statusCode}');
    }
    isLoading = false;
    notifyListeners();
  }

  //apply promocode

  applyPromo(var promocode) async {
    isLoading = true;
    error_message = null;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString("access_token") ?? "";

    final url = '${UrlConst.baseUrl}apply_offer/';
    log(url);
    Map<String, dynamic> data = {
      "promo_code": promocode,
    };
    log("data-----$data");
    final headers = {
      'Authorization': 'Bearer $accessToken',
    };

    // String body = jsonEncode(data);
    final response =
        await http.post(Uri.parse(url), headers: headers, body: data);
    log(response.body);
    var jsonResponse = jsonDecode(response.body);
    log("checkout ----- " + response.statusCode.toString());
    if (response.statusCode == 200) {
      checkOutModel = CheckOutModel.fromJson(json.decode(response.body));

      // final data = json.decode(response.body);

      // if (jsonResponse['message'] == "Invalid code") {
      //   return error_message = "Invalid code";
      // }
      // courseDetailModel = CourseDetailModel.fromJson(data);
    } else {
      log("inside =============================");
      checkOutModel = null;
      log("inside ============================= $checkOutModel");
      if (jsonResponse['message'] == "Invalid code") {
        return error_message = "Invalid code";
      }
      log('Failed to load courses: ${response.statusCode}');
    }
    isLoading = false;
    notifyListeners();
  }

  // remove promo code

  removePromo() async {
    isLoading = true;
    // orderId = null;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString("access_token") ?? "";

    final url = '${UrlConst.baseUrl}apply_offer/';
    log(url);
    // Map<String, dynamic> data = {
    //   "promo_code": promocode.toString(),
    // };
    // log("$data");
    final headers = {
      'Authorization': 'Bearer $accessToken',
    };
    final response = await http.post(
      Uri.parse(url),
      headers: headers,
    );
    log(response.body);

    if (response.statusCode == 200) {
      // final data = json.decode(response.body);
      log(response.body);
      checkOutModel = CheckOutModel.fromJson(json.decode(response.body));

      // courseDetailModel = CourseDetailModel.fromJson(data);
    } else {
      log('Failed to load courses: ${response.statusCode}');
    }
    isLoading = false;
    notifyListeners();
  }
}
