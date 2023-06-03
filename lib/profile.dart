import 'dart:io';

import 'package:countrylist/mycountrylist.dart';
import 'package:countrylist/stats.dart';
import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'editprofile.dart';


class MyProfile extends StatefulWidget {


  @override
  State<MyProfile> createState() => _MyProfile();
}

class _MyProfile extends State<MyProfile>{

  late Future<User> user;

  @override
  void initState() {
    super.initState();
    user = userByPrefs();
  }

  Future<User> userByPrefs() async{
    String? auxName,auxImage;
    SharedPreferences prefs = await SharedPreferences.getInstance();
      auxName = prefs.getString("name")!;
      auxImage = prefs.getString("image")!;
    return User(auxName, auxImage);
  }


  @override
  Widget build (BuildContext context){

    void toCountryList(){
      Navigator.push(context, MaterialPageRoute(builder: (context) => MyCountryList()));
    }

    void toStats(){
      Navigator.push(context, MaterialPageRoute(builder: (context) => MyStats()));
    }

    void toEditPage() async {
        await Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfile(user: user,)));
        setState(() {
          user = userByPrefs();
        });
    }


    Widget CustomProfilePicture() {
      return Stack(
        children: [
          FutureBuilder(
            future: user,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ClipOval(child: Image.file(File(snapshot.data!.image!) , width: 160, height: 160, fit: BoxFit.cover));
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              return ClipOval(child: Image(image: AssetImage("assets/Eliwood.jpg"), width: 160, height: 160, fit: BoxFit.cover));
            },
          ),
          Positioned(
            child: FloatingActionButton(
              onPressed: toEditPage,
              child: Icon(Icons.edit),
            ),
            right: 0,
            bottom: 0,
          ),
        ],
      );
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
            style: TextStyle(
              fontSize: 20,
              //color: Colors.white70
            ),
          ),
          Spacer(),
          CustomProfilePicture(),
          Spacer(),
          FutureBuilder(
            future: user,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data!.name!, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30));
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              return Text("User", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30));
            },
          ),
          Spacer(),

          Container(
            margin: EdgeInsets.all(15),
            //padding: EdgeInsets.all(50),// respecto al exterior
            /*decoration: BoxDecoration(
              border: Border.all(
                color: Colors.teal.shade100,
                width: 20,
              ),
            ),*/
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                      width:8,
                      color: Colors.teal
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: EdgeInsets.symmetric(
                    vertical: 15,
                    horizontal: 15,
                ),
                fixedSize: Size(240, 80),
              ),
              child: Text("Your Country List",
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
              onPressed: toCountryList,
            ),
          ),

          //SizedBox(width: 50),
          //Spacer(),

          Container(
            margin: EdgeInsets.all(15),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                      width:8,
                      color: Colors.teal
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: EdgeInsets.symmetric(
                  vertical: 15,
                  horizontal: 15,
                ),
                fixedSize: Size(240, 80),
              ),
              child: Text("Your Stats",
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
              onPressed: toStats,
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }
}
