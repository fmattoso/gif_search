import 'package:flutter/material.dart';
import 'package:gif_search/pages/home_page.dart';
import 'package:share_plus/share_plus.dart';
import 'package:transparent_image/transparent_image.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Busca Gif',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        scaffoldBackgroundColor: const Color(0xFF030303),
        hintColor: Colors.white,
      ),
      home: const MyHomePage(title: 'Buscador de Gifs!'),
    );
  }
}
