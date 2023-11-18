import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../menu/drawer.widget.dart';
import 'package:firebase_database/firebase_database.dart';
import '../config/global.params.dart';

String mode="Jour";
FirebaseDatabase fire = FirebaseDatabase.instance;
DatabaseReference ref =fire.ref();

class ParametresPage extends StatefulWidget{
  @override
  State<ParametresPage> createState() => _ParametresPageState();
}

class _ParametresPageState extends State<ParametresPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        title: Text('Paramétres', style: GoogleFonts.roboto(
            fontSize: 22, fontWeight: FontWeight.bold),),
        backgroundColor: Colors.purple.shade200,
      ),
      body: Column(
        children: [
          Text("Mode", style: TextStyle(fontSize: 22)),
          ListTile(
            title: Text("Jour"),
            leading: Radio<String>(
              value: "Jour",
              groupValue: mode,
              onChanged: (value) {
                setState(() {
                  mode=value!;
                });
              },
            ),
          ),
          ListTile(
            title: Text("Nuit"),
            leading: Radio<String>(
              value: "Nuit",
              groupValue: mode,
              onChanged: (value) {
                setState(() {
                  mode=value!;
                });
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(20),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50), backgroundColor: Colors.purple.shade300),
                onPressed: () {
                  _onSaveMode();

                },
                child: Text("Enregistrer",style: GoogleFonts.roboto(fontSize: 22, fontWeight: FontWeight.bold) )),

          ),
        ],
      )

    );
  }
  _onSaveMode() async{
    GlobalParams.themeActuel.setMode(mode);
    await ref.set({"mode":mode});
    print("mode appliqué $mode");
    Navigator.pop(context);

  }
}
