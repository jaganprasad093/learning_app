import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:learning_app/controller/edit_controller.dart';
import 'package:learning_app/core/constants/color_constants.dart';
import 'package:learning_app/core/constants/image_constants.dart';
import 'package:learning_app/core/widgets/custom_textformfield.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController name_Controller = TextEditingController();
  TextEditingController email_Controller = TextEditingController();
  TextEditingController phone_controller = TextEditingController();
  TextEditingController address_Controller = TextEditingController();
  TextEditingController date_Controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    init();
    super.initState();
  }

  init() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Initialize the controllers with stored values
    name_Controller.text = prefs.getString("name") ?? "";
    phone_controller.text = prefs.getString("mobile") ?? "";
    email_Controller.text = prefs.getString("email") ?? "";
    selectedGender = prefs.getString("gender");
    address_Controller.text = prefs.getString("address") ?? "";

    // Initialize the date controller with the formatted date
    String? dateString = prefs.getString("dob");
    if (dateString != null && dateString.isNotEmpty) {
      try {
        DateTime selectedDate = DateTime.parse(dateString);
        String formattedDate = DateFormat('dd-MM-yyyy').format(selectedDate);
        date_Controller.text = formattedDate;
        log("formatted date---$formattedDate");
        log("date string---$dateString");
      } catch (e) {
        print("Date parsing error: $e");
      }
    }

    // Notify the UI to update with the new values
    setState(() {});
  }

  final List<String> gender = [
    "Male",
    "Female",
  ];
  String? selectedGender;
  @override
  Widget build(BuildContext context) {
    var provider = context.read<EditController>();
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: CircleAvatar(
                      radius: 60,
                      backgroundImage: AssetImage(ImageConstants.splashscreen),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Basic Information",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: ColorConstants.primary_black.withOpacity(.5),
                        fontSize: 16),
                  ),
                  SizedBox(height: 10),
                  CustomTextField(
                    enabled: false,
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
                  CustomTextField(
                    controller: name_Controller,
                    hintText: "Name",
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter the name';
                      }

                      RegExp regex = RegExp(r'^[a-zA-Z\s]+$');

                      if (!regex.hasMatch(value)) {
                        return "Please enter a valid name ";
                      }
                    },
                  ),
                  SizedBox(height: 10),
                  CustomTextField(
                    // prefixText: "+91 ",
                    // errorText:
                    //     context.watch<RegisterController>().mobile_validate,
                    keyboardType: TextInputType.number,
                    prefix: Text(
                      "  +91 ",
                      style:
                          TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
                    ),

                    controller: phone_controller,
                    maxLength: 10,
                    hintText: "Phone number",
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter the phone number';
                      }
                      RegExp regex = RegExp(r'^\+?[0-9]{10,15}$');
                      if (!regex.hasMatch(phone_controller.text)) {
                        return "Enter a valid phone number";
                      }

                      return null;
                    },
                  ),
                  SizedBox(height: 30),
                  Text(
                    "Personal Information",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: ColorConstants.primary_black.withOpacity(.5),
                        fontSize: 16),
                  ),
                  SizedBox(height: 10),
                  DropdownButtonFormField(
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      focusedBorder: OutlineInputBorder(),
                      hintText: "Select gender",
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
                          ? 'Please select gender'
                          : null;
                    },
                  ),
                  SizedBox(height: 10),
                  CustomTextField(
                    readOnly: true,
                    suffixIcon: Icon(Icons.calendar_month_rounded),
                    onTap: () => selectDate(context, date_Controller),
                    controller: date_Controller,
                    hintText: "Date of birth",
                    validator: (String? value) {
                      return (value == null || value.isEmpty)
                          ? 'Please enter a date'
                          : null;
                    },
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: 100,
                    child: CustomTextField(
                      // contentPadding:
                      //     EdgeInsets.symmetric(horizontal: 10, vertical: 30),
                      controller: address_Controller,
                      hintText: "Address",
                      minLines: 5,
                      maxLines: 10,
                      validator: (String? value) {
                        return (value == null || value.isEmpty)
                            ? 'Please enter a address'
                            : null;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  InkWell(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        try {
                          DateTime parsedDate = DateFormat('dd-MM-yyyy')
                              .parse(date_Controller.text);

                          String formattedDate =
                              DateFormat('yyyy-MM-dd').format(parsedDate);

                          provider.editprofileData(
                              name_Controller.text,
                              phone_controller.text,
                              email_Controller.text,
                              selectedGender,
                              formattedDate,
                              address_Controller.text,
                              context);
                          // Navigator.pop(context);
                          // log("edit success");
                        } catch (e) {
                          print("Invalid date format: $e");
                        }
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
  Future selectDate(
      BuildContext context, TextEditingController controller) async {
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
    }
  }
}
