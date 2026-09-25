import 'package:flutter/material.dart';

void main() {
  runApp(const MeuApp());
}

class MeuApp extends StatelessWidget {
  const MeuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MensagemLifecycleScreen(),
    );
  }
}

class MensagemLifecycleScreen extends StatefulWidget {
  const MensagemLifecycleScreen({super.key});

  @override
  State<MensagemLifecycleScreen> createState() =>
      _MensagemLifecycleScreenState();
}

class _MensagemLifecycleScreenState
    extends State<MensagemLifecycleScreen> {

  bool mensagemVisivel = true;

  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();

    print("Tela iniciada");
  }

  @override
  Widget build(BuildContext context) {
    print("Tela reconstruída");

    return Scaffold(
      appBar: AppBar(
        title: const Text("Mensagem Lifecycle"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [

            TextField(
              controller: controller,
              decoration: const InputDecoration(
                labelText: "Digite uma mensagem",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            if (mensagemVisivel)
              const Text(
                "Esta é a mensagem!",
                style: TextStyle(fontSize: 20),
              ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                setState(() {
                  mensagemVisivel = !mensagemVisivel;
                });
              },
              child: Text(
                mensagemVisivel
                    ? "Esconder mensagem"
                    : "Mostrar mensagem",
              ),
            ),

            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Fechar tela"),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();

    print("Tela finalizada");

    super.dispose();
  }
}
