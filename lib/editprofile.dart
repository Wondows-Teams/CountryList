

import 'dart:io';

import 'package:countrylist/editprofile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfile extends StatefulWidget {

  EditProfile({required this.user});

  User user;
  File? image;
  @override
  State<EditProfile> createState() => _EditProfile(user: user);
}

class _EditProfile extends State<EditProfile>{
  _EditProfile({required this.user});
  User user;
  TextEditingController tController = TextEditingController();
  String pruebita = "Pruebita";


  void SaveChanges() async{
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      user.name = tController.text;
      pruebita = tController.text;
    });
    prefs.setString("name", user.name!);
  }

  void OpenDialog() => showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Where do you want to take the picture from?"),
        actions: [
          TextButton(onPressed: () => PickImage(ImageSource.gallery), child: Text("Gallery")),
          TextButton(onPressed: () => PickImage(ImageSource.camera), child: Text("Camera")),
        ],
      ),
  );

  Future PickImage(ImageSource source) async{
    final prefs = await SharedPreferences.getInstance();
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      ;
      setState(() => user.image = image.path);

      if (user.image == null){
        user.image == "";
      }

      prefs.setString("image", user.image!);

    } on PlatformException catch (e) {
      print("Failed to pick image: $e");
    }
  }

  Widget CustomProfilePicture() {
    return Stack(
      children: [
        user.image != null
            ? ClipOval(child: Image.file(File(user.image!) , width: 260, height: 260, fit: BoxFit.cover),)
            : ClipOval(child: Image(image: AssetImage("assets/Eliwood.jpg"), width: 260, height: 260, fit: BoxFit.cover)),
        Positioned(
          child: FloatingActionButton(
            onPressed: OpenDialog,
            child: Icon(Icons.add_a_photo),
          ),
          right: 0,
          bottom: 0,
        ),
      ],
    );
  }

  @override
  Widget build (BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile"),
        leading: BackButton(
          onPressed: () => Navigator.pop(context, user),
        ),
      ),

      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Spacer(),
            CustomProfilePicture(),
            Spacer(),
          ListView(
            padding: EdgeInsets.symmetric(horizontal: 32),
            physics: BouncingScrollPhysics(),
            shrinkWrap: true,
            children: [
              Text("Username" , style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, /*color: Colors.white70*/),),
              SizedBox(height: 10,),
              TextField(
                controller: tController,
                //cursorHeight: 100,
              )
            ],
          ),
            Spacer(),
            Text(user.name!,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            /*ElevatedButton(
                onPressed: SaveChanges,
                child: Text("Save changes")
            ),*/
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
                child: Text("Save changes",
                  style: TextStyle(
                    fontSize: 25,
                  ),
                ),
                onPressed: SaveChanges,
              ),
            ),
            Spacer(),

          ],
        ),
      ),
    );
  }
}



class CustomTextField extends StatefulWidget{

  CustomTextField({required this.label, required this.tController});
  TextEditingController tController;
  String label;
  @override
  State<CustomTextField> createState() => _CustomTextField(label: label, tController: tController);

}

class _CustomTextField extends State<CustomTextField>{

  _CustomTextField({required this.label, required this.tController});
  String label;
  TextEditingController tController;

  @override
  void dispose() {
    tController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){

    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 32),
      physics: BouncingScrollPhysics(),
      shrinkWrap: true,
      children: [
        Text(label , style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
        SizedBox(height: 10,),
        TextField(
          controller: tController,
        )
      ],
    );
  }
}


class User {
  String? name;
  String? image;

  User() {
    createPreferences();
  }

   void createPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    this.name = await prefs.getString("name");
    this.image = await prefs.getString("image");

    if(this.name == null){
      this.name = "User";
    }
  }

}