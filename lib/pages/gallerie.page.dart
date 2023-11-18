import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../menu/drawer.widget.dart';
import 'gallerie-details.page.dart';

class GalleriePage extends StatelessWidget{

  TextEditingController txt_gallery = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        title: Text('Gallerie', style: GoogleFonts.roboto(
            fontSize: 22, fontWeight: FontWeight.bold),),
        backgroundColor: Colors.purple.shade200,
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            child: TextFormField(
              controller: txt_gallery,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.photo_library),
                  hintText: "keyword",
                  border: OutlineInputBorder(
                      borderSide: BorderSide(width: 1),
                      borderRadius: BorderRadius.circular(10)
                  )
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50), backgroundColor: Colors.purple.shade300,
              ), onPressed: () {
              _onGetGallerieDetails(context);
            }, child: Text('Chercher', style: TextStyle(fontSize: 22),),
            ),
          )
        ],

      ),


    );
  }

  void _onGetGallerieDetails(BuildContext context){
    String keyword = txt_gallery.text;
    Navigator.push(context,
    MaterialPageRoute(builder: (context)=>GallerieDetailsPage(keyword)));
  }

}