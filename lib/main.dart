import 'package:flutter/material.dart';
import 'src/page_accueil.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      darkTheme: ThemeData.dark(),
      title: "Galerie Projets",
        home: PageAccueil(),
    );
  }
}











