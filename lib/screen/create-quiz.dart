import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quizapp/data/question-list.dart';
import 'package:quizapp/screen/home.dart';
import 'package:quizapp/screen/new-question.dart';
import 'package:quizapp/screen/view-quiz.dart';
import 'package:quizapp/widgets/button.dart';
import 'package:quizapp/widgets/inputfield.dart';
import 'package:quizapp/widgets/toast.dart';
import 'package:quizapp/widgets/white-text.dart';
import 'package:shared_preferences/shared_preferences.dart';


class CreateQuiz extends StatefulWidget {
  @override
  _CreateQuizState createState() => _CreateQuizState();
}

class _CreateQuizState extends State<CreateQuiz> {
  QuestionList q = QuestionList();
  int no = 0;
  Map<String,Map> questions;
  TextEditingController quizName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: CustomText(text: 'Create Quiz',size: 20,),
      ),

      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage('images/back.png'),fit: BoxFit.fitWidth),
        ),

        child: Padding(
          padding: const EdgeInsets.fromLTRB(20,5,20,10),
          child: Column(
            children: <Widget>[
              InputField(
                quiz: true,
                controller: quizName,
                hint: 'Enter Quiz Name',
                type: TextInputType.text,
              ),
              SizedBox(height: 15,),
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15)
                  ),
                  
                  child: Stack(
                    children: <Widget>[
                      ListView.builder(
                        itemCount: questions!=null?questions.length:0,
                        itemBuilder: (context,i){
                          return Padding(
                            padding: const EdgeInsets.fromLTRB(20,10,20,0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Theme.of(context).accentColor
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: CustomText(text: questions['Q${i+1}']['Q'].toString(),size: 20,align: TextAlign.center,),
                              ),
                            ),
                          );
                        },
                      ),

                      Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: FloatingActionButton(
                            backgroundColor: Colors.black,
                            splashColor: Theme.of(context).primaryColor,
                            child: Icon(Icons.add),
                            onPressed: (){
                              setState(() {
                                questions = q.getData();
                              });
                              no++;
                              Navigator.push(context, CupertinoPageRoute(builder: (context){
                                return NewQuestion(x: q,no: no,);}));

                            },
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Button(
                text: 'Submit Quiz',
                onclick: () async {
                  if(quizName.text!=''){
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    var email = prefs.getString('email');
                    Map<String,Map> newMap = questions;
                    newMap['details'] = {'user': email,'name': quizName.text};
                    print(newMap);
                    try{
                      Firestore.instance.collection('quiz').document(quizName.text).setData(newMap);
                      ToastBar(color: Colors.green,text: 'Quiz Submitted!').show();

                      Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context){
                        return Home();}));


                    }
                    catch(e){
                      ToastBar(color: Colors.red,text: 'Something went wrong!').show();
                    }
                  }
                  else{
                    ToastBar(color: Colors.red,text: 'Please add the Quiz Name').show();
                  }
                  },
              )
            ],
          ),
        ),

      ),

    );
  }
}
