import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quizapp/screen/home.dart';
import 'package:quizapp/widgets/button.dart';
import 'package:quizapp/widgets/toast.dart';
import 'package:quizapp/widgets/white-text.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Summary extends StatefulWidget {
  final int totQuestions;
  final String qname;

  const Summary({Key key, this.totQuestions, this.qname}) : super(key: key);


  @override
  _SummaryState createState() => _SummaryState();
}

class _SummaryState extends State<Summary> {

  int correct = 0;
  int incorrect = 0;
  int score = 0;
  int answered = 0;

  calculateData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var answers = prefs.getString('answerMap');
    Map details = json.decode(answers);
    print(details.toString()+" "+details.length.toString());
    for(int i=1;i<=details.length;i++){
      if(details['Q$i']=='correct'){
        correct++;
        score++;
      }
      else{
        incorrect++;
      }
    }
    setState(() {
      answered = details.length;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
calculateData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: CustomText(text: 'Summary',size: 20,),
      ),

      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage('images/back.png'),fit: BoxFit.fill),
        ),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Theme.of(context).accentColor,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          CustomText(text: 'No of Questions',size: 20,),
                          CustomText(text: widget.totQuestions.toString(),size: 20,)
                        ],
                      ),
                    ),

                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        CustomText(text: 'Answerd',size: 20,),
                        CustomText(text: answered.toString(),size: 20,)
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        CustomText(text: 'Correct Answers',size: 20,),
                        CustomText(text: correct.toString(),size: 20,)
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        CustomText(text: 'Incorrect Answers',size: 20,),
                        CustomText(text: incorrect.toString(),size: 20,)
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        CustomText(text: 'Score',size: 20,),
                        CustomText(text: score.toString(),size: 20,)
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(30),
              child: Button(text: 'OK',onclick: () async {
                try{
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  var email = prefs.getString('email');
                  var sub = await Firestore.instance.collection('score').where('email',isEqualTo: email).getDocuments();
                  var logged = sub.documents;

                  var exScore = logged[0].data['score'];
                  var newScore = exScore + score;

                 await Firestore.instance.collection('score').document(email).updateData({
                    'score' : newScore
                  });



                  await Firestore.instance.collection('taken').add({
                    'email' : email,
                    'score' : score,
                    'questions' : widget.totQuestions,
                    'answered': answered,
                    'correct': correct,
                    'incorrect': incorrect,
                    'name' : widget.qname
                  });

                  prefs.setString('answerMap', null);

                  ToastBar(text: 'Sucess',color: Colors.green).show();

                  Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context) {
                    return Home();
                  }));

                }
                catch(e){
                  ToastBar(text: 'Something went Wrong',color: Colors.red).show();
                }




              },),
            )
          ],
        ),



      ),

    );
  }
}
