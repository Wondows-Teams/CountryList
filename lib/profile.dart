import 'package:countrylist/mycountrylist.dart';
import 'package:countrylist/stats.dart';
import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:countrylist/editprofile.dart';

class MyProfile extends StatefulWidget {


  @override
  State<MyProfile> createState() => _MyProfile();
}

class _MyProfile extends State<MyProfile>{

    String name = "Anónimo";
    String image = "";
    int pfpIndex = 0;

  @override
  Widget build (BuildContext context){
    if (image == ""){
      pfpIndex = 0;
    } else {
      pfpIndex = 1;
    }

    var profilePicture = [
      ProfilePicture(name: name,
        radius: 100,
        fontsize: 100,),

      ProfilePicture(
        name: name,
        radius: 100,
        fontsize: 100,
        img: image,
      ),
    ];

    void toCountryList(){
      Navigator.push(context, MaterialPageRoute(builder: (context) => MyCountryList()));
    }

    void toStats(){
      Navigator.push(context, MaterialPageRoute(builder: (context) => MyStats()));
    }

    void toEditPage(){
      Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfile()));
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
          Stack(
              children: [
                profilePicture[pfpIndex],
                Positioned(
                  child: FloatingActionButton(
                    onPressed: toEditPage,
                    child: Icon(Icons.edit),
                  ),
                  right: 0,
                  bottom: 0,
                ),
              ],
          ),
          Spacer(),
          Text(name,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          ),
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