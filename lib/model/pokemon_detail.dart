class PokemomDetail {
  String name;
  int weight;
  int height;
  PokemonSprites sprites;
  PokemonSprites front;

  //constructor
  PokemomDetail(
      {this.name, this.weight, this.height, this.sprites, this.front});

  // json
  PokemomDetail.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    weight = json['weight'];
    height = json['height'];
    sprites = PokemonSprites.fromJson(json['sprites']['other']['dream_world']);
    front = PokemonSprites.fromJson(json['sprites']);
  }
}

class PokemonSprites {
  String front;
  String back;
  String front_default;

  PokemonSprites({this.front, this.back, this.front_default});

  PokemonSprites.fromJson(Map<String, dynamic> json) {
    front = json['front_default'];
    back = json['back_default'];
    front_default = json['front_default'];
  }
}
