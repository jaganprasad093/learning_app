import 'dart:developer';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:learning_app/core/constants/url_const.dart';
import 'package:learning_app/model/bannerModel.dart';
import 'package:learning_app/model/categorlistModel.dart';
import 'package:learning_app/model/featuredCourses.dart';
import 'package:learning_app/model/recommended_model.dart';
import 'package:learning_app/model/topCourseModel.dart';

class HomepageController with ChangeNotifier {
  RecommendedModel? recommendedModel;
  BannerModel? bannerModel;
  TopCoursesModel? topCoursesModel;
  FeaturedCoursesModel? featuredCoursesModel;
  CategoryListModel? categoryListModel;
  List<String>? bannerImg;
  getRecommendedCourses() async {
    final url = '${UrlConst.baseUrl}recommended_courses/';
    log(url);
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      recommendedModel = RecommendedModel.fromJson(data);
    } else {
      log('Failed to load courses: ${response.statusCode}');
    }
  }

  // get banner images
  getBanners() async {
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
    notifyListeners();
  }

  getTopCourses() async {
    final url = '${UrlConst.baseUrl}top_course_list/';
    log(url);
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      topCoursesModel = TopCoursesModel.fromJson(data);
    } else {
      log('Failed to load courses: ${response.statusCode}');
    }
  }

  getFeaturedCourse() async {
    final url = '${UrlConst.baseUrl}featured-course/';
    log(url);
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      featuredCoursesModel = FeaturedCoursesModel.fromJson(data);
    } else {
      log('Failed to load courses: ${response.statusCode}');
    }
  }

  getCategoryList() async {
    final url = '${UrlConst.baseUrl}category_list/';
    log(url);
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      categoryListModel = CategoryListModel.fromJson(data);
    } else {
      log('Failed to load courses: ${response.statusCode}');
    }
  }
}
