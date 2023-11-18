import 'package:flutter/material.dart';
import 'package:voyage/pages/authentification.page.dart';
import 'package:voyage/pages/contact.page.dart';
import 'package:voyage/pages/gallerie.page.dart';
import 'package:voyage/pages/home.page.dart';
import 'package:voyage/pages/inscription.page.dart';
import 'package:voyage/pages/meteo.page.dart';
import 'package:voyage/pages/parametres.page.dart';
import 'package:voyage/pages/pays.page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';
import 'package:voyage/config/global.params.dart';
//void main() => runApp(MyApp());

ThemeData theme = ThemeData.light();
Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  //theme=(await _onGetMode()== "Jour")? ThemeData.light(): ThemeData.dark();
  GlobalParams.themeActuel.setMode(await _onGetMode());

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final routes = {
    '/home': (context) => HomePage(),
    '/inscription': (context) => InscriptionPage(),
    '/authentification': (context) => AuthentificationPage(),
    '/meteo': (context) => MeteoPage(),
    '/gallerie': (context) => GalleriePage(),
    '/pays': (context) => PaysPage(),
    '/contact': (context) => ContactPage(),
    '/parametres': (context) => ParametresPage(),
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: routes,
      theme: GlobalParams.themeActuel.getTheme(),
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot){
          if (snapshot.hasData){
              return HomePage();}
          else
            return AuthentificationPage();
          },
      ),
    );
  }
  @override
  void initState() {
    super.initState();
    GlobalParams.themeActuel.addListener(() {
      setState(() {});
    });
  }
}
Future<String> _onGetMode() async{
  final snapshot= await ref.child("mode").get();
  if(snapshot.exists)
    mode= snapshot.value.toString();
  else
    mode="Jour";
  print(mode);
  return(mode);
}
