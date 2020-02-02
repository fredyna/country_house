import 'package:country_house/screens/CountryMap.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Country extends StatelessWidget {
  static const routeName = '/country';

  @override
  Widget build(BuildContext context) {
    final Map country = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: Text(country['name']),
      ),
      body: Container(
        padding: EdgeInsets.all(8),
        child: GridView(
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          children: <Widget>[
            FlipCard(
              direction: FlipDirection.VERTICAL,
              front: CountryCard("Capital"),
              back: CardSecond(title: country['capital']),
            ),
            FlipCard(
              direction: FlipDirection.VERTICAL,
              front: CountryCard("Population"),
              back: CardSecond(title: country['population'].toString()),
            ),
            FlipCard(
              direction: FlipDirection.VERTICAL,
              front: CountryCard("Flag"),
              back: Card(
                elevation: 10,
                child: Center(
                  child: Center(
                    child: SvgPicture.network(
                      country['flag'],
                      width: 200,
                      semanticsLabel: 'The Flag',
                    ),
                  ),
                ),
              ),
            ),
            FlipCard(
              direction: FlipDirection.VERTICAL,
              front: CountryCard("Currency"),
              back: CardSecond(title: country['currencies'][0]['name']),
            ),
            GestureDetector(
                onTap: () {
                  Navigator.of(context)
                      .pushNamed(CountryMap.routeName, arguments: {
                    'name': country['name'],
                    'latlng': country['latlng'],
                  });
                },
                child: CountryCard("Show on Map")),
          ],
        ),
      ),
    );
  }
}

class CardSecond extends StatelessWidget {
  final String title;
  CardSecond({this.title});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.deepOrange,
      elevation: 10,
      child: Center(
        child: Text(
          title,
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
    );
  }
}

class CountryCard extends StatelessWidget {
  final String title;
  CountryCard(this.title);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Center(
        child: Text(
          title,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
