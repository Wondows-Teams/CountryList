import 'dart:io';

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

  User user = User();

  @override
  void initState() {
    user = User();
    super.initState();
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
        final newUser = await Navigator.push(context,
            MaterialPageRoute(builder: (context) => EditProfile(user: user,)));
        setState(() => this.user = newUser);
    }


    Widget CustomProfilePicture() {
      return Stack(
        children: [
          user.image != null
              ? ClipOval(child: Image.file(File(user.image!) , width: 260, height: 260, fit: BoxFit.cover),)//160x160
              : ClipOval(child: Image(image: AssetImage("assets/Eliwood.jpg"), width: 260, height: 260, fit: BoxFit.cover)),
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
          user.name != null
              ? Text(user.name!, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, /*color: Colors.white70*/))
              : Text("User", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, /*color: Colors.white70*/)),

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

          /*Row(
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
          ),*/
          Spacer(),
        ],
      ),
    );
  }
}