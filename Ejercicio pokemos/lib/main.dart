import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ejemplo_2_documentacion/data/repositories/pokemon_repository.dart';
import 'package:ejemplo_2_documentacion/domain/usecases/get_pokemon_usecase.dart';
import 'package:ejemplo_2_documentacion/presentation/pages/home_page.dart';

void main() {
  final dio = Dio();
  final repository = PokemonRepository(dio);
  final getPokemonUseCase = GetPokemonUseCase(repository);

  runApp(MyApp(getPokemonUseCase: getPokemonUseCase));
}

class MyApp extends StatelessWidget {
  final GetPokemonUseCase getPokemonUseCase;

  const MyApp({super.key, required this.getPokemonUseCase});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pokémon App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: HomePage(getPokemonUseCase: getPokemonUseCase),
    );
  }
}
