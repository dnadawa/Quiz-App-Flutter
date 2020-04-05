import 'package:flutter/material.dart';
import 'package:quizapp/screen/create-quiz.dart';
import 'package:quizapp/screen/profile.dart';
import 'package:quizapp/screen/view-quiz.dart';
import 'package:quizapp/widgets/white-text.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin{
  
  TabController _tabController;
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _tabController.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Material(
        color: Theme.of(context).primaryColor,
        child: TabBar(
          controller: _tabController,
          unselectedLabelColor: Theme.of(context).accentColor,
          tabs: <Widget>[
            Tab(icon: Icon(Icons.home),text: 'Home',),
            Tab(icon: Icon(Icons.featured_play_list),text: 'Create Quiz',),
            Tab(icon: Icon(Icons.assignment_ind),text: 'Profile',),
          ],
        ),
      ),


      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          ViewQuiz(),
          CreateQuiz(),
          Profile(),
        ],
      ),



    );
  }
}
