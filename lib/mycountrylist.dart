
import 'package:flag/flag.dart';
import 'package:flutter/material.dart';

class MyCountryList extends StatefulWidget {


  @override
  State<MyCountryList> createState() => _MyCountryList();
}

class _MyCountryList extends State<MyCountryList>{

  var tabScreens = [];
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
        ListView(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,

          children: [
            Row(
              children: [
                Flag.fromCode(FlagsCode.SE, width: 30, height: 30),
                Text("Sweden"),
              ],
            ),
            Row(
              children: [
                Flag.fromCode(FlagsCode.FR, width: 30, height: 30),
                Text("France"),
              ],
            ),
            Row(
              children: [
                Flag.fromCode(FlagsCode.DE, width: 30, height: 30),
                Text("Germany"),
              ],
            ),
          ],
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
        ListView(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,

          children: [
            Divider(
            ),
            Row(
              children: [
                SizedBox(width: 30),
                Flag.fromCode(FlagsCode.ES, width: 30, height: 30),
                SizedBox(width: 20),
                Text("Spain"),
              ],
            ),
            Divider(),
            Row(
              children: [
                SizedBox(width: 30),
                Flag.fromCode(FlagsCode.IT, width: 30, height: 30),
                SizedBox(width: 20),
                Text("Italy"),
              ],
            ),
            Divider(),
            Row(
              children: [
                SizedBox(width: 30),
                Flag.fromCode(FlagsCode.GB, width: 30, height: 30),
                SizedBox(width: 20),
                Text("Great Britain"),
              ],
            ),
            Divider(),
          ],
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
        ListView(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,

          children: [
            Row(
              children: [
                Flag.fromCode(FlagsCode.QA, width: 30, height: 30),
                Text("Qatar"),
              ],
            ),
            Row(
              children: [
                Flag.fromCode(FlagsCode.SA, width: 30, height: 30),
                Text("Saudi Arabia"),
              ],
            ),
            Row(
              children: [
                Flag.fromCode(FlagsCode.KP, width: 30, height: 30),
                Text("North Korea"),
              ],
            ),
          ],
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
        ListView(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,

          children: [
            Row(
              children: [
                Flag.fromCode(FlagsCode.BR, width: 30, height: 30),
                Text("Brazil"),
              ],
            ),
            Row(
              children: [
                Flag.fromCode(FlagsCode.JP, width: 30, height: 30),
                Text("Japan"),
              ],
            ),
            Row(
              children: [
                Flag.fromCode(FlagsCode.KR, width: 30, height: 30),
                Text("Korea"),
              ],
            ),
          ],
        ),
      ],
    );
  }
}