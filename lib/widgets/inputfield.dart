import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final textStyle = TextStyle(
  fontWeight: FontWeight.bold,
  color: Colors.white,
);

class InputField extends StatelessWidget {

  final String hint;
  final TextInputType type;
  final bool ispassword;
  final Widget suffix;
  final TextEditingController controller;
  final bool quiz;

  const InputField({Key key, this.hint, this.type, this.ispassword=false, this.controller, this.suffix, this.quiz=false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  quiz==false?EdgeInsets.only(top: 20):EdgeInsets.all(0),
      child: TextField(
        style: textStyle,
        cursorColor: Colors.white,
        keyboardType: type,
        controller: controller,
        obscureText: ispassword,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: textStyle,
          suffix: suffix,
          enabledBorder:UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 2),
              borderRadius: BorderRadius.circular(10)
          ),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 5),
              borderRadius: BorderRadius.circular(10)
          ),

        ),
      ),
    );
  }
}