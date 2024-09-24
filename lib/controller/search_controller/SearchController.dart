import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:learning_app/core/constants/url_const.dart';
import 'package:learning_app/model/serachModel.dart';

class SearchCourseController with ChangeNotifier {
  bool _isloading = false;
  bool isEmpty = false;

  SearchModel? searchmodel;
  bool get isLoading => _isloading;
  set isLoading(bool value) {
    _isloading = value;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }

  getSearchCourses() async {
    isLoading = true;
    final url = '${UrlConst.baseUrl}course_search/';
    log(url);
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      searchmodel = SearchModel.fromJson(data);
    } else {
      log('Failed to load courses: ${response.statusCode}');
    }
    notifyListeners();
    isLoading = false;
  }

  searchData(var key) async {
    isLoading = true;
    final url = '${UrlConst.baseUrl}course_search/?search_key=$key';
    log(url);
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      log("response---${response.body}");
      searchmodel = SearchModel.fromJson(data);
      isEmpty = false;
    } else {
      log('Failed to load courses: ${response.statusCode}');
      log("length----${searchmodel?.message}");
      isEmpty = true;
    }
    notifyListeners();
    isLoading = false;
  }
}
