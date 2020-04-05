import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quizapp/widgets/button.dart';
import 'package:quizapp/widgets/white-text.dart';


class FrontSummary extends StatefulWidget {
  final int totQuestions;
  final int correct;
  final int incorrect;
  final int score;
  final int answered;

  const FrontSummary({Key key, this.totQuestions,this.correct, this.incorrect, this.score, this.answered}) : super(key: key);


  @override
  _FrontSummaryState createState() => _FrontSummaryState();
}

class _FrontSummaryState extends State<FrontSummary> {

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
                        CustomText(text: widget.answered.toString(),size: 20,)
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
                        CustomText(text: widget.correct.toString(),size: 20,)
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
                        CustomText(text: widget.incorrect.toString(),size: 20,)
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
                        CustomText(text: widget.score.toString(),size: 20,)
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(30),
              child: Button(text: 'OK',onclick: () async {
               Navigator.pop(context);
              },),
            )
          ],
        ),



      ),

    );
  }
}
