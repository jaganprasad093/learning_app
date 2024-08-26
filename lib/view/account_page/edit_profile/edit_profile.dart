import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:learning_app/core/constants/color_constants.dart';
import 'package:learning_app/core/constants/image_constants.dart';
import 'package:learning_app/core/widgets/custom_textformfield.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController name_Controller = TextEditingController();
  TextEditingController email_Controller = TextEditingController();
  TextEditingController phone_controller = TextEditingController();
  TextEditingController note_Controller = TextEditingController();
  TextEditingController date_Controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final List<String> gender = [
    "Male",
    "Female",
  ];
  String? selectedGender;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Edit profile",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  CircleAvatar(
                    radius: 70,
                    backgroundImage: AssetImage(ImageConstants.splashscreen),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  CustomTextField(
                    controller: name_Controller,
                    hintText: "Name",
                    validator: (String? value) {
                      return (value == null || value.isEmpty)
                          ? 'Please enter the name'
                          : null;
                    },
                  ),
                  SizedBox(height: 10),
                  IntlPhoneField(
                    disableLengthCheck: true,
                    // focusNode: focusNode,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      hintText: 'Phone Number',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    languageCode: "en",
                    initialCountryCode: "IN",
                    onChanged: (phone) {
                      print(phone.completeNumber);
                    },
                    onCountryChanged: (country) {
                      print('Country changed to: ' + country.name);
                    },
                    validator: (PhoneNumber? phonenumber) {
                      if (phonenumber == null || phonenumber.number.isEmpty) {
                        return 'enter phone number';
                      }
                      RegExp regex = RegExp(
                          r'^\s*(?:\+?(\d{1,3}))?[-. (]*(\d{3})[-. )]*(\d{3})[-. ]*(\d{4})(?: *x(\d+))?\s*$');
                      if (!regex.hasMatch(phonenumber.toString())) {
                        return "Enter a valid phone number";
                      }
                      return null;
                    },
                    // validator: (p0) {},
                  ),
                  SizedBox(height: 10),
                  CustomTextField(
                    controller: email_Controller,
                    hintText: "Email address",
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the email address';
                      }
                      if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                        return "Enter a valid email address";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  DropdownButtonFormField(
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      // enabledBorder: OutlineInputBorder(
                      //   borderRadius: BorderRadius.circular(20),
                      // ),
                      focusedBorder: OutlineInputBorder(),
                      hintText: "Select gender",
                      // fillColor: ColorConstants.button_color,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    value: selectedGender,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedGender = newValue;
                      });
                    },
                    items: gender.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    validator: (String? value) {
                      return (value == null || value.isEmpty)
                          ? 'Please select type'
                          : null;
                    },
                  ),
                  SizedBox(height: 10),
                  CustomTextField(
                    suffixIcon: Icon(
                      Icons.calendar_month_rounded,
                    ),
                    onTap: () => selectDate(context, date_Controller),
                    controller: email_Controller,
                    hintText: "Date",
                    validator: (String? value) {
                      return (value == null || value.isEmpty)
                          ? 'Please enter a date'
                          : null;
                    },
                  ),
                  SizedBox(height: 10),
                  CustomTextField(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 30),
                    controller: email_Controller,
                    hintText: "Test",
                    validator: (String? value) {
                      return (value == null || value.isEmpty)
                          ? 'Please enter a test'
                          : null;
                    },
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  InkWell(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.pop(context);
                        log("edit sucess");
                      }
                    },
                    child: Container(
                      height: 50,
                      // width: 200,
                      decoration: BoxDecoration(
                        color: ColorConstants.button_color,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          "Edit profile",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 30,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  DateTime selectedDate = DateTime.now();
  Future<void> selectDate(
      BuildContext context, TextEditingController controller) async {
    log("selected date and time now---$selectedDate");
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2024, 1),
      lastDate: DateTime(2100),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        String convertedDateTime =
            "${picked.day.toString().padLeft(2, '0')}-${picked.month.toString().padLeft(2, '0')}-${picked.year.toString()}";
        controller.value = TextEditingValue(text: convertedDateTime);
      });
      FocusScope.of(context).unfocus();
    }
  }
}
