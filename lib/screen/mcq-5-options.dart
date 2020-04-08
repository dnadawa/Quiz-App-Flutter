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


class Mcq5Options extends StatefulWidget {
  final String q;
  final String a1;
  final String a2;
  final String a3;
  final String a4;
  final String answer;
  final String qNo;
  final String quizName;
  final int qLength;
  final int no;

  const Mcq5Options({Key key, this.q, this.a1, this.a2, this.a3, this.a4, this.answer, this.qNo, this.quizName, this.no, this.qLength}) : super(key: key);


  @override
  _Mcq5OptionsState createState() => _Mcq5OptionsState();
}

class _Mcq5OptionsState extends State<Mcq5Options> {
  String selectedRadio;
  TextEditingController controller = TextEditingController();

  setSelectedRadio(String val) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String myMapString;
    var myMap;
    setState(() {
      selectedRadio = val;
      print(selectedRadio);
      myMapString = prefs.getString('answerMap');

      if(myMapString!=null){
        myMap = json.decode(myMapString);
        if(selectedRadio==widget.answer){
          myMap[widget.qNo] = 'correct';
          prefs.setString('answerMap', json.encode(myMap));
        }
        else{
          myMap[widget.qNo] = 'incorrect';
          prefs.setString('answerMap', json.encode(myMap));
        }
      }
      else{
        if(selectedRadio==widget.answer){
          prefs.setString('answerMap', json.encode({widget.qNo : 'correct'}));
        }
        else{
          prefs.setString('answerMap', json.encode({widget.qNo : 'incorrect'}));
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white
      ),
      child: SingleChildScrollView(
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

            Row(
              children: <Widget>[
                Radio(value: '1', groupValue: selectedRadio, onChanged: (value){
                  setSelectedRadio(value);
                }),
                SizedBox(
                    width: MediaQuery.of(context).size.width-90,
                    child: Text(widget.a1,style: TextStyle(fontWeight: FontWeight.w900),))
              ],
            ),
            Row(
              children: <Widget>[
                Radio(value: '2', groupValue: selectedRadio, onChanged: (value){
                  setSelectedRadio(value);
                }),
                SizedBox(
                    width: MediaQuery.of(context).size.width-90,
                    child: Text(widget.a2,style: TextStyle(fontWeight: FontWeight.w900),))
              ],
            ),
            Row(
              children: <Widget>[
                Radio(value: '3', groupValue: selectedRadio, onChanged: (value){
                  setSelectedRadio(value);
                }),
                SizedBox(
                    width: MediaQuery.of(context).size.width-90,
                    child: Text(widget.a3,style: TextStyle(fontWeight: FontWeight.w900),))
              ],
            ),
            Row(
              children: <Widget>[
                Radio(value: '4', groupValue: selectedRadio, onChanged: (value){
                  setSelectedRadio(value);
                }),
                SizedBox(
                    width: MediaQuery.of(context).size.width-90,
                    child: Text(widget.a4,style: TextStyle(fontWeight: FontWeight.w900),))
              ],
            ),

            CustomText(text: 'If the above answers are incorrect write correct answer in below box',color: Colors.black,align: TextAlign.center,),

            Padding(
              padding: const EdgeInsets.fromLTRB(20,20,20,0),
              child: QuestionInputField(text: 'Type Answer',controller: controller,),
            ),

            Padding(
              padding: const EdgeInsets.all(20),
              child: Button(text: 'Next',onclick: () async {

                SharedPreferences prefs = await SharedPreferences.getInstance();
                String myMapString;
                var myMap;
                myMapString = prefs.getString('answerMap');
                if (widget.answer != '1' && widget.answer != '2' &&
                    widget.answer != '3' && widget.answer != '4') {
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
                      prefs.setString('answerMap', json.encode({widget
                          .qNo: 'correct'}));
                    }
                    else {
                      prefs.setString('answerMap', json.encode({widget
                          .qNo: 'incorrect'}));
                    }
                  }
                }

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
      ),
    );
  }
}
