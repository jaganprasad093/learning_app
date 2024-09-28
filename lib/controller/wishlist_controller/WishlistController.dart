import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:learning_app/core/constants/url_const.dart';
import 'package:learning_app/model/wishlistModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Wishlistcontroller with ChangeNotifier {
  List<WishlistModel> wishlistList = [];
  List<String> favoriteIds = [];
  bool _isloading = false;
  bool get isLoading => _isloading;
  set isLoading(bool value) {
    _isloading = value;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }

  AddWishlist(
    var course,
    var price,
    var varient,
  ) async {
    isLoading = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString("access_token") ?? "";

    final url = '${UrlConst.baseUrl}wishlist/';
    log(url);
    Map<String, dynamic> data = {
      "course": course.toString(),
      "variant": varient.toString(),
      "price": price.toString()
    };
    log("$data");
    final headers = {
      'Authorization': 'Bearer $accessToken',
    };

    // String body = jsonEncode(data);
    final response =
        await http.post(Uri.parse(url), headers: headers, body: data);
    log(response.body);
    if (response.statusCode == 200) {
      // final data = json.decode(response.body);
      log(response.body);
      favoriteIds.add(course.toString());
      log("favoriteIds-----$favoriteIds");
      getWishlist();
      // courseDetailModel = CourseDetailModel.fromJson(data);
    } else {
      log('Failed to load courses: ${response.statusCode}');
    }
    isLoading = false;
    notifyListeners();
  }

  removeWishlist(var course, var variant, final bool isWishlist,
      final BuildContext context) async {
    isLoading = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final accessToken = prefs.getString("access_token") ?? "";

    final url = '${UrlConst.baseUrl}wishlist/';
    log(url);
    Map<String, dynamic> data = {
      "course": course.toString(),
      "variant": variant.toString(),
    };
    final headers = {
      'Authorization': 'Bearer $accessToken',
    };

    // String body = jsonEncode(data);
    final response =
        await http.put(Uri.parse(url), headers: headers, body: data);
    log(response.body);
    if (response.statusCode == 200) {
      // final data = json.decode(response.body);
      favoriteIds.remove("$course");
      // favoriteIds.clear();
      log("remove courseID---$course");
      log("remove favIds---$favoriteIds");

      log(response.body);
      getWishlist();
      // courseDetailModel = CourseDetailModel.fromJson(data);
      if (isWishlist) {
        return Navigator.pop(context);
      }
    } else {
      log('Failed to load courses: ${response.statusCode}');
    }
    isLoading = false;

    notifyListeners();
  }

  getWishlist() async {
    isLoading = true;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('courseID');

    // var ids = prefs.getStringList("courseID") ?? [];

    final accessToken = prefs.getString("access_token") ?? "";
    final url = '${UrlConst.baseUrl}wishlist/';
    log(url);
    final headers = {
      'Authorization': 'Bearer $accessToken',
    };
    final response = await http.get(Uri.parse(url), headers: headers);
    log("response wishlist----${response.body}");
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      wishlistList = (data['data']["wishlist"] as List)
          .map(
            (e) => WishlistModel.fromJson(e),
          )
          .toList();
      List<String> courseIds =
          wishlistList.map((item) => item.courseId.toString()).toList();
      await prefs.setStringList('courseID', courseIds);
      favoriteIds = courseIds;
      log("favorire ids --- $favoriteIds");
    } else {
      log('response----${response.statusCode}');
    }
    // log('wishlist length -- ${wishlistList.length}');
    isLoading = false;
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   notifyListeners();
    // });
    notifyListeners();
  }
}
