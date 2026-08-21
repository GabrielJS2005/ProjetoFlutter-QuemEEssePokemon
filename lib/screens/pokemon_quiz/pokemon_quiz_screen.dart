import 'dart:math';

import 'package:flutter/material.dart';
import 'package:quem_e_esse_pokemon/models/pokemon.dart';
import 'package:quem_e_esse_pokemon/screens/pokemon_quiz/game_status.dart';
import 'package:quem_e_esse_pokemon/services/pokemon_service.dart';

class PokemonQuizScreen extends StatefulWidget {
  const PokemonQuizScreen({super.key});

  @override
  State<PokemonQuizScreen> createState() => _PokemonQuizScreenState();
}

class _PokemonQuizScreenState extends State<PokemonQuizScreen> {

  final PokemonService pokemonService = PokemonService();

  final TextEditingController answerController = TextEditingController();

  final Random random = Random();

  Pokemon? pokemon;

  GameStatus status = GameStatus.loading;

  int score = 0;
  int hits = 0;
  int errors = 0;

  String userAnswer = '';
  String? hint;

  @override
  void initState() {

    super.initState();

    loadPokemon();

  }

  @override
  void dispose() {

    answerController.dispose();

    super.dispose();

  }

  Future<void> loadPokemon() async {

    setState(() {
      status = GameStatus.loading;
      hint = null;
      userAnswer = '';
      answerController.clear();
    });

    try {

      final id = random.nextInt(151) + 1;

      final result = await pokemonService.getPokemon(id);

      if (!mounted) {
        return;

      }

      setState(() {
        pokemon = result;
        status = GameStatus.playing;
      });

    } catch (error) {

      if (!mounted) {
        return;

      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Não foi possível carregar o Pokemon.')),
      );

    }

  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}