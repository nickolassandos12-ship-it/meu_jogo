import 'package:flutter/material.dart';
import 'package:meu_jogo/configuracao.dart';
import 'package:meu_jogo/inicio.dart';
import 'package:meu_jogo/skin.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    
    // 🎨 BOTÕES ULTRA GIGANTES
    final logoWidth = screenWidth * 0.98;
    final buttonHeight = screenHeight * 0.34; // 34% ULTRA ALTO
    final buttonSpacing = screenWidth * 0.015; // Espaço mínimo

    return Scaffold(
      body: Stack(
        children: [
          // 🔵 FUNDO
          Positioned.fill(
            child: Image.asset(
              'assets/fundo_home.png',
              fit: BoxFit.cover,
            ),
          ),

          // 🟢 LOGO (mantida igual)
          Align(
            alignment: Alignment.topCenter,
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.only(
                  top: screenHeight * 0.005,
                  left: screenWidth * 0.01,
                  right: screenWidth * 0.01,
                ),
                child: Image.asset(
                  'assets/nome.png',
                  width: logoWidth > 500 ? 500 : logoWidth,
                  height: screenHeight * 0.32,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),

          // 🎮 BOTÕES ULTRA GIGANTES - HORIZONTAL
          Align(
            alignment: Alignment.bottomCenter,
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: screenHeight * 0.04, // Mais perto da borda
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    // 🎨 SKIN - GIGANTE
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: EdgeInsets.only(right: buttonSpacing),
                        child: BotaoAnimado(
                          imagem: 'assets/skin.png',
                          largura: screenWidth * 0.36, // 36% GIGANTE
                          altura: buttonHeight,
                          onTap: () {
                            print('Skin clicado');
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const skinjogo(),
                              ),
                            );
                          },
                        ),
                      ),
                    ),

                    // ▶️ INICIAR - MONSTRUOSO
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: buttonSpacing),
                        child: BotaoAnimado(
                          imagem: 'assets/inicia.png',
                          largura: screenWidth * 0.52, // 52% MONSTRUOSO
                          altura: buttonHeight * 1.3, // 30% mais alto
                          onTap: () {
                            print('Iniciar jogo');
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const iniciojogo(),
                              ),
                            );
                          },
                        ),
                      ),
                    ),

                    // ⚙️ CONFIG - GIGANTE
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: EdgeInsets.only(left: buttonSpacing),
                        child: BotaoAnimado(
                          imagem: 'assets/configuracao.png',
                          largura: screenWidth * 0.36, // 36% GIGANTE
                          altura: buttonHeight,
                          onTap: () {
                            print('Configurações clicado');
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ConfJogo(),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BotaoAnimado extends StatefulWidget {
  final String imagem;
  final double largura;
  final double? altura;
  final VoidCallback onTap;

  const BotaoAnimado({
    super.key,
    required this.imagem,
    required this.onTap,
    required this.largura,
    this.altura,
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
          height: widget.altura,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}