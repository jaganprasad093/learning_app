import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:learning_app/controller/login&registration/register_controller.dart';
import 'package:learning_app/view/bottom_navigation/bottom_navigation.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditController with ChangeNotifier {
  var profile_pic;
  File? imageFile;
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
    log("accestoken---$accessToken");
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

  deleteProfile(BuildContext context) async {
    final url = Uri.parse("http://learningapp.e8demo.com/api/delete-profile/");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString("access_token") ?? "";
    final headers = {
      'Authorization': 'Bearer $accessToken',
    };

    final response = await http.delete(url, headers: headers);
    log(response.body);
    if (response.statusCode == 200) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.clear();
      Navigator.pushReplacementNamed(context, "/login");
      log("response--${response.body}");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Deleted sucessfully'),
          backgroundColor: Colors.green,
        ),
      );
      return true;
    } else {
      log('Failed to delete item: ${response.statusCode} ${response.body}');
      return false;
    }
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      await _cropImage(pickedFile.path);
    }
    notifyListeners();
  }

  Future<void> captureImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      await _cropImage(pickedFile.path);
    }
    notifyListeners();
  }

  Future<void> _cropImage(String imagePath) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: imagePath,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Cropper',
          toolbarColor: Colors.deepOrange,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false,
        ),
      ],
    );

    if (croppedFile != null) {
      imageFile = File(croppedFile.path);
      profile_pic = croppedFile.path;
      log("propic---$profile_pic");
      log("image file---$imageFile");
      // SharedPreferences prefs = await SharedPreferences.getInstance();
      // prefs.setString('profile_pic', profile_pic);

      notifyListeners();
    }
  }
}
