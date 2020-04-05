import 'package:flutter/material.dart';
import 'package:quizapp/widgets/white-text.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String image,name='Username';
  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString('username');
      image = prefs.getString('image');
    });
    
  }
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: CustomText(text: 'Profile',size: 20,),
      ),

      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage('images/back.png'),fit: BoxFit.fitWidth),
        ),
        
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              backgroundImage: image==null?AssetImage('images/avatar.png'):NetworkImage(image),
              radius: 55,
            ),
            Padding(
              padding: const EdgeInsets.all(30),
              child: Container(
                 decoration: BoxDecoration(
                   color: Colors.white,
                   borderRadius: BorderRadius.circular(40),
                   border: Border.all(color: Theme.of(context).accentColor,width: 1),
                 ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: CustomText(text: name,color: Colors.black,size: 30,),
                  ),
                ),
              ),
            )
          ],
        ),

      ),

    );
  }
}
