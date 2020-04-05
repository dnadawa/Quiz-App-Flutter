import 'package:flutter/material.dart';
import 'package:quizapp/data/question-list.dart';
import 'package:quizapp/widgets/button.dart';
import 'package:quizapp/widgets/question-input.dart';
import 'package:quizapp/widgets/toast.dart';
import 'package:quizapp/widgets/white-text.dart';

class NewQuestion extends StatefulWidget {
  final QuestionList x;
  final int no;

  const NewQuestion({Key key, this.x, this.no}) : super(key: key);
  @override
  _NewQuestionState createState() => _NewQuestionState();
}

class _NewQuestionState extends State<NewQuestion> {

  String status;
  bool ans1,ans3,ans4,ans2;
  TextEditingController mcqQ = TextEditingController();
  TextEditingController mcqA1 = TextEditingController();
  TextEditingController mcqA2 = TextEditingController();
  TextEditingController mcqA3 = TextEditingController();
  TextEditingController mcqA4 = TextEditingController();
  TextEditingController mcqA5 = TextEditingController();
  TextEditingController singleQ = TextEditingController();
  TextEditingController singleA = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    status = 'mcq';
    ans1 = false;
    ans2 = false;
    ans3 = false;
    ans4 = false;
    //status = 'MCQ with 4 Answers';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: CustomText(text: 'New Question',size: 20,),
      ),

      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage('images/back.png'),fit: BoxFit.fill),
        ),

      child: Column(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15)
                ),

              child: SingleChildScrollView(
                child: Column(

                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(30),
                      child: DropdownButton(
                        isExpanded: true,

                        items: [
                          DropdownMenuItem(child: CustomText(text: 'MCQ allowing one selection',color: Colors.black,),value: 'mcq',),
                          DropdownMenuItem(child: CustomText(text: 'MCQ allowing more than one selection',color: Colors.black,),value: 'mcq2options',),
                          DropdownMenuItem(child: CustomText(text: 'MCQ with an other option to write your own',color: Colors.black,),value: 'mcq5',),
                          DropdownMenuItem(child: CustomText(text: 'Write Answer',color: Colors.black,),value: 'write',),
                        ],onChanged:(newValue){
                        setState(() {
                          status = newValue;
                        });
                      },
                        value: status,
                      ),
                    ),




                    status=='mcq'||status=='mcq2options'||status=='mcq5'?
                    Column(
                      children: <Widget>[
                        CustomText(text: 'Please tick the box infront of the correct answer!',color: Colors.black,size: 20,align: TextAlign.center,),

                        Padding(
                          padding: const EdgeInsets.fromLTRB(20,20,20,0),
                          child: QuestionInputField(text: 'Question',controller: mcqQ,),
                        ),

                        Padding(
                          padding: const EdgeInsets.fromLTRB(20,20,20,0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Expanded(child: QuestionInputField(text: 'Answer 1',controller: mcqA1,)),
                              Checkbox(value: ans1, onChanged: (x){
                                setState(() {
                                  ans1 = x;
                                });
                              })
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20,20,20,0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Expanded(child: QuestionInputField(text: 'Answer 2',controller: mcqA2,)),
                              Checkbox(value: ans2, onChanged: (x){
                                setState(() {
                                  ans2 = x;
                                });
                              })
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20,20,20,0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Expanded(child: QuestionInputField(text: 'Answer 3',controller: mcqA3,)),
                              Checkbox(value: ans3, onChanged: (x){
                                setState(() {
                                  ans3 = x;
                                });
                              })
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20,20,20,0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Expanded(child: QuestionInputField(text: 'Answer 4',controller: mcqA4,)),
                              Checkbox(value: ans4, onChanged: (x){
                                setState(() {
                                  ans4 = x;
                                });
                              })
                            ],
                          ),
                        ),
                      ],
                    ):SizedBox.shrink(),

                    status=='mcq5'?
                    Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: CustomText(text: 'If not from above please write the correct answer',color: Colors.black,size: 20,align: TextAlign.center,),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20,0,20,10),
                          child: QuestionInputField(text: 'Correct Answer',controller: mcqA5,),
                        )
                      ],
                    ):SizedBox.shrink(),

                    status=='write'?
                    Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20,20,20,0),
                          child: QuestionInputField(text: 'Question',controller: singleQ,),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20,20,20,0),
                          child: QuestionInputField(text: 'Answer',controller: singleA,),
                        ),
                      ],
                    ):SizedBox.shrink()

                  ],
                ),
              ),

              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(20,0,20,10),
            child: Button(
              text: 'Add',
              onclick: (){

                if(status=='mcq'){

                    if(ans1==false&&ans2==false&&ans3==false&&ans4==false){
                      ToastBar(text: 'Please tick the correct answer',color: Colors.red).show();
                    }
                    else{
                      mcqWithOneAnswer();
                    }

                }

                else if(status=='mcq2options'){
                  if(ans1==false&&ans2==false&&ans3==false&&ans4==false){
                    ToastBar(text: 'Please tick the correct answer',color: Colors.red).show();
                  }
                  else{
                    mcqWithTwoAnswer();
                  }
                }

                else if(status=='mcq5'){

                  if(ans1==false&&ans2==false&&ans3==false&&ans4==false&&mcqA5.text==''){
                    ToastBar(text: 'Please tick the correct answer OR write the correct answer in the box',color: Colors.red).show();
                  }
                  else{
                    mcqWithAdditionalAnswer();
                  }

                }

                else{
                  if(singleA.text==''&&singleQ.text==''){
                    ToastBar(text: 'Please type the correct answer',color: Colors.red).show();
                  }
                  else{
                    singleAnswer();
                  }
                }

                },

            ),
          )

        ],
      ),

      ),

    );
  }


  mcqWithOneAnswer(){
    String correct;
    if(ans1==true){
      correct = '1';
    }
    else if(ans2==true){
      correct = '2';
    }
    else if(ans3==true){
      correct = '3';
    }
    else{
      correct = '4';
    }


    widget.x.add(widget.no.toString(),{
      'type': 'mcq',
      'Q': mcqQ.text,
      'A1': mcqA1.text,
      'A2': mcqA2.text,
      'A3': mcqA3.text,
      'A4': mcqA4.text,
      'correct': correct
    });

    Navigator.pop(context);
  }

  mcqWithTwoAnswer(){
    List<String> correct = [];
    if(ans1==true){
      correct.add('1');
    }
    if(ans2==true){
      correct.add('2');
    }
    if(ans3==true){
      correct.add('3');
    }
    if(ans4==true){
      correct.add('4');
    }



    widget.x.add(widget.no.toString(),{
      'type': 'mcq2options',
      'Q': mcqQ.text,
      'A1': mcqA1.text,
      'A2': mcqA2.text,
      'A3': mcqA3.text,
      'A4': mcqA4.text,
      'correct': correct
    });

    Navigator.pop(context);
  }

  singleAnswer(){
    widget.x.add(widget.no.toString(),{
      'type': 'single',
      'Q': singleQ.text,
      'correct': singleA.text.toLowerCase()
    });

    Navigator.pop(context);
  }

  mcqWithAdditionalAnswer(){
    String correct;
    if(ans1==true){
      correct = '1';
    }
    else if(ans2==true){
      correct = '2';
    }
    else if(ans3==true){
      correct = '3';
    }
    else if(ans4==true){
      correct = '4';
    }
    else if(mcqA5.text!=''){
      correct = mcqA5.text.toLowerCase();
    }


    widget.x.add(widget.no.toString(),{
      'type': 'mcq5',
      'Q': mcqQ.text,
      'A1': mcqA1.text,
      'A2': mcqA2.text,
      'A3': mcqA3.text,
      'A4': mcqA4.text,
      'correct': correct
    });

    Navigator.pop(context);
  }




}
//onclick: (){
//widget.x.add(widget.no.toString(),{
//'Question ${widget.no}': 'Hello',
//'Answer ${widget.no}': 'World',
//});
//Navigator.pop(context);
//},