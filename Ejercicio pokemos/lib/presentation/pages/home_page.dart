import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:ejemplo_2_documentacion/dto/pokemon.dart';
import 'package:ejemplo_2_documentacion/domain/usecases/get_pokemon_usecase.dart';
import 'package:ejemplo_2_documentacion/presentation/widgets/pokemon_image_widget.dart';
import 'package:ejemplo_2_documentacion/presentation/widgets/pokemon_search_field.dart';

class HomePage extends StatefulWidget {
  final GetPokemonUseCase getPokemonUseCase;

  const HomePage({super.key, required this.getPokemonUseCase});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _key = GlobalKey<ExpandableFabState>();
  late final TextEditingController _pokemonController;
  late Future<Pokemon> _pokemonFuture;

  @override
  void initState() {
    super.initState();
    _pokemonController = TextEditingController();
    _loadRandomPokemon();
  }

  @override
  void dispose() {
    _pokemonController.dispose();
    super.dispose();
  }

  void _loadRandomPokemon() {
    final randomId = Random().nextInt(898) + 1; // Solo pokemones de gen 1-8
    setState(() {
      _pokemonFuture = widget.getPokemonUseCase(randomId.toString());
    });
  }

  void _searchPokemon() {
    final name = _pokemonController.text.trim();
    if (name.isNotEmpty) {
      setState(() {
        _pokemonFuture = widget.getPokemonUseCase(name);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Pokémon App'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              PokemonSearchField(controller: _pokemonController),
              const SizedBox(height: 20),
              PokemonImageWidget(pokemonFuture: _pokemonFuture),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: ExpandableFab.location,
      floatingActionButton: ExpandableFab(
        key: _key,
        overlayStyle: ExpandableFabOverlayStyle(
          color: Colors.black.withValues(alpha: 0.5),
          blur: 5,
        ),
        children: [
          FloatingActionButton.small(
            heroTag: 'search',
            child: const Icon(Icons.search),
            onPressed: _searchPokemon,
          ),
          FloatingActionButton.small(
            heroTag: 'random',
            child: const Icon(Icons.shuffle),
            onPressed: _loadRandomPokemon,
          ),
        ],
      ),
    );
  }
}
