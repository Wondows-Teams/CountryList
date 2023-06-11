

import 'dart:io';

import 'package:countrylist/editprofile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfile extends StatefulWidget {

  EditProfile({required this.user});

  Future<User> user;
  File? image;
  @override
  State<EditProfile> createState() => _EditProfile(user: user);
}

class _EditProfile extends State<EditProfile> {
  _EditProfile({required this.user});

  Future<User> user;
  TextEditingController tController = TextEditingController();
  String pruebita = "Pruebita";

  @override
  void initState() {
    super.initState();
    iniciarUsuario();
  }

  void iniciarUsuario(){
      user = userByPrefs();
  }

  Future<User> userByPrefs() async{
    String? auxName,auxImage;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    auxName = prefs.getString("name")!;
    auxImage = prefs.getString("image")!;
    return User(auxName, auxImage);
  }

  void SaveChanges() async {
    final prefs = SharedPreferences.getInstance().then((value)
    {
      value.setString("name", tController.text);
      setState(() {
        user = userByPrefs();
      });
    });
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
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;

      final prefs = SharedPreferences.getInstance().then((value) {
      value.setString("image", image.path);
      setState(() {
        user = userByPrefs();
      });
      });

    } on PlatformException catch (e) {
      print("Failed to pick image: $e");
    }
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
          onPressed: () => Navigator.pop(context),
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
              )
            ],
          ),
            Spacer(),
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
  late String? name;
  late String? image;

  User(String?_name, String? _image) {
    name = _name;
    image = _image;
  }


  void createPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    this.name = await prefs.getString("name");
    this.image = await prefs.getString("image");

    if (this.name == null) {
      this.name = "User";
    }
  }
}


