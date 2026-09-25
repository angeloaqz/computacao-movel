import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import '../models/pokemon.dart';
import '../services/pokemon_service.dart';

class PokemonScreen extends StatefulWidget {
  const PokemonScreen({super.key});

  @override
  State<PokemonScreen> createState() => _PokemonScreenState();
}

class _PokemonScreenState extends State<PokemonScreen> {
  final TextEditingController _controller = TextEditingController();
  final AudioPlayer _audioPlayer = AudioPlayer();
  final PokemonService _pokemonService = PokemonService();

  Pokemon? pokemon;
  bool isLoading = false;
  String errorMessage = '';
  int numeroAtual = 25;

  @override
  void initState() {
    super.initState();
    print('initState: carregando Pokémon inicial');
    _buscarPokemon(numeroAtual.toString());
  }

  Future<void> _buscarPokemon(String term) async {
    setState(() {
      isLoading = true;
      errorMessage = '';
    });

    try {
      final result = await _pokemonService.fetchPokemon(term);
      setState(() {
        pokemon = result;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        pokemon = null;
        isLoading = false;
        errorMessage = 'Erro ao buscar Pokémon.';
      });
    }
  }

  Future<void> _buscarPorNumero(int numero) async {
    if (numero < 1) return;
    numeroAtual = numero;
    await _buscarPokemon(numeroAtual.toString());
  }

  Future<void> _tocarSom() async {
    if (pokemon != null && pokemon!.cryUrl.isNotEmpty) {
      await _audioPlayer.stop();
      await _audioPlayer.play(UrlSource(pokemon!.cryUrl));
    }
  }

  String formatarNome(String text) {
    if (text.isEmpty) return '';
    return text[0].toUpperCase() + text.substring(1);
  }

  @override
  void dispose() {
    print('dispose: tela finalizada');
    _controller.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('build: interface reconstruída');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokédex com API'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Digite o nome ou número do Pokémon',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                if (_controller.text.isNotEmpty) {
                  numeroAtual = int.tryParse(_controller.text) ?? numeroAtual;
                  _buscarPokemon(_controller.text);
                }
              },
              child: const Text('Buscar'),
            ),
            const SizedBox(height: 20),

            if (isLoading) const CircularProgressIndicator(),

            if (errorMessage.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Text(
                  errorMessage,
                  style: const TextStyle(fontSize: 16, color: Colors.red),
                ),
              ),

            if (!isLoading && errorMessage.isEmpty && pokemon != null) ...[
              Text(
                formatarNome(pokemon!.name),
                style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              Text('Número: ${pokemon!.id}', style: const TextStyle(fontSize: 20)),
              const SizedBox(height: 12),
              if (pokemon!.imageUrl.isNotEmpty)
                Image.network(pokemon!.imageUrl, height: 200),
              const SizedBox(height: 12),
              ElevatedButton.icon(
                onPressed: _tocarSom,
                icon: const Icon(Icons.volume_up),
                label: const Text('Tocar som'),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: () => _buscarPorNumero(numeroAtual - 1),
                    icon: const Icon(Icons.arrow_back),
                    label: const Text('Anterior'),
                  ),
                  ElevatedButton.icon(
                    onPressed: () => _buscarPorNumero(numeroAtual + 1),
                    icon: const Icon(Icons.arrow_forward),
                    label: const Text('Próximo'),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}