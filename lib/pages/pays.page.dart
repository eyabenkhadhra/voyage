import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../menu/drawer.widget.dart';

class PaysPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        title: Text('Pays', style: GoogleFonts.roboto(
            fontSize: 22, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.purple.shade200,
      ),
      body: Center(
        child: Text(
          'Page Pays',
            style: GoogleFonts.sacramento(textStyle: Theme.of(context).textTheme.headlineMedium, fontWeight: FontWeight.bold, fontSize: 28,)
        ),
      ),

    );
  }

}