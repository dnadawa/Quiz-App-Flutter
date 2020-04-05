import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:quizapp/screen/sign-up.dart';
import 'package:quizapp/widgets/button.dart';
import 'package:quizapp/widgets/inputfield.dart';
import 'package:quizapp/widgets/toast.dart';
import 'package:quizapp/widgets/white-text.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home.dart';

class SignIn extends StatelessWidget {

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  CollectionReference collectionReference = Firestore.instance.collection('users');
  GoogleSignIn _googleSignIn = GoogleSignIn();

  signInWithEmail(BuildContext context) async {
    try{
      AuthResult result = await _firebaseAuth.signInWithEmailAndPassword(
          email: email.text, password: password.text);
      FirebaseUser user = result.user;
      print(user.uid);

      var sub = await Firestore.instance.collection('users').where('email',isEqualTo: email.text).getDocuments();
      var logged = sub.documents;

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('email', user.email);
      prefs.setString('username', logged[0].data['name']);
      prefs.setString('image', logged[0].data['image']);


      Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context){
        return Home();}));
    }
    catch(E){
      print(E);
      ToastBar(color: Colors.red,text: 'Something went Wrong').show();
    }
  }

  signInWithGoogle(BuildContext context) async {
    try{
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final FirebaseUser user = (await _firebaseAuth.signInWithCredential(credential)).user;

      var sub = await Firestore.instance.collection('score').where('email',isEqualTo: user.email).getDocuments();
      var logged = sub.documents;

      if(logged.isEmpty){
        await Firestore.instance.collection('score').document(user.email).setData({
          'email' : user.email,
          'score' : 0
        });
      }

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('email', user.email);
      prefs.setString('username', user.displayName);
      prefs.setString('image', user.photoUrl);
      print("signed in " + user.displayName);
      Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context){
        return Home();}));
    }
    catch(E){
      print(E);
      ToastBar(color: Colors.red,text: 'Something went Wrong').show();
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage('images/back.png'),fit: BoxFit.fitHeight)
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(50,200,40,40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              CustomText(text: 'Log into your account',size: 30,),
              InputField(hint: 'Email',type: TextInputType.emailAddress,ispassword: false,controller: email,),
              InputField(hint: 'Password',ispassword:true,controller: password,),
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Button(onclick: ()=>signInWithEmail(context),
                  text: 'Log in',
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: CustomText(text: 'OR',size: 20,),
              ),
              Button(text: 'Sign in with Google',color: Colors.white,social: true,icon: FontAwesomeIcons.google,onclick: ()=>signInWithGoogle(context),),

              Expanded(
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: GestureDetector(
                      onTap: (){
                        Navigator.push(
                          context,
                          CupertinoPageRoute(builder: (context) => SignUp()),
                        );
                      },
                      child: CustomText(text: 'Create an Account',size: 14)),
                ),
              ),


            ],
          ),
        ),
      ),
    );
  }
}
