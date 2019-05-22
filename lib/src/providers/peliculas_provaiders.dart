import 'dart:convert';
import 'dart:async';

import 'package:peliculas/src/models/pelicula_model.dart';
import 'package:http/http.dart' as http;

class PeliculasProviders {
  String _apikey   = '1a874ef005de067ae1ee5fe75031c734';
  String _url      = 'api.themoviedb.org';
  String _language = 'es-ES';

  int _popularesPage = 0;
  bool _cargando = false;

  List<Pelicula> _populares = new List();

  // *** creando una tuberia para el flujo de peliculas
  final _popularesStreamController = StreamController<List<Pelicula>>.broadcast();

  // *** ingreso a la tuberia
  Function(List<Pelicula>) get popularesSink => _popularesStreamController.sink.add;

  // *** salida de la tuberia
  Stream<List<Pelicula>> get popularesStream => _popularesStreamController.stream;

  // *** cerrar el flujo cuando termine de pasar el StreamControler
  void disposeStreams(){
    _popularesStreamController?.close();
  }

  // TODO: optimización para obtener la respuesta del api
  Future<List<Pelicula>> _procesarRespuesta(Uri url) async{

    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);

    final peliculas = new Peliculas.fromJsonList(decodedData['results']);

    return peliculas.items;
  }

  // TODO: obtener todos los que estan en cines
  Future<List<Pelicula>> getEnCines() async{
    final url = Uri.https(_url,'3/movie/now_playing', {
      'api_key': _apikey,
      'language': _language
    });

    return await _procesarRespuesta(url);
  }


  // TODO: obtener todos los populares
  Future<List<Pelicula>> getPopulares() async{

    if(_cargando){
      return [];
    }

    _cargando = true;


    _popularesPage++;

    final url = Uri.https(_url, '3/movie/popular',{
      'api_key': _apikey,
      'language': _language,
      'page': _popularesPage.toString()
    });

    final resp = await _procesarRespuesta(url);

    _populares.addAll(resp);
    popularesSink(_populares);

    _cargando = false;
    return resp;
  }



}