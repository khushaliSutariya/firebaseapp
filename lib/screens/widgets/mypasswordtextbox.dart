import 'package:flutter/material.dart';
class MyPasswordTextBox extends StatefulWidget{
  TextEditingController? passcontroller;
  FormFieldValidator passvalidator;
  String passhintText;
  TextInputType keyboardType;
  MyPasswordTextBox({super.key, required this.passcontroller,required this.passvalidator,required this.keyboardType,required this.passhintText});
  @override
  State<MyPasswordTextBox> createState() => _MyPasswordTextBoxState();
}

class _MyPasswordTextBoxState extends State<MyPasswordTextBox> {
  bool _passwordVisible = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xffFFFFFF),
      child: TextFormField(
        validator: widget.passvalidator,
        controller: widget.passcontroller,
        obscureText: _passwordVisible,
        keyboardType: widget.keyboardType,
        decoration: InputDecoration(
          hintText: widget.passhintText,
          hintStyle: const TextStyle(fontFamily: "Poppins"),
          fillColor: const Color(0xffFF6480),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xffFF6480), width: 2.0),
          ),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xffFF6480), width: 2.0),
          ),
          suffixIcon: IconButton(
            icon: Icon(
              _passwordVisible
                  ? Icons.visibility
                  : Icons.visibility_off,
              color: const Color(0xffC0C0C0),
            ),
            onPressed: () {
              setState(() {
                _passwordVisible = !_passwordVisible;
              });
            },
          ),
        ),
      ),
    );
  }

}
