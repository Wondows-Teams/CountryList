import 'package:flutter/material.dart';

class MyStats extends StatefulWidget {


  @override
  State<MyStats> createState() => _MyStats();
}

class _MyStats extends State<MyStats>{


  @override
  Widget build (BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Stats"),
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
              'Total kilometres:',
            ),
          ],
        ),
      ),
    );
  }
}