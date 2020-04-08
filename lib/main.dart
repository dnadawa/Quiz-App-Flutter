import 'package:flutter/material.dart';
import 'package:quizapp/screen/home.dart';
import 'package:quizapp/screen/sign-in.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('answerMap', null);
  var email = prefs.getString('email');
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
        primaryColor: Color(0xff000051),
        accentColor: Color(0xff5C6BC0)
    ),
    home: email==null?SignIn():Home(),
  )
  );
}
