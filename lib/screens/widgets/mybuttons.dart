import 'package:flutter/material.dart';

class MyButtons extends StatelessWidget {
  VoidCallback onPressed;
  String text;
  double? width;

  MyButtons({Key? key, required this.onPressed, required this.text,this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.08,
      width: width,
      child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            primary: const Color(0xffFF6480),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(35.0),
            ),
          ),
          child: Text(
            text,
            style:
                const TextStyle(fontSize: 16, color: Colors.white, fontFamily: "Poppins", fontWeight: FontWeight.bold),
          )),
    );
  }
}
