import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthentificationPage extends StatelessWidget {
  late SharedPreferences prefs;
  TextEditingController txt_login = new TextEditingController();
  TextEditingController txt_password = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Page Authentification', style: GoogleFonts.roboto(fontSize: 22, fontWeight: FontWeight.bold)), backgroundColor: Colors.purple.shade200, centerTitle: true,),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: TextFormField(
              controller: txt_login,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  hintText: "Identifiant",
                  border: OutlineInputBorder(
                      borderSide: BorderSide(width: 1),
                      borderRadius: BorderRadius.circular(10))),
            ),
          ),
          Container(
            padding: EdgeInsets.all(20),
            child: TextFormField(
              obscureText: true,
              controller: txt_password,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.password),
                  hintText: "Mot de passe",
                  border: OutlineInputBorder(
                      borderSide: BorderSide(width: 1),
                      borderRadius: BorderRadius.circular(10))),
            ),
          ),
          Container(
            padding: EdgeInsets.all(20),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50), backgroundColor: Colors.purple.shade200),
              onPressed: () {
                _onAuthentifier(context);
              },
              child: Text(
                "Connexion",
                  style: GoogleFonts.roboto(fontSize: 22, fontWeight: FontWeight.bold)
              )
            ),
          ),
          TextButton(
            child: Text("Nouvel Utilisateur", style: GoogleFonts.roboto(fontSize: 22, fontWeight: FontWeight.bold)),
              style: TextButton.styleFrom(
                foregroundColor: Colors.purple.shade200, // Text Color
              ),
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/inscription');
            }),
        ],
      )
    );
  }
  Future<void> _onAuthentifier(BuildContext context) async {
    SnackBar snackBar = SnackBar(content: Text(""));
    if(!txt_login.text.isEmpty && !txt_password.text.isEmpty){
      try {
        final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: txt_login.text, password: txt_password.text,);
        Navigator.pop(context);
        Navigator.pushNamed(context, '/home');
      } on FirebaseAuthException catch (e){
        if (e.code == 'user-not-found'){
          snackBar=SnackBar(content: Text("Utilisateur inexistant"));
        }else if (e.code == 'wrong-password') {
          snackBar = SnackBar(content: Text("Vérifier votre mot de passe"));
        }
      }catch (e) {
        print(e);}
      }else {
      snackBar = SnackBar(
        content: Text('Id ou mot de passe vides'),
      );
    }
    ScaffoldMessenger.of(context).showSnackBar(snackBar);

  }
}
