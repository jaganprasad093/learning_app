import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:learning_app/core/constants/color_constants.dart';
import 'package:learning_app/core/constants/url_const.dart';
import 'package:learning_app/model/aboutModel.dart';
import 'package:learning_app/model/reviewModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Reviewcontroller with ChangeNotifier {
  ReviewsModel? reviewsModel;
  AboutModel? aboutModel;
  bool _isloading = false;
  bool get isLoading => _isloading;
  set isLoading(bool value) {
    _isloading = value;
    // notifyListeners();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }

  getReviews(var courseID) async {
    isLoading = true;
    final url =
        '${UrlConst.baseUrl}user-review/get_review/?course_id=$courseID';
    log(url);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString("access_token") ?? "";
    final headers = {
      'Authorization': 'Bearer $accessToken',
    };
    final response = await http.get(
        Uri.parse(
          url,
        ),
        headers: headers);
    log(response.body);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      reviewsModel = ReviewsModel.fromJson(data);
    } else {
      log('Failed to load courses: ${response.statusCode}');
    }
    isLoading = false;
  }

  AddReview(var rating, var course_id, var review, BuildContext context) async {
    isLoading = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString("access_token") ?? "";

    final url = '${UrlConst.baseUrl}user-review/add_review/';
    log(url);
    Map<String, dynamic> data = {
      "rating": rating.toString(),
      "course_id": course_id.toString(),
      "review": review.toString(),
    };
    // log("$data");
    final headers = {
      'Authorization': 'Bearer $accessToken',
    };

    // String body = jsonEncode(data);
    final response =
        await http.post(Uri.parse(url), headers: headers, body: data);
    log("response----${response.body}");

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: ColorConstants.button_color,
          content: Text(" Review added"),
        ),
      );
      // final data = json.decode(response.body);
      log("it enters");

      // courseDetailModel = CourseDetailModel.fromJson(data);
    } else {
      log('Failed to load courses: ${response.statusCode}');
    }
    isLoading = false;
    notifyListeners();
  }

  getAbout() async {
    isLoading = true;
    final url = '${UrlConst.baseUrl}about-app/';
    log(url);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString("access_token") ?? "";
    final headers = {
      'Authorization': 'Bearer $accessToken',
    };
    final response = await http.get(
        Uri.parse(
          url,
        ),
        headers: headers);
    log(response.body);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      aboutModel = AboutModel.fromJson(data);
    } else {
      log('Failed to load courses: ${response.statusCode}');
    }
    isLoading = false;
  }

  addReport(var email, var report_issue, BuildContext context) async {
    isLoading = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString("access_token") ?? "";

    final url = '${UrlConst.baseUrl}report-issue/';
    log(url);
    Map<String, dynamic> data = {
      "report_issue": report_issue.toString(),
      "email": email.toString()
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
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: ColorConstants.button_color,
          content: Text(" Review added"),
        ),
      );
      // final data = json.decode(response.body);
      // courseDetailModel = CourseDetailModel.fromJson(data);
    } else {
      log('Failed to load courses: ${response.statusCode}');
    }
    isLoading = false;
    notifyListeners();
  }
}
