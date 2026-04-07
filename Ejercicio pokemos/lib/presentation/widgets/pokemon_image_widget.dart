import 'package:flutter/material.dart';
import 'package:ejemplo_2_documentacion/dto/pokemon.dart';

class PokemonImageWidget extends StatelessWidget {
  final Future<Pokemon> pokemonFuture;

  const PokemonImageWidget({super.key, required this.pokemonFuture});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Pokemon>(
      future: pokemonFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }
        if (snapshot.hasError) {
          debugPrint('Error loading pokemon: ${snapshot.error}');
          return Text('Error: ${snapshot.error}');
        }
        if (snapshot.hasData) {
          final pokemon = snapshot.data!;
          debugPrint('Pokemon loaded: ${pokemon.name} (ID: ${pokemon.id})');
          String? imageUrl;

          // Intentar obtener imagen en orden de prioridad
          imageUrl = pokemon.sprites.other?.officialArtwork.frontDefault;
          imageUrl ??= pokemon.sprites.other?.home.frontDefault;
          imageUrl ??= pokemon.sprites.frontDefault;

          if (imageUrl != null && imageUrl.isNotEmpty) {
            return Image.network(imageUrl, height: 300);
          }
          return const Icon(Icons.image_not_supported, size: 100);
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
