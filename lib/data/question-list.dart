import 'dart:async';

class QuestionList{



  final Map<String,Map> questions = {};

  add(String no, Map data){
    this.questions['Q$no'] = data;
    print('Data added!');
    print(questions);
  }

  Map<String,Map> getData(){
    return questions;
  }

}

