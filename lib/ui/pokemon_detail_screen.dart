import 'package:flutter/material.dart';
import 'package:pokemon_api/api/pokemon_api.dart';
import 'package:pokemon_api/model/pokemon_detail.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PokemonDetailScreen extends StatefulWidget {
  final String url;
  const PokemonDetailScreen({Key key, this.url}) : super(key: key);

  @override
  State<PokemonDetailScreen> createState() => _PokemonDetailScreenState();
}

class _PokemonDetailScreenState extends State<PokemonDetailScreen> {
  Future<PokemomDetail> pokemon;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pokemon = PokemonAPI().fetchPokemonDetail(widget.url);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: pokemon,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final pokemon = snapshot.data;
          // detail
          return Scaffold(
            appBar: AppBar(
              title: Text('${pokemon.name}'),
            ),
            body: Column(
              children: [
                SvgPicture.network('${pokemon.sprites.front}'),
                Image.network('${pokemon.front.front_default}'),
                Text('W:  ${pokemon.weight}'),
                Text('H: ${pokemon.height}'),
              ],
            ),
          );
        }
        return Scaffold(
          body: CircularProgressIndicator(),
        );
      },
    );
  }
}
