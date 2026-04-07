import 'package:flutter/material.dart';

class PokemonSearchField extends StatelessWidget {
  final TextEditingController controller;

  const PokemonSearchField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: const InputDecoration(
        labelText: 'Nombre del Pokémon',
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.search),
      ),
    );
  }
}
