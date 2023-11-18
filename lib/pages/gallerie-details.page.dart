import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../menu/drawer.widget.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GallerieDetailsPage extends StatefulWidget{
  String keyword= "";

  GallerieDetailsPage(this.keyword);

  @override
  State<GallerieDetailsPage> createState() => _GallerieDetailsPageState();
}

class _GallerieDetailsPageState extends State<GallerieDetailsPage> {
  int currentPage = 1;
  int size =10;
  int totalPages=100;
  ScrollController _scrollController= ScrollController();
  List<dynamic> hits =[];
  var galleryData;

  @override
  void initState() {
    super.initState();
    getGalleryData(widget.keyword);
    _scrollController.addListener(() {
      if( _scrollController.position.pixels== _scrollController.position.maxScrollExtent){
        if(currentPage<totalPages){
          currentPage++;
          getGalleryData(widget.keyword);
        }
      }

    });
  }

  void getGalleryData(String keyword) {
    print("Gallerie de" + keyword);
    String url = "https://pixabay.com/api/?key=35407165-b2cd52f8b169bb0dc25dbda01&q=${keyword}&page=${currentPage}&per_page=${size}";
    http.get(Uri.parse(url)).then((resp) {
      setState(() {
        galleryData = json.decode(resp.body);
        print(galleryData);
        hits.addAll(galleryData['hits']);
        totalPages= (galleryData['totalHits']/size).ceil();
      });
    }).catchError((err){
      print(err);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        title: totalPages==0?
        Text('pas de resultats'):
        Text("${widget.keyword}, ${currentPage}/${totalPages}", style: GoogleFonts.roboto(
            fontSize: 22, fontWeight: FontWeight.bold),),
        backgroundColor: Colors.purple.shade200,
      ),
      body: (galleryData == null
      ? Center(child: CircularProgressIndicator())
      :ListView.builder(
        controller: _scrollController,
        itemCount:(galleryData == null ? 0 : hits.length) ,
        itemBuilder: (context, index){
          return Column(
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.only(left:10, right:10),
                child: Card(
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Center(
                      child: Text(
                        hits[index]['tags'],
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  color: Colors.purple.shade300,
                ),
              ),
              Container(
                child: Card(
                  child: Image.network(hits[index]['webformatURL'], fit: BoxFit.fitWidth,),
                ),
              )
            ],
          );
        },
      ))

    );
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _scrollController.dispose();
  }
}