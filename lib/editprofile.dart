

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

class _EditProfile extends State<EditProfile> {
  _EditProfile({required this.user});

  User user;
  TextEditingController tController = TextEditingController();
  String pruebita = "Pruebita";


  void SaveChanges() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      user.name = tController.text;
      pruebita = tController.text;
    });
    prefs.setString("name", user.name!);
  }

  void OpenPictureOption() =>
      showModalBottomSheet(
        context: context,
        builder: ((builder) => pictureBottomSheet()),
      );



  Widget pictureBottomSheet(){
    return Container(
      height: 150,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: [
          Text("Where do you want to take the picture from?"),
          SizedBox(height: 20,),
          Row(
            children: [
              TextButton.icon(icon: Icon(Icons.camera_alt), onPressed: () => PickImage(ImageSource.camera) , label: Text("Camera")),
            ],
          ),
          Row(
            children: [
              TextButton.icon(icon: Icon(Icons.camera_alt), onPressed: () => PickImage(ImageSource.gallery) , label: Text("Gallery")),
            ],
          ),
        ],
      ),
    );
  }

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
    Navigator.pop(context);
  }

  Widget CustomProfilePicture() {
    return Stack(
      children: [
        user.image != null
            ? ClipOval(child: Image.file(File(user.image!) , width: 160, height: 160, fit: BoxFit.cover),)
            : ClipOval(child: Image(image: AssetImage("assets/Eliwood.jpg"), width: 160, height: 160, fit: BoxFit.cover)),
        Positioned(
          child: FloatingActionButton(
            onPressed: OpenPictureOption,
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
              Text("Username" , style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
              SizedBox(height: 10,),
              TextField(
                controller: tController,
              )
            ],
          ),
            Spacer(),
            Text(user.name!),
            ElevatedButton(
                onPressed: SaveChanges,
                child: Text("Save changes")
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
    this.name =  await prefs.getString("name");
    this.image = await prefs.getString("image");

    if(this.name == null){
      this.name = "User";
    }
  }

}