import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:quizapp/widgets/button.dart';
import 'package:quizapp/widgets/inputfield.dart';
import 'package:quizapp/widgets/toast.dart';
import 'package:quizapp/widgets/white-text.dart';

class SignUp extends StatefulWidget {

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  TextEditingController uname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  File image;
  String imgurl;

    FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  CollectionReference collectionReference = Firestore.instance.collection('users');

  signUp() async {
    if(email.text!='' && password.text!='' && uname.text!=''){
      try{
        AuthResult result = await _firebaseAuth.createUserWithEmailAndPassword(
            email: email.text, password: password.text);
        FirebaseUser user = result.user;
        print(user.uid);

        await Firestore.instance.collection('score').document(user.email).setData({
          'email' : user.email,
          'score' : 0
        });

        await collectionReference.document(user.uid).setData({
          'name': uname.text,
          'email': email.text,
          'image': imgurl
        });
        uname.clear();
        email.clear();
        password.clear();
        setState(() {
          image = null;
        });
        ToastBar(color: Colors.green,text: 'Signed Up Successfully!').show();
      }
      catch(E){
        ToastBar(color: Colors.red,text: 'Something Went Wrong!').show();
        print(E);
      }
    }else{
      ToastBar(color: Colors.red,text: 'Please Fill all the Fields!').show();
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
          padding: const EdgeInsets.fromLTRB(50,0,40,0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CustomText(text: 'Create your account',size: 30,),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: GestureDetector(
                  onTap: () async {
                    image = await ImagePicker.pickImage(source: ImageSource.gallery);
                    setState(() {});
                    try{
                      StorageReference ref = FirebaseStorage.instance.ref().child("pro_pics/${basename(image.path)}");
                      StorageUploadTask uploadTask = ref.putFile(image);
                      final StorageTaskSnapshot downloadUrl = (await uploadTask.onComplete);
                      imgurl = (await downloadUrl.ref.getDownloadURL());
                      print("url is $imgurl");
                    }
                    catch(e){
                      print(e);
                      ToastBar(text: 'Something Went Wrong while uploading image!',color: Colors.red).show();
                    }
                  },
                  child: CircleAvatar(
                    radius: 55,
                    backgroundColor: Colors.red,
                    backgroundImage: image==null?AssetImage('images/avatar.png'):FileImage(image),
                  ),
                ),
              ),
              CustomText(text: 'Upload your profile picture',size: 16,),
              InputField(hint: 'Username',controller: uname,),
              InputField(hint: 'Email',type: TextInputType.emailAddress,controller: email,),
              InputField(hint: 'Password',ispassword:true,controller: password,),
              Padding(
                padding: const EdgeInsets.only(top: 70),
                child: Button(onclick: ()=>signUp(),
                    text: 'Sign Up'),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
