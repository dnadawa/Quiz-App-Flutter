import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quizapp/screen/summary.dart';
import 'package:quizapp/widgets/button.dart';
import 'package:quizapp/widgets/route-animation.dart';
import 'package:quizapp/widgets/white-text.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'answer-screen.dart';

class ShowMcq2Options extends StatefulWidget {
  final String q;
  final int no;
  final String a1;
  final String a2;
  final String a3;
  final String a4;
  final List answer;
  final String qNo;
  final int qLength;
  final String quizName;

  const ShowMcq2Options(
      {Key key,
      this.q,
      this.a1,
      this.a2,
      this.a3,
      this.a4,
      this.answer,
      this.qNo,
      this.quizName,
      this.no, this.qLength})
      : super(key: key);

  @override
  _ShowMcq2OptionsState createState() => _ShowMcq2OptionsState();
}

class _ShowMcq2OptionsState extends State<ShowMcq2Options> {
  bool ans1, ans3, ans4, ans2;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ans1 = false;
    ans2 = false;
    ans3 = false;
    ans4 = false;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Colors.white),
      child: Column(children: <Widget>[
        Container(
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Theme.of(context).accentColor,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: CustomText(
              text: widget.q,
              align: TextAlign.center,
              size: 20,
            ),
          ),
        ),
        Row(
          children: <Widget>[
            Checkbox(
                value: ans1,
                onChanged: (x) {
                  setState(() {
                    ans1 = x;
                  });
                }),
            Text(
              widget.a1,
              style: TextStyle(fontWeight: FontWeight.w900),
            )
          ],
        ),
        Row(
          children: <Widget>[
            Checkbox(
                value: ans2,
                onChanged: (x) {
                  setState(() {
                    ans2 = x;
                  });
                }),
            Text(
              widget.a2,
              style: TextStyle(fontWeight: FontWeight.w900),
            )
          ],
        ),
        Row(
          children: <Widget>[
            Checkbox(
                value: ans3,
                onChanged: (x) {
                  setState(() {
                    ans3 = x;
                  });
                }),
            Text(
              widget.a3,
              style: TextStyle(fontWeight: FontWeight.w900),
            )
          ],
        ),
        Row(
          children: <Widget>[
            Checkbox(
                value: ans4,
                onChanged: (x) {
                  setState(() {
                    ans4 = x;
                  });
                }),
            Text(
              widget.a4,
              style: TextStyle(fontWeight: FontWeight.w900),
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Button(
            text: 'Next',
            onclick: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              String myMapString;
              var myMap;
              myMapString = prefs.getString('answerMap');

              if (myMapString != null) {
                myMap = json.decode(myMapString);
                if (ans1 == true && widget.answer.contains('1')) {
                  if (ans2 == true && widget.answer.contains('2')) {
                    if (ans3 == true && widget.answer.contains('3')) {
                      if (ans4 == true && widget.answer.contains('4')) {
                        myMap[widget.qNo] = 'correct';
                        prefs.setString('answerMap', json.encode(myMap));
                      } else if (ans4 == true && !widget.answer.contains(
                          '4')) {
                        myMap[widget.qNo] = 'incorrect';
                        prefs.setString('answerMap', json.encode(myMap));
                      } else if (ans4 == false && widget.answer.contains(
                          '4')) {
                        myMap[widget.qNo] = 'incorrect';
                        prefs.setString('answerMap', json.encode(myMap));
                      } else if (ans4 == false &&
                          !widget.answer.contains('4')) {
                        myMap[widget.qNo] = 'correct';
                        prefs.setString('answerMap', json.encode(myMap));
                      }
                    } else if (ans3 == true && !widget.answer.contains('3')) {
                      myMap[widget.qNo] = 'incorrect';
                      prefs.setString('answerMap', json.encode(myMap));
                    } else if (ans3 == false && widget.answer.contains('3')) {
                      myMap[widget.qNo] = 'incorrect';
                      prefs.setString('answerMap', json.encode(myMap));
                    } else if (ans3 == false && !widget.answer.contains(
                        '3')) {
                      if (ans4 == true && widget.answer.contains('4')) {
                        myMap[widget.qNo] = 'correct';
                        prefs.setString('answerMap', json.encode(myMap));
                      } else if (ans4 == true &&
                          !widget.answer.contains('4')) {
                        myMap[widget.qNo] = 'incorrect';
                        prefs.setString('answerMap', json.encode(myMap));
                      } else if (ans4 == false &&
                          widget.answer.contains('4')) {
                        myMap[widget.qNo] = 'incorrect';
                        prefs.setString('answerMap', json.encode(myMap));
                      } else if (ans4 == false &&
                          !widget.answer.contains('4')) {
                        myMap[widget.qNo] = 'correct';
                        prefs.setString('answerMap', json.encode(myMap));
                      }
                    }
                  } else if (ans2 == true && !widget.answer.contains('2')) {
                    myMap[widget.qNo] = 'incorrect';
                    prefs.setString('answerMap', json.encode(myMap));
                  } else if (ans2 == false && widget.answer.contains('2')) {
                    myMap[widget.qNo] = 'incorrect';
                    prefs.setString('answerMap', json.encode(myMap));
                  } else if (ans2 == false && !widget.answer.contains('2')) {
                    if (ans3 == true && widget.answer.contains('3')) {
                      if (ans4 == true && widget.answer.contains('4')) {
                        myMap[widget.qNo] = 'correct';
                        prefs.setString('answerMap', json.encode(myMap));
                      } else if (ans4 == true &&
                          !widget.answer.contains('4')) {
                        myMap[widget.qNo] = 'incorrect';
                        prefs.setString('answerMap', json.encode(myMap));
                      } else if (ans4 == false &&
                          widget.answer.contains('4')) {
                        myMap[widget.qNo] = 'incorrect';
                        prefs.setString('answerMap', json.encode(myMap));
                      } else if (ans4 == false &&
                          !widget.answer.contains('4')) {
                        myMap[widget.qNo] = 'correct';
                        prefs.setString('answerMap', json.encode(myMap));
                      }
                    } else if (ans3 == true && !widget.answer.contains('3')) {
                      myMap[widget.qNo] = 'incorrect';
                      prefs.setString('answerMap', json.encode(myMap));
                    } else if (ans3 == false && widget.answer.contains('3')) {
                      myMap[widget.qNo] = 'incorrect';
                      prefs.setString('answerMap', json.encode(myMap));
                    } else if (ans3 == false && !widget.answer.contains(
                        '3')) {
                      if (ans4 == true && widget.answer.contains('4')) {
                        myMap[widget.qNo] = 'correct';
                        prefs.setString('answerMap', json.encode(myMap));
                      } else
                      if (ans4 == true && !widget.answer.contains('4')) {
                        myMap[widget.qNo] = 'incorrect';
                        prefs.setString('answerMap', json.encode(myMap));
                      } else
                      if (ans4 == false && widget.answer.contains('4')) {
                        myMap[widget.qNo] = 'incorrect';
                        prefs.setString('answerMap', json.encode(myMap));
                      } else if (ans4 == false &&
                          !widget.answer.contains('4')) {
                        myMap[widget.qNo] = 'correct';
                        prefs.setString('answerMap', json.encode(myMap));
                      }
                    }
                  }
                } else if (ans1 == true && !widget.answer.contains('1')) {
                  myMap[widget.qNo] = 'incorrect';
                  prefs.setString('answerMap', json.encode(myMap));
                } else if (ans1 == false && widget.answer.contains('1')) {
                  myMap[widget.qNo] = 'incorrect';
                  prefs.setString('answerMap', json.encode(myMap));
                } else if (ans1 == false && !widget.answer.contains('1')) {
                  if (ans2 == true && widget.answer.contains('2')) {
                    if (ans3 == true && widget.answer.contains('3')) {
                      if (ans4 == true && widget.answer.contains('4')) {
                        myMap[widget.qNo] = 'correct';
                        prefs.setString('answerMap', json.encode(myMap));
                      } else if (ans4 == true &&
                          !widget.answer.contains('4')) {
                        myMap[widget.qNo] = 'incorrect';
                        prefs.setString('answerMap', json.encode(myMap));
                      } else if (ans4 == false &&
                          widget.answer.contains('4')) {
                        myMap[widget.qNo] = 'incorrect';
                        prefs.setString('answerMap', json.encode(myMap));
                      } else if (ans4 == false &&
                          !widget.answer.contains('4')) {
                        myMap[widget.qNo] = 'correct';
                        prefs.setString('answerMap', json.encode(myMap));
                      }
                    } else if (ans3 == true && !widget.answer.contains('3')) {
                      myMap[widget.qNo] = 'incorrect';
                      prefs.setString('answerMap', json.encode(myMap));
                    } else if (ans3 == false && widget.answer.contains('3')) {
                      myMap[widget.qNo] = 'incorrect';
                      prefs.setString('answerMap', json.encode(myMap));
                    } else if (ans3 == false && !widget.answer.contains(
                        '3')) {
                      if (ans4 == true && widget.answer.contains('4')) {
                        myMap[widget.qNo] = 'correct';
                        prefs.setString('answerMap', json.encode(myMap));
                      } else
                      if (ans4 == true && !widget.answer.contains('4')) {
                        myMap[widget.qNo] = 'incorrect';
                        prefs.setString('answerMap', json.encode(myMap));
                      } else
                      if (ans4 == false && widget.answer.contains('4')) {
                        myMap[widget.qNo] = 'incorrect';
                        prefs.setString('answerMap', json.encode(myMap));
                      } else if (ans4 == false &&
                          !widget.answer.contains('4')) {
                        myMap[widget.qNo] = 'correct';
                        prefs.setString('answerMap', json.encode(myMap));
                      }
                    }
                  } else if (ans2 == true && !widget.answer.contains('2')) {
                    myMap[widget.qNo] = 'incorrect';
                    prefs.setString('answerMap', json.encode(myMap));
                  } else if (ans2 == false && widget.answer.contains('2')) {
                    myMap[widget.qNo] = 'incorrect';
                    prefs.setString('answerMap', json.encode(myMap));
                  } else if (ans2 == false && !widget.answer.contains('2')) {
                    if (ans3 == true && widget.answer.contains('3')) {
                      if (ans4 == true && widget.answer.contains('4')) {
                        myMap[widget.qNo] = 'correct';
                        prefs.setString('answerMap', json.encode(myMap));
                      } else
                      if (ans4 == true && !widget.answer.contains('4')) {
                        myMap[widget.qNo] = 'incorrect';
                        prefs.setString('answerMap', json.encode(myMap));
                      } else
                      if (ans4 == false && widget.answer.contains('4')) {
                        myMap[widget.qNo] = 'incorrect';
                        prefs.setString('answerMap', json.encode(myMap));
                      } else if (ans4 == false &&
                          !widget.answer.contains('4')) {
                        myMap[widget.qNo] = 'correct';
                        prefs.setString('answerMap', json.encode(myMap));
                      }
                    } else if (ans3 == true && !widget.answer.contains('3')) {
                      myMap[widget.qNo] = 'incorrect';
                      prefs.setString('answerMap', json.encode(myMap));
                    } else if (ans3 == false && widget.answer.contains('3')) {
                      myMap[widget.qNo] = 'incorrect';
                      prefs.setString('answerMap', json.encode(myMap));
                    } else
                    if (ans3 == false && !widget.answer.contains('3')) {
                      if (ans4 == true && widget.answer.contains('4')) {
                        myMap[widget.qNo] = 'correct';
                        prefs.setString('answerMap', json.encode(myMap));
                      } else
                      if (ans4 == true && !widget.answer.contains('4')) {
                        myMap[widget.qNo] = 'incorrect';
                        prefs.setString('answerMap', json.encode(myMap));
                      } else
                      if (ans4 == false && widget.answer.contains('4')) {
                        myMap[widget.qNo] = 'incorrect';
                        prefs.setString('answerMap', json.encode(myMap));
                      } else if (ans4 == false &&
                          !widget.answer.contains('4')) {
                        myMap[widget.qNo] = 'correct';
                        prefs.setString('answerMap', json.encode(myMap));
                      }
                    }
                  }
                } else if (ans2 == true && !widget.answer.contains('2')) {
                  myMap[widget.qNo] = 'incorrect';
                  prefs.setString('answerMap', json.encode(myMap));
                } else if (ans3 == true && !widget.answer.contains('3')) {
                  myMap[widget.qNo] = 'incorrect';
                  prefs.setString('answerMap', json.encode(myMap));
                } else if (ans4 == true && !widget.answer.contains('4')) {
                  myMap[widget.qNo] = 'incorrect';
                  prefs.setString('answerMap', json.encode(myMap));
                } else {
                  myMap[widget.qNo] = 'correct';
                  prefs.setString('answerMap', json.encode(myMap));
                }
              }


              else {
                if (ans1 == true && widget.answer.contains('1')) {
                  if (ans2 == true && widget.answer.contains('2')) {
                    if (ans3 == true && widget.answer.contains('3')) {
                      if (ans4 == true && widget.answer.contains('4')) {
                        prefs.setString('answerMap',
                            json.encode({widget.qNo: 'correct'}));
                      } else if (ans4 == true && !widget.answer.contains(
                          '4')) {
                        prefs.setString('answerMap',
                            json.encode({widget.qNo: 'incorrect'}));
                      } else if (ans4 == false && widget.answer.contains(
                          '4')) {
                        prefs.setString('answerMap',
                            json.encode({widget.qNo: 'incorrect'}));
                      } else if (ans4 == false &&
                          !widget.answer.contains('4')) {
                        prefs.setString('answerMap',
                            json.encode({widget.qNo: 'correct'}));
                      }
                    } else if (ans3 == true && !widget.answer.contains('3')) {
                      prefs.setString('answerMap', json.encode(
                          {widget.qNo: 'incorrect'}));
                    } else if (ans3 == false && widget.answer.contains('3')) {
                      prefs.setString('answerMap', json.encode(
                          {widget.qNo: 'incorrect'}));
                    } else if (ans3 == false && !widget.answer.contains(
                        '3')) {
                      if (ans4 == true && widget.answer.contains('4')) {
                        prefs.setString('answerMap',
                            json.encode({widget.qNo: 'correct'}));
                      } else if (ans4 == true &&
                          !widget.answer.contains('4')) {
                        prefs.setString('answerMap',
                            json.encode({widget.qNo: 'incorrect'}));
                      } else if (ans4 == false &&
                          widget.answer.contains('4')) {
                        prefs.setString('answerMap',
                            json.encode({widget.qNo: 'incorrect'}));
                      } else if (ans4 == false &&
                          !widget.answer.contains('4')) {
                        prefs.setString('answerMap',
                            json.encode({widget.qNo: 'correct'}));
                      }
                    }
                  } else if (ans2 == true && !widget.answer.contains('2')) {
                    prefs.setString('answerMap', json.encode({widget
                        .qNo: 'incorrect'}));
                  } else if (ans2 == false && widget.answer.contains('2')) {
                    prefs.setString('answerMap', json.encode({
                      widget.qNo: 'incorrect'
                    }));
                  } else if (ans2 == false && !widget.answer.contains('2')) {
                    if (ans3 == true && widget.answer.contains('3')) {
                      if (ans4 == true && widget.answer.contains('4')) {
                        prefs.setString('answerMap',
                            json.encode({widget.qNo: 'correct'}));
                      } else if (ans4 == true &&
                          !widget.answer.contains('4')) {
                        prefs.setString('answerMap',
                            json.encode({widget.qNo: 'incorrect'}));
                      } else if (ans4 == false &&
                          widget.answer.contains('4')) {
                        prefs.setString('answerMap',
                            json.encode({widget.qNo: 'incorrect'}));
                      } else if (ans4 == false &&
                          !widget.answer.contains('4')) {
                        prefs.setString('answerMap',
                            json.encode({widget.qNo: 'correct'}));
                      }
                    } else if (ans3 == true && !widget.answer.contains('3')) {
                      prefs.setString('answerMap',
                          json.encode({widget.qNo: 'incorrect'}));
                    } else if (ans3 == false && widget.answer.contains('3')) {
                      prefs.setString('answerMap',
                          json.encode({widget.qNo: 'incorrect'}));
                    } else if (ans3 == false && !widget.answer.contains(
                        '3')) {
                      if (ans4 == true && widget.answer.contains('4')) {
                        prefs.setString('answerMap',
                            json.encode({widget.qNo: 'correct'}));
                      } else
                      if (ans4 == true && !widget.answer.contains('4')) {
                        prefs.setString('answerMap',
                            json.encode({widget.qNo: 'incorrect'}));
                      } else
                      if (ans4 == false && widget.answer.contains('4')) {
                        prefs.setString('answerMap',
                            json.encode({widget.qNo: 'incorrect'}));
                      } else if (ans4 == false &&
                          !widget.answer.contains('4')) {
                        prefs.setString('answerMap',
                            json.encode({widget.qNo: 'correct'}));
                      }
                    }
                  }
                } else if (ans1 == true && !widget.answer.contains('1')) {
                  prefs.setString(
                      'answerMap', json.encode({widget.qNo: 'incorrect'}));
                } else if (ans1 == false && widget.answer.contains('1')) {
                  prefs.setString('answerMap', json.encode({widget
                      .qNo: 'incorrect'}));
                } else if (ans1 == false && !widget.answer.contains('1')) {
                  if (ans2 == true && widget.answer.contains('2')) {
                    if (ans3 == true && widget.answer.contains('3')) {
                      if (ans4 == true && widget.answer.contains('4')) {
                        prefs.setString('answerMap',
                            json.encode({widget.qNo: 'correct'}));
                      } else if (ans4 == true &&
                          !widget.answer.contains('4')) {
                        prefs.setString('answerMap',
                            json.encode({widget.qNo: 'incorrect'}));
                      } else if (ans4 == false &&
                          widget.answer.contains('4')) {
                        prefs.setString('answerMap',
                            json.encode({widget.qNo: 'incorrect'}));
                      } else if (ans4 == false &&
                          !widget.answer.contains('4')) {
                        prefs.setString('answerMap',
                            json.encode({widget.qNo: 'correct'}));
                      }
                    } else if (ans3 == true && !widget.answer.contains('3')) {
                      prefs.setString('answerMap',
                          json.encode({widget.qNo: 'incorrect'}));
                    } else if (ans3 == false && widget.answer.contains('3')) {
                      prefs.setString('answerMap',
                          json.encode({widget.qNo: 'incorrect'}));
                    } else if (ans3 == false && !widget.answer.contains(
                        '3')) {
                      if (ans4 == true && widget.answer.contains('4')) {
                        prefs.setString('answerMap',
                            json.encode({widget.qNo: 'correct'}));
                      } else
                      if (ans4 == true && !widget.answer.contains('4')) {
                        prefs.setString('answerMap',
                            json.encode({widget.qNo: 'incorrect'}));
                      } else
                      if (ans4 == false && widget.answer.contains('4')) {
                        prefs.setString('answerMap',
                            json.encode({widget.qNo: 'incorrect'}));
                      } else if (ans4 == false &&
                          !widget.answer.contains('4')) {
                        prefs.setString('answerMap',
                            json.encode({widget.qNo: 'correct'}));
                      }
                    }
                  } else if (ans2 == true && !widget.answer.contains('2')) {
                    prefs.setString('answerMap', json.encode(
                        {widget.qNo: 'incorrect'}));
                  } else if (ans2 == false && widget.answer.contains('2')) {
                    prefs.setString('answerMap', json.encode(
                        {widget.qNo: 'incorrect'}));
                  } else if (ans2 == false && !widget.answer.contains('2')) {
                    if (ans3 == true && widget.answer.contains('3')) {
                      if (ans4 == true && widget.answer.contains('4')) {
                        prefs.setString('answerMap',
                            json.encode({widget.qNo: 'correct'}));
                      } else
                      if (ans4 == true && !widget.answer.contains('4')) {
                        prefs.setString('answerMap',
                            json.encode({widget.qNo: 'incorrect'}));
                      } else
                      if (ans4 == false && widget.answer.contains('4')) {
                        prefs.setString('answerMap',
                            json.encode({widget.qNo: 'incorrect'}));
                      } else if (ans4 == false &&
                          !widget.answer.contains('4')) {
                        prefs.setString('answerMap',
                            json.encode({widget.qNo: 'correct'}));
                      }
                    } else if (ans3 == true && !widget.answer.contains('3')) {
                      prefs.setString('answerMap',
                          json.encode({widget.qNo: 'incorrect'}));
                    } else if (ans3 == false && widget.answer.contains('3')) {
                      prefs.setString('answerMap',
                          json.encode({widget.qNo: 'incorrect'}));
                    } else
                    if (ans3 == false && !widget.answer.contains('3')) {
                      if (ans4 == true && widget.answer.contains('4')) {
                        prefs.setString('answerMap',
                            json.encode({widget.qNo: 'correct'}));
                      } else
                      if (ans4 == true && !widget.answer.contains('4')) {
                        prefs.setString('answerMap',
                            json.encode({widget.qNo: 'incorrect'}));
                      } else
                      if (ans4 == false && widget.answer.contains('4')) {
                        prefs.setString('answerMap',
                            json.encode({widget.qNo: 'incorrect'}));
                      } else if (ans4 == false &&
                          !widget.answer.contains('4')) {
                        prefs.setString('answerMap',
                            json.encode({widget.qNo: 'correct'}));
                      }
                    }
                  }
                } else if (ans2 == true && !widget.answer.contains('2')) {
                  prefs.setString('answerMap', json.encode({widget
                      .qNo: 'incorrect'}));
                } else if (ans3 == true && !widget.answer.contains('3')) {
                  prefs.setString('answerMap', json.encode({
                    widget.qNo: 'incorrect'
                  }));
                } else if (ans4 == true && !widget.answer.contains('4')) {
                  prefs.setString('answerMap', json.encode({
                    widget.qNo: 'incorrect'
                  }));
                } else {
                  prefs.setString('answerMap', json.encode({
                    widget.qNo: 'correct'
                  }));
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
      ]),
    );
  }
}
