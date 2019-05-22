import 'package:flutter/material.dart';
import 'package:peliculas/src/providers/peliculas_provaiders.dart';

import 'package:peliculas/src/widgets/card_swiper_widget.dart';
import 'package:peliculas/src/widgets/movie_horizontal.dart';

class HomePage extends StatelessWidget {
  final pelicuclasProvider = new PeliculasProviders();

  @override
  Widget build(BuildContext context) {
    pelicuclasProvider.getPopulares();

    return Scaffold(
      appBar: AppBar(
        title: Text('Pelícuals en cines'),
        centerTitle: false,
        backgroundColor: Colors.indigoAccent,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search), onPressed: () {})
        ],
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _swipeCards(),
            _footer(context),
          ],
        ),
      ),
    );
  }

  Widget _swipeCards() {
    return FutureBuilder(
        future: pelicuclasProvider.getEnCines(),
        builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
          if (snapshot.hasData) {
            return CardSwiper(
              peliculas: snapshot.data, //*** enviando data al CardSwiper
            );
          } else {
            return Container(
                height: 400.0,
                child: Center(
                  child: CircularProgressIndicator(),
                ));
          }
        });
  }

  Widget _footer(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
              padding: EdgeInsets.only(left: 20.0),
              child: Text(
                'Populares',
                style: Theme.of(context).textTheme.subhead,
              )),
          SizedBox(
            height: 5.0,
          ),
          StreamBuilder(
              stream: pelicuclasProvider.popularesStream,
              builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
                if (snapshot.hasData) {
                  return MovieHorizontal(
                    peliculas: snapshot.data,
                    siguientePagina: pelicuclasProvider.getPopulares,
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              }),
        ],
      ),
    );
  }
}
