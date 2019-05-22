import 'package:flutter/material.dart';
import 'package:peliculas/src/home_page.dart';
import 'package:peliculas/src/pages/pelicula_detalle.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Películas',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/'       : (BuildContext context) => HomePage(),
        'detalle' : (BuildContext context) => PeliculaDetalle()
      },
    );
  }
}

