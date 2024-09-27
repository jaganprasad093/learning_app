import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:learning_app/core/constants/url_const.dart';
import 'package:learning_app/model/learningDetailModel.dart';
import 'package:learning_app/model/myLearningModel.dart' as myLearning;
import 'package:shared_preferences/shared_preferences.dart';

class Mylearningcontroller with ChangeNotifier {
  myLearning.MyLearningModel? myLearningModel;
  LearningDetailModel? learningDetailModel;
  bool _isloading = false;
  bool get isLoading => _isloading;
  set isLoading(bool value) {
    _isloading = value;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }

  getMyLearnings() async {
    isLoading = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString("access_token") ?? "";

    final url = '${UrlConst.baseUrl}my-courses/';
    log(url);
    // Map<String, dynamic> data = {
    //   // "payment_method": payment.toString(),
    //   // "promo_code": promocode
    // };
    // log("$data");
    final headers = {
      'Authorization': 'Bearer $accessToken',
    };

    // String body = jsonEncode(data);
    final response = await http.get(Uri.parse(url), headers: headers);
    log("response----${response.body}");
    final data = json.decode(response.body);
    myLearningModel = myLearning.MyLearningModel.fromJson(data);
    if (response.statusCode == 200) {
      // return myLearningModel;
    } else {
      log('Failed to load courses: ${response.statusCode}');
    }
    isLoading = false;
    notifyListeners();
  }

// detail learning page

  detailLearningpage(var courseID) async {
    isLoading = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString("access_token") ?? "";

    final url = '${UrlConst.baseUrl}topic_list/?course_id=$courseID';
    log(url);
    // Map<String, dynamic> data = {
    //   // "payment_method": payment.toString(),
    //   // "promo_code": promocode
    // };
    // log("$data");
    final headers = {
      'Authorization': 'Bearer $accessToken',
    };

    // String body = jsonEncode(data);
    final response = await http.get(Uri.parse(url), headers: headers);

    final data = json.decode(response.body);
    learningDetailModel = LearningDetailModel.fromJson(data);
    log("response----${response.body}");
    if (response.statusCode == 200) {
    } else {
      log('Failed to load courses: ${response.statusCode}');
    }
    isLoading = false;
    notifyListeners();
  }

  // adding watch length
  watchlength(var courseId, var topicId, var watchDuration) async {
    // isLoading = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString("access_token") ?? "";

    final url = '${UrlConst.baseUrl}topic_list/?course_id=$courseId';
    log(url);

    Map<String, String> data = {
      "courseid": courseId.toString(),
      "topicid": topicId.toString(),
      "watch_duration": watchDuration.toString()
    };

    log("$data");
    final headers = {
      'Authorization': 'Bearer $accessToken',
      'Content-Type': 'application/json'
    };

    String body = jsonEncode(data);

    final response =
        await http.post(Uri.parse(url), headers: headers, body: body);
    log("response----${response.body}");

    if (response.statusCode == 200) {
      log("it enters");
    } else {
      log('Failed to load courses: ${response.statusCode}');
    }

    // isLoading = false;
    notifyListeners();
  }

  double percentageCalculator(String watch, String video) {
    Duration watchDuration = parseDuration(watch);
    Duration videoDuration = parseDuration(video);
    log("watch in duration---$watchDuration");
    log("video in duration---$videoDuration");
    double watchInSeconds = watchDuration.inSeconds.toDouble();
    double videoInSeconds = videoDuration.inSeconds.toDouble();
    log("video---$videoInSeconds");
    log("watch in seconds---$watchInSeconds");
    double percentage = (watchInSeconds / videoInSeconds) * 100;
    log("percentage-----$percentage");
    return percentage;
  }

  Duration parseDuration(String durationString) {
    List<String> parts = durationString.split(':');
    log("parts----$parts");
    // if (parts.length < 3) {
    //   throw FormatException("Invalid duration format");
    // }

    num hours = num.tryParse(parts[0]) ?? 0;

    num minutes = num.tryParse(parts[1]) ?? 0;
    log("mintues-----$minutes");

    num seconds = 0;
    if (parts.length > 2) {
      seconds = num.tryParse(parts[2]) ?? 0;
    }
    log("seconds-----$seconds");

    return Duration(
      hours: hours.toInt(),
      minutes: minutes.toInt(),
      seconds: seconds.floor(),
      milliseconds: ((seconds - seconds.floor()) * 1000).toInt(),
    );
  }

  Future<List<myLearning.Datum>> searchCourses(String searchTerm) async {
    await getMyLearnings();
    var courses = myLearningModel?.data ?? [];

    List<myLearning.Datum> matchingCourses = courses.where((course) {
      final courseName = course.courseName?.toLowerCase() ?? '';
      final instructorName = course.instructorName?.toLowerCase() ?? '';
      return courseName.contains(searchTerm.toLowerCase()) ||
          instructorName.contains(searchTerm.toLowerCase());
    }).toList();

    log("matching courses---${matchingCourses.map((c) => c.toJson()).toList()}");
    return matchingCourses;
  }
}
