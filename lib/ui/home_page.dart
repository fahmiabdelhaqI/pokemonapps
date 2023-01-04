import 'package:flutter/material.dart';
import 'package:pokemon_api/api/pokemon_api.dart';
import 'package:pokemon_api/model/pokemon_index.dart';
import 'package:pokemon_api/ui/pokemon_detail_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<PokemonIndex> pokemonIndex;

  @override
  void initState() {
    super.initState();
    pokemonIndex = PokemonAPI().fetchPokemon(0);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Pokemom List"),
        ),
        body: FutureBuilder(
          future: pokemonIndex,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              // var pokemonList = snapshot.data.pokemonSummary;
              // daftar pokemon
              return PokemonListView(pokemonList: snapshot.data.pokemonSummary);
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}

class PokemonListView extends StatefulWidget {
  final pokemonList;
  const PokemonListView({Key key, this.pokemonList}) : super(key: key);

  @override
  State<PokemonListView> createState() => _PokemonListViewState();
}

class _PokemonListViewState extends State<PokemonListView> {
  int currentOffset = 0;
  List<PokemonSummary> _pokemonList;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pokemonList = widget.pokemonList;
  }

  checkPokemon(context, url) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: ((context) => PokemonDetailScreen(url: url)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollEndNotification>(
      child: ListView.builder(
        itemCount: _pokemonList.length,
        itemBuilder: (context, index) {
          return Container(
            height: 50,
            child: ListTile(
              title: Text('${_pokemonList[index].name}'),
              onTap: () {
                checkPokemon(context, _pokemonList[index].url);
              },
            ),
          );
        },
      ),
      onNotification: (notifiation) {
        currentOffset = currentOffset + 20;
        PokemonAPI().fetchPokemon(currentOffset).then((res) {
          setState(() {
            _pokemonList.addAll(res.pokemonSummary);
          });
        });
      },
    );
  }
}
