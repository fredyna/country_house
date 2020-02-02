import 'package:country_house/screens/AllCountries.dart';
import 'package:country_house/screens/Country.dart';
import 'package:country_house/screens/CountryMap.dart';
import 'package:flutter/material.dart';

main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AllCountries(),
      routes: {
        CountryMap.routeName: (ctx) => CountryMap(),
      },
    );
  }
}
