

import 'dart:io';

import 'package:countrylist/editprofile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:image_picker/image_picker.dart';

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


  void SaveChanges(){
    setState(() {
      user.name = tController.text;
      pruebita = tController.text;
    });
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
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      final imageTemporary = File(image.path);
      setState(() => user.image = imageTemporary);

    } on PlatformException catch (e) {
      print("Failed to pick image: $e");
    }
  }

  Widget CustomProfilePicture() {
    return Stack(
      children: [
        user.image != null
            ? ClipOval(child: Image.file(user.image! , width: 160, height: 160, fit: BoxFit.cover),)
            : ClipOval(child: Image(image: AssetImage("assets/Eliwood.jpg"), width: 160, height: 160, fit: BoxFit.cover)),
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
              Text("Username" , style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
              SizedBox(height: 10,),
              TextField(
                controller: tController,
              )
            ],
          ),
            Spacer(),
            Text(user.name),
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
  String name = "Anónimo";
  File? image;

  User(){
    this.name = "Anónimo";
    this.image = null;
  }


}