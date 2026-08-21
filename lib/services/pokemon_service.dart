import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:quem_e_esse_pokemon/models/pokemon.dart';

class PokemonService {
  
  static const String baseUrl = 'https://pokeapi.co/api/v2';

  Future<Pokemon> getPokemon(int id) async {

    final response = await http.get(
      Uri.parse('$baseUrl/pokemon/$id'),
    );

    if (response.statusCode != 200) {
      throw Exception('Erro ao carregar Pokemon.');

    }

    final json = jsonDecode(response.body);

    return Pokemon.fromJson(json);

  }

}