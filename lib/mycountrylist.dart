
import 'package:flag/flag.dart';
import 'package:flutter/material.dart';

import 'ListaPaises.dart';

class MyCountryList extends StatefulWidget {


  @override
  State<MyCountryList> createState() => _MyCountryList();
}

class _MyCountryList extends State<MyCountryList>{

  void toEditScreen(){

  }

  @override
  Widget build (BuildContext context){
    return DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            title: Text("Your Country List"),
            leading: BackButton(
              onPressed: () => Navigator.pop(context),
            ),
            bottom: TabBar(
              tabs: [
                Tab(text: "Visiting",),
                Tab(text: "Visited",),
                Tab(text: "Not visiting",),
                Tab(text: "Plan to visit",),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: toEditScreen,
            child: Icon(Icons.edit_note),
          ),

          body: Center(
            // Center is a layout widget. It takes a single child and positions it
            // in the middle of the parent.
            child: TabBarView(
              children: [
                VisitingCountry(),
                VisitedCountry(),
                NotVisitingCountry(),
                PlanToVisitCountry(),
              ],
            ),
          ),
        ),
    );
  }
}


class VisitingCountry extends StatelessWidget {

  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Text(
          'Countries visiting right now:',
        ),
        Expanded(
            child: ListaPaises(["ESP"], true),
        ),
      ],
    );
  }
}

class VisitedCountry extends StatelessWidget {

  Widget build(BuildContext context) {

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Text(
          'Visited countries:',
        ),
        Expanded(
          child: ListaPaises(["AFG"], true),
        ),
      ],
    );
  }
}

class NotVisitingCountry extends StatelessWidget {

  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Text(
          'Countries not going to visit:',
        ),
        Expanded(
          child: ListaPaises(["BRA"], true),
        ),
      ],
    );
  }
}

class PlanToVisitCountry extends StatelessWidget {

  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Text(
          'Countries planing to visit:',
        ),
        Expanded(
          child: ListaPaises(["JPN"], true),
        ),
      ],
    );
  }
}