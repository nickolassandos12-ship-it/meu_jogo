import 'package:flutter/material.dart';
import 'package:meu_jogo/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const ConfJogo());
}

class ConfJogo extends StatelessWidget {
  const ConfJogo({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(title: 'Meu Jogo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double volume = 0.5;
  double opacidade = 0.5;

  @override
  void initState() {
    super.initState();
    _carregarConfiguracoes();
  }

  Future<void> _carregarConfiguracoes() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      volume = prefs.getDouble('volume') ?? 0.5;
      opacidade = prefs.getDouble('opacidade') ?? 0.5;
    });
  }

  Future<void> _salvarConfiguracoes() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setDouble('volume', volume);
    await prefs.setDouble('opacidade', opacidade);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final voltarSize = screenWidth * 0.18;

    return Scaffold(
      body: Stack(
        children: [
          // Fundo
          Positioned.fill(
            child: Image.asset(
              'assets/fundo_home.png',
              fit: BoxFit.cover,
            ),
          ),

          // Escurecimento do fundo
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(opacidade),
            ),
          ),

          // ⬅️ BOTÃO VOLTAR - FUNCIONANDO 100%
Align(
  alignment: Alignment.topLeft,
  child: SafeArea(
    child: Padding(
      padding: EdgeInsets.all(screenWidth * 0.06),
      child: BotaoAnimado(
        imagem: 'assets/voltar.png',
        largura: voltarSize,
        altura: voltarSize * 1.1,
        onTap: () async {
          await _salvarConfiguracoes(); // 💾 Aguarda salvar
          print('✅ Voltar clicado - salvando...');
          
          // 🔙 VOLTA PARA TELA ANTERIOR
          if (Navigator.canPop(context)) {
            Navigator.pop(context); // ✅ Funciona se veio de outra tela
          } else {
            // Fallback: vai para home se não puder voltar
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const MyApp()),
            );
          }
        },
      ),
    ),
  ),
),

          // Painel principal
          Center(
            child: SizedBox(
              width: screenWidth * 0.92,
              height: screenHeight * 0.78,
              child: Stack(
                children: [
                  // Imagem do painel
                  Positioned.fill(
                    child: Image.asset(
                      'assets/configuracao2.png',
                      fit: BoxFit.contain,
                    ),
                  ),

                  // VOLUME
      Positioned(
        top: screenHeight * 0.10,
        left: 0,
        right: 0,
        child: Center(
          child: SizedBox(
            width: screenWidth * 0.38,
            child: Material(
              color: Colors.transparent,
              elevation: 12,
              borderRadius: BorderRadius.circular(22),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 14,
                  horizontal: 10,
                ),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.28),
                  borderRadius: BorderRadius.circular(22),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.15),
                    width: 1.5,
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Volume',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.015),
                    Slider(
                      value: volume,
                      min: 0,
                      max: 1,
                      divisions: 100,
                      onChanged: (value) {
                        setState(() => volume = value);
                        _salvarConfiguracoes();
                      },
                    ),
                    Text(
                      '${(volume * 100).round()}%',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),

      // OPACIDADE
      Positioned(
        top: screenHeight * 0.37, // antes era 0.48
        left: 0,
        right: 0,
        child: Center(
          child: SizedBox(
            width: screenWidth * 0.38,
            child: Material(
              color: Colors.transparent,
              elevation: 12,
              borderRadius: BorderRadius.circular(22),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 14,
                  horizontal: 10,
                ),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.28),
                  borderRadius: BorderRadius.circular(22),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.15),
                    width: 1.5,
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Opacidade',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.015),
                    Slider(
                      value: opacidade,
                      min: 0,
                      max: 1,
                      divisions: 100,
                      onChanged: (value) {
                        setState(() => opacidade = value);
                        _salvarConfiguracoes();
                      },
                    ),
                    Text(
                      '${(opacidade * 100).round()}%',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
                ],
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

  void _pressionar() {
    setState(() {
      _scale = 0.9;
    });
  }

  void _soltar() {
    setState(() {
      _scale = 1.0;
    });
  }

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