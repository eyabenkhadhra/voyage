import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class MeteoDetailsPage extends StatefulWidget{
  String ville ="";
  MeteoDetailsPage(this.ville);



  @override
  State<MeteoDetailsPage> createState() => _MeteoDetailsPageState();
}

class _MeteoDetailsPageState extends State<MeteoDetailsPage> {
  var meteoData;
  @override
  void initState(){
    super.initState();
    getMeteoData(widget.ville);
  }
  void getMeteoData(String ville){
    print("Méteo de la ville de"+ ville);
    String url =
        "https://api.openweathermap.org/data/2.5/forecast?q=${ville}&appid=52b19f06d1ea77b31ab8d2e2f8602e77";
    http.get(Uri.parse(url)).then((resp){
      setState(() {
        this.meteoData = json.decode(resp.body);
        print(this.meteoData);
      });

    }).catchError((err){
      print(err);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Page Meteo Details ${widget.ville}',
              style: GoogleFonts.roboto(
                  fontSize: 22, fontWeight: FontWeight.bold)),
          backgroundColor: Colors.purple.shade200,

          centerTitle: true,
        ),
      body: meteoData == null ?
          Center(
            child: CircularProgressIndicator(),
          ):
      ListView.builder(
          itemCount: (meteoData == null ?0 : meteoData['list'].length),
          itemBuilder: (context, index){
            return Card(
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [Colors.purple.shade300, Colors.transparent])
                ) ,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: [
                        //ce widget sera développé dans la question 8
                        CircleAvatar(
                          backgroundImage: AssetImage("images/${meteoData['list'][index]['weather'][0]['main'].toString().toLowerCase()}.png}",
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //ce widget sera développé dans la question 9
                              Text("${new DateFormat
                                  ('E-dd/MM/yyyy').format(DateTime.fromMicrosecondsSinceEpoch(meteoData['list'][index]['dt']*1000000))
                              }",
                                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                              ),
                              //ce widget sera dévaloppé dans la question 10
                              Text("${new DateFormat
                                ('HH:mm').format(DateTime.fromMicrosecondsSinceEpoch(meteoData['list'][index]['dt']*1000000))
                              }"
                                "| ${meteoData['list'][index]['weather'][0]['main']}",
                                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    //ce wigdet sera dévelopé dans la question 11
                    Text("${(meteoData['list'][index]['main']['temp']- 273.15).round()} °C",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            );

    }
    ));
  }
}