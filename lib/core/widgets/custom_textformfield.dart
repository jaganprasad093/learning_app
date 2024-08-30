// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:learning_app/core/constants/color_constants.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool isPassword;
  final String? Function(String?)? validator;
  final VoidCallback? onTap;
  final Widget? suffixIcon;
  final EdgeInsetsGeometry? contentPadding;
  final Widget? prefix;
  final String? prefixText;
  final String? errorText;
  final TextInputType? keyboardType;
  final int? maxLength;
  final int? minLines;
  final bool? readOnly;
  bool? enabled;
  final int? maxLines;

  CustomTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.isPassword = false,
    this.validator,
    this.onTap,
    this.suffixIcon,
    this.contentPadding,
    this.prefix,
    this.prefixText,
    this.errorText,
    this.keyboardType,
    this.maxLength,
    this.minLines,
    this.readOnly,
    this.enabled,
    this.maxLines,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool obscureText = isPassword;

    return StatefulBuilder(
      builder: (context, setState) {
        return TextFormField(
          maxLines: isPassword ? 1 : maxLines,
          enabled: enabled,
          readOnly: readOnly ?? false,
          onTap: onTap,
          controller: controller,
          obscureText: obscureText,
          maxLength: maxLength,
          minLines: minLines,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: ColorConstants.primary_black.withOpacity(.5),
                )),
            prefixIcon: prefix,
            counterText: "",
            errorText: errorText,
            contentPadding: contentPadding == null
                ? EdgeInsets.symmetric(vertical: 10, horizontal: 10)
                : contentPadding,
            hintText: hintText,
            prefixText: prefixText,
            // isDense: true,
            prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
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
