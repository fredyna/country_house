import 'package:country_house/screens/Country.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class AllCountries extends StatefulWidget {
  @override
  _AllCountriesState createState() => _AllCountriesState();
}

class _AllCountriesState extends State<AllCountries> {
  List countries = [];
  List filteredCountries = [];
  bool isSearching = false;

  getCountries() async {
    var response = await Dio().get('https://restcountries.eu/rest/v2/all');
    return response.data;
  }

  @override
  void initState() {
    getCountries().then((data) {
      setState(() {
        countries = filteredCountries = data;
      });
    });
    super.initState();
  }

  void _filterCountries(value) {
    setState(() {
      filteredCountries = countries
          .where((country) =>
              country['name'].toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: !isSearching
            ? Text("All Countries")
            : TextField(
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  icon: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  hintText: "Search country ...",
                  hintStyle: TextStyle(color: Colors.white),
                ),
                onChanged: (value) {
                  _filterCountries(value);
                },
              ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              !isSearching ? Icons.search : Icons.close,
            ),
            onPressed: () {
              setState(() {
                isSearching = !isSearching;
                if (!isSearching) filteredCountries = countries;
              });
            },
          ),
        ],
      ),
      body: Container(
          padding: EdgeInsets.all(10),
          child: countries.length > 0
              ? ListView.builder(
                  itemCount: filteredCountries.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed(Country.routeName,
                            arguments: {'name': filteredCountries[index]});
                      },
                      child: Card(
                        elevation: 10,
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                          child: Text(
                            filteredCountries[index]['name'],
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                    );
                  })
              : Center(
                  child: CircularProgressIndicator(),
                )),
    );
  }
}
