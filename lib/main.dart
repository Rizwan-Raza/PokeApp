import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:poke_app/pokedetail.dart';
import 'package:poke_app/pokemons.dart';

void main() => runApp(MaterialApp(
      title: "Poke App",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        accentColor: Colors.cyanAccent[600],
        primaryColor: Colors.cyan[600],
      ),
      home: HomePage(),
    ));

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() {
    return new HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  PokeHub pokeHub;

  var url =
      "https://raw.githubusercontent.com/Biuni/PokemonGo-Pokedex/master/pokedex.json";
  @override
  void initState() {
    super.initState();

    fetchData();
  }

  fetchData() async {
    var res = await http.get(url);
    var decodedValues = jsonDecode(res.body);
    pokeHub = PokeHub.fromJson(decodedValues);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Poke App"),
      ),
      drawer: Drawer(),
      body: pokeHub == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : GridView.count(
              crossAxisCount: 2,
              children: pokeHub.pokemon
                  .map((Pokemon pokemon) => Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PokeDetail(pokemon),
                              ),
                            );
                          },
                          child: Card(
                            elevation: 2.0,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Hero(
                                  tag: pokemon.img,
                                  child: Container(
                                    height: 100,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(pokemon.img),
                                      ),
                                    ),
                                  ),
                                ),
                                Text(
                                  pokemon.name.toString(),
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ))
                  .toList(),
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          setState(() {});
        },
        child: Icon(Icons.refresh),
      ),
    );
  }
}
