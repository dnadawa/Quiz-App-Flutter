import 'package:flutter/material.dart';

class QuestionInputField extends StatelessWidget {
  final String text;
  final TextEditingController controller;

  const QuestionInputField({Key key, this.text, this.controller}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Theme.of(context).accentColor,
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 15),
        child: Center(
          child: TextField(
            controller: controller,
            style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),
            decoration: new InputDecoration.collapsed(
                hintText: text,
                hintStyle:TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20)
            ),
          ),
        ),
      ),
    );
  }
}
