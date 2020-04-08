import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quizapp/screen/answer-screen.dart';
import 'package:quizapp/screen/summary.dart';
import 'package:quizapp/widgets/button.dart';
import 'package:quizapp/widgets/question-input.dart';
import 'package:quizapp/widgets/route-animation.dart';
import 'package:quizapp/widgets/white-text.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SingleAnswer extends StatefulWidget {
  final String q;
  final String answer;
  final String qNo;
  final String quizName;
  final int qLength;
  final int no;

  const SingleAnswer({Key key, this.answer, this.qNo, this.quizName, this.no, this.q, this.qLength}) : super(key: key);


  @override
  _SingleAnswerState createState() => _SingleAnswerState();
}

class _SingleAnswerState extends State<SingleAnswer> {
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white
      ),
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Theme.of(context).accentColor,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: CustomText(text: widget.q,align: TextAlign.center,size: 20,),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(10),
            child: QuestionInputField(text: 'Type Answer',),
          ),

          Padding(
            padding: const EdgeInsets.all(20),
            child: Button(text: 'Next',onclick: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              String myMapString;
              var myMap;
              setState(() {
                myMapString = prefs.getString('answerMap');
                if (myMapString != null) {
                  myMap = json.decode(myMapString);
                  if (controller.text.toLowerCase() == widget.answer) {
                    myMap[widget.qNo] = 'correct';
                    prefs.setString('answerMap', json.encode(myMap));
                  }
                  else {
                    myMap[widget.qNo] = 'incorrect';
                    prefs.setString('answerMap', json.encode(myMap));
                  }
                }
                else {
                  if (controller.text.toLowerCase() == widget.answer) {
                    prefs.setString('answerMap', json.encode(
                        {widget.qNo: 'correct'}));
                  }
                  else {
                    prefs.setString('answerMap', json.encode(
                        {widget.qNo: 'incorrect'}));
                  }
                }
              });



              if (widget.no == widget.qLength) {
                Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context) {
                  return Summary(totQuestions: widget.qLength,qname: widget.quizName);
                }));
              }

              else {
                var answers = prefs.getString('answerMap');
                print(json.decode(answers));
                int y = widget.no;
                Navigator.push(context, MyCustomRoute(builder: (context) {
                  return Answer(quizName: widget.quizName, no: y + 1,);
                }));
              }

            }
    ),
          )


        ],
      ),
    );
  }
}
