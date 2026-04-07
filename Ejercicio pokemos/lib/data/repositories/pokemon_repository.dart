import 'package:dio/dio.dart';
import 'package:ejemplo_2_documentacion/dto/pokemon.dart';
import 'package:flutter/foundation.dart';

class PokemonRepository {
  final Dio _dio;

  PokemonRepository(this._dio);

  Future<Pokemon> getPokemon(String name) async {
    try {
      debugPrint('Fetching pokemon: $name');
      final response = await _dio.get('https://pokeapi.co/api/v2/pokemon/$name');
      debugPrint('Pokemon fetched successfully: $name');
      debugPrint('Response data type: ${response.data.runtimeType}');
      try {
        return Pokemon.fromJson(response.data);
      } catch (parseError) {
        debugPrint('Error parsing pokemon JSON: $parseError');
        debugPrint('Response data: ${response.data}');
        rethrow;
      }
    } catch (e) {
      debugPrint('Error fetching pokemon $name: $e');
      rethrow;
    }
  }
}
