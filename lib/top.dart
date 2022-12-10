import 'package:flutter/material.dart';

class MyTop extends StatefulWidget {


  @override
  State<MyTop> createState() => _MyTop();
}

class _MyTop extends State<MyTop>{


  @override
  Widget build (BuildContext context){
    return Center(
      // Center is a layout widget. It takes a single child and positions it
      // in the middle of the parent.
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text(
            'These are the best countries:',
          ),
        ],
      ),
    );
  }
}