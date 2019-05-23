import 'package:flutter/material.dart';
import 'package:peliculas/src/models/pelicula_model.dart';
import 'package:peliculas/src/providers/peliculas_provaiders.dart';

class DataSearch extends SearchDelegate {

  String seleccion = '';
  final peliculasProvider = new PeliculasProviders();

  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions, son las acciones del appBar
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = '';
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading, Icono a la izquierda del appBar
    return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults, crea los resultados que vamos  mostrar
    return Center(
      child: Container(
        height: 100.0,
        width: 100.0,
        color: Colors.blueAccent,
        child: Text(seleccion),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions, las sugerencias que aparecen cuando la persona escribe

    if(query.isEmpty){
      return Container();
    } 
    
    return FutureBuilder(
      future: peliculasProvider.buscarpelicula(query),
      builder: (BuildContext context, AsyncSnapshot<List<Pelicula>> snapshot){

        if(snapshot.hasData){

          final peliculas = snapshot.data;

          return ListView(
            children: peliculas.map((pelicula){
              return ListTile(
                leading: FadeInImage(
                    placeholder: AssetImage('assets/images/no-image.jpg'),
                    image: NetworkImage(pelicula.getPosterImg()),
                  fit: BoxFit.cover,
                  width: 50.0,
                ),
                title: Text(pelicula.title),
                subtitle: Text(pelicula.originalTitle),

                onTap: (){
                  close(context, null);
                  pelicula.uniqueId = '';
                  Navigator.pushNamed(context, 'detalle', arguments: pelicula, );
                },
              );
            }).toList(),
          );
        }else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      }
    );
  }
}
