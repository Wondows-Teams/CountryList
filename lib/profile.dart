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