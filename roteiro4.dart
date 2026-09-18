import 'package:flutter/material.dart';

class AnimationScreen extends StatefulWidget {
  const AnimationScreen({super.key});

  @override
  State<AnimationScreen> createState() => _AnimationScreenState();
}

class _AnimationScreenState extends State<AnimationScreen> {
  double largura = 100;
  double altura = 100;
  Color cor = Colors.blue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("AnimatedContainer"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: const Duration(seconds: 1),
              width: largura,
              height: altura,
              color: cor,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  if (largura == 100) {
                    largura = 250;
                    altura = 200;
                    cor = Colors.red;
                  } else {
                    largura = 100;
                    altura = 100;
                    cor = Colors.blue;
                  }
                });
              },
              child: const Text("Animar"),
            ),
          ],
        ),
      ),
    );
  }
}

// exercicio 2 
import 'package:flutter/material.dart';

class PulseIconExample extends StatefulWidget {
  const PulseIconExample({super.key});

  @override
  State<PulseIconExample> createState() => _PulseIconExampleState();
}

class _PulseIconExampleState extends State<PulseIconExample> {
  double _size = 50.0;

  void _animateIcon() async {
    setState(() {
      _size = 100.0;
    });

    await Future.delayed(const Duration(milliseconds: 300));

    setState(() {
      _size = 50.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animação com AnimatedContainer'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              width: _size,
              height: _size,
              child: FittedBox(
                child: Icon(
                  Icons.favorite,
                  color: Colors.red,
                ),
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: _animateIcon,
              child: const Text('Animar Ícone'),
            ),
          ],
        ),
      ),
    );
  }
}

//exercicio 3
import 'package:flutter/material.dart';

class ToggleTextOpacityExample extends StatefulWidget {
  const ToggleTextOpacityExample({super.key});

  @override
  State<ToggleTextOpacityExample> createState() => _ToggleTextOpacityExampleState();
}

class _ToggleTextOpacityExampleState extends State<ToggleTextOpacityExample> {
  bool _isVisible = true;

  void _toggleVisibility() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animação com AnimatedOpacity'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedOpacity(
              opacity: _isVisible ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 500), 
              curve: Curves.easeInOut,
              child: const Text(
                'Olá! Agora você me vê. 😄',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: _toggleVisibility,
              child: Text(_isVisible ? 'Esconder Texto' : 'Mostrar Texto'),
            ),
          ],
        ),
      ),
    );
  }
}

//exercicio 4 
import 'package:flutter/material.dart';

class ExpandableCardExample extends StatefulWidget {
  const ExpandableCardExample({super.key});

  @override
  State<ExpandableCardExample> createState() => _ExpandableCardExampleState();
}

class _ExpandableCardExampleState extends State<ExpandableCardExample> {
  bool _isExpanded = false;

  void _toggleCard() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Card Expansível'),
      ),
      body: Center(
        child: GestureDetector(
          onTap: _toggleCard,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            width: _isExpanded ? 320.0 : 200.0,
            height: _isExpanded ? 220.0 : 100.0,
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: _isExpanded ? Colors.indigo : Colors.blue,
              borderRadius: BorderRadius.circular(16.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 8.0,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      _isExpanded ? Icons.star : Icons.star_border,
                      color: Colors.white,
                      size: 28,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      _isExpanded ? 'Card Expandido' : 'Clique para expandir',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                if (_isExpanded) ...[
                  const SizedBox(height: 16),
                  const Text(
                    'Este é o conteúdo extra exibido apenas quando o card está expandido. Clique novamente para recolher!',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//exercicio 5
import 'package:flutter/material.dart';

class CombinedAnimationExample extends StatefulWidget {
  const CombinedAnimationExample({super.key});

  @override
  State<CombinedAnimationExample> createState() => _CombinedAnimationExampleState();
}

class _CombinedAnimationExampleState extends State<CombinedAnimationExample> {
  bool _isAnimated = false;

  void _toggleAnimation() {
    setState(() {
      _isAnimated = !_isAnimated;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animações Combinadas'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
              width: _isAnimated ? 280.0 : 120.0,
              height: _isAnimated ? 180.0 : 120.0,
              alignment: Alignment.center,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: _isAnimated ? Colors.deepPurple : Colors.blueAccent,
                borderRadius: BorderRadius.circular(_isAnimated ? 20.0 : 10.0),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
                opacity: _isAnimated ? 1.0 : 0.0,
                child: const Text(
                  'Texto revelado com sucesso! ✨',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 50),
            ElevatedButton.icon(
              onPressed: _toggleAnimation,
              icon: Icon(_isAnimated ? Icons.close : Icons.play_arrow),
              label: Text(_isAnimated ? 'Restaurar' : 'Animar'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                textStyle: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
