import 'package:flutter/material.dart';
import 'package:poke_app/pokemons.dart';

class PokeDetail extends StatelessWidget {
  final Pokemon pokemon;

  bodyWidget(BuildContext context) => Stack(
        children: <Widget>[
          Positioned(
            height: MediaQuery.of(context).size.height / 1.5,
            width: MediaQuery.of(context).size.width - 16,
            left: 8.0,
            top: MediaQuery.of(context).size.height * 0.1,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SizedBox(
                    height: 50.0,
                  ),
                  Text(
                    pokemon.name,
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text("Height: ${pokemon.height}"),
                  Text("Weight: ${pokemon.weight}"),
                  Text("Types"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: pokemon.type
                        .map((type) => FilterChip(
                              backgroundColor: Colors.amber,
                              label: Text(type),
                              onSelected: (b) {},
                            ))
                        .toList(),
                  ),
                  Text("Weaknesses"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: pokemon.weaknesses
                        .map((weakness) => FilterChip(
                              backgroundColor: Colors.red,
                              label: Text(
                                weakness,
                                style: TextStyle(color: Colors.white),
                              ),
                              onSelected: (b) {},
                            ))
                        .toList(),
                  ),
                  Text("Evolutions"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: new List.from(pokemon.prevEvolution != null
                        ? pokemon.prevEvolution
                            .map((evolution) => FilterChip(
                                  backgroundColor: Colors.lightGreen,
                                  label: Text(
                                    evolution.name,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  onSelected: (b) {},
                                ))
                            .toList()
                        : [])
                      ..add(FilterChip(
                        backgroundColor: Theme.of(context).primaryColor,
                        label: Text(
                          pokemon.name,
                          style: TextStyle(color: Colors.white),
                        ),
                        onSelected: (b) {},
                      ))
                      ..addAll(pokemon.nextEvolution != null
                          ? pokemon.nextEvolution
                              .map((evolution) => FilterChip(
                                    backgroundColor: Colors.green,
                                    label: Text(
                                      evolution.name,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    onSelected: (b) {},
                                  ))
                              .toList()
                          : []),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Hero(
              tag: pokemon.img,
              child: Container(
                height: 120.0,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(pokemon.img),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          )
        ],
      );

  PokeDetail(this.pokemon);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: Text(pokemon.name),
        elevation: 0.0,
      ),
      body: bodyWidget(context),
    );
  }
}
