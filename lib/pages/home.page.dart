import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:voyage/config/global.params.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../menu/drawer.widget.dart';

class HomePage extends StatelessWidget {
  //late SharedPreferences prefs;

  @override
  Widget build(BuildContext context) {
    final user= FirebaseAuth.instance.currentUser;
    return Scaffold(
        drawer: MyDrawer(),
        appBar: AppBar(
          title: Text('Page Home',
              style: GoogleFonts.roboto(
                  fontSize: 22, fontWeight: FontWeight.bold)),
          backgroundColor: Colors.purple.shade200,
          centerTitle: true,
        ),
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              child: Text("Utilisateur: ${user?.email}",style: TextStyle(fontSize: 20)),
            ),

            Center(
              child: Wrap(children: [
                ...(GlobalParams.accueil as List).map((item) {
                  return InkWell(
                    child: Ink.image(
                      height: 180,
                      width: 180,
                      image: item['image'],),
                    onTap: (){
                      if ('${item["route"]}' !="/authentification")
                        Navigator.pushNamed(context, "${item['route']}");
                      else
                        _Deconnexion(context);
                    },
                  );
                })
              ]),
            )
          ],
        ));
  }

  Future<void> _Deconnexion(context) async {
    FirebaseAuth.instance.signOut();
    Navigator.of(context).pushNamedAndRemoveUntil(
        '/authentification', (Route<dynamic> route) => false);
  }
}
