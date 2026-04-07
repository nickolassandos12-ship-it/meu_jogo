import 'package:flutter/material.dart';
import 'package:meu_jogo/inicio_config.dart';


void main() {
  runApp(const iniciojogo());
}

class iniciojogo extends StatelessWidget {
  const iniciojogo({super.key});
  

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(title: 'Meu Jogo'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 🔵 FUNDO
          Positioned.fill(
            child: Image.asset(
              'assets/fundo.png',
              fit: BoxFit.cover,
              ),
            ),
            
             Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: BotaoAnimado(
                imagem: 'assets/configuracaojogo.png',
                largura: 120,
                onTap: () {
                  print('Configurações clicado');
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                    builder: (context) => const inicioconfig(),
                  ),
                 );          
                },
              ),
            ),
          ),
          ]
        )
      );
    }
  }
class BotaoAnimado extends StatefulWidget {
  final String imagem;
  final double largura;
  final VoidCallback onTap;

  const BotaoAnimado({
    super.key,
    required this.imagem,
    required this.onTap,
    this.largura = 200,
  });

  @override
  State<BotaoAnimado> createState() => _BotaoAnimadoState();
}
class _BotaoAnimadoState extends State<BotaoAnimado> {
  double _scale = 1.0;

  void _pressionar() => setState(() => _scale = 0.9);
  void _soltar() => setState(() => _scale = 1.0);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: (_) => _pressionar(),
      onTapUp: (_) => _soltar(),
      onTapCancel: _soltar,
      child: AnimatedScale(
        scale: _scale,
        duration: const Duration(milliseconds: 100),
        child: Image.asset(
          widget.imagem,
          width: widget.largura,
        ),
      ),
    );
  }
}