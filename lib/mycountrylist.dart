
import 'package:flag/flag.dart';
import 'package:flutter/material.dart';

class MyCountryList extends StatefulWidget {


  @override
  State<MyCountryList> createState() => _MyCountryList();
}

class _MyCountryList extends State<MyCountryList>{


  @override
  Widget build (BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Country List"),
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
              'Your countries:',
            ),
            Flag.fromCode(FlagsCode.ES, width: 30, height: 30),
            Flag.fromCode(FlagsCode.US, width: 30, height: 30),
            Flag.fromCode(FlagsCode.GB, width: 30, height: 30),
          ],
        ),
      ),
    );
  }
}