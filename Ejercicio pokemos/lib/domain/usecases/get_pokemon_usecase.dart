import 'package:ejemplo_2_documentacion/data/repositories/pokemon_repository.dart';
import 'package:ejemplo_2_documentacion/dto/pokemon.dart';

class GetPokemonUseCase {
  final PokemonRepository _repository;

  GetPokemonUseCase(this._repository);

  Future<Pokemon> call(String name) async {
    return await _repository.getPokemon(name.toLowerCase());
  }
}
