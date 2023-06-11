import 'package:countrylist/profile.dart';
import 'package:flutter/material.dart';

import 'ListaPaises.dart';
import 'dataModel.dart';
import 'database.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: Colors.teal.shade200,
        secondaryHeaderColor: Colors.tealAccent
      ),
      home: MyMain(),
    );
  }
}

class MyMain extends StatefulWidget {


  MyMain({super.key});

  @override
  State<MyMain> createState() => _MyMain();

}

class _MyMain extends State<MyMain> {
  int index = 1;
  var scenes = [
    ListaPaises(codigosTop(), true),
    ListaPaises([], false),
    MyProfile(),
  ];


  int actualizarPaises(int index){
    List<String> actualizado = codigosTop();
    
    ListaPaises listaActualizada = scenes[0] as ListaPaises;
    listaActualizada.codPaisesFiltro = codigosTop();
    
    return index;
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text("My Country List"),
        leading: Image(image: AssetImage("assets/MyCountryList.png"),),
      ),
      //drawer: CustomDrawer(),//Logo aqui
      body: scenes[index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (index) => setState(() => this.index = actualizarPaises(index)),
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.star),
              label: "Best",
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home"
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Profile"
          ),
        ],
      ),
    );
  }
}

List<String> codigosTop(){
  PaisDatabase bbdd = PaisDatabase.instance;
  List<String> codigos = [];
  List<Pais> paises = [];
  bbdd.readAll(paisesFavs).then(
          (value) {
            paises = value;
            paises.forEach((element) {
            codigos.add(element.code);
            });
          }
  );
  return codigos;
}


class CustomDrawer extends StatelessWidget {
  CustomDrawer({super.key});

  void navegacioncita(){

  }
  @override
  Widget build(BuildContext context){
    return Drawer(
      child: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.home),
            title: Text("Menu Principal"),
            onTap: (){},
          ),
          ListTile(
            leading: Icon(Icons.analytics),
            title: Text("Estadísticas"),
            onTap: (){},
          ),
          ListTile(
            leading: Icon(Icons.beenhere),
            title: Text("Insignias"),
            onTap: (){},
          ),
        ],
        ),
    );
  }
}