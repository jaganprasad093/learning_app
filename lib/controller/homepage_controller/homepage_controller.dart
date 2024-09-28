import 'dart:developer';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:learning_app/core/constants/url_const.dart';
import 'package:learning_app/model/bannerModel.dart';
import 'package:learning_app/model/categorlistModel.dart';
import 'package:learning_app/model/courseDetail_model.dart';
import 'package:learning_app/model/featuredCourses.dart';
import 'package:learning_app/model/recentlyViewedModel.dart';
import 'package:learning_app/model/recommended_model.dart';
import 'package:learning_app/model/topCourseModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomepageController with ChangeNotifier {
  RecommendedModel? recommendedModel;
  BannerModel? bannerModel;
  TopCoursesModel? topCoursesModel;
  FeaturedCoursesModel? featuredCoursesModel;
  CategoryListModel? categoryListModel;
  CourseDetailModel? courseDetailModel;
  RecentlyViewedModel? recentlyViewedModel;
  List<String>? bannerImg;

  bool _isloading = false;
  bool get isLoading => _isloading;
  set isLoading(bool value) {
    _isloading = value;
    // notifyListeners();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }

  getRecommendedCourses() async {
    isLoading = true;
    final url = '${UrlConst.baseUrl}recommended_courses/';
    log(url);
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      // var jsonResponse = jsonDecode(response.body);

      recommendedModel = RecommendedModel.fromJson(data);
    } else {
      log('Failed to load courses: ${response.statusCode}');
    }
    isLoading = false;
  }

  // get banner images
  getBanners() async {
    isLoading = true;
    final url = '${UrlConst.baseUrl}banner/';
    log(url);
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      bannerModel = BannerModel.fromJson(json.decode(response.body));

      List<String> bannerImageList = [];

      if (bannerModel != null && bannerModel!.data != null) {
        for (var datum in bannerModel!.data!) {
          if (datum.bannerImg != null) {
            for (var bannerImg in datum.bannerImg!) {
              if (bannerImg.bannerImg != null) {
                bannerImageList.add(bannerImg.bannerImg!);
              }
            }
          }
        }
      }
      bannerImg = bannerImageList;
      log('Banner Images: $bannerImg');
    } else {
      log('Failed to load banners: ${response.statusCode}');
    }
    isLoading = false;
    notifyListeners();
  }

  getTopCourses() async {
    isLoading = true;
    final url = '${UrlConst.baseUrl}top_course_list/';
    log(url);
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      topCoursesModel = TopCoursesModel.fromJson(data);
    } else {
      log('Failed to load courses: ${response.statusCode}');
    }
    isLoading = false;
  }

  getFeaturedCourse() async {
    isLoading = true;
    final url = '${UrlConst.baseUrl}featured-course/';
    log(url);
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      featuredCoursesModel = FeaturedCoursesModel.fromJson(data);
    } else {
      log('Failed to load courses: ${response.statusCode}');
    }
    isLoading = false;
  }

  getCategoryList() async {
    isLoading = true;
    final url = '${UrlConst.baseUrl}category_list/';
    log(url);
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      categoryListModel = CategoryListModel.fromJson(data);
    } else {
      log('Failed to load courses: ${response.statusCode}');
    }
    isLoading = false;
  }

  getRecentlyViewed() async {
    isLoading = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString("access_token") ?? "";
    final url = '${UrlConst.baseUrl}recent-courses/?auth_token=$accessToken';
    log(url);
    final headers = {
      'Authorization': 'Bearer $accessToken',
    };
    final response = await http.get(Uri.parse(url), headers: headers);
    // log(response.body);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      var jsonResponse = jsonDecode(response.body);
      var status = jsonResponse["status"];
      log("status-------$status");

      recentlyViewedModel = RecentlyViewedModel.fromJson(data);
    } else {
      log("recently viewed function ");
      log('Failed to load courses: ${response.statusCode}');
    }
    isLoading = false;
    notifyListeners();
  }

  Future<CourseDetailModel?> getCourseDetails(var id) async {
    isLoading = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString("access_token") ?? "";

    final url =
        '${UrlConst.baseUrl}user-coursedetail/?coursedetail_id=$id&auth_token=$accessToken';
    log(url);
    final headers = {
      'Authorization': 'Bearer $accessToken',
    };

    final response = await http.get(Uri.parse(url), headers: headers);
    // log(response.body);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      courseDetailModel = CourseDetailModel.fromJson(data);
      return courseDetailModel;
    } else {
      log('Failed to load courses: ${response.statusCode}');
    }
    getRecentlyViewed();
    isLoading = false;
    notifyListeners();
    return null;
  }
}
