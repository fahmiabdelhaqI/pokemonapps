import 'dart:convert';

import 'package:pokemon_api/model/pokemon_detail.dart';
import 'package:pokemon_api/model/pokemon_index.dart';
import 'package:http/http.dart' as http;

class PokemonAPI {
  Future<PokemonIndex> fetchPokemon(int offset) async {
    final res = await http.get(
        "https://pokeapi.co/api/v2/pokemon?offset=${offset.toString()}&limit=20");

    if (res.statusCode == 200) {
      return PokemonIndex.fromJson(jsonDecode(res.body));
    } else {
      print("Gagal Mengambil Pokemon");
      throw Exception('Failed to load Pokemon');
    }
  }

  Future<PokemomDetail> fetchPokemonDetail(url) async {
    final res = await http.get(url);

    if (res.statusCode == 200) {
      print(res.body);
      return PokemomDetail.fromJson(jsonDecode(res.body));
    } else {
      throw Exception('Failed to load Pokemon');
    }
  }
}
