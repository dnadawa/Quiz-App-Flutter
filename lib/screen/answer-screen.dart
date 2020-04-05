import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quizapp/screen/mcq-2-options.dart';
import 'package:quizapp/screen/single.dart';
import 'package:quizapp/widgets/mcq-widget.dart';
import 'package:quizapp/widgets/white-text.dart';

import 'mcq-5-options.dart';


class Answer extends StatefulWidget {
  final String quizName;
  final int no;
   Answer({Key key, this.quizName, this.no=1}) : super(key: key);
   @override
  _AnswerState createState() => _AnswerState();
}

class _AnswerState extends State<Answer> {
  var questionList;
  List<String> typeList=[];
  getQuestions() async {
    var man = await Firestore.instance.collection('quiz').document(widget.quizName).get();
  setState(() {
    questionList = man.data;
  });

    if(questionList.length!=0){
      for(int i=1;i<=questionList.length-1;i++){
        typeList.add(questionList['Q$i']['type']);
      }
    }

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getQuestions();


    //getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: CustomText(text: widget.quizName,size: 20,),
      ),

      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage('images/back.png'),fit: BoxFit.fill),
        ),

        child: typeList.isNotEmpty?Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            typeList[widget.no-1]=='mcq'?
            ShowMcq(
              qNo: 'Q${widget.no}',
              no: widget.no,
              qLength: questionList.length-1,
              q: questionList['Q${widget.no}']['Q'],
              a1: questionList['Q${widget.no}']['A1'],
              a2: questionList['Q${widget.no}']['A2'],
              a3: questionList['Q${widget.no}']['A3'],
              a4: questionList['Q${widget.no}']['A4'],
              answer: questionList['Q${widget.no}']['correct'],
              quizName: widget.quizName,
            ):
            typeList[widget.no-1]=='single'?
                Single(
                  qNo: 'Q${widget.no}',
                  no: widget.no,
                  qLength: questionList.length-1,
                  quizName: widget.quizName,
                  q: questionList['Q${widget.no}']['Q'],
                  answer: questionList['Q${widget.no}']['correct'],
                ):
            typeList[widget.no-1]=='mcq5'?
            Mcq5Options(
              qNo: 'Q${widget.no}',
              no: widget.no,
              q: questionList['Q${widget.no}']['Q'],
              a1: questionList['Q${widget.no}']['A1'],
              a2: questionList['Q${widget.no}']['A2'],
              a3: questionList['Q${widget.no}']['A3'],
              qLength: questionList.length-1,
              a4: questionList['Q${widget.no}']['A4'],
              answer: questionList['Q${widget.no}']['correct'],
              quizName: widget.quizName,
            ): ShowMcq2Options(
              qNo: 'Q${widget.no}',
              no: widget.no,
              q: questionList['Q${widget.no}']['Q'],
              qLength: questionList.length-1,
              a1: questionList['Q${widget.no}']['A1'],
              a2: questionList['Q${widget.no}']['A2'],
              a3: questionList['Q${widget.no}']['A3'],
              a4: questionList['Q${widget.no}']['A4'],
              answer: questionList['Q${widget.no}']['correct'],
              quizName: widget.quizName,
            ),
          ],
        ):Center(child: CircularProgressIndicator()),




      ),

    );
  }
}
