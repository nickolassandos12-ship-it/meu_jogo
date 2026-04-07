import 'package:flutter/material.dart';
import 'package:meu_jogo/main.dart';

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
  Widget build(BuildContext context) {
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



          // 🌑 CAMADA ESCURA
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.5),
            ),
          ),



          // ⬅️ BOTÃO VOLTAR
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.all(60),
              child: BotaoAnimado(
                imagem: 'assets/voltar.png',
                largura: 150,
                onTap: () {
                  print('voltar clicado');
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                    builder: (context) => const MyApp(),
                  ),
                 );          
                },
              ),
            ),
          ),


          // ⚙️ PAINEL DE CONFIGURAÇÃO
          Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.75,
              height: MediaQuery.of(context).size.height * 0.75,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Imagem de fundo da configuração
                  Image.asset(
                    'assets/configuracao2.png',
                    fit: BoxFit.contain,
                  ),



                  // Barra de volume
                  Positioned(
                    top: MediaQuery.of(context).size.height * 0.16,
                    child: SizedBox(
                      width: 400,
                      child: Column(
                        children: [
                          const Text(
                            'Volume',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 60,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 20),

                          SliderTheme(
                            data: SliderTheme.of(context).copyWith(
                              trackHeight: 8,
                              activeTrackColor: const Color.fromARGB(255, 4, 40, 94),
                              inactiveTrackColor: Colors.white24,
                              thumbColor: Colors.white,
                              overlayColor: const Color.fromARGB(255, 250, 4, 4).withOpacity(0.2),
                              thumbShape: const RoundSliderThumbShape(
                                enabledThumbRadius: 12,
                              ),
                            ),
                            child: Slider(
                              value: volume,
                              min: 0,
                              max: 1,
                              divisions: 100,
                              onChanged: (value) {
                                setState(() {
                                  volume = value;
                                });
                              },
                            ),
                          ),

                          const SizedBox(height: 10),

                          Text(
                            '${(volume * 100).round()}%',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),


                           Positioned(
                    top: MediaQuery.of(context).size.height * 0.50,
                    child: SizedBox(
                      width: 400,
                      child: Column(
                        children: [
                          const Text(
                            'Opacidade',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 60,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 20),

                          SliderTheme(
                            data: SliderTheme.of(context).copyWith(
                              trackHeight: 8,
                              activeTrackColor: const Color.fromARGB(255, 4, 40, 94),
                              inactiveTrackColor: Colors.white24,
                              thumbColor: Colors.white,
                              overlayColor: const Color.fromARGB(255, 250, 4, 4).withOpacity(0.2),
                              thumbShape: const RoundSliderThumbShape(
                                enabledThumbRadius: 12,
                              ),
                            ),
                            child: Slider(
                              value: opacidade,
                              min: 0,
                              max: 1,
                              divisions: 100,
                              onChanged: (value) {
                                setState(() {
                                  opacidade = value;
                                });
                              },
                            ),
                          ),

                          const SizedBox(height: 10),

                          Text(
                            '${(opacidade * 100).round()}%',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                      ]
               ),
              ),
             ),
            ],
           ),
          ),
         ),
        ],
       ),
      )
     )
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
  double _scale = 2.0;

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
        ),
      ),
    );
  }
}

