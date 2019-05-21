import 'dart:convert';

import 'package:peliculas/src/models/pelicula_model.dart';
import 'package:http/http.dart' as http;

class PeliculasProviders {
  String _apikey   = '1a874ef005de067ae1ee5fe75031c734';
  String _url      = 'api.themoviedb.org';
  String _language = 'es-ES';


  Future<List<Pelicula>> getEnCines() async{
    final url = Uri.https(_url,'3/movie/now_playing', {
      'api_key': _apikey,
      'language': _language
    });


    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);

    final peliculas = new Peliculas.fromJsonList(decodedData['results']);

    return peliculas.items;
  }
}