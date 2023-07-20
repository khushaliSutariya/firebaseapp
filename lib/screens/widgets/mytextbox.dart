import 'package:flutter/material.dart';

class MyTextBox extends StatelessWidget {
  GestureTapCallback onTap;
  String? hintText;
  Widget? prefix;
  Widget? suffixIcon;
  TextEditingController? controller;
  TextInputType keyboardType;
  FormFieldValidator validator;
  MyTextBox(
      {Key? key,
      this.hintText,
      required this.onTap,
      this.controller,
        this.suffixIcon,
      required this.validator,
      required this.keyboardType,
      this.prefix})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      onTap: onTap,
      validator: validator,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: prefix,
        suffixIcon: suffixIcon,
        hintStyle: const TextStyle(fontFamily: "Poppins",fontSize: 12.0,color: Color(0xffA8A8A8),fontWeight: FontWeight.w600),
        fillColor: const Color(0xffFC6281),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xffFC6281), width: 2.0),
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xffFC6281), width: 2.0),
        ),
      ),
    );
  }
}
