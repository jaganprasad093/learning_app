import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:learning_app/core/constants/url_const.dart';
import 'package:learning_app/model/SubCategoryModel.dart';
import 'package:learning_app/model/category_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CategoryController with ChangeNotifier {
  CategoryModel? categorymodel;
  SubCategoryModel? subCategoryModel;
  List subCategoryList = [];
  bool _isloading = false;
  bool get isLoading => _isloading;
  set isLoading(bool value) {
    _isloading = value;
    // notifyListeners();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }

  getCategoryItem(var id) async {
    isLoading = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString("access_token") ?? "";

    final url =
        '${UrlConst.baseUrl}course_list/?cate_id=$id&auth_token=$accessToken';
    // final headers = {
    //   'Authorization': 'Bearer $accessToken',
    // };
    log(url);
    final response = await http.get(Uri.parse(url));
    log("category ---${response.body}");
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      categorymodel = CategoryModel.fromJson(data);
      fetchSubCategoryDetails(data);
    } else {
      categorymodel = null;
    }
    isLoading = false;
    notifyListeners();
  }

   fetchSubCategoryDetails(data) {
    subCategoryList.clear();
    if (data['data'] != null) {
      for (var course in data['data']) {
        var subCategory = course['sub_category'];
        if (subCategory != null) {
          subCategoryList.add({
            'id': subCategory['id'],
            'sub_category_name': subCategory['sub_catehory_name'],
          });
        }
      }
    }
    log('Subcategory List: $subCategoryList');
  }

  getSubCategories(var id) async {
    isLoading = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString("access_token") ?? "";

    final url =
        '${UrlConst.baseUrl}course_list/?sub_cate_id=$id&auth_token=$accessToken';
    // final headers = {
    //   'Authorization': 'Bearer $accessToken',
    // };
    log(url);
    final response = await http.get(Uri.parse(url));
    // log("category ---${response.body}");
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      subCategoryModel = SubCategoryModel.fromJson(data);
    } else {
      log('Failed to load courses: ${response.statusCode}');
    }
    isLoading = false;
    notifyListeners();
  }
}
