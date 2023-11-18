import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';

class InscriptionPage extends StatelessWidget {
  late SharedPreferences prefs;
  TextEditingController txt_login = new TextEditingController();
  TextEditingController txt_password = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Page Inscription', style: GoogleFonts.roboto(fontSize: 22, fontWeight: FontWeight.bold)), backgroundColor: Colors.purple.shade200, centerTitle: true,),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: TextFormField(
              controller: txt_login,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  hintText: "Utilisateur",
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
                    minimumSize: const Size.fromHeight(50), backgroundColor: Colors.purple.shade300),
                onPressed: () {
                  _onInscrire(context);
                },
                child: Text("Inscription",style: GoogleFonts.roboto(fontSize: 22, fontWeight: FontWeight.bold) )),

          ),
          TextButton(
            child: Text("J'ai déjà un compte", style: GoogleFonts.roboto(fontSize: 22, fontWeight: FontWeight.bold)),

            style: TextButton.styleFrom(
              foregroundColor: Colors.purple.shade200, // Text Color
            ),
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/authentification');

            },
          ),
        ],
      ),
    );
  }

  Future<void> _onInscrire(BuildContext context) async {
    SnackBar snackBar = SnackBar(content: Text(""));

    if (!txt_login.text.isEmpty && !txt_password.text.isEmpty) {
      try {
        final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: txt_login.text,
          password: txt_password.text,
        );
        Navigator.pop(context);
        Navigator.pushNamed(context, '/home');
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          snackBar = SnackBar(content: Text("Mot de passe faible"));
        } else if (e.code == 'email-already-in-use') {
          snackBar = SnackBar(content: Text("Email deja existant"));
        }
      } catch (e) {
        print(e);
      }

    } else {
       snackBar = SnackBar(
        content: Text('Id ou mot de passe vides'),
      );
    }
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
