import 'package:flutter/material.dart';

class MyProfile extends StatefulWidget {


  @override
  State<MyProfile> createState() => _MyProfile();
}

class _MyProfile extends State<MyProfile>{


  @override
  Widget build (BuildContext context){
    return Center(
      // Center is a layout widget. It takes a single child and positions it
      // in the middle of the parent.
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text(
            'Welcome to your profile',
          ),

        ],
      ),
    );
  }
}