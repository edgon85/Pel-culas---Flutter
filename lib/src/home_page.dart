import 'package:flutter/material.dart';
import 'package:peliculas/src/providers/peliculas_provaiders.dart';

import 'package:peliculas/src/widgets/card_swiper_widget.dart';

class HomePage extends StatelessWidget {
  final pelicuclasProvider = new PeliculasProviders();

  @override
  Widget build(BuildContext context) {
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
        children: <Widget>[
          Text(
            'Populares',
            style: Theme.of(context).textTheme.subhead,
          ),
          FutureBuilder(
              future: pelicuclasProvider.getPopulares(),
              builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
                snapshot.data?.forEach((p) => print(p.title));

                return Container();
              })
        ],
      ),
    );
  }
}
