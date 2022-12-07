

import 'package:flutter/material.dart';

class EditProfile extends StatefulWidget {


  @override
  State<EditProfile> createState() => _EditProfile();
}

class _EditProfile extends State<EditProfile>{


  @override
  Widget build (BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile"),
        leading: BackButton(
          onPressed: () => Navigator.pop(context),
        ),
      ),

      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Edit:',
            ),
          ],
        ),
      ),
    );
  }
}