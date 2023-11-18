import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import '../config/global.params.dart';
import 'package:google_fonts/google_fonts.dart';

class MyDrawer extends StatelessWidget {
  late SharedPreferences prefs;

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
          children: [
            DrawerHeader(
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [Colors.white, Colors.purple.shade300])
                ),
                child: Center(
                  child: CircleAvatar(
                    backgroundImage: AssetImage("images/eya.jpg"),
                    radius: 80,
                  ),
                )
            ),
            //parcourir les différentes elements du menu
            ...(GlobalParams.menus as List).map((item) {
              return ListTile(
                title: Text('${item['title']}', style: GoogleFonts.roboto(fontSize: 22, color: Colors.purple.shade200,fontWeight: FontWeight.bold),),
                leading: item['icon'],
                trailing: Icon(Icons.arrow_right, color: Colors.purple.shade200,),
                onTap: () async {
                  if('${item['title']}' !="Déconnexion"){
                    Navigator.of(context).pop();
                    Navigator.pushNamed(context, "${item['route']}");
                  }
                  else{
                    FirebaseAuth.instance.signOut();
                    Navigator.of(context).pushNamedAndRemoveUntil('/authentification', (Route<dynamic> route) => false);
                  }
                },
              );
            }),
           ],
        )
    );


  }

}