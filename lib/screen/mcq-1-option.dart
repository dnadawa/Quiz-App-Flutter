import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quizapp/screen/answer-screen.dart';
import 'package:quizapp/screen/summary.dart';
import 'package:quizapp/widgets/route-animation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/button.dart';
import '../widgets/white-text.dart';

class Mcq extends StatefulWidget {
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

  const Mcq({Key key, this.q, this.a1, this.a2, this.a3, this.a4, this.answer, this.qNo, this.quizName, this.no, this.qLength}) : super(key: key);


  @override
  _McqState createState() => _McqState();
}

class _McqState extends State<Mcq> {
  String selectedRadio;

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

          Padding(
            padding: const EdgeInsets.all(20),
            child: Button(text: 'Next',onclick: () async {
              if(widget.no==widget.qLength){
                Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context){
                  return Summary(totQuestions: widget.qLength,qname: widget.quizName,);}));
              }
              else{
                SharedPreferences prefs = await SharedPreferences.getInstance();
                var answers = prefs.getString('answerMap');
                print(json.decode(answers));
                int y = widget.no;
                Navigator.push(context, MyCustomRoute(builder: (context){
                  return Answer(quizName: widget.quizName,no: y+1,);}));
              }
              },),
          )


        ],
      ),
    );
  }
}
