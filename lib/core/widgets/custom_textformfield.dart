import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool isPassword;
  final String? Function(String?)? validator;
  final VoidCallback? onTap;
  final Widget? suffixIcon;
  final EdgeInsetsGeometry? contentPadding;

  const CustomTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.isPassword = false,
    this.validator,
    this.onTap,
    this.suffixIcon,
    this.contentPadding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool obscureText = isPassword;

    return StatefulBuilder(
      builder: (context, setState) {
        return TextFormField(
          onTap: () {},
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            contentPadding: contentPadding == null
                ? EdgeInsets.symmetric(vertical: 10, horizontal: 10)
                : contentPadding,
            hintText: hintText,
            suffixIcon: isPassword
                ? GestureDetector(
                    onTap: () {
                      setState(() {
                        obscureText = !obscureText;
                      });
                    },
                    child: Icon(
                      obscureText ? Icons.visibility : Icons.visibility_off,
                    ),
                  )
                : suffixIcon,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          validator: validator,
        );
      },
    );
  }
}
