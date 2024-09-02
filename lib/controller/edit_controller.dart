import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:learning_app/controller/login&registration/register_controller.dart';
import 'package:learning_app/view/bottom_navigation/bottom_navigation.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditController with ChangeNotifier {
//   editprofileData(var name, var phone, var email, var gender, var dob,
//       var address, BuildContext context, var profile_pic) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     final url = 'http://learningapp.e8demo.com/api/user-edit/';
//     final accessToken = prefs.getString("access_token") ?? "";

//     Map<String, dynamic> data = {
//       "name": name,
//       "address": address,
//       "email": email,
//       "dob": dob,
//       "gender": gender,
//       "mobile": phone,
//       "profile_pic": profile_pic,
//     };
//     // log("name--$name");
//     // log("address--$address");
//     String body = jsonEncode(data);
//     final response = await http.put(
//       Uri.parse(url),
//       headers: {
//         'Authorization': 'Bearer $accessToken',
//         'Content-Type': 'application/json',
//       },
//       body: body,
//     );
//     log(response.body);
//     var jsonResponse = jsonDecode(response.body);

//     if (response.statusCode == 200) {
//       if (jsonResponse['status'] != "failure") {
// // context.read<RegisterController>().

//         await context.read<RegisterController>().saveUserData(
//             accessToken,
//             "refreshToken",
//             1,
//             email,
//             phone,
//             name,
//             gender,
//             dob,
//             true,
//             address,
//             profile_pic);
//       }
//       Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(
//             builder: (context) => BottomNavigation(initialIndex: 4),
//           ));
//       log('Data updated successfully: ${response.body}');
//     } else {
//       log('Failed to update data: ${response.statusCode}');
//     }
//   }
  bool _isloading = false;
  bool get isLoading => _isloading;
  set isLoading(bool value) {
    _isloading = value;
    notifyListeners();
  }

  Future<void> editProfileData({
    required String name,
    required String phone,
    required String email,
    required String gender,
    required String dob,
    required String address,
    required BuildContext context,
    required File? profilePic,
  }) async {
    isLoading = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final url = 'http://learningapp.e8demo.com/api/user-edit/';
    final accessToken = prefs.getString("access_token") ?? "";
    log("profile pic in controller---$profilePic");
    // if (profilePic == null) {
    //   log('No profile image selected.');
    //   return;
    // }

    var request = http.MultipartRequest('PUT', Uri.parse(url));
    request.headers['Authorization'] = 'Bearer $accessToken';

    request.fields['name'] = name;
    request.fields['address'] = address;
    request.fields['email'] = email;
    request.fields['dob'] = dob;
    request.fields['gender'] = gender;
    request.fields['mobile'] = phone;

    log("requested fiels-- ${request.fields}");
    if (profilePic != null) {
      log('profile======${profilePic.path}');
      request.files.add(
          await http.MultipartFile.fromPath('profile_pic', profilePic.path));
    }
    log("requested fiels-- ${request.files}");
    final response = await request.send();
    final responseData = await http.Response.fromStream(response);
    log('Response status: ${response.statusCode}');
    log('Response body: ${responseData.body}');

    if (response.statusCode == 200) {
      log('Response body: ${responseData.body}');
      var jsonResponse = jsonDecode(responseData.body);

      if (jsonResponse['status'] != "failure") {
        var image = jsonResponse["data"]['profile_pic'];
        await context.read<RegisterController>().saveUserData(
              accessToken,
              "refreshToken",
              1,
              email,
              phone,
              name,
              gender,
              dob,
              true,
              address,
              image,
            );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => BottomNavigation(initialIndex: 4),
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.green,
            content: Text("Profile Updated Successfully"),
          ),
        );
        log('Data updated successfully: ${responseData.body}');
      }
    } else {
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //       content: Text('Failed to update profile: ${response.statusCode}')),
      // );
      log('Failed to update data: ${response.statusCode}');
    }
    isLoading = false;
  }
}
