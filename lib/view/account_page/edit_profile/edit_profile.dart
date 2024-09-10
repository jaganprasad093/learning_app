import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:learning_app/controller/edit_controller.dart';
import 'package:learning_app/core/constants/color_constants.dart';
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
  // final GlobalKey _menuKey = GlobalKey();
  var profile_pic;
  // File? _imageFile;

  @override
  void initState() {
    init();
    super.initState();
  }

  init() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Initialize the controllers with stored values
    name_Controller.text = prefs.getString("name") ?? "";
    var mobile = prefs.getString("mobile") ?? "";
    if (mobile.startsWith("+91")) {
      return mobile = mobile.substring(3);
    }
    phone_controller.text = mobile;
    email_Controller.text = prefs.getString("email") ?? "";
    selectedGender = prefs.getString("gender");
    address_Controller.text = prefs.getString("address") ?? "";

    profile_pic = prefs.getString("profile_pic");
    log("adress--${prefs.getString("address")}");
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
    // log("pick image--$_imageFile");
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
    var provider = context.watch<EditController>();
    var _imageFile = provider.imageFile;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Edit profile",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
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
                  child: Stack(children: [
                    CircleAvatar(
                      backgroundImage: profile_pic == null ||
                              profile_pic.isEmpty
                          ? NetworkImage(
                              "https://i0.wp.com/florrycreativecare.com/wp-content/uploads/2020/08/blank-profile-picture-mystery-man-avatar-973460.jpg?ssl=1")
                          : _imageFile == null
                              ? NetworkImage(profile_pic)
                              : FileImage(File(_imageFile!.path)),
                      radius: 60,
                      // backgroundColor: Colors.grey.withOpacity(0.6),
                    ),
                    Positioned(
                        bottom: 5,
                        right: 1,
                        child: InkWell(
                          onTapDown: (details) {
                            showbuttonMenu(context, details.globalPosition);
                          },
                          child: Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color:
                                  ColorConstants.primary_black.withOpacity(.5),
                            ),
                            child: Icon(
                              Icons.edit,
                              size: 16,
                              color: Colors.white,
                            ),
                          ),
                        )),
                  ]),
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
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
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
                DropdownButtonFormField<String>(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    focusedBorder: OutlineInputBorder(),
                    hintText: "Select gender",
                    hintStyle: TextStyle(
                      textBaseline: TextBaseline.alphabetic,
                      height: 2,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  value:
                      selectedGender != null && gender.contains(selectedGender)
                          ? selectedGender
                          : null,
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
                        ? 'Select gender'
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
                        ? 'Select date of birth'
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
                          ? 'Enter a address'
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

                        provider.editProfileData(
                            name: name_Controller.text,
                            phone: phone_controller.text,
                            email: email_Controller.text,
                            gender: selectedGender ?? "",
                            dob: formattedDate,
                            address: address_Controller.text,
                            context: context,
                            profilePic: _imageFile);

                        // context.read<EditController>().editProfileData(
                        //     name: 'John Doe',
                        //     phone: '1234567890',
                        //     email: 'john.doe@example.com',
                        //     gender: 'Male',
                        //     dob: '1990-01-01',
                        //     address: '123 Main St',
                        //     context: context,
                        //     // profilePic:
                        //     profilePic: _imageFile);

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
                      child: provider.isLoading
                          ? CircularProgressIndicator(
                              color: ColorConstants.primary_white,
                            )
                          : Text(
                              "Update profile",
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
    );
  }

  void showbuttonMenu(BuildContext context, Offset offset) {
    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;

    final double menuWidth = 200;
    final double menuHeight = 100; // Set a height for the menu (optional)

    final double rightPosition = MediaQuery.of(context).size.width - 40;
    final double topPosition = offset.dy;
    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        rightPosition,
        topPosition,
        MediaQuery.of(context).size.width - rightPosition, // Right side
        MediaQuery.of(context).size.height - topPosition, // Bottom side
      ),
      items: [
        PopupMenuItem(
          child: Text("Gallery"),
          value: 'gallery',
        ),
        PopupMenuItem(
          child: Text(
            "Camera",
          ),
          value: 'camera',
        ),
      ],
    ).then((value) {
      if (value == 'gallery') {
        context.read<EditController>().pickImage();
      } else if (value == 'camera') {
        context.read<EditController>().captureImage();
      }
    });
  }

  DateTime selectedDate = DateTime(2015, 12, 31);

  Future<void> selectDate(
    BuildContext context,
    TextEditingController controller,
  ) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2015, 12, 31),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.blue,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.blue,
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        String formattedDate =
            "${picked.day.toString().padLeft(2, '0')}-${picked.month.toString().padLeft(2, '0')}-${picked.year.toString()}";
        controller.value = TextEditingValue(text: formattedDate);
      });
    } else {
      String formattedDate =
          "${selectedDate.day.toString().padLeft(2, '0')}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.year.toString()}";
      controller.value = TextEditingValue(text: formattedDate);
    }
  }
}
