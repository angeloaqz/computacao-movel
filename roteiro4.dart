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
