import 'package:countrylist/mycountrylist.dart';
import 'package:countrylist/stats.dart';
import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';

class MyProfile extends StatefulWidget {


  @override
  State<MyProfile> createState() => _MyProfile();
}

class _MyProfile extends State<MyProfile>{





  @override
  Widget build (BuildContext context){

    void toCountryList(){
      Navigator.push(context, MaterialPageRoute(builder: (context) => MyCountryList()));
    }

    void toStats(){
      Navigator.push(context, MaterialPageRoute(builder: (context) => MyStats()));
    }

    return Center(
      // Center is a layout widget. It takes a single child and positions it
      // in the middle of the parent.
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Spacer(),
          const Text(
            'Welcome to your profile',
          ),
          Spacer(),
          ProfilePicture(
              name: "Pipe",
              radius: 100,
              fontsize: 100),
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  child: Text("Your Country List"),
                  onPressed: toCountryList,
              ),
              SizedBox(width: 50),
              ElevatedButton(
                  child: Text("Your Stats"),
                  onPressed: toStats,
              ),
            ],
          ),
          Spacer(),
        ],
      ),
    );
  }
}