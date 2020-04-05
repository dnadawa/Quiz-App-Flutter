import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quizapp/screen/answer-screen.dart';
import 'package:quizapp/screen/front-summary.dart';
import 'package:quizapp/widgets/white-text.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ViewQuiz extends StatefulWidget {
  @override
  _ViewQuizState createState() => _ViewQuizState();
}

class _ViewQuizState extends State<ViewQuiz> {
  List availiableQuizList;
  var availiableQuizSub;

  List<DocumentSnapshot> oldQuizList;
  var oldQuizSub;

  List<DocumentSnapshot> scoreList;
  var scoreSub;
  var score = 0;
  List newQuizList = [];
  List newQuizList2 = [];

getData() async {
  SharedPreferences prefs  = await SharedPreferences.getInstance();
  var email = prefs.getString('email');
  scoreSub = await Firestore.instance.collection('score').where('email', isEqualTo: email).getDocuments();
  scoreList = scoreSub.documents;
  setState(() {
    score = scoreList[0].data['score'];
  });

  availiableQuizSub = await Firestore.instance.collection('quiz').getDocuments();
  await setState(() {
    availiableQuizList = availiableQuizSub.documents;
  });




  oldQuizSub = await Firestore.instance.collection('taken').where('email', isEqualTo: email).getDocuments();
  await setState(() {
    oldQuizList = oldQuizSub.documents;
  });
  checkAvailibility();

}


  checkAvailibility(){
    print(availiableQuizList[0].data);

    for(int i=0;i<availiableQuizList.length;i++){
      setState(() {
        newQuizList2.add(availiableQuizList[i].documentID);
        newQuizList.add(availiableQuizList[i].documentID);
      });
    }


    for(int j=0;j<oldQuizList.length;j++){
      if(newQuizList2.contains(oldQuizList[j]['name'])){
        print('containing ${oldQuizList[j]['name']}');
        setState(() {
          newQuizList.remove(oldQuizList[j]['name']);
        });

      }
    }

  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  //Timer(Duration(seconds: 3), ()=>checkAvailibility());

}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: CustomText(text: 'Home',size: 20,),
      ),

      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage('images/back.png'),fit: BoxFit.fitWidth),
        ),

        child: Column(
          children: <Widget>[
            Container(width: double.infinity,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: CustomText(text: 'Total Score',size: 25,),
                ),
                CircleAvatar(backgroundColor: Colors.white,child: CustomText(text: score.toString(),size: 20,color: Colors.black,),)
              ],
            ),

            Expanded(
              child: Container(
                margin: EdgeInsets.all(15),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15)
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CustomText(text: 'Availiable Quizes',color: Colors.black,size: 20,),
                  newQuizList!=null?
                  newQuizList.isNotEmpty?
                  CarouselSlider.builder(
                      itemCount: newQuizList.length!=null?newQuizList.length:0,
                      autoPlay: true,
                      enlargeCenterPage: true,
                      itemBuilder: (context,i){
                        String quizName = newQuizList[i];

                    return Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: GestureDetector(
                        onTap: (){
                          Navigator.push(context, CupertinoPageRoute(builder: (context){
                            return Answer(quizName: quizName,);}));
                        },
                        child: Container(
                          width: double.infinity,
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Theme.of(context).accentColor,
                          ),
                          child: Center(child: CustomText(text: quizName,size: 25,align: TextAlign.center,)),
                        ),
                      ),
                    );
                  }
                  )
                  :Container(
                      width: double.infinity,
                      height: 200,
                      child: Center(child: CustomText(text: 'No Data',color: Colors.black,size: 20,align: TextAlign.center,)))
                  :Center(child: CircularProgressIndicator(),)
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.all(15),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15)
                ),
                child: Column(
                  children: <Widget>[
                    CustomText(text: 'Old Quizes',color: Colors.black,size: 20,),
                    oldQuizList!=null?
                    oldQuizList.isNotEmpty?
                    CarouselSlider.builder(
                        itemCount: oldQuizList.length!=null?oldQuizList.length:0,
                        autoPlay: true,
                        enlargeCenterPage: true,
                        itemBuilder: (context,i){
                          String quizName = oldQuizList[i]['name'];
                          var singleScore = oldQuizList[i]['score'];
                          var answered = oldQuizList[i]['answered'];
                          var correct = oldQuizList[i]['correct'];
                          var incorrect = oldQuizList[i]['incorrect'];
                          var question = oldQuizList[i]['questions'];

                          return Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: GestureDetector(
                              onTap: (){
                                Navigator.push(context, CupertinoPageRoute(builder: (context) {
                                  return FrontSummary(score: singleScore,totQuestions: question,answered: answered,correct: correct,incorrect: incorrect,);
                                }));
                              },
                              child: Container(
                                width: double.infinity,
                                margin: EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Theme.of(context).accentColor,
                                ),
                                child: Center(child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    CustomText(text: quizName,size: 25,align: TextAlign.center,),
                                    SizedBox(height: 20,),
                                    CircleAvatar(
                                      backgroundColor: Colors.white,
                                      child: CustomText(text: singleScore.toString(),size: 20,color: Colors.black,),
                                    )
                                  ],
                                )),
                              ),
                            ),
                          );
                        }
                    )
                        :Container(
                        width: double.infinity,
                        height: 200,
                        child: Center(child: CustomText(text: 'No Data',color: Colors.black,size: 20,align: TextAlign.center,)))
                        :
                        Container(
                            height: 200,
                            child: Center(child: CircularProgressIndicator(),))
                  ],
                ),
              ),
            ),
          ],
        ),

      ),

    );
  }
}
